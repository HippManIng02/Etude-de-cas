_cqa_text_report = {
  paths = {
    {
      hint = {
        {
          details = "Calling (and then returning from) a function prevents many compiler optimizations (like vectorization), breaks control flow (which reduces pipeline performance) and executes extra instructions to save/restore the registers used inside it, which is very expensive (dozens of cycles). Consider to inline small functions.\n - unknown: 1 occurrences\n",
          title = "CALL instructions",
          txt = "Detected function call instructions.\n",
        },
        {
          details = "These instructions generate more than one micro-operation and only one of them can be decoded during a cycle and the extra micro-operations increase pressure on execution units.\n - JMP: 1 occurrences\n",
          title = "Complex instructions",
          txt = "Detected COMPLEX INSTRUCTIONS.\n",
        },
        {
          title = "Type of elements and instruction set",
          txt = "No instructions are processing arithmetic or math operations on FP elements. This function is probably writing/copying data or processing integer elements.",
        },
        {
          title = "Matching between your function (in the source code) and the binary function",
          txt = "The binary function does not contain any FP arithmetical operations.\nThe binary function is loading 8 bytes.\nThe binary function is storing 28 bytes.",
        },
      },
      expert = {
        {
          title = "General properties",
          txt = "nb instructions    : 35\nnb uops            : 44\nloop length        : 118\nused x86 registers : 11\nused mmx registers : 0\nused xmm registers : 0\nused ymm registers : 0\nused zmm registers : 0\nnb stack references: 4\n",
        },
        {
          title = "Front-end",
          txt = "MACRO FUSION NOT POSSIBLE\nFIT IN UOP CACHE\nmicro-operation queue: 7.33 cycles\nfront end            : 7.33 cycles\n",
        },
        {
          title = "Back-end",
          txt = "       | ALU0/BRU0 | ALU1 | ALU2 | ALU3/BRU1 | AGU0 | AGU1 | FP0  | FP1  | FP2  | FP3\n--------------------------------------------------------------------------------------\nuops   | 4.00      | 4.00 | 4.00 | 4.00      | 3.00 | 3.00 | 0.00 | 0.00 | 0.00 | 0.00\ncycles | 4.00      | 4.00 | 4.00 | 4.00      | 3.00 | 3.00 | 0.00 | 0.00 | 0.00 | 0.00\n\nExecution ports to units layout:\n - ALU0/BRU0: ALU\n - ALU1: ALU\n - ALU2: ALU\n - ALU3/BRU1: ALU\n - AGU0 (128 bits): store address, load\n - AGU1 (128 bits): store address, load\n - FP0 (128 bits): VPU\n - FP1 (128 bits): VPU\n - FP2 (128 bits): VPU, FP store data\n - FP3 (128 bits): VPU, DIV/SQRT\n\nCycles executing div or sqrt instructions: NA\nCycles loading/storing data              : 4.00\n",
        },
        {
          title = "Cycles summary",
          txt = "Front-end : 7.33\nDispatch  : 4.00\nOverall L1: 7.33\n",
        },
        {
          title = "Vectorization ratios",
          txt = "all     : 0%\nload    : 0%\nstore   : 0%\nmul     : 0%\nadd-sub : NA (no add-sub vectorizable/vectorized instructions)\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: NA (no div/sqrt vectorizable/vectorized instructions)\nother   : 0%\n",
        },
        {
          title = "Vector efficiency ratios",
          txt = "all     : 19%\nload    : 25%\nstore   : 21%\nmul     : 12%\nadd-sub : NA (no add-sub vectorizable/vectorized instructions)\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: NA (no div/sqrt vectorizable/vectorized instructions)\nother   : 17%\n",
        },
        {
          title = "Cycles and memory resources usage",
          txt = "Assuming all data fit into the L1 cache, each call to the function takes 7.33 cycles. At this rate:\n - 3% of peak load performance is reached (1.09 out of 32.00 bytes loaded per cycle (GB/s @ 1GHz))\n - 23% of peak store performance is reached (3.82 out of 16.00 bytes stored per cycle (GB/s @ 1GHz))\n",
        },
        {
          title = "Front-end bottlenecks",
          txt = "Performance is limited by instruction throughput (loading/decoding program instructions to execution core) (front-end is a bottleneck).\n\nBy removing all these bottlenecks, you can lower the cost of an iteration from 7.33 to 4.00 cycles (1.83x speedup).\n",
        },
        {
          title = "ASM code",
          txt = "In the binary file, the address of the function is: 1810\n\nInstruction                     | Nb FU | ALU0/BRU0 | ALU1 | ALU2 | ALU3/BRU1 | AGU0 | AGU1 | FP0 | FP1 | FP2 | FP3 | Latency | Recip. throughput\n-------------------------------------------------------------------------------------------------------------------------------------------------\nENDBR64\nPUSH %R15                       | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 1\nMOV %EDI,%R15D                  | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 0       | 0.25\nMOV %R15D,%EDI                  | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 0       | 0.25\nPUSH %R14                       | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 1\nIMUL %R15D,%EDI                 | 1     | 0         | 1    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 3       | 1\nPUSH %R13                       | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 1\nMOV %RSI,%R13                   | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 0       | 0.25\nPUSH %R12                       | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 1\nPUSH %RBP                       | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 1\nPUSH %RBX                       | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 1\nSAL $0x3,%RDI                   | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nSUB $0x28,%RSP                  | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nMOV %R15D,0xc(%RSP)             | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 4       | 1\nMOV %RDX,0x10(%RSP)             | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 4       | 1\nMOV %R15,0x18(%RSP)             | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 4       | 1\nCALL 1140 <.plt.sec@start+0x60> | 6     | 1.25      | 1.25 | 1.25 | 1.25      | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 0       | 1\nMOV %RAX,(%RSP)                 | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 4       | 1\nTEST %R15D,%R15D                | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nJE 18ed <kernel+0xdd>           | 1     | 0.50      | 0    | 0    | 0.50      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.50\nSAL $0x3,%R15                   | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nXOR %EBX,%EBX                   | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 0       | 0.25\nNOPW (%RAX,%RAX,1)              | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nNOPL (%RAX)                     | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nMOV (%RSP),%RDI                 | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 3       | 0.50\nADD $0x28,%RSP                  | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nPOP %RBX                        | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.50\nPOP %RBP                        | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.50\nPOP %R12                        | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.50\nPOP %R13                        | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.50\nPOP %R14                        | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.50\nPOP %R15                        | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.50\nJMP 10e0 <.plt.sec@start>       | 6     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 0       | 2\nNOPW %CS:(%RAX,%RAX,1)          | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nXCHG %AX,%AX                    | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\n",
        },
      },
      header = {
        "Warnings:\n - The number of fused uops of the instruction [ENDBR64] is unknown\n - Detected a function call instruction: ignoring called function instructions.\nRerun with --follow-calls=append to include them to analysis  or with --follow-calls=inline to simulate inlining.\n",
        "0% of peak computational performance is used (0.00 out of 24.00 FLOP per cycle (GFLOPS @ 1GHz))",
      },
      brief = {
      },
      gain = {
        {
          workaround = " - Try another compiler or update/tune your current one\n - Make array accesses unit-stride:\n  * If your function streams arrays of structures (AoS), try to use structures of arrays instead (SoA):\nfor(i) a[i].x = b[i].x; (slow, non stride 1) => for(i) a.x[i] = b.x[i]; (fast, stride 1)\n",
          details = "All SSE/AVX instructions are used in scalar version (process only one data element in vector registers).\nSince your execution units are vector units, only a vectorized function can use their full power.\n",
          title = "Vectorization",
          txt = "Your function is not vectorized.\nOnly 19% of vector register length is used (average across all SSE/AVX instructions).\nBy vectorizing your function, you can lower the cost of an iteration from 7.33 to 1.07 cycles (6.83x speedup).",
        },
        {
          title = "Execution units bottlenecks",
          txt = "Found no such bottlenecks but see expert reports for more complex bottlenecks.",
        },
      },
      potential = {
      },
    },
  },
  AVG = {
      hint = {
        {
          details = "Calling (and then returning from) a function prevents many compiler optimizations (like vectorization), breaks control flow (which reduces pipeline performance) and executes extra instructions to save/restore the registers used inside it, which is very expensive (dozens of cycles). Consider to inline small functions.\n - unknown: 1 occurrences\n",
          title = "CALL instructions",
          txt = "Detected function call instructions.\n",
        },
        {
          details = "These instructions generate more than one micro-operation and only one of them can be decoded during a cycle and the extra micro-operations increase pressure on execution units.\n - JMP: 1 occurrences\n",
          title = "Complex instructions",
          txt = "Detected COMPLEX INSTRUCTIONS.\n",
        },
        {
          title = "Type of elements and instruction set",
          txt = "No instructions are processing arithmetic or math operations on FP elements. This function is probably writing/copying data or processing integer elements.",
        },
        {
          title = "Matching between your function (in the source code) and the binary function",
          txt = "The binary function does not contain any FP arithmetical operations.\nThe binary function is loading 8 bytes.\nThe binary function is storing 28 bytes.",
        },
      },
      expert = {
        {
          title = "General properties",
          txt = "nb instructions    : 35\nnb uops            : 44\nloop length        : 118\nused x86 registers : 11\nused mmx registers : 0\nused xmm registers : 0\nused ymm registers : 0\nused zmm registers : 0\nnb stack references: 4\n",
        },
        {
          title = "Front-end",
          txt = "MACRO FUSION NOT POSSIBLE\nFIT IN UOP CACHE\nmicro-operation queue: 7.33 cycles\nfront end            : 7.33 cycles\n",
        },
        {
          title = "Back-end",
          txt = "       | ALU0/BRU0 | ALU1 | ALU2 | ALU3/BRU1 | AGU0 | AGU1 | FP0  | FP1  | FP2  | FP3\n--------------------------------------------------------------------------------------\nuops   | 4.00      | 4.00 | 4.00 | 4.00      | 3.00 | 3.00 | 0.00 | 0.00 | 0.00 | 0.00\ncycles | 4.00      | 4.00 | 4.00 | 4.00      | 3.00 | 3.00 | 0.00 | 0.00 | 0.00 | 0.00\n\nExecution ports to units layout:\n - ALU0/BRU0: ALU\n - ALU1: ALU\n - ALU2: ALU\n - ALU3/BRU1: ALU\n - AGU0 (128 bits): store address, load\n - AGU1 (128 bits): store address, load\n - FP0 (128 bits): VPU\n - FP1 (128 bits): VPU\n - FP2 (128 bits): VPU, FP store data\n - FP3 (128 bits): VPU, DIV/SQRT\n\nCycles executing div or sqrt instructions: NA\nCycles loading/storing data              : 4.00\n",
        },
        {
          title = "Cycles summary",
          txt = "Front-end : 7.33\nDispatch  : 4.00\nOverall L1: 7.33\n",
        },
        {
          title = "Vectorization ratios",
          txt = "all     : 0%\nload    : 0%\nstore   : 0%\nmul     : 0%\nadd-sub : NA (no add-sub vectorizable/vectorized instructions)\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: NA (no div/sqrt vectorizable/vectorized instructions)\nother   : 0%\n",
        },
        {
          title = "Vector efficiency ratios",
          txt = "all     : 19%\nload    : 25%\nstore   : 21%\nmul     : 12%\nadd-sub : NA (no add-sub vectorizable/vectorized instructions)\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: NA (no div/sqrt vectorizable/vectorized instructions)\nother   : 17%\n",
        },
        {
          title = "Cycles and memory resources usage",
          txt = "Assuming all data fit into the L1 cache, each call to the function takes 7.33 cycles. At this rate:\n - 3% of peak load performance is reached (1.09 out of 32.00 bytes loaded per cycle (GB/s @ 1GHz))\n - 23% of peak store performance is reached (3.82 out of 16.00 bytes stored per cycle (GB/s @ 1GHz))\n",
        },
        {
          title = "Front-end bottlenecks",
          txt = "Performance is limited by instruction throughput (loading/decoding program instructions to execution core) (front-end is a bottleneck).\n\nBy removing all these bottlenecks, you can lower the cost of an iteration from 7.33 to 4.00 cycles (1.83x speedup).\n",
        },
        {
          title = "ASM code",
          txt = "In the binary file, the address of the function is: 1810\n\nInstruction                     | Nb FU | ALU0/BRU0 | ALU1 | ALU2 | ALU3/BRU1 | AGU0 | AGU1 | FP0 | FP1 | FP2 | FP3 | Latency | Recip. throughput\n-------------------------------------------------------------------------------------------------------------------------------------------------\nENDBR64\nPUSH %R15                       | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 1\nMOV %EDI,%R15D                  | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 0       | 0.25\nMOV %R15D,%EDI                  | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 0       | 0.25\nPUSH %R14                       | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 1\nIMUL %R15D,%EDI                 | 1     | 0         | 1    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 3       | 1\nPUSH %R13                       | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 1\nMOV %RSI,%R13                   | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 0       | 0.25\nPUSH %R12                       | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 1\nPUSH %RBP                       | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 1\nPUSH %RBX                       | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 1\nSAL $0x3,%RDI                   | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nSUB $0x28,%RSP                  | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nMOV %R15D,0xc(%RSP)             | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 4       | 1\nMOV %RDX,0x10(%RSP)             | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 4       | 1\nMOV %R15,0x18(%RSP)             | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 4       | 1\nCALL 1140 <.plt.sec@start+0x60> | 6     | 1.25      | 1.25 | 1.25 | 1.25      | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 0       | 1\nMOV %RAX,(%RSP)                 | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 4       | 1\nTEST %R15D,%R15D                | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nJE 18ed <kernel+0xdd>           | 1     | 0.50      | 0    | 0    | 0.50      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.50\nSAL $0x3,%R15                   | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nXOR %EBX,%EBX                   | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 0       | 0.25\nNOPW (%RAX,%RAX,1)              | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nNOPL (%RAX)                     | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nMOV (%RSP),%RDI                 | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 3       | 0.50\nADD $0x28,%RSP                  | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nPOP %RBX                        | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.50\nPOP %RBP                        | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.50\nPOP %R12                        | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.50\nPOP %R13                        | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.50\nPOP %R14                        | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.50\nPOP %R15                        | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.50\nJMP 10e0 <.plt.sec@start>       | 6     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 0       | 2\nNOPW %CS:(%RAX,%RAX,1)          | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nXCHG %AX,%AX                    | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\n",
        },
      },
      header = {
        "Warnings:\n - The number of fused uops of the instruction [ENDBR64] is unknown\n - Detected a function call instruction: ignoring called function instructions.\nRerun with --follow-calls=append to include them to analysis  or with --follow-calls=inline to simulate inlining.\n",
        "0% of peak computational performance is used (0.00 out of 24.00 FLOP per cycle (GFLOPS @ 1GHz))",
      },
      brief = {
      },
      gain = {
        {
          workaround = " - Try another compiler or update/tune your current one\n - Make array accesses unit-stride:\n  * If your function streams arrays of structures (AoS), try to use structures of arrays instead (SoA):\nfor(i) a[i].x = b[i].x; (slow, non stride 1) => for(i) a.x[i] = b.x[i]; (fast, stride 1)\n",
          details = "All SSE/AVX instructions are used in scalar version (process only one data element in vector registers).\nSince your execution units are vector units, only a vectorized function can use their full power.\n",
          title = "Vectorization",
          txt = "Your function is not vectorized.\nOnly 19% of vector register length is used (average across all SSE/AVX instructions).\nBy vectorizing your function, you can lower the cost of an iteration from 7.33 to 1.07 cycles (6.83x speedup).",
        },
        {
          title = "Execution units bottlenecks",
          txt = "Found no such bottlenecks but see expert reports for more complex bottlenecks.",
        },
      },
      potential = {
      },
    },
  common = {
    header = {
      "The function is defined in /home/hippolyte/Documents/Projet/AOA/demo_2024/Etude-de-cas/kernel.c:3-16,25-31.\n",
      "Warnings:\nIgnoring paths for analysis",
    },
  },
  _objects = {
     ["image_vec_align"] = {type = "image", format = "url", data = "../images/cqa/vec_align.svg", size = {x = 500, }, },
     ["image_1x64_512"] = {type = "image", format = "url", data = "../images/cqa/1x64_512.svg", size = {x = 500, }, },
     ["image_1x32_128"] = {type = "image", format = "url", data = "../images/cqa/1x32_128.svg", size = {x = 500, }, },
     ["image_4x32_256"] = {type = "image", format = "url", data = "../images/cqa/4x32_256.svg", size = {x = 500, }, },
     ["image_1x64_128"] = {type = "image", format = "url", data = "../images/cqa/1x64_128.svg", size = {x = 500, }, },
     ["image_4x32_512"] = {type = "image", format = "url", data = "../images/cqa/4x32_512.svg", size = {x = 500, }, },
     ["image_8x32_512"] = {type = "image", format = "url", data = "../images/cqa/8x32_512.svg", size = {x = 500, }, },
     ["image_1x32_256"] = {type = "image", format = "url", data = "../images/cqa/1x32_256.svg", size = {x = 500, }, },
     ["image_2x64_512"] = {type = "image", format = "url", data = "../images/cqa/2x64_512.svg", size = {x = 500, }, },
     ["image_col_maj"] = {type = "image", format = "url", data = "../images/cqa/col_maj.svg", size = {x = 500, }, },
     ["image_1x64_256"] = {type = "image", format = "url", data = "../images/cqa/1x64_256.svg", size = {x = 500, }, },
     ["image_row_maj"] = {type = "image", format = "url", data = "../images/cqa/row_maj.svg", size = {x = 500, }, },
     ["image_4x64_512"] = {type = "image", format = "url", data = "../images/cqa/4x64_512.svg", size = {x = 500, }, },
     ["image_1x32_512"] = {type = "image", format = "url", data = "../images/cqa/1x32_512.svg", size = {x = 500, }, },
     ["image_2x64_256"] = {type = "image", format = "url", data = "../images/cqa/2x64_256.svg", size = {x = 500, }, },
  },
}
