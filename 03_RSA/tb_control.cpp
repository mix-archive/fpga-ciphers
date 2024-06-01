#include <array>
#include <cstring>
#include <iostream>
#include <verilated.h>

#include <verilated.h>
#include <verilated_vcd_c.h>

#include "obj_dir/Vcontrol.h"

// Helper function to convert a string of bytes into a VlWide array
template <std::size_t N>
constexpr std::array<uint64_t, N / 8> CharToVlWide(const char (&input)[N])
{
    std::array<uint64_t, N / 8> result = {0};
    for (std::size_t i = 0; i < N - 1; ++i)
    {
        result[i / 8] |= static_cast<uint64_t>(static_cast<unsigned char>(input[N - 2 - i])) << (8 * (i % 8));
    }
    return result;
}

constexpr auto p_data = CharToVlWide("\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x67\x64\x65\x82\x05\x2b");
constexpr auto q_data = CharToVlWide("\x00\x00\x00\x00\x00\x00\x01\xb1\xab\xa3\x96\x15\x3c\x5a\xf5\x49");
constexpr auto msg_in_data = CharToVlWide("\x00\x26\x2d\x80\x6a\x3e\x18\xf0\x3a\xb3\x7b\x28\x57\xe7\xe1\x49");

int main()
{
    auto dut = Vcontrol();

    Verilated::traceEverOn(true);
    auto m_trace = VerilatedVcdC();
    dut.trace(&m_trace, 5);
    m_trace.open("waveform.vcd");

    vluint64_t sim_time = 0;

    std::memcpy(dut.p.m_storage, p_data.data(), p_data.size() * sizeof(uint64_t));
    std::memcpy(dut.q.m_storage, q_data.data(), q_data.size() * sizeof(uint64_t));
    std::memcpy(dut.msg_in.m_storage, msg_in_data.data(), msg_in_data.size() * sizeof(uint64_t));

    dut.reset = 1;
    dut.encrypt_decrypt = 1;

    for (unsigned int i = 0; i < 10; i++)
    {
        dut.clk ^= 1;
        dut.eval();
        m_trace.dump(sim_time);
        sim_time++;
    }

    dut.reset = 0;

    for (unsigned int i = 0; i < 1000; i++)
    {
        dut.clk ^= 1;
        dut.eval();
        m_trace.dump(sim_time);
        sim_time++;
    }

    dut.reset1 = 1;

    for (unsigned int i = 0; i < 10; i++)
    {
        dut.clk ^= 1;
        dut.eval();
        m_trace.dump(sim_time);
        sim_time++;
    }

    dut.reset1 = 0;

    for (unsigned int i = 0; i < 1000; i++)
    {
        dut.clk ^= 1;
        dut.eval();
        m_trace.dump(sim_time);
        sim_time++;
    }

    m_trace.close();
    return 0;
}