local M = {}

local vault_path = vim.fn.expand("~/Projects/makifdb/notes")

local function today_str()
  return os.date("%Y-%m-%d")
end

local function yesterday_str()
  return os.date("%Y-%m-%d", os.time() - 86400)
end

local function file_path(date_str)
  return vault_path .. "/inbox/journal/" .. date_str .. ".md"
end

local function read_file(path)
  local f = io.open(path, "r")
  if not f then return {} end
  local lines = {}
  for line in f:lines() do
    table.insert(lines, line)
  end
  f:close()
  return lines
end

local function extract_incomplete_todos(lines)
  local todos = {}
  for _, line in ipairs(lines) do
    if line:match("^%- %[ %]") then
      table.insert(todos, line)
    end
  end
  return todos
end

function M.open_daily()
  local today = today_str()
  local path = file_path(today)

  vim.fn.mkdir(vault_path .. "/inbox/journal", "p")

  if vim.fn.filereadable(path) == 0 then
    local lines = { "# " .. today, "", "## Today", "", "- [ ] ", "", "## Carried over" }

    local yesterday = yesterday_str()
    local ypath = file_path(yesterday)
    local ycontent = read_file(ypath)
    local todos = extract_incomplete_todos(ycontent)
    if #todos > 0 then
      for _, todo in ipairs(todos) do
        table.insert(lines, todo)
      end
    end

    table.insert(lines, "")
    table.insert(lines, "## Notes")
    table.insert(lines, "")

    local f = io.open(path, "w")
    if f then
      f:write(table.concat(lines, "\n"))
      f:close()
    end
  end

  vim.cmd("edit " .. path)
end

return M
