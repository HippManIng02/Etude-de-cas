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
          workaround = "Recompile with march=znver1.\nCQA target is AMD_fam17h_mod11h (1st generation Athlon and Ryzen 3/5/7 APUs based on the Zen microarchitecture) but specialization flags are -march=x86-64",
          details = "These instructions generate more than one micro-operation and only one of them can be decoded during a cycle and the extra micro-operations increase pressure on execution units.\n - CVTSI2SD: 1 occurrences\n",
          title = "Complex instructions",
          txt = "Detected COMPLEX INSTRUCTIONS.\n",
        },
        {
          workaround = "Avoid mixing data with different types. In particular, check if the type of constants is the same as array elements.",
          details = " - CVTSI2SD (INT32/64 to FP64, scalar): 1 occurrences\n",
          title = "Conversion instructions",
          txt = "Detected expensive conversion instructions.",
        },
        {
          title = "Type of elements and instruction set",
          txt = "1 SSE or AVX instructions are processing arithmetic or math operations on double precision FP elements in scalar mode (one at a time).\n",
        },
        {
          title = "Matching between your loop (in the source code) and the binary loop",
          txt = "The binary loop is composed of 1 FP arithmetical operations:\n - 1: divide\nThe binary loop is loading 8 bytes (1 double precision FP elements).\nThe binary loop is storing 8 bytes (1 double precision FP elements).",
        },
        {
          title = "Arithmetic intensity",
          txt = "Arithmetic intensity is 0.06 FP operations per loaded or stored byte.",
        },
      },
      expert = {
        {
          title = "General properties",
          txt = "nb instructions    : 8\nnb uops            : 13\nloop length        : 36\nused x86 registers : 3\nused mmx registers : 0\nused xmm registers : 1\nused ymm registers : 0\nused zmm registers : 0\nnb stack references: 0\n",
        },
        {
          title = "Front-end",
          txt = "ASSUMED MACRO FUSION\nFIT IN UOP CACHE\nmicro-operation queue: 2.17 cycles\nfront end            : 2.17 cycles\n",
        },
        {
          title = "Back-end",
          txt = "       | ALU0/BRU0 | ALU1 | ALU2 | ALU3/BRU1 | AGU0 | AGU1 | FP0  | FP1  | FP2  | FP3\n--------------------------------------------------------------------------------------\nuops   | 1.75      | 1.75 | 1.75 | 1.75      | 1.50 | 1.50 | 0.67 | 0.33 | 1.00 | 2.00\ncycles | 1.75      | 1.75 | 1.75 | 1.75      | 1.50 | 1.50 | 0.67 | 0.33 | 1.00 | 2.00\n\nExecution ports to units layout:\n - ALU0/BRU0: ALU\n - ALU1: ALU\n - ALU2: ALU\n - ALU3/BRU1: ALU\n - AGU0 (128 bits): store address, load\n - AGU1 (128 bits): store address, load\n - FP0 (128 bits): VPU\n - FP1 (128 bits): VPU\n - FP2 (128 bits): VPU, FP store data\n - FP3 (128 bits): VPU, DIV/SQRT\n\nCycles executing div or sqrt instructions: 4.00-5.00\nCycles loading/storing data              : 1.00\nLongest recurrence chain latency (RecMII): 1.00\n",
        },
        {
          title = "Cycles summary",
          txt = "Front-end : 2.17\nDispatch  : 2.00\nDIV/SQRT  : 4.00-5.00\nData deps.: 1.00\nOverall L1: 4.00-5.00\n",
        },
        {
          title = "Vectorization ratios",
          txt = "INT\nall    : 50%\nload   : NA (no load vectorizable/vectorized instructions)\nstore  : NA (no store vectorizable/vectorized instructions)\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nfma    : NA (no fma vectorizable/vectorized instructions)\nother  : 50%\nFP\nall     : 0%\nload    : 0%\nstore   : 0%\nmul     : NA (no mul vectorizable/vectorized instructions)\nadd-sub : NA (no add-sub vectorizable/vectorized instructions)\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: 0%\nother   : NA (no other vectorizable/vectorized instructions)\nINT+FP\nall     : 25%\nload    : 0%\nstore   : 0%\nmul     : NA (no mul vectorizable/vectorized instructions)\nadd-sub : NA (no add-sub vectorizable/vectorized instructions)\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: 0%\nother   : 50%\n",
        },
        {
          title = "Vector efficiency ratios",
          txt = "INT\nall    : 31%\nload   : NA (no load vectorizable/vectorized instructions)\nstore  : NA (no store vectorizable/vectorized instructions)\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nfma    : NA (no fma vectorizable/vectorized instructions)\nother  : 31%\nFP\nall     : 25%\nload    : 25%\nstore   : 25%\nmul     : NA (no mul vectorizable/vectorized instructions)\nadd-sub : NA (no add-sub vectorizable/vectorized instructions)\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: 25%\nother   : NA (no other vectorizable/vectorized instructions)\nINT+FP\nall     : 28%\nload    : 25%\nstore   : 25%\nmul     : NA (no mul vectorizable/vectorized instructions)\nadd-sub : NA (no add-sub vectorizable/vectorized instructions)\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: 25%\nother   : 31%\n",
        },
        {
          title = "Cycles and memory resources usage",
          txt = "Assuming all data fit into the L1 cache, each iteration of the binary loop takes 5.00 cycles. At this rate:\n - 5% of peak load performance is reached (1.60 out of 32.00 bytes loaded per cycle (GB/s @ 1GHz))\n - 10% of peak store performance is reached (1.60 out of 16.00 bytes stored per cycle (GB/s @ 1GHz))\n",
        },
        {
          title = "Front-end bottlenecks",
          txt = "Found no such bottlenecks.",
        },
        {
          title = "ASM code",
          txt = "In the binary file, the address of the loop is: 1338\n\nInstruction                     | Nb FU | ALU0/BRU0 | ALU1 | ALU2 | ALU3/BRU1 | AGU0 | AGU1 | FP0  | FP1  | FP2 | FP3  | Latency | Recip. throughput\n----------------------------------------------------------------------------------------------------------------------------------------------------\nCALL 1170 <.plt.sec@start+0x90> | 6     | 1.25      | 1.25 | 1.25 | 1.25      | 0.50 | 0.50 | 0    | 0    | 0   | 0    | 0       | 1\nPXOR %XMM0,%XMM0                | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0    | 0    | 0   | 0    | 0       | 0.25\nADD $0x8,%R14                   | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0    | 0    | 0   | 0    | 1       | 0.25\nCVTSI2SD %EAX,%XMM0             | 2     | 0         | 0    | 0    | 0         | 0    | 0    | 0.33 | 0.33 | 0   | 1.33 | 7       | 1\nDIVSD 0xe07(%RIP),%XMM0         | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0    | 0    | 0   | 1    | 8-13    | 4-5\nMOVSD %XMM0,-0x8(%R14)          | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0    | 0    | 1   | 0    | 1       | 1\nCMP %RBX,%R14                   | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0    | 0    | 0   | 0    | 1       | 0.25\nJNE 1338 <main+0x1b8>           | 1     | 0.50      | 0    | 0    | 0.50      | 0    | 0    | 0    | 0    | 0   | 0    | 1       | 0.50\n",
        },
      },
      header = {
        "Warnings:\nDetected a function call instruction: ignoring called function instructions.\nRerun with --follow-calls=append to include them to analysis  or with --follow-calls=inline to simulate inlining.",
        "1% of peak computational performance is used (0.20 out of 12.00 FLOP per cycle (GFLOPS @ 1GHz))",
      },
      brief = {
      },
      gain = {
        {
          workaround = " - Try another compiler or update/tune your current one:\n  * recompile with ftree-vectorize (included in O3) to enable loop vectorization and with fassociative-math (included in Ofast or ffast-math) to extend vectorization to FP reductions.\n - Remove inter-iterations dependences from your loop and make it unit-stride:\n  * If your arrays have 2 or more dimensions, check whether elements are accessed contiguously and, otherwise, try to permute loops accordingly:\nC storage order is row-major: for(i) for(j) a[j][i] = b[j][i]; (slow, non stride 1) => for(i) for(j) a[i][j] = b[i][j]; (fast, stride 1)<<image_row_maj>>\n  * If your loop streams arrays of structures (AoS), try to use structures of arrays instead (SoA):\nfor(i) a[i].x = b[i].x; (slow, non stride 1) => for(i) a.x[i] = b.x[i]; (fast, stride 1)\n",
          details = "Store and arithmetical SSE/AVX instructions are used in scalar version (process only one data element in vector registers).\nSince your execution units are vector units, only a vectorized loop can use their full power.\n",
          title = "Vectorization",
          txt = "Your loop is probably not vectorized.\nOnly 28% of vector register length is used (average across all SSE/AVX instructions).\nBy vectorizing your loop, you can lower the cost of an iteration from 5.00 to 2.50 cycles (2.00x speedup).",
        },
        {
          workaround = " - Reduce the number of division or square root instructions:\n  * If denominator is constant over iterations, use reciprocal (replace x/y with x*(1/y)). Check precision impact. This will be done by your compiler with ffast-math or Ofast\n - Check whether you really need double precision. If not, switch to single precision to speedup execution\n",
          title = "Execution units bottlenecks",
          txt = "Performance is limited by execution of divide and square root operations (the divide/square root unit is a bottleneck).\n\nBy removing all these bottlenecks, you can lower the cost of an iteration from 5.00 to 2.17 cycles (2.31x speedup).\n",
        },
      },
      potential = {
        {
          title = "Expensive FP math instructions/calls",
          txt = "Detected performance impact from expensive FP math instructions/calls.\nBy removing/reexpressing them, you can lower the cost of an iteration from 5.00 to 2.17 cycles (2.31x speedup).",
        },
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
          workaround = "Recompile with march=znver1.\nCQA target is AMD_fam17h_mod11h (1st generation Athlon and Ryzen 3/5/7 APUs based on the Zen microarchitecture) but specialization flags are -march=x86-64",
          details = "These instructions generate more than one micro-operation and only one of them can be decoded during a cycle and the extra micro-operations increase pressure on execution units.\n - CVTSI2SD: 1 occurrences\n",
          title = "Complex instructions",
          txt = "Detected COMPLEX INSTRUCTIONS.\n",
        },
        {
          workaround = "Avoid mixing data with different types. In particular, check if the type of constants is the same as array elements.",
          details = " - CVTSI2SD (INT32/64 to FP64, scalar): 1 occurrences\n",
          title = "Conversion instructions",
          txt = "Detected expensive conversion instructions.",
        },
        {
          title = "Type of elements and instruction set",
          txt = "1 SSE or AVX instructions are processing arithmetic or math operations on double precision FP elements in scalar mode (one at a time).\n",
        },
        {
          title = "Matching between your loop (in the source code) and the binary loop",
          txt = "The binary loop is composed of 1 FP arithmetical operations:\n - 1: divide\nThe binary loop is loading 8 bytes (1 double precision FP elements).\nThe binary loop is storing 8 bytes (1 double precision FP elements).",
        },
        {
          title = "Arithmetic intensity",
          txt = "Arithmetic intensity is 0.06 FP operations per loaded or stored byte.",
        },
      },
      expert = {
        {
          title = "General properties",
          txt = "nb instructions    : 8\nnb uops            : 13\nloop length        : 36\nused x86 registers : 3\nused mmx registers : 0\nused xmm registers : 1\nused ymm registers : 0\nused zmm registers : 0\nnb stack references: 0\n",
        },
        {
          title = "Front-end",
          txt = "ASSUMED MACRO FUSION\nFIT IN UOP CACHE\nmicro-operation queue: 2.17 cycles\nfront end            : 2.17 cycles\n",
        },
        {
          title = "Back-end",
          txt = "       | ALU0/BRU0 | ALU1 | ALU2 | ALU3/BRU1 | AGU0 | AGU1 | FP0  | FP1  | FP2  | FP3\n--------------------------------------------------------------------------------------\nuops   | 1.75      | 1.75 | 1.75 | 1.75      | 1.50 | 1.50 | 0.67 | 0.33 | 1.00 | 2.00\ncycles | 1.75      | 1.75 | 1.75 | 1.75      | 1.50 | 1.50 | 0.67 | 0.33 | 1.00 | 2.00\n\nExecution ports to units layout:\n - ALU0/BRU0: ALU\n - ALU1: ALU\n - ALU2: ALU\n - ALU3/BRU1: ALU\n - AGU0 (128 bits): store address, load\n - AGU1 (128 bits): store address, load\n - FP0 (128 bits): VPU\n - FP1 (128 bits): VPU\n - FP2 (128 bits): VPU, FP store data\n - FP3 (128 bits): VPU, DIV/SQRT\n\nCycles executing div or sqrt instructions: 4.00-5.00\nCycles loading/storing data              : 1.00\nLongest recurrence chain latency (RecMII): 1.00\n",
        },
        {
          title = "Cycles summary",
          txt = "Front-end : 2.17\nDispatch  : 2.00\nDIV/SQRT  : 4.00-5.00\nData deps.: 1.00\nOverall L1: 4.00-5.00\n",
        },
        {
          title = "Vectorization ratios",
          txt = "INT\nall    : 50%\nload   : NA (no load vectorizable/vectorized instructions)\nstore  : NA (no store vectorizable/vectorized instructions)\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nfma    : NA (no fma vectorizable/vectorized instructions)\nother  : 50%\nFP\nall     : 0%\nload    : 0%\nstore   : 0%\nmul     : NA (no mul vectorizable/vectorized instructions)\nadd-sub : NA (no add-sub vectorizable/vectorized instructions)\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: 0%\nother   : NA (no other vectorizable/vectorized instructions)\nINT+FP\nall     : 25%\nload    : 0%\nstore   : 0%\nmul     : NA (no mul vectorizable/vectorized instructions)\nadd-sub : NA (no add-sub vectorizable/vectorized instructions)\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: 0%\nother   : 50%\n",
        },
        {
          title = "Vector efficiency ratios",
          txt = "INT\nall    : 31%\nload   : NA (no load vectorizable/vectorized instructions)\nstore  : NA (no store vectorizable/vectorized instructions)\nmul    : NA (no mul vectorizable/vectorized instructions)\nadd-sub: NA (no add-sub vectorizable/vectorized instructions)\nfma    : NA (no fma vectorizable/vectorized instructions)\nother  : 31%\nFP\nall     : 25%\nload    : 25%\nstore   : 25%\nmul     : NA (no mul vectorizable/vectorized instructions)\nadd-sub : NA (no add-sub vectorizable/vectorized instructions)\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: 25%\nother   : NA (no other vectorizable/vectorized instructions)\nINT+FP\nall     : 28%\nload    : 25%\nstore   : 25%\nmul     : NA (no mul vectorizable/vectorized instructions)\nadd-sub : NA (no add-sub vectorizable/vectorized instructions)\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: 25%\nother   : 31%\n",
        },
        {
          title = "Cycles and memory resources usage",
          txt = "Assuming all data fit into the L1 cache, each iteration of the binary loop takes 5.00 cycles. At this rate:\n - 5% of peak load performance is reached (1.60 out of 32.00 bytes loaded per cycle (GB/s @ 1GHz))\n - 10% of peak store performance is reached (1.60 out of 16.00 bytes stored per cycle (GB/s @ 1GHz))\n",
        },
        {
          title = "Front-end bottlenecks",
          txt = "Found no such bottlenecks.",
        },
        {
          title = "ASM code",
          txt = "In the binary file, the address of the loop is: 1338\n\nInstruction                     | Nb FU | ALU0/BRU0 | ALU1 | ALU2 | ALU3/BRU1 | AGU0 | AGU1 | FP0  | FP1  | FP2 | FP3  | Latency | Recip. throughput\n----------------------------------------------------------------------------------------------------------------------------------------------------\nCALL 1170 <.plt.sec@start+0x90> | 6     | 1.25      | 1.25 | 1.25 | 1.25      | 0.50 | 0.50 | 0    | 0    | 0   | 0    | 0       | 1\nPXOR %XMM0,%XMM0                | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0    | 0    | 0   | 0    | 0       | 0.25\nADD $0x8,%R14                   | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0    | 0    | 0   | 0    | 1       | 0.25\nCVTSI2SD %EAX,%XMM0             | 2     | 0         | 0    | 0    | 0         | 0    | 0    | 0.33 | 0.33 | 0   | 1.33 | 7       | 1\nDIVSD 0xe07(%RIP),%XMM0         | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0    | 0    | 0   | 1    | 8-13    | 4-5\nMOVSD %XMM0,-0x8(%R14)          | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0    | 0    | 1   | 0    | 1       | 1\nCMP %RBX,%R14                   | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0    | 0    | 0   | 0    | 1       | 0.25\nJNE 1338 <main+0x1b8>           | 1     | 0.50      | 0    | 0    | 0.50      | 0    | 0    | 0    | 0    | 0   | 0    | 1       | 0.50\n",
        },
      },
      header = {
        "Warnings:\nDetected a function call instruction: ignoring called function instructions.\nRerun with --follow-calls=append to include them to analysis  or with --follow-calls=inline to simulate inlining.",
        "1% of peak computational performance is used (0.20 out of 12.00 FLOP per cycle (GFLOPS @ 1GHz))",
      },
      brief = {
      },
      gain = {
        {
          workaround = " - Try another compiler or update/tune your current one:\n  * recompile with ftree-vectorize (included in O3) to enable loop vectorization and with fassociative-math (included in Ofast or ffast-math) to extend vectorization to FP reductions.\n - Remove inter-iterations dependences from your loop and make it unit-stride:\n  * If your arrays have 2 or more dimensions, check whether elements are accessed contiguously and, otherwise, try to permute loops accordingly:\nC storage order is row-major: for(i) for(j) a[j][i] = b[j][i]; (slow, non stride 1) => for(i) for(j) a[i][j] = b[i][j]; (fast, stride 1)<<image_row_maj>>\n  * If your loop streams arrays of structures (AoS), try to use structures of arrays instead (SoA):\nfor(i) a[i].x = b[i].x; (slow, non stride 1) => for(i) a.x[i] = b.x[i]; (fast, stride 1)\n",
          details = "Store and arithmetical SSE/AVX instructions are used in scalar version (process only one data element in vector registers).\nSince your execution units are vector units, only a vectorized loop can use their full power.\n",
          title = "Vectorization",
          txt = "Your loop is probably not vectorized.\nOnly 28% of vector register length is used (average across all SSE/AVX instructions).\nBy vectorizing your loop, you can lower the cost of an iteration from 5.00 to 2.50 cycles (2.00x speedup).",
        },
        {
          workaround = " - Reduce the number of division or square root instructions:\n  * If denominator is constant over iterations, use reciprocal (replace x/y with x*(1/y)). Check precision impact. This will be done by your compiler with ffast-math or Ofast\n - Check whether you really need double precision. If not, switch to single precision to speedup execution\n",
          title = "Execution units bottlenecks",
          txt = "Performance is limited by execution of divide and square root operations (the divide/square root unit is a bottleneck).\n\nBy removing all these bottlenecks, you can lower the cost of an iteration from 5.00 to 2.17 cycles (2.31x speedup).\n",
        },
      },
      potential = {
        {
          title = "Expensive FP math instructions/calls",
          txt = "Detected performance impact from expensive FP math instructions/calls.\nBy removing/reexpressing them, you can lower the cost of an iteration from 5.00 to 2.17 cycles (2.31x speedup).",
        },
      },
    },
  common = {
    header = {
      "The loop is defined in /home/hippolyte/Documents/Projet/AOA/demo_2024/Etude-de-cas/driver.c:17-18.\n",
      "The related source loop is multi-versionned.",
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
