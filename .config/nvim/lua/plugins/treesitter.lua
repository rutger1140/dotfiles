return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, { "php", "html" })
  end,
  init = function()
    -- Treat .blade.php files as "blade" filetype
    vim.filetype.add({
      pattern = { [".*%.blade%.php"] = "blade" },
    })

    -- Register the Blade parser source so `:TSInstall blade` knows where to fetch it.
    -- Uses pcall in case the parsers API is unavailable (e.g. during initial install
    -- or after a nvim-treesitter API change).
    local ok, parsers = pcall(require, "nvim-treesitter.parsers")
    if ok and parsers.get_parser_configs then
      local parser_config = parsers.get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }
    end

    -- Enable Treesitter highlighting for blade files.
    -- This is needed because LazyVim does not automatically activate
    -- Treesitter highlighting for custom/non-bundled filetypes.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "blade",
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
