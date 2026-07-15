-- [[ Leader ]] --
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Lazy.nvim ]] --
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- [[ Plugins ]] --
require('lazy').setup({
  -- Git
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop/shiftwidth
  'tpope/vim-sleuth',

  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'folke/lazydev.nvim',
    },
  },

  -- Completion
  {
    'saghen/blink.cmp',
    version = '*',
    dependencies = { 'L3MON4D3/LuaSnip' },
    opts = {
      snippets = { preset = 'luasnip' },
      sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
      keymap = { preset = 'default' },
    },
  },

  -- Keybind hints
  { 'folke/which-key.nvim', opts = {} },

  -- Git signs
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        vim.keymap.set('n', '[c', require('gitsigns').prev_hunk, { buffer = bufnr, desc = 'Prev Hunk' })
        vim.keymap.set('n', ']c', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Next Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview Hunk' })
      end,
    },
  },

  -- Theme
  {
    'sainnhe/gruvbox-material',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('gruvbox-material')
    end,
  },

  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = { theme = 'gruvbox-material' },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = { 'diagnostics' },
        lualine_y = { { 'location', fmt = function(s) return s end } },
        lualine_z = { 'progress' },
      },
    },
  },

  -- Autopairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  -- File explorer
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    opts = {
      filesystem = { filtered_items = { visible = true } },
    },
  },

  -- Commenting
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function() return vim.fn.executable 'make' == 1 end,
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    config = function()
      require('nvim-treesitter').setup({
        ensure_installed = { 'go', 'lua', 'vim', 'vimdoc', 'query', 'python', 'javascript', 'typescript', 'tsx', 'rust', 'c', 'cpp', 'yaml', 'json', 'html', 'css' },
        auto_install = true,
      })
      require('nvim-treesitter-textobjects').setup({
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = { [']m'] = '@function.outer', [']]'] = '@class.outer' },
          goto_next_end = { [']M'] = '@function.outer', [']['] = '@class.outer' },
          goto_previous_start = { ['[m'] = '@function.outer', ['[['] = '@class.outer' },
          goto_previous_end = { ['[M'] = '@function.outer', ['[]'] = '@class.outer' },
        },
      })
    end,
  },

  -- Go
  {
    'ray-x/go.nvim',
    ft = { 'go', 'gomod' },
    config = function() require('go').setup() end,
    build = ':lua require("go.install").update_all_sync()',
  },
}, {})

-- [[ Options ]] --
vim.o.number = true
vim.o.hlsearch = false
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true
vim.o.fillchars = 'eob: '

-- [[ Keymaps ]] --
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Yank highlight ]] --
local hl_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
  group = hl_group,
  pattern = '*',
})

-- [[ Telescope ]] --
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}
pcall(require('telescope').load_extension, 'fzf')

vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Recent files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Buffers' })
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10, previewer = false,
  })
end, { desc = '[/] Fuzzily search buffer' })
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = '[E]xplorer' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = '[G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Diagnostics ]] --
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Floating diagnostic' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics list' })

-- [[ LSP ]] --
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then desc = 'LSP: ' .. desc end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, blink = pcall(require, 'blink.cmp')
if ok_cmp then
  capabilities = blink.get_lsp_capabilities(capabilities)
end

local servers = {
  gopls = {
    settings = {
      gopls = {
        analyses = { unusedparams = true },
        staticcheck = true,
      },
    },
  },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

require('mason-lspconfig').setup({ ensure_installed = vim.tbl_keys(servers) })
for server_name, server_settings in pairs(servers) do
  vim.lsp.config(server_name, {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = server_settings,
  })
  vim.lsp.enable(server_name)
end

-- [[ lazydev (neovim lua dev) ]] --
require('lazydev').setup()

-- vim: ts=2 sts=2 sw=2 et
