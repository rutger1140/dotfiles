return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.keymap.set("n", "<C-n>", ":Neotree toggle reveal reveal_force_cwd<CR>", {})
  end,
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_hidden = false,
        visible = true,
      },
    },
  },
}
