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
 use "steelsojka/pears.nvim"
 
 --补全
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
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
  ensure_installed = { "c", "cpp", "lua", "rust" },

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

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
-- Enable the following language servers
local servers = { 'clangd','gopls','pyright'}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
-------------------------------------------------------------------------------------------

vim.diagnostic.config({
  virtual_text = {
    prefix = '✘', -- Could be '●', '▎', 'x'
  }
})
local lspkind = require('lspkind')
--------------------------------------------------------------------------------------------


-- luasnip setup
local luasnip = require 'luasnip'
-- nvim-cmp setup
vim.o.completeopt = 'menuone,noselect'
-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- local cmp = require'cmp'
-- cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
        return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line-1, line, true)[1]:sub(col, col):match('%s') == nil
end

-- Add lspkind
local lspkind = require('lspkind')
-- local luasnip = require('luasnip')

local source_mapping = {
    -- buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[Lua]",
    cmp_tabnine = "[TN]",
    path = "[Path]",
    emoji = "[Emoji]",
    look = "[Dict]",
    calc = "[Calc]",
    vsnip = "[vsnip]",
}


cmp.setup({
    enabled = function()
        if require"cmp.config.context".in_treesitter_capture("comment")==true or require"cmp.config.context".in_syntax_group("Comment") then
            return false
        else
            return true
        end
    end,
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
--   formatting = {
-- format = require'lspkind'.cmp_format({
--   mode = 'symbol_text',
--   maxwidth = 50,
-- })
-- },
    formatting = {
            format = lspkind.cmp_format{
                mode = 'symbol_text', -- show only symbol annotations
                maxwidth = 100, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

                -- The function below will be called before any actual modifications from lspkind
                -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                before = function(entry, vim_item)
                    vim_item.kind = lspkind.presets.default[vim_item.kind]
                    local menu = source_mapping[entry.source.name]
                    if entry.source.name == 'cmp_tabnine' then
                        if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                            menu = entry.completion_item.data.detail .. ' ' .. menu
                        end
                        vim_item.kind = ''
                    end
                    vim_item.menu = menu
                    return vim_item
                end
            }
    },
    mapping = {
        -- ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        -- ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        -- ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-b>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-f>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<Tab>'] = function(fallback)  -- see GH-231, GH-286
            if cmp.visible() then cmp.select_next_item()
            elseif has_words_before() then cmp.complete()
            else fallback() end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            else fallback() end
        end,
    },
    sources = {
        { name = "nvim_lsp", priority = 100}, -- Keep LSP results on top.
        { name = "nvim_lua" },
        { name = 'vsnip' }, -- For vsnip users.
        -- { name = "luasnip" },
        -- { name = "buffer" ,keyword_pattern = [[\k]] ,priority = 90},
        { name = "cmp_tabnine" , priority = 15},
        { name = "path" },
        {name = 'emoji', insert = true},
        {
            name = 'look',
            priority = 1,
            keyword_length = 5,
            option = {
                convert_case = true,
                loud = true
                --dict = '/usr/share/dict/words'
            }
        },
        { name = 'calc' },
        {name = 'nvim_lsp_signature_help'},
    },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
    },
    preselect = cmp.PreselectMode.Item,
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    experimental = {
        ghost_text = true,
        native_menu = false,
    },
})


--自定义快捷键
vim.api.nvim_set_keymap("i", "<C-l>", "<Right>", {})
vim.api.nvim_set_keymap("n", "<leader>b", ":bp<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>f", ":bn<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>d", ":bd<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>t", ":vsplit term://cmd<CR>", {})
vim.api.nvim_set_keymap("t", "<leader>c", "exit<CR><CR>", {})


vim.api.nvim_set_keymap("n", "q", ":nohl<CR>", {})
vim.api.nvim_set_keymap("v", "q", "<Esc>", {})

vim.api.nvim_set_keymap("n", "Y", '"+yy', {})
vim.api.nvim_set_keymap("n", "P", '"+p', {})
vim.api.nvim_set_keymap("v", "Y", '"+y', {})
vim.api.nvim_set_keymap("v", "P", '"+p', {})


vim.api.nvim_set_keymap("n", "zl", "<C-w>3>", {})

