#include <array>
#include <cstring>
#include <iostream>
#include <verilated.h>
#include <iomanip>

#include <verilated.h>
#include <verilated_vcd_c.h>

#include "obj_dir/VARS_SHA_1.h"

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
constexpr auto uint8_to_uint32_reverse(const std::array<uint8_t, N> &input)
{
    auto result = uint8_to_uint32(input);
    for (std::size_t i = 0; i < N / 4 / 2; ++i)
    {
        auto temp = result[i];
        result[i] = result[N / 4 - 1 - i];
        result[N / 4 - 1 - i] = temp;
    }
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

constexpr auto cv = uint8_to_uint32_reverse((std::array<uint8_t, 20>{0x67, 0x45, 0x23, 0x01, 0xEF, 0xCD, 0xAB, 0x89, 0x98, 0xBA, 0xDC, 0xFE, 0x10, 0x32, 0x54, 0x76, 0xC3, 0xD2, 0xE1, 0xF0}));
constexpr auto test_data1 = uint8_to_uint32(hash_pad("abc"));
constexpr auto test_data2 = uint8_to_uint32(hash_pad("abb"));
constexpr auto test_data3 = uint8_to_uint32(hash_pad("abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq"));

class Simulation
{
public:
    VARS_SHA_1 dut;
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
        std::memcpy(dut.cv.m_storage, cv.data(), cv.size() * sizeof(uint32_t));

        dut.reset = 1;
        m_sleep(3);
        dut.reset = 0;
        m_sleep(2);

        m_doHash(test_data1);
        std::cout << "Test 1: ";
        for (const auto &word : uint32_reverse_to_uint8(dut.cv_next))
            std::cout << std::hex << std::setw(2) << std::setfill('0') << static_cast<int>(word);
        std::cout << std::endl;
        
        m_doHash(test_data2);
        std::cout << "Test 2: ";
        for (const auto &word : uint32_reverse_to_uint8(dut.cv_next))
            std::cout << std::hex << std::setw(2) << std::setfill('0') << static_cast<int>(word);
        std::cout << std::endl;

        m_doHash(test_data3);
        std::cout << "Test 3: ";
        for (const auto &word : uint32_reverse_to_uint8(dut.cv_next))
            std::cout << std::hex << std::setw(2) << std::setfill('0') << static_cast<int>(word);
        std::cout << std::endl;
    }

private:
    void m_atPosEdge()
    {
        dut.clk = 0;
        dut.eval();
        m_trace.dump(sim_time++);

        dut.clk = 1;
        dut.eval();
        m_trace.dump(sim_time++);
    }

    void m_inputData(const std::array<uint32_t, 16> &data)
    {
        for (const auto &word : data)
        {
            dut.din = word;
            dut.load = 1;
            m_atPosEdge();
        }
        dut.load = 0;
    }

    template <std::size_t N>
    void m_doHash(const std::array<uint32_t, N> &data)
    {
        static_assert(N % 16 == 0, "Data size must be multiple of 16");
        std::memcpy(dut.cv.m_storage, cv.data(), cv.size() * sizeof(uint32_t));
        for (std::size_t i = 0; i < N; i = i + 16)
        {
            m_atPosEdge();

            std::array<uint32_t, 16> sliced_data;
            std::memcpy(sliced_data.data(), data.data() + i, sliced_data.size() * sizeof(uint32_t));
            m_inputData(sliced_data);

            dut.start = 1;
            dut.use_prev_cv = i > 0;
            m_atPosEdge();
            dut.use_prev_cv = 0;
            dut.start = 0;

            while (dut.busy)
                m_atPosEdge();
        }
    }

    void m_sleep(uint32_t cycles)
    {
        for (uint32_t i = 0; i < cycles; ++i)
            m_atPosEdge();
    }
};

int main()
{
    Simulation sim;
    sim.run();
    return 0;
}