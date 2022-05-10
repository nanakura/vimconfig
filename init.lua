--linux-~.config/nvim/init.lua
--git clone --depth 1 https://github.com/wbthomason/packer.nvim\ ~/.local/share/nvim/site/pack/packer/start/packer.nvim

--windows   ~/AppData\Local\nvim\init.lua
-- git clone https://github.com/wbthomason/packer.nvim "~\AppData\Local\nvim-data\site\pack\packer\start"
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
 
  use 'nvim-lualine/lualine.nvim'--状态栏
  
  use 'mjlbach/onedark.nvim'  --主题
  
  use 'nvim-treesitter/nvim-treesitter'--高亮

  use {--butter插件
  'romgrk/barbar.nvim',
  requires = {'kyazdani42/nvim-web-devicons'}
    }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- 书目录
    }
 }
 use 'b3nj5m1n/kommentary'--注释
 use 'steelsojka/pears.nvim'
 use 'numToStr/FTerm.nvim'
 use 'lukas-reineke/indent-blankline.nvim'
 use 'lewis6991/gitsigns.nvim'

 use {
	 'nvim-telescope/telescope.nvim',
	 requires = {'nvim-lua/plenary.nvim'}
 }


 --补全
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'onsails/lspkind.nvim'
end)
vim.o.tabstop=4
vim.bo.tabstop=4
vim.o.softtabstop=4
vim.o.shiftwidth=4
vim.o.scrolloff=4
vim.o.sidescrolloff=4
vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.wo.cursorline=true
vim.o.autoindent=true
vim.o.shiftround=true
vim.o.hlsearch = false
vim.wo.number = true
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.opt.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'
vim.o.termguicolors = true
vim.o.completeopt = 'menuone,noselect'
vim.cmd [[colorscheme onedark]]

--Set statusbar状态栏
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
------------------------------------------------------------------------------------------------------------
--nvim-tree
require'nvim-tree'.setup { -- BEGIN_DEFAULT_OPTS
  auto_reload_on_write = true,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_setup_file = false,
  open_on_tab = false,
  sort_by = "name",
  update_cwd = false,
  view = {
    width = 30,
    height = 30,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {
        -- user mappings go here
      },
    },
  },
  renderer = {
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {},
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd = nil,
    args = {},
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      git = false,
      profile = false,
    },
  },
} -- END_DEFAULT_OPTS
vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>lua require'nvim-tree'.toggle(false, true)<CR>", { noremap = true, silent = true })

--------------------------------------------------------------------------------------------------------------
-- Treesitter configuration 高亮
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "lua", "rust","go","html","python","cmake" },

  sync_install = false,

  ignore_install = { "javascript" },
  highlight = {
    enable = true,
   -- disable = { "c", "rust" },

    additional_vim_regex_highlighting = false,
  },
}
----------------------------------------
--注释
require('kommentary.config').use_extended_mappings()
vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>kommentary_line_increase", {})
vim.api.nvim_set_keymap("x", "<leader>c", "<Plug>kommentary_visual_increase", {})
vim.api.nvim_set_keymap("n", "<leader>cu", "<Plug>kommentary_line_decrease", {})
vim.api.nvim_set_keymap("x", "<leader>u", "<Plug>kommentary_visual_decrease", {})

------------------------------------------------------------------------------------------
require "pears".setup(function(conf)
  conf.pair("{", {filetypes = {"c", "javascript","cpp","python","html","css","lua","json","cmake","sh"}})
end)

---------------------------------------------------------------------------------------------------
-------------------------blankline
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}
-----------------------------------------------------------------------------------------------------
--Fterm
require'FTerm'.setup({
    border = 'double',
    dimensions  = {
        height = 0.7,
        width = 0.7,
    },
})
vim.keymap.set('n', '<leader>t', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<leader>d', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
-------------------------------------------------------------------------------------------
function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', 'gn', '<cmd>lua require("cosmic-ui").rename()<cr>')
map('n', '<leader>g', '<cmd>lua require("cosmic-ui").code_actions()<cr>')
map('v', '<leader>g', '<cmd>lua require("cosmic-ui").range_code_actions()<cr>')


-------------------------------------------------------------------------------------------
-- LSP settings
local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'm', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
-- Enable the following language servers lua-language-servers
local servers = { 'clangd' , 'rust_analyzer' , 'gopls'}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
local function goto_definition(split_cmd)
  local util = vim.lsp.util
  local log = require("vim.lsp.log")
  local api = vim.api

  -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
  local handler = function(_, result, ctx)
    if result == nil or vim.tbl_isempty(result) then
      local _ = log.info() and log.info(ctx.method, "No location found")
      return nil
    end

    if split_cmd then
      vim.cmd(split_cmd)
    end

    if vim.tbl_islist(result) then
      util.jump_to_location(result[1])

      if #result > 1 then
        util.set_qflist(util.locations_to_items(result))
        api.nvim_command("copen")
        api.nvim_command("wincmd p")
      end
    else
      util.jump_to_location(result)
    end
  end

  return handler
end

--在悬停窗口中自动显示线路诊断
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

vim.lsp.handlers["textDocument/definition"] = goto_definition('split')
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
vim.diagnostic.config({
  virtual_text = {
    prefix = '●', -- Could be '', '▎', 'x'
  }
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

-----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-- luasnip setup
local luasnip = require 'luasnip'


-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
   window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

local lspkind = require('lspkind')
cmp.setup {
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol',
      maxwidth = 50, 
      before = function (entry, vim_item)
        return vim_item
      end
    })
  }
}
    
  --------------------------------------------------------------------------------------------
    cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })
  
  require'cmp'.setup.cmdline(':', {
  sources = {
    { name = 'cmdline' }
  }
})
----------------------------------------------------------------------------------------------
require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '|', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '|', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '|', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '|', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '|', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}
--------------------------------------------------------------------------------------------------
vim.api.nvim_set_keymap("n", "<leader>ff", [[<cmd>lua require('telescope.builtin').find_files()<cr>]],{})
vim.api.nvim_set_keymap("n", "<leader>fg", [[<cmd>lua require('telescope.builtin').live_grep()<cr>]],{})
vim.api.nvim_set_keymap("n", "<leader>fb", [[<cmd>lua require('telescope.builtin').buffers()<cr>]],{})

--自定义快捷键
vim.api.nvim_set_keymap("i", "<C-l>", "<Right>", {})
vim.api.nvim_set_keymap("n", "<leader>b", ":bp<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>f", ":bn<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>d", ":bd<CR>", {})


vim.api.nvim_set_keymap("n", "q", ":nohl<CR>", {})
vim.api.nvim_set_keymap("v", "q", "<Esc>", {})

vim.api.nvim_set_keymap("n", "<leader>y", '"+yy', {})
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', {})
vim.api.nvim_set_keymap("n", "<leader>p", '"+p', {})

vim.api.nvim_set_keymap("n", "zl", "<C-w>3>", {})

