return {
  {
    -- img-clip.nvim - A plugin for inserting images from system clipboard
    -- src: https://github.com/HakonHarnes/img-clip.nvim
    "HakonHarnes/img-clip.nvim",
    opts = {
      filetypes = {
        -- enable for codecompanion
        codecompanion = {
          prompt_for_file_name = false,
          template = "[Image]($FILE_PATH)",
          use_absolute_path = true,
        },
      },
    },
  }
}
