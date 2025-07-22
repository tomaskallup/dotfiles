return {
  "echaya/neowiki.nvim",
  opts = {
    wiki_dirs = {
      -- neowiki.nvim supports both absolute and relative paths
      { name = "Work", path = "~/.wiki/work" },
      { name = "Personal", path = "~/.wiki/personal" },
    },
  },
  keys = {
    { "<leader>W", "<cmd>lua require('neowiki').open_wiki_floating()<cr>", desc = "Open Floating Wiki" },
  },
}
