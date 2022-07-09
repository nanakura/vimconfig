--linux-~.config/nvim/init.lua
--git clone --depth 1 https://github.com/wbthomason/packer.nvim\ ~/.local/share/nvim/site/pack/packer/start/packer.nvim

--windows   ~/AppData\Local\nvim\init.lua
-- git clone https://github.com/wbthomason/packer.nvim "~\AppData\Local\nvim-data\site\pack\packer\start"
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    --补全
    use 'ray-x/lsp_signature.nvim'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/nvim-cmp'
    use 'onsails/lspkind.nvim'

    use  'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
	use 'rafamadriz/friendly-snippets'


    use {
        'kyazdani42/nvim-tree.lua',-- 树目录
        requires = {
            'kyazdani42/nvim-web-devicons',
        }
    }

    use 'nvim-lualine/lualine.nvim'--状态栏
    --use 'mjlbach/onedark.nvim'--主题
    use({'glepnir/zephyr-nvim',requires = { 'nvim-treesitter/nvim-treesitter', opt = true },})--主题
    use 'nvim-treesitter/nvim-treesitter'--高亮
    use 'stevearc/aerial.nvim'--函数列表
    use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}

    use {
        'nvim-telescope/telescope.nvim',--模糊搜索
        requires = {'nvim-lua/plenary.nvim'}
    }
    use 'numToStr/FTerm.nvim'--终端

    use 'b3nj5m1n/kommentary'--注释
    use 'lukas-reineke/indent-blankline.nvim'--对齐线
    use 'mg979/vim-visual-multi' --多光标
    use "Pocco81/AutoSave.nvim"--自动保存
	use 'windwp/nvim-autopairs'--括号补全
	use 'ethanholz/nvim-lastplace'--打开上一次位置


    use 'lewis6991/gitsigns.nvim'--git修改
	use 'tveskag/nvim-blame-line'
end)
vim.o.tabstop=4
vim.bo.tabstop=4
vim.o.softtabstop=4
vim.o.shiftwidth=4
vim.o.scrolloff=4
vim.o.sidescrolloff=4
vim.wo.numberwidth=1
vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.wo.cursorline=true
vim.o.autoindent=true
vim.o.shiftround=true
vim.o.hlsearch = false
vim.wo.number = true
vim.o.mouse = 'a'
vim.o.swapfile=true
vim.o.breakindent = true
vim.opt.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'
vim.o.termguicolors = true
vim.o.completeopt = 'menuone,noselect'
vim.cmd [[colorscheme zephyr]]

-----------------------------------------------------------------------------------
-- LSP settings
local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function() vim.inspect(vim.lsp.buf.list_workspace_folders()) end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)
    vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
end
-----------------------------------------------------------------------------------------------
--完成函数参数
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
--------------------------------------------------------------------------------------------------
local servers = { 'clangd', 'gopls', 'sumneko_lua','rust_analyzer'}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end


require'lspconfig'.sumneko_lua.setup {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

require('lspconfig')['rust_analyzer'].setup{
    { "rust-analyzer" },
    { "rust" },
}

-----------------------------------------------------------------------------------
--在悬停窗口中自动显示线路诊断
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

local signs = { Error = "✗", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    virtual_text = {
        prefix = '●',
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = true,
        severity_sort = false,
    }
})
-----------------------------------------------------------------------------------
local cfg = {
    debug = false, -- set to true to enable debug logging
    log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
    verbose = false, -- show debug line number
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
    floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
    floating_window_above_cur_line = true,
    floating_window_off_x = 1,
    floating_window_off_y = -1,
    fix_pos = false,
    hint_enable = true,
    hint_prefix = "💡",
    hint_scheme = "String",
    hi_parameter = "LspSignatureActiveParameter",
    max_height = 2,
    max_width = 50,
    handler_opts = {
        border = "rounded"
    },
    always_trigger = false,
    auto_close_after = nil,
    extra_trigger_chars = {},
    zindex = 200,
    padding = '',
    transparency = nil,
    shadow_blend = 36,
    shadow_guibg = 'Black',
    timer_interval = 200,
    toggle_key = nil
}
require'lsp_signature'.setup(cfg)
require "lsp_signature".setup({
    bind = true,
    handler_opts = {
        border = "rounded"
    }
})

------------------------------------------------------------------------------------
-- luasnip setup
local luasnip = require 'luasnip'
local lspkind = require('lspkind')
require("luasnip.loaders.from_vscode").lazy_load()
------------------------------------------------------------------------------------
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
    view = {
        entries = {name = 'custom' }
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol",
            menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[Latex]",
            })
        }),
    },
}

-----------------------------------------------------------------------------------
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
    width = 22,
    height = 22,
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
-----------------------------------------------------------------------------------
--theme
-----------------------------------------------------------------------------------------------
-- Treesitter configuration 高亮
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "cpp", "lua", "rust","go","cmake" },
    sync_install = false,
    ignore_install = { "javascript" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
---------------------------------------------------------------------------------------
--函数列表
require("aerial").setup({
  on_attach = function(bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>fc', '<cmd>AerialToggle!<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '{', '<cmd>AerialPrev<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '}', '<cmd>AerialNext<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[[', '<cmd>AerialPrevUp<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']]', '<cmd>AerialNextUp<CR>', {})
  end,
    backends = { "treesitter", "lsp", "markdown" },
  close_behavior = "auto",
  default_bindings = true,
  default_direction = "prefer_right",
  disable_max_lines = 10000,
  disable_max_size = 2000000, -- Default 2MB
  filter_kind = {
    "Class",
    "Constructor",
    "Enum",
    "Function",
    "Interface",
    "Module",
    "Method",
    "Struct",
  },
  highlight_mode = "split_width",
  highlight_closest = true,
  highlight_on_hover = false,
  highlight_on_jump = 300,
  icons = {},
  ignore = {
    unlisted_buffers = true,
    filetypes = {},
    buftypes = "special",
    wintypes = "special",
  },
  link_folds_to_tree = false,
  link_tree_to_folds = true,
  manage_folds = false,
  max_width = { 30, 0.2 },
  width = nil,
  min_width = 20,
  nerd_font = "auto",
  on_attach = nil,
  on_first_symbols = nil,
  open_automatic = false,
  placement_editor_edge = false,
  post_jump_cmd = "normal! zz",
  close_on_select = false,
  show_guides = false,
  update_events = "TextChanged,InsertLeave",
  guides = {
    mid_item = "├─",
    last_item = "└─",
    nested_top = "│ ",
    whitespace = "  ",
  },
  float = {
    border = "rounded",
    relative = "cursor",
    max_height = 0.9,
    height = nil,
    min_height = { 8, 0.1 },

    override = function(conf)
      return conf
    end,
  },

  lsp = {
    diagnostics_trigger_update = true,
    update_when_errors = true,
    update_delay = 300,
  },

  treesitter = {
    update_delay = 300,
  },
})
----------------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------
--bufferline
vim.opt.termguicolors = true
require("bufferline").setup{}

-----------------------------------------------------------------------------------
--括号补全
local npairs=require('nvim-autopairs')
npairs.setup({
    fast_wrap = {},
})
npairs.setup({
    fast_wrap = {
        map = '<M-e>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = [=[[%'%"%)%>%]%)%}%,]]=],
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'Search',
        highlight_grey='Comment'
    },
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp = require('cmp')
cmp.event:on(
'confirm_done',
cmp_autopairs.on_confirm_done()
)

require('nvim-autopairs').setup({
    enable_check_bracket_line = false
})

----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--模糊查找
vim.api.nvim_set_keymap("n", "<leader>ff", [[<cmd>lua require('telescope.builtin').find_files()<cr>]],{})
vim.api.nvim_set_keymap("n", "<leader>fg", [[<cmd>lua require('telescope.builtin').live_grep()<cr>]],{})
vim.api.nvim_set_keymap("n", "<leader>fb", [[<cmd>lua require('telescope.builtin').buffers()<cr>]],{})

-----------------------------------------------------------------------------------
--Fterm终端
require'FTerm'.setup({
    border = 'double',
    dimensions  = {
        height = 0.9,
        width = 0.8,
    },
})

local fterm = require("FTerm")
local btop = fterm:new({
    ft = 'fterm_lazygit',
    cmd = "lazygit",
    dimensions = {
        height = 0.9,
        width = 0.8
    }
})

vim.keymap.set('n', '<leader>g', function()
    btop:toggle()
end)

vim.keymap.set('n', '<leader>t', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<leader>d', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
-----------------------------------------------------------------------------------
require('indent_blankline').setup {
    char = '┆',
    show_trailing_blankline_indent = false,
}
------------------------------------------------------------------------------------
--自动保存
local autosave = require("autosave")
autosave.setup(
{
    enabled = true,
    execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
    events = {"InsertLeave", "TextChanged"},
    conditions = {
        exists = true,
        filename_is_not = {},
        filetype_is_not = {},
        modifiable = true
    },
    write_all_buffers = false,
    on_off_commands = true,
    clean_command_line_interval = 0,
    debounce_delay = 135
}
)
-----------------------------------------------------------------------------------
--注释
require('kommentary.config').use_extended_mappings()
vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>kommentary_line_increase", {})
vim.api.nvim_set_keymap("x", "<leader>cc", "<Plug>kommentary_visual_increase", {})

vim.api.nvim_set_keymap("n", "<leader>cu", "<Plug>kommentary_line_decrease", {})
vim.api.nvim_set_keymap("x", "<leader>cu", "<Plug>kommentary_visual_decrease", {})
----------------------------------------------------------------------------------
--
require'nvim-lastplace'.setup {
    lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
    lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
    lastplace_open_folds = true
}
------------------------------------------------------------------------------------
--git支持
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
----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--自定义快捷键
vim.api.nvim_set_keymap("i", "<C-l>", "<Right>", {})
vim.api.nvim_set_keymap("n", "<C-k>", ":bp<CR>", {})
vim.api.nvim_set_keymap("n", "<C-j>", ":bn<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>d", ":bd<CR>", {})

vim.api.nvim_set_keymap("n", "<leader>a", ":%s/<C-r><C-w>//g<left><left>", {})

vim.api.nvim_set_keymap("n", "q", ":nohl<CR>", {})
vim.api.nvim_set_keymap("v", "q", "<Esc>", {})

vim.api.nvim_set_keymap("n", "<leader>yy", '"+yy', {})
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', {})
vim.api.nvim_set_keymap("n", "<leader>p", '"+p', {})

vim.api.nvim_set_keymap("n", "<C-w>j", "<C-w>t<C-w>K", {})
vim.api.nvim_set_keymap("n", "<C-w>k", "<C-w>t<C-w>H", {})
vim.api.nvim_set_keymap("n", "zl", "<C-w>3>", {})
