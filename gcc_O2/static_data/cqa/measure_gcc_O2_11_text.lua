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
          workaround = " - Try to reorganize arrays of structures to structures of arrays\n - Consider to permute loops (see vectorization gain report)\n",
          details = " - Constant unknown stride: 2 occurrence(s)\nNon-unit stride (uncontiguous) accesses are not efficiently using data caches\n",
          title = "Slow data structures access",
          txt = "Detected data structures (typically arrays) that cannot be efficiently read/written",
        },
        {
          title = "Type of elements and instruction set",
          txt = "No instructions are processing arithmetic or math operations on FP elements. This loop is probably writing/copying data or processing integer elements.",
        },
        {
          title = "Matching between your loop (in the source code) and the binary loop",
          txt = "The binary loop does not contain any FP arithmetical operations.\nThe binary loop is loading 32 bytes.\nThe binary loop is storing 8 bytes.",
        },
        {
          workaround = "Unroll your loop if trip count is significantly higher than target unroll factor and if some data references are common to consecutive iterations. This can be done manually. Or by recompiling with -funroll-loops and/or -floop-unroll-and-jam. Or with the unroll (resp. unroll_and_jam) directive on top of the inner (resp. surrounding) loop. You can enforce an unroll factor: #pragma GCC unroll N",
          title = "Unroll opportunity",
          txt = "Loop is data access bound.",
        },
      },
      expert = {
        {
          title = "General properties",
          txt = "nb instructions    : 11\nnb uops            : 15\nloop length        : 46\nused x86 registers : 8\nused mmx registers : 0\nused xmm registers : 2\nused ymm registers : 0\nused zmm registers : 0\nnb stack references: 2\n",
        },
        {
          title = "Front-end",
          txt = "ASSUMED MACRO FUSION\nFIT IN UOP CACHE\nmicro-operation queue: 2.50 cycles\nfront end            : 2.50 cycles\n",
        },
        {
          title = "Back-end",
          txt = "       | ALU0/BRU0 | ALU1 | ALU2 | ALU3/BRU1 | AGU0 | AGU1 | FP0  | FP1  | FP2  | FP3\n--------------------------------------------------------------------------------------\nuops   | 2.00      | 2.00 | 2.00 | 2.00      | 3.00 | 3.00 | 0.00 | 0.00 | 1.00 | 0.00\ncycles | 2.00      | 2.00 | 2.00 | 2.00      | 3.00 | 3.00 | 0.00 | 0.00 | 1.00 | 0.00\n\nExecution ports to units layout:\n - ALU0/BRU0: ALU\n - ALU1: ALU\n - ALU2: ALU\n - ALU3/BRU1: ALU\n - AGU0 (128 bits): store address, load\n - AGU1 (128 bits): store address, load\n - FP0 (128 bits): VPU\n - FP1 (128 bits): VPU\n - FP2 (128 bits): VPU, FP store data\n - FP3 (128 bits): VPU, DIV/SQRT\n\nCycles executing div or sqrt instructions: NA\nCycles loading/storing data              : 2.00\nLongest recurrence chain latency (RecMII): 1.00\n",
        },
        {
          title = "Cycles summary",
          txt = "Front-end : 2.50\nDispatch  : 3.00\nData deps.: 1.00\nOverall L1: 3.00\n",
        },
        {
          title = "Vectorization ratios",
          txt = "INT\nall    : 0%\nload   : NA (no load vectorizable/vectorized instructions)\nstore  : NA (no store vectorizable/vectorized instructions)\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: 0%\nfma    : NA (no fma vectorizable/vectorized instructions)\nother  : NA (no other vectorizable/vectorized instructions)\nFP\nall     : 0%\nload    : 0%\nstore   : 0%\nmul     : NA (no mul vectorizable/vectorized instructions)\nadd-sub : NA (no add-sub vectorizable/vectorized instructions)\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: NA (no div/sqrt vectorizable/vectorized instructions)\nother   : NA (no other vectorizable/vectorized instructions)\nINT+FP\nall     : 0%\nload    : 0%\nstore   : 0%\nmul     : NA (no mul vectorizable/vectorized instructions)\nadd-sub : 0%\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: NA (no div/sqrt vectorizable/vectorized instructions)\nother   : NA (no other vectorizable/vectorized instructions)\n",
        },
        {
          title = "Vector efficiency ratios",
          txt = "INT\nall    : 12%\nload   : NA (no load vectorizable/vectorized instructions)\nstore  : NA (no store vectorizable/vectorized instructions)\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: 12%\nfma    : NA (no fma vectorizable/vectorized instructions)\nother  : NA (no other vectorizable/vectorized instructions)\nFP\nall     : 25%\nload    : 25%\nstore   : 25%\nmul     : NA (no mul vectorizable/vectorized instructions)\nadd-sub : NA (no add-sub vectorizable/vectorized instructions)\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: NA (no div/sqrt vectorizable/vectorized instructions)\nother   : NA (no other vectorizable/vectorized instructions)\nINT+FP\nall     : 21%\nload    : 25%\nstore   : 25%\nmul     : NA (no mul vectorizable/vectorized instructions)\nadd-sub : 12%\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: NA (no div/sqrt vectorizable/vectorized instructions)\nother   : NA (no other vectorizable/vectorized instructions)\n",
        },
        {
          title = "Cycles and memory resources usage",
          txt = "Assuming all data fit into the L1 cache, each iteration of the binary loop takes 3.00 cycles. At this rate:\n - 33% of peak load performance is reached (10.67 out of 32.00 bytes loaded per cycle (GB/s @ 1GHz))\n - 16% of peak store performance is reached (2.67 out of 16.00 bytes stored per cycle (GB/s @ 1GHz))\n",
        },
        {
          title = "Front-end bottlenecks",
          txt = "Found no such bottlenecks.",
        },
        {
          title = "ASM code",
          txt = "In the binary file, the address of the loop is: 18b0\n\nInstruction                     | Nb FU | ALU0/BRU0 | ALU1 | ALU2 | ALU3/BRU1 | AGU0 | AGU1 | FP0 | FP1 | FP2 | FP3 | Latency | Recip. throughput\n-------------------------------------------------------------------------------------------------------------------------------------------------\nMOV (%RSP),%RAX                 | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 3       | 0.50\nMOVSD (%R13,%R14,1),%XMM0       | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 1       | 0.50\nMOVSD (%RAX,%R14,1),%XMM1       | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 1       | 0.50\nCALL 1100 <.plt.sec@start+0x20> | 6     | 1.25      | 1.25 | 1.25 | 1.25      | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 0       | 1\nMOV 0x10(%RSP),%RAX             | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 3       | 0.50\nMOV %EBP,%ESI                   | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 0       | 0.25\nADD $0x1,%EBP                   | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nMOVSD %XMM0,(%RAX,%R14,1)       | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 1   | 0   | 1       | 1\nADD %R15,%R14                   | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nCMP %R12D,%ESI                  | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nJNE 18b0 <kernel+0xa0>          | 1     | 0.50      | 0    | 0    | 0.50      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.50\n",
        },
      },
      header = {
        "Warnings:\nDetected a function call instruction: ignoring called function instructions.\nRerun with --follow-calls=append to include them to analysis  or with --follow-calls=inline to simulate inlining.",
        "0% of peak computational performance is used (0.00 out of 24.00 FLOP per cycle (GFLOPS @ 1GHz))",
      },
      brief = {
      },
      gain = {
        {
          workaround = " - Try to reorganize arrays of structures to structures of arrays\n - Consider to permute loops (see vectorization gain report)\n",
          title = "Code clean check",
          txt = "Detected a slowdown caused by scalar integer instructions (typically used for address computation).\nBy removing them, you can lower the cost of an iteration from 3.00 to 1.50 cycles (2.00x speedup).",
        },
        {
          workaround = " - Try another compiler or update/tune your current one:\n  * recompile with ftree-vectorize (included in O3) to enable loop vectorization and with fassociative-math (included in Ofast or ffast-math) to extend vectorization to FP reductions.\n - Remove inter-iterations dependences from your loop and make it unit-stride:\n  * If your arrays have 2 or more dimensions, check whether elements are accessed contiguously and, otherwise, try to permute loops accordingly:\nC storage order is row-major: for(i) for(j) a[j][i] = b[j][i]; (slow, non stride 1) => for(i) for(j) a[i][j] = b[i][j]; (fast, stride 1)<<image_row_maj>>\n  * If your loop streams arrays of structures (AoS), try to use structures of arrays instead (SoA):\nfor(i) a[i].x = b[i].x; (slow, non stride 1) => for(i) a.x[i] = b.x[i]; (fast, stride 1)\n",
          details = "All SSE/AVX instructions are used in scalar version (process only one data element in vector registers).\nSince your execution units are vector units, only a vectorized loop can use their full power.\n",
          title = "Vectorization",
          txt = "Your loop is not vectorized.\nOnly 21% of vector register length is used (average across all SSE/AVX instructions).\nBy vectorizing your loop, you can lower the cost of an iteration from 3.00 to 0.56 cycles (5.33x speedup).",
        },
        {
          workaround = " - Read less array elements\n - Write less array elements\n - Provide more information to your compiler:\n  * hardcode the bounds of the corresponding 'for' loop\n  * use the 'restrict' C99 keyword\n",
          title = "Execution units bottlenecks",
          txt = "Performance is limited by:\n - reading data from caches/RAM (load units are a bottleneck)\n - writing data to caches/RAM (the store unit is a bottleneck)\n\nBy removing all these bottlenecks, you can lower the cost of an iteration from 3.00 to 2.50 cycles (1.20x speedup).\n",
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
          workaround = " - Try to reorganize arrays of structures to structures of arrays\n - Consider to permute loops (see vectorization gain report)\n",
          details = " - Constant unknown stride: 2 occurrence(s)\nNon-unit stride (uncontiguous) accesses are not efficiently using data caches\n",
          title = "Slow data structures access",
          txt = "Detected data structures (typically arrays) that cannot be efficiently read/written",
        },
        {
          title = "Type of elements and instruction set",
          txt = "No instructions are processing arithmetic or math operations on FP elements. This loop is probably writing/copying data or processing integer elements.",
        },
        {
          title = "Matching between your loop (in the source code) and the binary loop",
          txt = "The binary loop does not contain any FP arithmetical operations.\nThe binary loop is loading 32 bytes.\nThe binary loop is storing 8 bytes.",
        },
        {
          workaround = "Unroll your loop if trip count is significantly higher than target unroll factor and if some data references are common to consecutive iterations. This can be done manually. Or by recompiling with -funroll-loops and/or -floop-unroll-and-jam. Or with the unroll (resp. unroll_and_jam) directive on top of the inner (resp. surrounding) loop. You can enforce an unroll factor: #pragma GCC unroll N",
          title = "Unroll opportunity",
          txt = "Loop is data access bound.",
        },
      },
      expert = {
        {
          title = "General properties",
          txt = "nb instructions    : 11\nnb uops            : 15\nloop length        : 46\nused x86 registers : 8\nused mmx registers : 0\nused xmm registers : 2\nused ymm registers : 0\nused zmm registers : 0\nnb stack references: 2\n",
        },
        {
          title = "Front-end",
          txt = "ASSUMED MACRO FUSION\nFIT IN UOP CACHE\nmicro-operation queue: 2.50 cycles\nfront end            : 2.50 cycles\n",
        },
        {
          title = "Back-end",
          txt = "       | ALU0/BRU0 | ALU1 | ALU2 | ALU3/BRU1 | AGU0 | AGU1 | FP0  | FP1  | FP2  | FP3\n--------------------------------------------------------------------------------------\nuops   | 2.00      | 2.00 | 2.00 | 2.00      | 3.00 | 3.00 | 0.00 | 0.00 | 1.00 | 0.00\ncycles | 2.00      | 2.00 | 2.00 | 2.00      | 3.00 | 3.00 | 0.00 | 0.00 | 1.00 | 0.00\n\nExecution ports to units layout:\n - ALU0/BRU0: ALU\n - ALU1: ALU\n - ALU2: ALU\n - ALU3/BRU1: ALU\n - AGU0 (128 bits): store address, load\n - AGU1 (128 bits): store address, load\n - FP0 (128 bits): VPU\n - FP1 (128 bits): VPU\n - FP2 (128 bits): VPU, FP store data\n - FP3 (128 bits): VPU, DIV/SQRT\n\nCycles executing div or sqrt instructions: NA\nCycles loading/storing data              : 2.00\nLongest recurrence chain latency (RecMII): 1.00\n",
        },
        {
          title = "Cycles summary",
          txt = "Front-end : 2.50\nDispatch  : 3.00\nData deps.: 1.00\nOverall L1: 3.00\n",
        },
        {
          title = "Vectorization ratios",
          txt = "INT\nall    : 0%\nload   : NA (no load vectorizable/vectorized instructions)\nstore  : NA (no store vectorizable/vectorized instructions)\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: 0%\nfma    : NA (no fma vectorizable/vectorized instructions)\nother  : NA (no other vectorizable/vectorized instructions)\nFP\nall     : 0%\nload    : 0%\nstore   : 0%\nmul     : NA (no mul vectorizable/vectorized instructions)\nadd-sub : NA (no add-sub vectorizable/vectorized instructions)\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: NA (no div/sqrt vectorizable/vectorized instructions)\nother   : NA (no other vectorizable/vectorized instructions)\nINT+FP\nall     : 0%\nload    : 0%\nstore   : 0%\nmul     : NA (no mul vectorizable/vectorized instructions)\nadd-sub : 0%\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: NA (no div/sqrt vectorizable/vectorized instructions)\nother   : NA (no other vectorizable/vectorized instructions)\n",
        },
        {
          title = "Vector efficiency ratios",
          txt = "INT\nall    : 12%\nload   : NA (no load vectorizable/vectorized instructions)\nstore  : NA (no store vectorizable/vectorized instructions)\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: 12%\nfma    : NA (no fma vectorizable/vectorized instructions)\nother  : NA (no other vectorizable/vectorized instructions)\nFP\nall     : 25%\nload    : 25%\nstore   : 25%\nmul     : NA (no mul vectorizable/vectorized instructions)\nadd-sub : NA (no add-sub vectorizable/vectorized instructions)\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: NA (no div/sqrt vectorizable/vectorized instructions)\nother   : NA (no other vectorizable/vectorized instructions)\nINT+FP\nall     : 21%\nload    : 25%\nstore   : 25%\nmul     : NA (no mul vectorizable/vectorized instructions)\nadd-sub : 12%\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: NA (no div/sqrt vectorizable/vectorized instructions)\nother   : NA (no other vectorizable/vectorized instructions)\n",
        },
        {
          title = "Cycles and memory resources usage",
          txt = "Assuming all data fit into the L1 cache, each iteration of the binary loop takes 3.00 cycles. At this rate:\n - 33% of peak load performance is reached (10.67 out of 32.00 bytes loaded per cycle (GB/s @ 1GHz))\n - 16% of peak store performance is reached (2.67 out of 16.00 bytes stored per cycle (GB/s @ 1GHz))\n",
        },
        {
          title = "Front-end bottlenecks",
          txt = "Found no such bottlenecks.",
        },
        {
          title = "ASM code",
          txt = "In the binary file, the address of the loop is: 18b0\n\nInstruction                     | Nb FU | ALU0/BRU0 | ALU1 | ALU2 | ALU3/BRU1 | AGU0 | AGU1 | FP0 | FP1 | FP2 | FP3 | Latency | Recip. throughput\n-------------------------------------------------------------------------------------------------------------------------------------------------\nMOV (%RSP),%RAX                 | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 3       | 0.50\nMOVSD (%R13,%R14,1),%XMM0       | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 1       | 0.50\nMOVSD (%RAX,%R14,1),%XMM1       | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 1       | 0.50\nCALL 1100 <.plt.sec@start+0x20> | 6     | 1.25      | 1.25 | 1.25 | 1.25      | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 0       | 1\nMOV 0x10(%RSP),%RAX             | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 3       | 0.50\nMOV %EBP,%ESI                   | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 0       | 0.25\nADD $0x1,%EBP                   | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nMOVSD %XMM0,(%RAX,%R14,1)       | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 1   | 0   | 1       | 1\nADD %R15,%R14                   | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nCMP %R12D,%ESI                  | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nJNE 18b0 <kernel+0xa0>          | 1     | 0.50      | 0    | 0    | 0.50      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.50\n",
        },
      },
      header = {
        "Warnings:\nDetected a function call instruction: ignoring called function instructions.\nRerun with --follow-calls=append to include them to analysis  or with --follow-calls=inline to simulate inlining.",
        "0% of peak computational performance is used (0.00 out of 24.00 FLOP per cycle (GFLOPS @ 1GHz))",
      },
      brief = {
      },
      gain = {
        {
          workaround = " - Try to reorganize arrays of structures to structures of arrays\n - Consider to permute loops (see vectorization gain report)\n",
          title = "Code clean check",
          txt = "Detected a slowdown caused by scalar integer instructions (typically used for address computation).\nBy removing them, you can lower the cost of an iteration from 3.00 to 1.50 cycles (2.00x speedup).",
        },
        {
          workaround = " - Try another compiler or update/tune your current one:\n  * recompile with ftree-vectorize (included in O3) to enable loop vectorization and with fassociative-math (included in Ofast or ffast-math) to extend vectorization to FP reductions.\n - Remove inter-iterations dependences from your loop and make it unit-stride:\n  * If your arrays have 2 or more dimensions, check whether elements are accessed contiguously and, otherwise, try to permute loops accordingly:\nC storage order is row-major: for(i) for(j) a[j][i] = b[j][i]; (slow, non stride 1) => for(i) for(j) a[i][j] = b[i][j]; (fast, stride 1)<<image_row_maj>>\n  * If your loop streams arrays of structures (AoS), try to use structures of arrays instead (SoA):\nfor(i) a[i].x = b[i].x; (slow, non stride 1) => for(i) a.x[i] = b.x[i]; (fast, stride 1)\n",
          details = "All SSE/AVX instructions are used in scalar version (process only one data element in vector registers).\nSince your execution units are vector units, only a vectorized loop can use their full power.\n",
          title = "Vectorization",
          txt = "Your loop is not vectorized.\nOnly 21% of vector register length is used (average across all SSE/AVX instructions).\nBy vectorizing your loop, you can lower the cost of an iteration from 3.00 to 0.56 cycles (5.33x speedup).",
        },
        {
          workaround = " - Read less array elements\n - Write less array elements\n - Provide more information to your compiler:\n  * hardcode the bounds of the corresponding 'for' loop\n  * use the 'restrict' C99 keyword\n",
          title = "Execution units bottlenecks",
          txt = "Performance is limited by:\n - reading data from caches/RAM (load units are a bottleneck)\n - writing data to caches/RAM (the store unit is a bottleneck)\n\nBy removing all these bottlenecks, you can lower the cost of an iteration from 3.00 to 2.50 cycles (1.20x speedup).\n",
        },
      },
      potential = {
      },
    },
  common = {
    header = {
      "The loop is defined in /home/hippolyte/Documents/Projet/AOA/demo_2024/Etude-de-cas/kernel.c:25-27.\n",
      "The related source loop is not unrolled or unrolled with no peel/tail loop.",
    },
    nb_paths = 1,
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
