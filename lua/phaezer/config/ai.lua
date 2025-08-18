--- AI configuration
-- This module is consumed by various AI plugins to load prompts and configuration.

---@module 'Config.ai'
local M = {}

local prompts_dir = os.getenv 'PROMPTS_DIR' or vim.fn.expand '~/.config/nvim/prompts'

local load_prompt_file = function(file)
  local path = vim.fn.expand(prompts_dir .. '/' .. file)
  local file = io.open(path, 'r')
  if not file then
    return nil
  end

  local content = file:read '*all'
  file:close()
  return content
end

-- load a prompt from a list of files, in order of priority, returning the first found prompt
-- if no files are found, return the default prompt
---@param key string key of the prompt to load
---@param default string default prompt to use if no files are found
---@return string prompt text
function M.prompt(key, default)
  local _t = M.prompts[key]
  if not _t then
    vim.notify('Prompt not found for key: ' .. key, vim.log.levels.WARN)
    return default
  end

  for _, file in ipairs(_t.files) do
    local prompt = load_prompt_file(file)
    if prompt then
      return prompt
    end
  end

  return default
end

M.config = {
  copilot = {
    chat_model = 'claude-sonnet-4-20250514',
    default_model = 'gpt-4o',
  },

  anthropic = {
    base_url = os.getenv 'ANTHROPIC_BASE_URL' or 'https://api.anthropic.com/v1',
    api_key = os.getenv 'ANTHROPIC_API_KEY' or vim.g.anthropic_api_key,
    api_key_path = os.getenv 'ANTHROPIC_API_KEY_PATH'
      or vim.g.anthronpic_api_key_path
      or vim.fn.expand '~/.config/anthropic_api_key',
    default_model = os.getenv 'ANTHROPIC_DEFAULT_MODEL' or 'claude-3-5-sonnet-20240620',
  },

  openai = {
    base_url = os.getenv 'OPENAI_BASE_URL' or 'https://api.openai.com/v1',
    api_key = os.getenv 'OPENAI_API_KEY' or vim.g.openai_api_key,
    api_key_path = os.getenv 'OPENAI_API_KEY_PATH'
      or vim.g.openai_api_key_path
      or vim.fn.expand '~/.config/openai_api_key',
    default_model = os.getenv 'OPENAI_DEFAULT_MODEL' or 'gpt-4o',
  },
}

M.prompts = {
  diagnose_code = {
    name = 'Diagnose Code',
    files = { 'diagnose_code.md', 'diagnose_code.txt' },
    default = [[You are a helpful assistant that diagnoses errors in code.
You will be given a code snippet and a diagnostic message.
You will need to diagnose the error and provide a solution.
You will need to provide a code snippet that fixes the error.
You will need to provide a test case that verifies the fix.
You will need to provide a code snippet that fixes the error.]],
    prompt = function()
      return M.prompt('diagnose_code', M.prompts.diagnose_code.default)
    end,
  },

  fix_code = {
    files = { 'fix_code.md', 'fix_code.txt' },
    default = [[You are a helpful assistant that fixes errors in code.
You will be given a code snippet and a diagnostic message.
You will need to fix the error and provide a solution.
You will need to provide a code snippet that fixes the error.
You will need to provide a test case that verifies the fix.]],
    prompt = function()
      return M.prompt('fix_code', M.prompts.fix_code.default)
    end,
  },

  explain_code = {
    files = { 'explain_code.md', 'explain_code.txt' },
    default = [[
You are a helpful assistant that explains code.
You will be given a code snippet and a question.
You will need to explain the code in a way that is easy to understand.
You will need to provide a code snippet that fixes the error.
      ]],
    prompt = function()
      return M.prompt('explain_code', M.prompts.explain_code.default)
    end,
  },

  refactor_code = {
    files = { 'refactor_code.md', 'refactor_code.txt' },
    default = [[
You are a helpful assistant that refactors code.
You will be given a code snippet and a question.
You will need to refactor the code in a way that is easy to understand.
You will need to provide a code snippet that fixes the error.
      ]],
    prompt = function()
      return M.prompt('refactor_code', M.prompts.refactor_code.default)
    end,
  },

  generate_code = {
    files = { 'generate_code.md', 'generate_code.txt' },
    default = [[
You are a helpful assistant that generates code.
You will be given a code snippet and a question.
You will need to generate a code snippet that fixes the error.
You will need to provide a code snippet that fixes the error.
    ]],
    prompt = function()
      return M.prompt('generate_code', M.prompts.generate_code.default)
    end,
  },

  review_code = {
    files = { 'review_code.md', 'review_code.txt' },
    default = [[
You are a helpful assistant that reviews code.
You will be given a code snippet and a question.
You will need to review the code and provide a code snippet that fixes the error.
You will need to provide a code snippet that fixes the error.
    ]],
    prompt = function()
      return M.prompt('review_code', M.prompts.review_code.default)
    end,
  },

  generate_test_code = {
    files = { 'generate_test_code.md', 'generate_test_code.txt' },
    default = [[You are a helpful assistant that generates test cases for code.
You will be given a code snippet and a question.
You will need to generate a test case that verifies the fix.
You will need to provide a code snippet that fixes the error.]],
    prompt = function()
      return M.prompt('generate_test_code', M.prompts.generate_test_code.default)
    end,
  },

  document_code = {
    files = { 'generate_code_documentation.md', 'generate_code_documentation.txt' },
    default = [[You are a helpful assistant that generates documentation for code.
You will be given a code snippet and a question.
You will need to generate documentation for the code.
You will need to provide a code snippet that fixes the error.]],
    prompt = function()
      return M.prompt('generate_documentation_code', M.prompts.document_code.default)
    end,
  },
}

return M
