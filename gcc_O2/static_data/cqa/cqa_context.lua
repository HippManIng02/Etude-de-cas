_cqa_uarch_const = {
  ["uop cache capacity"] = 1300,
  ["ports"] = {
    [1] = {
      ["name"] = "ALU0/BRU0",
      ["units"] = {
        ["ALU"] = {
        },
      },
    },
    [2] = {
      ["name"] = "ALU1",
      ["units"] = {
        ["ALU"] = {
        },
      },
    },
    [3] = {
      ["name"] = "ALU2",
      ["units"] = {
        ["ALU"] = {
        },
      },
    },
    [4] = {
      ["name"] = "ALU3/BRU1",
      ["units"] = {
        ["ALU"] = {
        },
      },
    },
    [5] = {
      ["width"] = 128,
      ["name"] = "AGU0",
      ["units"] = {
        ["store address"] = {
        },
        ["load"] = {
        },
      },
    },
    [6] = {
      ["width"] = 128,
      ["name"] = "AGU1",
      ["units"] = {
        ["store address"] = {
        },
        ["load"] = {
        },
      },
    },
    [7] = {
      ["width"] = 128,
      ["name"] = "FP0",
      ["units"] = {
        ["VPU"] = {
        },
      },
    },
    [8] = {
      ["width"] = 128,
      ["name"] = "FP1",
      ["units"] = {
        ["VPU"] = {
        },
      },
    },
    [9] = {
      ["width"] = 128,
      ["name"] = "FP2",
      ["units"] = {
        ["VPU"] = {
        },
        ["FP store data"] = {
        },
      },
    },
    [10] = {
      ["width"] = 128,
      ["name"] = "FP3",
      ["units"] = {
        ["VPU"] = {
        },
        ["DIV/SQRT"] = {
        },
      },
    },
  },
  ["UQ throughput"] = 6,
  ["vector-unaligned optimal pattern"] = "1x128",
  ["INT vector size in bytes"] = 32,
  ["IQ throughput"] = 4,
  ["NOP 0f 1f decode"] = "fast",
  ["bytes fetched per cycle"] = 32,
  ["retire throughput"] = 8,
  ["nb execution ports"] = 10,
  ["vector size in bytes"] = 32,
}
