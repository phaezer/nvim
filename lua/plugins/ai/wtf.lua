-- wtf.nvim A Neovim plugin to help you work out what the fudge that diagnostic means and how to fix it!
-- src: https://github.com/piersolenski/wtf.nvim
return {
  "piersolenski/wtf.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  opts = {
    openai_model_id = "gpt-4o",
    language = "english",
    search_engine = "google"
  },
  additional_instructions = [[
      Be concise and to the point. Provide examples and code snippets when appropriate. Offer multiple solutions when appropriate.
      If the provided diagnostics and code is not clear, or does not provide enough context, ask for more information.]],

}
