#include <verilated.h>
#include <verilated_vcd_c.h>

#include "obj_dir/Vcontrol.h"

void CharToVlWide(const char in[16], VlWide<4UL> &out)
{
    // m_storage is an array of 4 unsigned longs, little-endian
    // in is an array of 16 unsigned chars, big-endian
    memset(out.m_storage, 0, sizeof(out.m_storage));
    for (int i = 0; i < 16; i++)
        out.m_storage[i / 4] |= (unsigned char)in[i] << (i % 4) * 8;
}

int main()
{
    auto dut = Vcontrol();

    Verilated::traceEverOn(true);
    auto m_trace = VerilatedVcdC();
    dut.trace(&m_trace, 5);
    m_trace.open("waveform.vcd");

    vluint64_t sim_time = 0;

    // 0x0000000000000000000067646582052b
    CharToVlWide("\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x67\x64\x65\x82\x05\x2b", dut.p);
    // 0x00000000000001b1aba396153c5af549
    CharToVlWide("\x00\x00\x00\x00\x00\x00\x01\xb1\xab\xa3\x96\x15\x3c\x5a\xf5\x49", dut.q);
    // 0x00262d806a3e18f03ab37b2857e7e149
    CharToVlWide("\x00\x26\x2d\x80\x6a\x3e\x18\xf0\x3a\xb3\x7b\x28\x57\xe7\xe1\x49", dut.msg_in);

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