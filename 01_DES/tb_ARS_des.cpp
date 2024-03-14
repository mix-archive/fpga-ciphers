#include <stdlib.h>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>

#include "obj_dir/VARS_des.h"

#define MAX_SIM_TIME 2000

int main(int argc, char **argv, char **env)
{
    VARS_des *dut = new VARS_des;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("waveform.vcd");

    dut->reset = 0;
    dut->key = 0x0123456789abcdef;
    dut->din = 0x82bc228322dce089;
    dut->flag = 1;

    vluint64_t sim_time = 0;
    while (sim_time < MAX_SIM_TIME)
    {
        dut->clk ^= 1;
        dut->eval();
        m_trace->dump(sim_time);
        sim_time++;
        // wait for 100ns for global reset to finish
        if (sim_time == 10)
        {
            dut->reset = 1;
        }
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}
