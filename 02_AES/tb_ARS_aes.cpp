
#include <stdlib.h>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>

#include "obj_dir/VARS_aes.h"
#include "tb_ARS_aes.h"

#define MAX_SIM_TIME 2000

#define CHARS_TO_UL(x, offset) ((x[offset] | (x[offset + 1] << 8) | (x[offset + 2] << 16) | (x[offset + 3] << 24)))

void CharToVlWide(unsigned char in[16], VlWide<4UL> &out)
{
    // m_storage is an array of 4 unsigned longs, little-endian
    // in is an array of 16 unsigned chars, big-endian
    memset(out.m_storage, 0, sizeof(out.m_storage));
    for (int i = 0; i < 16; i++)
        out.m_storage[i / 4] |= in[i] << (i % 4) * 8;
}

void VlWideToChar(VlWide<4UL> &in, unsigned char out[16])
{
    // m_storage is an array of 4 unsigned longs, little-endian
    // out is an array of 16 unsigned chars, big-endian
    for (int i = 0; i < 16; i++)
        out[i] = (unsigned char)(in.m_storage[i / 4] >> (i % 4) * 8);
}

#define run_until_ready(dut, sim_time, m_trace)               \
    do                                                        \
    {                                                         \
        while (!dut->ready)                                   \
        {                                                     \
            dut->clk ^= 1;                                    \
            dut->load = dut->clk ? dut->load ^ 1 : dut->load; \
            dut->eval();                                      \
            m_trace->dump(sim_time);                          \
            sim_time++;                                       \
        }                                                     \
    } while (0)

#define reset(dut, cycles, sim_time, m_trace)     \
    do                                            \
    {                                             \
        dut->reset = 0;                           \
        for (unsigned int i = 0; i < cycles; i++) \
        {                                         \
            dut->clk ^= 1;                        \
            dut->eval();                          \
            m_trace->dump(sim_time);              \
            sim_time++;                           \
        }                                         \
        dut->reset = 1;                           \
    } while (0)

#define print_hex(x, length)                    \
    do                                          \
    {                                           \
        for (int i = 0; i < length; i++)        \
        {                                       \
            std::cout << std::hex << (int)x[i]; \
        }                                       \
        std::cout << std::endl;                 \
    } while (0)

#define compare(x, y, length)                        \
    do                                               \
    {                                                \
        if (memcmp(x, y, length) == 0)               \
        {                                            \
            std::cout << "Test passed" << std::endl; \
        }                                            \
        else                                         \
        {                                            \
            std::cout << "Test failed" << std::endl; \
            std::cout << "Expected: ";               \
            print_hex(y, length);                    \
            std::cout << "Got: ";                    \
            print_hex(x, length);                    \
        }                                            \
    } while (0)

int main(int argc, char **argv, char **env)
{
    auto *dut = new VARS_aes;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("waveform.vcd");

    vluint64_t sim_time = 0;

    unsigned int vector_count = sizeof(testVectors) / sizeof(testVectors[0]), now_vector = 0;
    for (auto vector : testVectors)
    {

        std::cout << "Vector " << vector_count << "/" << ++now_vector << std::endl;
        unsigned char dout[16];

        // encryption
        dut->enc = 0;
        reset(dut, 10, sim_time, m_trace);
        CharToVlWide(vector.k, dut->key);
        CharToVlWide(vector.pt, dut->din);
        run_until_ready(dut, sim_time, m_trace);
        // encryption verification
        VlWideToChar(dut->dout, dout);
        std::cout << "Encryption: ";
        compare(dout, vector.ct, sizeof(dout));

        // decryption
        dut->enc = 1;
        reset(dut, 10, sim_time, m_trace);
        CharToVlWide(vector.ct, dut->din);
        run_until_ready(dut, sim_time, m_trace);
        // decryption verification
        VlWideToChar(dut->dout, dout);
        std::cout << "Decryption: ";
        compare(dout, vector.pt, sizeof(dout));
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
    return 0;
}
