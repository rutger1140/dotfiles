-- Adds filetypes to the files that don't have a filetype
--
-- Issue with blade.php files -> set filetype to html for now
-- https://github.com/EmranMR/tree-sitter-blade/discussions/19
vim.filetype.add({
  pattern = {
    [".*%.blade%.php"] = "html",
  },
})
