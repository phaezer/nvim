return {
  -- ==============================================================================================
  -- Yanky
  -- Yank wrapper providing persistent history
  {
    'gbprod/yanky.nvim',
    lazy = false,
    dependencies = { 'folke/snacks.nvim' },
    keys = {
      { '<leader>p', function() Snacks.picker.yanky() end, mode = { 'n', 'x' }, desc = 'Open Yank History' },
      { 'y', '<Plug>(YankyYank)', desc = 'Yank (copy)', mode = { 'n', 'x' } },
      { 'p', '<Plug>(YankyPutAfter)', desc = 'Paste after', mode = { 'n', 'x' } },
      { 'P', '<Plug>(YankyPutBefore)', desc = 'Paste before', mode = { 'n', 'x' } },
      { 'gp', '<Plug>(YankyGPutAfter)', desc = 'Paste after and keep cursor position', mode = { 'n', 'x' } },
      { 'gP', '<Plug>(YankyGPutBefore)', desc = 'Paste before and keep cursor position', mode = { 'n', 'x' } },
      { '<c-p>', '<Plug>(YankyPreviousEntry)', desc = 'Yank' },
      { '<c-n>', '<Plug>(YankyNextEntry)', desc = 'Delete' },
      { ']p', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'Change' },
      { '[p', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'Paste before indent linewise' },
      { ']P', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'Paste after indent linewise' },
      { '[P', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'Paste before indent linewise' },
      { 'iy', function() require('yanky.textobj').last_put() end, desc = 'Paste last yanked text object', mode = { 'o', 'x' } },
    },
    opts = {
      ring = {
        history_length = 100,
        storage = 'shada',
        storage_path = vim.fn.stdpath 'data' .. '/databases/yanky.db', -- Only for sqlite storage
        sync_with_numbered_registers = true,
        cancel_event = 'update',
        ignore_registers = { '_' },
        update_register_on_cycle = false,
        permanent_wrapper = nil,
      },
      picker = {
        select = {
          action = nil, -- nil to use default put action
        },
        telescope = {
          use_default_mappings = true, -- if default mappings should be used
          mappings = nil, -- nil to use default mappings or no mappings (see `use_default_mappings`)
        },
      },
      system_clipboard = {
        sync_with_ring = true,
        clipboard_register = nil,
      },
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 500,
      },
      preserve_cursor_position = {
        enabled = true,
      },
      textobj = {
        enabled = false,
      },
    },
  }, -- / Yanky

  -- ==============================================================================================
  -- Image Clip
  -- A plugin for inserting images from system clipboard
  {
    'HakonHarnes/img-clip.nvim',
    lazy = true,
    cmd = { 'PasteImage', 'ImgClipDebug', 'ImgClipConfig' },
    opts = {
      default = {
        -- file and directory options
        dir_path = 'assets',
        file_name = '%Y-%m-%d-%H-%M-%S',
        use_absolute_path = false,
        relative_to_current_file = false,

        -- template options
        template = '$FILE_PATH',
        url_encode_path = false,
        relative_template_path = true,
        use_cursor_in_template = true,
        insert_mode_after_paste = true,

        -- prompt options
        prompt_for_file_name = true,
        show_dir_path_in_prompt = false,

        -- base64 options
        max_base64_size = 10,
        embed_image_as_base64 = false,

        -- image options
        process_cmd = '',
        copy_images = false,
        download_images = true,

        -- drag and drop options
        drag_and_drop = {
          enabled = true,
          insert_mode = false,
        },
      },
      filetypes = {
        markdown = {
          url_encode_path = true,
          template = '![$CURSOR]($FILE_PATH)',
          download_images = false,
        },
        html = {
          template = '<img src="$FILE_PATH" alt="$CURSOR">',
        },
        org = {
          template = [=[
    #+BEGIN_FIGURE
    [[file:$FILE_PATH]]
    #+CAPTION: $CURSOR
    #+NAME: fig:$LABEL
    #+END_FIGURE
        ]=],
        },
        asciidoc = {
          template = 'image::$FILE_PATH[width=80%, alt="$CURSOR"]',
        },
        -- enable for codecompanion
        codecompanion = {
          prompt_for_file_name = false,
          template = '[Image]($FILE_PATH)',
          use_absolute_path = true,
        },
      },
    },
  }, -- / Image Clip
}
