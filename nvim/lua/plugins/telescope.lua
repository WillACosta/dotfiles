return {
  "nvim-telescope/telescope.nvim",
  opts = {
    pickers = {
      find_files = {
        hidden = true, -- Set to true to show hidden files
        -- You can also add other options here, like find_command
        -- find_command = { "rg", "--files", "--hidden", "--glob=!**/.git/*" },
      },
    },
  },
}
