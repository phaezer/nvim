-- NOTE: configuration for managing notes in Neovim
-- DOCS: tutorial: https://www.youtube.com/watch?v=NnmRVY22Lq8&list=PLx2ksyallYzVI8CN1JMXhEf62j2AijeDa&index=2

---load list of workspaces from env var
local function workspaces_from_env()
  -- load env
  -- TODO: finish this
end

return {
  'nvim-neorg/neorg',
  lazy = false,
  version = '*',
  opts = {
    load = {
      ['core.defaults'] = {}, -- Loads default behaviour
      ['core.concealer'] = { config = { folds = true, icon_preset = 'varied' } }, -- Adds pretty icons to your documents
      ['core.keybinds'] = {
        config = {
          neorg_leader = ',',
        },
      },
      ['core.dirman'] = {
        config = {
          workspaces = {
            notes = '~/notes',
          },
          default_workspace = 'notes',
        },
      },
    },
  },
}
