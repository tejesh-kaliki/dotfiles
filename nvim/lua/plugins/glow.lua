return {
  "ellisonleao/glow.nvim",
  cmd = "Glow",
  opts = {
    border = "shadow",
    pager = false,
    width = 120,
    height = 100,
    width_ratio = 0.8,
    height_ratio = 0.8,
  },
  keys = {
    { "<leader>mg", "<cmd>Glow<cr>", desc = "Glow (Markdown Preview)" },
  },
}
