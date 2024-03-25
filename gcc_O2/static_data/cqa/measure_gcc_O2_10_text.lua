_cqa_text_report = {
  paths = {
    {
      hint = {
        {
          details = "These instructions generate more than one micro-operation and only one of them can be decoded during a cycle and the extra micro-operations increase pressure on execution units.\n - CMOVAE: 1 occurrences\n",
          title = "Complex instructions",
          txt = "Detected COMPLEX INSTRUCTIONS.\n",
        },
        {
          workaround = " - Try to reorganize arrays of structures to structures of arrays\n - Consider to permute loops (see vectorization gain report)\n",
          details = " - Constant unknown stride: 1 occurrence(s)\nNon-unit stride (uncontiguous) accesses are not efficiently using data caches\n",
          title = "Slow data structures access",
          txt = "Detected data structures (typically arrays) that cannot be efficiently read/written",
        },
        {
          title = "Type of elements and instruction set",
          txt = "No instructions are processing arithmetic or math operations on FP elements. This loop is probably writing/copying data or processing integer elements.",
        },
        {
          title = "Matching between your loop (in the source code) and the binary loop",
          txt = "The binary loop does not contain any FP arithmetical operations.\nThe binary loop is loading 20 bytes.\nThe binary loop is storing 8 bytes.",
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
          txt = "nb instructions    : 12\nnb uops            : 11\nloop length        : 45\nused x86 registers : 7\nused mmx registers : 0\nused xmm registers : 0\nused ymm registers : 0\nused zmm registers : 0\nnb stack references: 1\n",
        },
        {
          title = "Front-end",
          txt = "ASSUMED MACRO FUSION\nFIT IN UOP CACHE\nmicro-operation queue: 1.83 cycles\nfront end            : 1.83 cycles\n",
        },
        {
          title = "Back-end",
          txt = "       | ALU0/BRU0 | ALU1 | ALU2 | ALU3/BRU1 | AGU0 | AGU1 | FP0  | FP1  | FP2  | FP3\n--------------------------------------------------------------------------------------\nuops   | 1.50      | 1.50 | 1.50 | 1.50      | 2.00 | 2.00 | 0.00 | 0.00 | 0.00 | 0.00\ncycles | 1.50      | 1.50 | 1.50 | 1.50      | 2.00 | 2.00 | 0.00 | 0.00 | 0.00 | 0.00\n\nExecution ports to units layout:\n - ALU0/BRU0: ALU\n - ALU1: ALU\n - ALU2: ALU\n - ALU3/BRU1: ALU\n - AGU0 (128 bits): store address, load\n - AGU1 (128 bits): store address, load\n - FP0 (128 bits): VPU\n - FP1 (128 bits): VPU\n - FP2 (128 bits): VPU, FP store data\n - FP3 (128 bits): VPU, DIV/SQRT\n\nCycles executing div or sqrt instructions: NA\nCycles loading/storing data              : 1.50\nLongest recurrence chain latency (RecMII): 1.00\n",
        },
        {
          title = "Cycles summary",
          txt = "Front-end : 1.83\nDispatch  : 2.00\nData deps.: 1.00\nOverall L1: 2.00\n",
        },
        {
          title = "Vectorization ratios",
          txt = "all     : 0%\nload    : 0%\nstore   : 0%\nmul     : NA (no mul vectorizable/vectorized instructions)\nadd-sub : NA (no add-sub vectorizable/vectorized instructions)\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: NA (no div/sqrt vectorizable/vectorized instructions)\nother   : 0%\n",
        },
        {
          title = "Vector efficiency ratios",
          txt = "all     : 20%\nload    : 25%\nstore   : 25%\nmul     : NA (no mul vectorizable/vectorized instructions)\nadd-sub : NA (no add-sub vectorizable/vectorized instructions)\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: NA (no div/sqrt vectorizable/vectorized instructions)\nother   : 12%\n",
        },
        {
          title = "Cycles and memory resources usage",
          txt = "Assuming all data fit into the L1 cache, each iteration of the binary loop takes 2.00 cycles. At this rate:\n - 31% of peak load performance is reached (10.00 out of 32.00 bytes loaded per cycle (GB/s @ 1GHz))\n - 25% of peak store performance is reached (4.00 out of 16.00 bytes stored per cycle (GB/s @ 1GHz))\n",
        },
        {
          title = "Front-end bottlenecks",
          txt = "Found no such bottlenecks.",
        },
        {
          title = "ASM code",
          txt = "In the binary file, the address of the loop is: 187b\n\nInstruction            | Nb FU | ALU0/BRU0 | ALU1 | ALU2 | ALU3/BRU1 | AGU0 | AGU1 | FP0 | FP1 | FP2 | FP3 | Latency | Recip. throughput\n----------------------------------------------------------------------------------------------------------------------------------------\nMOV %ESI,%R12D         | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 0       | 0.25\nXOR %ESI,%ESI          | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 0       | 0.25\nCMP %R12D,%EBX         | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nJA 1894 <kernel+0x84>  | 1     | 0.50      | 0    | 0    | 0.50      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.50\nMOV 0x77f(%RIP),%RSI   | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 3       | 0.50\nMOV 0x780(%RIP),%RAX   | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 3       | 0.50\nCMOVAE %RAX,%RSI       | 2     | 0.50      | 0.50 | 0.50 | 0.50      | 0    | 0    | 0   | 0   | 0   | 0   | 2       | 0.50\nMOV %RSI,(%RCX)        | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 4       | 1\nLEA 0x1(%R12),%ESI\nADD %R15,%RCX          | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nCMP %ESI,0xc(%RSP)     | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 1       | 0.50\nJNE 1878 <kernel+0x68> | 1     | 0.50      | 0    | 0    | 0.50      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.50\n",
        },
      },
      header = {
        "Warnings:\nThe number of fused uops of the instruction [LEA	0x1(%R12),%ESI] is unknown",
        "0% of peak computational performance is used (0.00 out of 24.00 FLOP per cycle (GFLOPS @ 1GHz))",
      },
      brief = {
      },
      gain = {
        {
          workaround = " - Try another compiler or update/tune your current one:\n  * recompile with ftree-vectorize (included in O3) to enable loop vectorization and with fassociative-math (included in Ofast or ffast-math) to extend vectorization to FP reductions.\n - Remove inter-iterations dependences from your loop and make it unit-stride:\n  * If your arrays have 2 or more dimensions, check whether elements are accessed contiguously and, otherwise, try to permute loops accordingly:\nC storage order is row-major: for(i) for(j) a[j][i] = b[j][i]; (slow, non stride 1) => for(i) for(j) a[i][j] = b[i][j]; (fast, stride 1)<<image_row_maj>>\n  * If your loop streams arrays of structures (AoS), try to use structures of arrays instead (SoA):\nfor(i) a[i].x = b[i].x; (slow, non stride 1) => for(i) a.x[i] = b.x[i]; (fast, stride 1)\n",
          details = "All SSE/AVX instructions are used in scalar version (process only one data element in vector registers).\nSince your execution units are vector units, only a vectorized loop can use their full power.\n",
          title = "Vectorization",
          txt = "Your loop is not vectorized.\nOnly 20% of vector register length is used (average across all SSE/AVX instructions).\nBy vectorizing your loop, you can lower the cost of an iteration from 2.00 to 0.37 cycles (5.33x speedup).",
        },
        {
          workaround = " - Read less array elements\n - Write less array elements\n - Provide more information to your compiler:\n  * hardcode the bounds of the corresponding 'for' loop\n  * use the 'restrict' C99 keyword\n",
          title = "Execution units bottlenecks",
          txt = "Performance is limited by:\n - reading data from caches/RAM (load units are a bottleneck)\n - writing data to caches/RAM (the store unit is a bottleneck)\n\nBy removing all these bottlenecks, you can lower the cost of an iteration from 2.00 to 1.83 cycles (1.09x speedup).\n",
        },
      },
      potential = {
      },
    },
    {
      hint = {
        {
          workaround = " - Try to reorganize arrays of structures to structures of arrays\n - Consider to permute loops (see vectorization gain report)\n",
          details = " - Constant unknown stride: 1 occurrence(s)\nNon-unit stride (uncontiguous) accesses are not efficiently using data caches\n",
          title = "Slow data structures access",
          txt = "Detected data structures (typically arrays) that cannot be efficiently read/written",
        },
        {
          title = "Type of elements and instruction set",
          txt = "No instructions are processing arithmetic or math operations on FP elements. This loop is probably writing/copying data or processing integer elements.",
        },
        {
          title = "Matching between your loop (in the source code) and the binary loop",
          txt = "The binary loop does not contain any FP arithmetical operations.\nThe binary loop is loading 4 bytes.\nThe binary loop is storing 8 bytes.",
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
          txt = "nb instructions    : 9\nnb uops            : 7\nloop length        : 27\nused x86 registers : 6\nused mmx registers : 0\nused xmm registers : 0\nused ymm registers : 0\nused zmm registers : 0\nnb stack references: 1\n",
        },
        {
          title = "Front-end",
          txt = "ASSUMED MACRO FUSION\nFIT IN UOP CACHE\nmicro-operation queue: 1.17 cycles\nfront end            : 1.17 cycles\n",
        },
        {
          title = "Back-end",
          txt = "       | ALU0/BRU0 | ALU1 | ALU2 | ALU3/BRU1 | AGU0 | AGU1 | FP0  | FP1  | FP2  | FP3\n--------------------------------------------------------------------------------------\nuops   | 1.00      | 1.00 | 1.00 | 1.00      | 1.00 | 1.00 | 0.00 | 0.00 | 0.00 | 0.00\ncycles | 1.00      | 1.00 | 1.00 | 1.00      | 1.00 | 1.00 | 0.00 | 0.00 | 0.00 | 0.00\n\nExecution ports to units layout:\n - ALU0/BRU0: ALU\n - ALU1: ALU\n - ALU2: ALU\n - ALU3/BRU1: ALU\n - AGU0 (128 bits): store address, load\n - AGU1 (128 bits): store address, load\n - FP0 (128 bits): VPU\n - FP1 (128 bits): VPU\n - FP2 (128 bits): VPU, FP store data\n - FP3 (128 bits): VPU, DIV/SQRT\n\nCycles executing div or sqrt instructions: NA\nCycles loading/storing data              : 1.00\nLongest recurrence chain latency (RecMII): 1.00\n",
        },
        {
          title = "Cycles summary",
          txt = "Front-end : 1.17\nDispatch  : 1.00\nData deps.: 1.00\nOverall L1: 1.17\n",
        },
        {
          title = "Vectorization ratios",
          txt = "all     : 0%\nload    : NA (no load vectorizable/vectorized instructions)\nstore   : 0%\nmul     : NA (no mul vectorizable/vectorized instructions)\nadd-sub : NA (no add-sub vectorizable/vectorized instructions)\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: NA (no div/sqrt vectorizable/vectorized instructions)\nother   : 0%\n",
        },
        {
          title = "Vector efficiency ratios",
          txt = "all     : 18%\nload    : NA (no load vectorizable/vectorized instructions)\nstore   : 25%\nmul     : NA (no mul vectorizable/vectorized instructions)\nadd-sub : NA (no add-sub vectorizable/vectorized instructions)\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: NA (no div/sqrt vectorizable/vectorized instructions)\nother   : 12%\n",
        },
        {
          title = "Cycles and memory resources usage",
          txt = "Assuming all data fit into the L1 cache, each iteration of the binary loop takes 1.17 cycles. At this rate:\n - 10% of peak load performance is reached (3.43 out of 32.00 bytes loaded per cycle (GB/s @ 1GHz))\n - 42% of peak store performance is reached (6.86 out of 16.00 bytes stored per cycle (GB/s @ 1GHz))\n",
        },
        {
          title = "Front-end bottlenecks",
          txt = "Performance is limited by instruction throughput (loading/decoding program instructions to execution core) (front-end is a bottleneck).\n\nBy removing all these bottlenecks, you can lower the cost of an iteration from 1.17 to 1.00 cycles (1.17x speedup).\n",
        },
        {
          title = "ASM code",
          txt = "In the binary file, the address of the loop is: 187b\n\nInstruction            | Nb FU | ALU0/BRU0 | ALU1 | ALU2 | ALU3/BRU1 | AGU0 | AGU1 | FP0 | FP1 | FP2 | FP3 | Latency | Recip. throughput\n----------------------------------------------------------------------------------------------------------------------------------------\nMOV %ESI,%R12D         | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 0       | 0.25\nXOR %ESI,%ESI          | 1     | 0         | 0    | 0    | 0         | 0    | 0    | 0   | 0   | 0   | 0   | 0       | 0.25\nCMP %R12D,%EBX         | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nJA 1894 <kernel+0x84>  | 1     | 0.50      | 0    | 0    | 0.50      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.50\nMOV %RSI,(%RCX)        | 1     | 0         | 0    | 0    | 0         | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 4       | 1\nLEA 0x1(%R12),%ESI\nADD %R15,%RCX          | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.25\nCMP %ESI,0xc(%RSP)     | 1     | 0.25      | 0.25 | 0.25 | 0.25      | 0.50 | 0.50 | 0   | 0   | 0   | 0   | 1       | 0.50\nJNE 1878 <kernel+0x68> | 1     | 0.50      | 0    | 0    | 0.50      | 0    | 0    | 0   | 0   | 0   | 0   | 1       | 0.50\n",
        },
      },
      header = {
        "Warnings:\nThe number of fused uops of the instruction [LEA	0x1(%R12),%ESI] is unknown",
        "0% of peak computational performance is used (0.00 out of 24.00 FLOP per cycle (GFLOPS @ 1GHz))",
      },
      brief = {
      },
      gain = {
        {
          workaround = " - Try another compiler or update/tune your current one:\n  * recompile with ftree-vectorize (included in O3) to enable loop vectorization and with fassociative-math (included in Ofast or ffast-math) to extend vectorization to FP reductions.\n - Remove inter-iterations dependences from your loop and make it unit-stride:\n  * If your arrays have 2 or more dimensions, check whether elements are accessed contiguously and, otherwise, try to permute loops accordingly:\nC storage order is row-major: for(i) for(j) a[j][i] = b[j][i]; (slow, non stride 1) => for(i) for(j) a[i][j] = b[i][j]; (fast, stride 1)<<image_row_maj>>\n  * If your loop streams arrays of structures (AoS), try to use structures of arrays instead (SoA):\nfor(i) a[i].x = b[i].x; (slow, non stride 1) => for(i) a.x[i] = b.x[i]; (fast, stride 1)\n",
          details = "All SSE/AVX instructions are used in scalar version (process only one data element in vector registers).\nSince your execution units are vector units, only a vectorized loop can use their full power.\n",
          title = "Vectorization",
          txt = "Your loop is not vectorized.\nOnly 18% of vector register length is used (average across all SSE/AVX instructions).\nBy vectorizing your loop, you can lower the cost of an iteration from 1.17 to 0.19 cycles (6.22x speedup).",
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
          details = "These instructions generate more than one micro-operation and only one of them can be decoded during a cycle and the extra micro-operations increase pressure on execution units.\n - CMOVAE: 1 occurrences\n",
          title = "Complex instructions",
          txt = "Detected COMPLEX INSTRUCTIONS.\n",
        },
        {
          title = "Type of elements and instruction set",
          txt = "No instructions are processing arithmetic or math operations on FP elements. This loop is probably writing/copying data or processing integer elements.",
        },
        {
          title = "Matching between your loop (in the source code) and the binary loop",
          txt = "The binary loop does not contain any FP arithmetical operations.\nThe binary loop is loading 12 bytes.\nThe binary loop is storing 8 bytes.",
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
          txt = "nb instructions    : 10.50\nnb uops            : 9\nloop length        : 36\nused x86 registers : 6.50\nused mmx registers : 0\nused xmm registers : 0\nused ymm registers : 0\nused zmm registers : 0\nnb stack references: 1\n",
        },
        {
          title = "Front-end",
          txt = "MACRO FUSION NOT POSSIBLE\nmicro-operation queue: 1.50 cycles\nfront end            : 1.50 cycles\n",
        },
        {
          title = "Back-end",
          txt = "       | ALU0/BRU0 | ALU1 | ALU2 | ALU3/BRU1 | AGU0 | AGU1 | FP0  | FP1  | FP2  | FP3\n--------------------------------------------------------------------------------------\nuops   | 1.25      | 1.25 | 1.25 | 1.25      | 1.50 | 1.50 | 0.00 | 0.00 | 0.00 | 0.00\ncycles | 1.25      | 1.25 | 1.25 | 1.25      | 1.50 | 1.50 | 0.00 | 0.00 | 0.00 | 0.00\n\nExecution ports to units layout:\n - ALU0/BRU0: ALU\n - ALU1: ALU\n - ALU2: ALU\n - ALU3/BRU1: ALU\n - AGU0 (128 bits): store address, load\n - AGU1 (128 bits): store address, load\n - FP0 (128 bits): VPU\n - FP1 (128 bits): VPU\n - FP2 (128 bits): VPU, FP store data\n - FP3 (128 bits): VPU, DIV/SQRT\n\nCycles executing div or sqrt instructions: NA\nLongest recurrence chain latency (RecMII): 1.00\n",
        },
        {
          title = "Cycles summary",
          txt = "Front-end : 1.50\nDispatch  : 1.50\nData deps.: 1.00\nOverall L1: 1.58\n",
        },
        {
          title = "Vectorization ratios",
          txt = "all     : 0%\nload    : 0%\nstore   : 0%\nmul     : NA (no mul vectorizable/vectorized instructions)\nadd-sub : NA (no add-sub vectorizable/vectorized instructions)\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: NA (no div/sqrt vectorizable/vectorized instructions)\nother   : 0%\n",
        },
        {
          title = "Vector efficiency ratios",
          txt = "all     : 19%\nload    : 25%\nstore   : 25%\nmul     : NA (no mul vectorizable/vectorized instructions)\nadd-sub : NA (no add-sub vectorizable/vectorized instructions)\nfma     : NA (no fma vectorizable/vectorized instructions)\ndiv/sqrt: NA (no div/sqrt vectorizable/vectorized instructions)\nother   : 12%\n",
        },
        {
          title = "Cycles and memory resources usage",
          txt = "Assuming all data fit into the L1 cache, each iteration of the binary loop takes 1.58 cycles. At this rate:\n - 20% of peak load performance is reached (6.71 out of 32.00 bytes loaded per cycle (GB/s @ 1GHz))\n - 33% of peak store performance is reached (5.43 out of 16.00 bytes stored per cycle (GB/s @ 1GHz))\n",
        },
      },
      header = {
        "0% of peak computational performance is used (0.00 out of 24.00 FLOP per cycle (GFLOPS @ 1GHz))",
      },
      brief = {
      },
      gain = {
        {
          workaround = " - Try another compiler or update/tune your current one:\n  * recompile with ftree-vectorize (included in O3) to enable loop vectorization and with fassociative-math (included in Ofast or ffast-math) to extend vectorization to FP reductions.\n - Remove inter-iterations dependences from your loop and make it unit-stride:\n  * If your arrays have 2 or more dimensions, check whether elements are accessed contiguously and, otherwise, try to permute loops accordingly:\nC storage order is row-major: for(i) for(j) a[j][i] = b[j][i]; (slow, non stride 1) => for(i) for(j) a[i][j] = b[i][j]; (fast, stride 1)<<image_row_maj>>\n  * If your loop streams arrays of structures (AoS), try to use structures of arrays instead (SoA):\nfor(i) a[i].x = b[i].x; (slow, non stride 1) => for(i) a.x[i] = b.x[i]; (fast, stride 1)\n",
          details = "All SSE/AVX instructions are used in scalar version (process only one data element in vector registers).\nSince your execution units are vector units, only a vectorized loop can use their full power.\n",
          title = "Vectorization",
          txt = "Your loop is not vectorized.\nOnly 19% of vector register length is used (average across all SSE/AVX instructions).\nBy vectorizing your loop, you can lower the cost of an iteration from 1.58 to 0.28 cycles (5.63x speedup).",
        },
      },
      potential = {
      },
    },
  common = {
    header = {
      "The loop is defined in /home/hippolyte/Documents/Projet/AOA/demo_2024/Etude-de-cas/kernel.c:10-16.\n",
      "The related source loop is not unrolled or unrolled with no peel/tail loop.",
      "The structure of this loop is probably <if then [else] end>.\n",
      "The presence of multiple execution paths is typically the main/first bottleneck.\nTry to simplify control inside loop: ideally, try to remove all conditional expressions, for example by (if applicable):\n - hoisting them (moving them outside the loop)\n - turning them into conditional moves, MIN or MAX\n\n",
      "Ex: if (x<0) x=0 => x = (x<0 ? 0 : x) (or MAX(0,x) after defining the corresponding macro)\n",
    },
    nb_paths = 2,
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
