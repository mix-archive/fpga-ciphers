#include <array>
#include <cstring>
#include <iostream>
#include <verilated.h>
#include <iomanip>

#include <verilated.h>
#include <verilated_vcd_c.h>

#include "obj_dir/VARS_SM3.h"

template <std::size_t N>
constexpr auto hash_pad(const char (&input)[N])
{
    constexpr auto len = (N + 8) % 64 ? 64 * ((N + 8) / 64 + 1) : N + 8;
    std::array<uint8_t, len> result = {0};
    for (std::size_t i = 0; i < N - 1; ++i)
        result[i] = static_cast<uint8_t>(input[i]);
    result[N - 1] = 0x80;
    for (std::size_t i = 0; i < 8; ++i)
        result[len - 1 - i] = static_cast<uint8_t>((N - 1) * 8 >> i * 8);
    return result;
}

template <std::size_t N>
constexpr auto uint8_to_uint32(const std::array<uint8_t, N> &input)
{
    std::array<uint32_t, N / 4> result = {0};
    for (std::size_t i = 0; i < N / 4; ++i)
        result[i] = (input[i * 4] << 24) | (input[i * 4 + 1] << 16) |
                    (input[i * 4 + 2] << 8) | input[i * 4 + 3];
    return result;
}

template <std::size_t N>
auto uint32_reverse_to_uint8(const VlWide<N> &input)
{
    std::array<uint8_t, N * 4> result = {0};
    std::array<uint32_t, N> temp;
    std::reverse_copy(std::begin(input.m_storage), std::end(input.m_storage), std::begin(temp));
    for (std::size_t i = 0; i < N; ++i)
    {
        result[i * 4] = static_cast<uint8_t>(temp[i] >> 24);
        result[i * 4 + 1] = static_cast<uint8_t>(temp[i] >> 16);
        result[i * 4 + 2] = static_cast<uint8_t>(temp[i] >> 8);
        result[i * 4 + 3] = static_cast<uint8_t>(temp[i]);
    }
    return result;
}

constexpr auto test_data1 = uint8_to_uint32(hash_pad("abc"));
constexpr auto test_data2 = uint8_to_uint32(hash_pad("abb"));
constexpr auto test_data3 = uint8_to_uint32(hash_pad("abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq"));

class Simulation
{

private:
    void m_atPosEdge()
    {
        dut.clk = 1;
        dut.eval();
        m_trace.dump(sim_time++);

        dut.clk = 0;
        dut.eval();
        m_trace.dump(sim_time++);
    }

    void m_inputData(const std::array<uint32_t, 16> &data)
    {
        for (const auto &word : data)
        {
            dut.din = word;
            m_atPosEdge();
        }
    }

    template <std::size_t N>
    auto m_doHash(const std::array<uint32_t, N> &data)
    {
        static_assert(N % 16 == 0, "Data size must be multiple of 16");
        for (std::size_t i = 0; i < N; i = i + 16)
        {
            m_atPosEdge();

            std::array<uint32_t, 16> sliced_data;
            std::memcpy(sliced_data.data(), data.data() + i, sliced_data.size() * sizeof(uint32_t));

            dut.cmd_i = i > 0 ? 0b110 : 0b010;
            dut.cmd_w_i = 1;
            m_atPosEdge();
            dut.cmd_w_i = 0;
            m_inputData(sliced_data);

            while (dut.cmd_o & 0b1000)
                m_atPosEdge();
        }

        dut.cmd_i = 0b001;
        dut.cmd_w_i = 1;
        m_atPosEdge();
        dut.cmd_w_i = 0;

        do
            m_atPosEdge();
        while (dut.read_counter >= 8);

        std::array<uint8_t, 32> result;
        for (std::size_t i = 0; i < 8; ++i)
        {
            m_atPosEdge();
            for (std::size_t j = 0; j < 4; ++j)
                result[i * 4 + j] = static_cast<uint8_t>(dut.dout >> (24 - j * 8));
        }

        return result;
    }

    void m_sleep(uint32_t cycles)
    {
        for (uint32_t i = 0; i < cycles; ++i)
            m_atPosEdge();
    }

public:
    VARS_SM3 dut;
    VerilatedVcdC m_trace;
    vluint64_t sim_time = 0;

    Simulation()
    {
        Verilated::traceEverOn(true);
        dut.trace(&m_trace, 5);
        m_trace.open("waveform.vcd");
    }

    ~Simulation()
    {
        m_trace.close();
    }

    void run()
    {
        dut.reset = 1;
        m_sleep(4);
        dut.reset = 0;
        m_sleep(3);

        std::cout << "Test data 1: ";
        auto result = m_doHash(test_data1);
        for (const auto &word : result)
            std::cout << std::hex << std::setw(2) << std::setfill('0') << static_cast<int>(word);
        std::cout << std::endl;

        std::cout << "Test data 2: ";
        result = m_doHash(test_data2);
        for (const auto &word : result)
            std::cout << std::hex << std::setw(2) << std::setfill('0') << static_cast<int>(word);
        std::cout << std::endl;

        std::cout << "Test data 3: ";
        result = m_doHash(test_data3);
        for (const auto &word : result)
            std::cout << std::hex << std::setw(2) << std::setfill('0') << static_cast<int>(word);
        std::cout << std::endl;
    }
};

int main()
{
    Simulation sim;
    sim.run();
    return 0;
}