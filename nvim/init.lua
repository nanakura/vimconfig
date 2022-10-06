-- xMonody-x huanbin_xiao@163.com
require('packer').startup({function(use)
	use 'wbthomason/packer.nvim' --补全
	use { "williamboman/mason.nvim" }

	use 'ray-x/lsp_signature.nvim'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/nvim-cmp'

	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'
	use 'rafamadriz/friendly-snippets'--片段
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-cmdline'

	use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons', }, tag = 'nightly' }


	use 'akinsho/toggleterm.nvim'

	use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}}--模糊搜索
	use 'lewis6991/gitsigns.nvim'--git修改
	use 'stevearc/aerial.nvim'--函数列表
	use 'nvim-treesitter/nvim-treesitter'--高亮

	-- use 'mjlbach/onedark.nvim'--主题
	use 'marko-cerovac/material.nvim'

	use 'nvim-lualine/lualine.nvim'--状态栏

	use { 'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'} }
	use 'lukas-reineke/indent-blankline.nvim'--对齐线

	use 'b3nj5m1n/kommentary'--注释
	use 'Pocco81/auto-save.nvim' --autosave 自动保存
	use 'windwp/nvim-autopairs'--括号补全
	use 'ethanholz/nvim-lastplace'--打开上一次位置

end,
git = {

	depth = 1, -- Git clone depth
	clone_timeout = 60, -- Timeout, in seconds, for git clones
	default_url_format = 'git@github.com:%s',-- Lua format string used for "aaa/bbb" style plugins
},
config = {
	display = {
		open_fn = function()
			return require('packer.util').float({ border = 'single' })
		end
	}
}})


vim.o.tabstop=4
vim.bo.tabstop=4
vim.o.softtabstop=4
vim.o.shiftwidth=4
--vim.o.expandtab=true --设置tab=空格
vim.o.scrolloff=6
vim.o.pumheight=10
vim.wo.numberwidth=1
vim.transparent_window = true
vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.wo.cursorline=true
vim.o.autoindent=true
vim.o.shiftround=true
vim.o.hlsearch = true
vim.wo.number = true
vim.o.mouse = 'a'
vim.o.swapfile=false
vim.o.breakindent = true
vim.opt.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 200
vim.wo.signcolumn = 'yes'
vim.o.termguicolors = true
vim.o.backspace='indent,eol,start' --设置back键
vim.o.completeopt = 'menuone,noselect'

--vim.cmd [[ set guifont=CodeNewRoman_Nerd_Font_Mono:h11 ]]

--------------------------------------------------------------------------

require("mason").setup({
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗"
			}
		}
	})
-- lspconfig settings
local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr }
	local opts1 = { noremap=true, silent=true }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'gp', vim.diagnostic.goto_prev, opts1 )
	vim.keymap.set('n', 'gn', vim.diagnostic.goto_next,  opts1)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
	--vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
	--[[ vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
	vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
	vim.keymap.set('n', '<leader>wl', function() vim.inspect(vim.lsp.buf.list_workspace_folders()) end, opts)
	vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts) ]]
	vim.keymap.set('n', 'gr', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', 'gc', vim.lsp.buf.references, opts)
	vim.keymap.set('n', 'gf', require('telescope.builtin').lsp_document_symbols, opts)
	-- vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
end
---------------------------------------------------------------------------------------------
--完成函数参数
local lsp_flags = {
	debounce_text_changes = 150,
}
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
---------------------------------------------------------------------------------------------
local servers = { 'clangd'}
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end

require'lspconfig'.sumneko_lua.setup ({
		on_attach = function(client, bufnr)
			client.server_capabilities.document_formatting = false
			client.server_capabilities.document_range_formatting = false
			on_attach(client, bufnr)
		end,
		flags = {
			debounce_text_changes = 150,
		},
		capabilities = capabilities,


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
	})

require'lspconfig'.gopls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		init_options = {
			usePlaceholders = true,
			completeUnimported = true,
		},
	})

require('lspconfig')['rust_analyzer'].setup{
	on_attach = on_attach,
	flags = lsp_flags,
	settings = {
		["rust-analyzer"] = {}
	}
}



-----------------------------------------------------------------------------------
--在悬停窗口中自动显示线路诊断
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
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
--sago

local cfg = {
  debug = false, -- set to true to enable debug logging
  -- log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
  -- default is  ~/.cache/nvim/lsp_signature.log
  verbose = false, -- show debug line number

  bind = true, -- This is mandatory, otherwise border config won't get registered.
  
               -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 1, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                 -- set to 0 if you DO NOT want any API comments be shown
                 -- This setting only take effect in insert mode, it does not affect signature help in normal
                 -- mode, 10 by default

  max_height = 3, -- max height of signature floating_window
  max_width = 100, -- max_width of signature floating_window
  wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long

  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap

  floating_window_off_x =90, -- adjust float windows x position.
  floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines

  close_timeout = 4000, -- close floating window after ms when laster parameter is entered
  fix_pos = true,  -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = false, -- virtual hint enable
  hint_prefix = "💡",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
  hint_scheme = "String",
  hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
  handler_opts = {
    border = "rounded"   -- double, rounded, single, shadow, none
  },

  always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  zindex = 10, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

  padding = ' ', -- character to pad on left and right of signature can be ' ', or '|'  etc

  transparency = nil, -- disabled by default, allow floating win transparent value 1~100
  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 20, -- default timer check interval set to lower value if you want to reduce latency
 toggle_key = '<c-s>', --toggle signature on and off in insert mode,  e.g. toggle_key = '<m-x>'
  select_signature_key = '<c-n>', --cycle to next signature, e.g. '<m-n>' function overloading
  move_cursor_key = '<c-m>', --imap, use nvim_set_current_win to move cursor between current win and floating
}

-- recommended:
require'lsp_signature'.setup(cfg) -- no need to specify bufnr if you don't use toggle_key

-----------------------------------------------------------------------------------

-- luasnip setup
local luasnip = require 'luasnip'
require("luasnip.loaders.from_vscode").lazy_load()
------------------------------------------------------------------------------------
local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 20


-- nvim-cmp setup
local cmp = require('cmp')
cmp.setup{
snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
		luasnip.lsp_expand(args.body)
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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
		{ name = 'path'},
		{ name = 'buffer'},
	},
	view = {
		entries = {name = 'custom' }
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
		local label = vim_item.abbr
		local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
		if truncated_label ~= label then
        vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
		end
		 -- Kind icons
		vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
      -- Source
		vim_item.menu = ({
        buffer = "[Buf]",
        nvim_lsp = "[LSP]",
        luasnip = "[Snp]",
      })[entry.source.name]
      return vim_item
    end
  },
}


cmp.setup.filetype('gitcommit', {
		sources = cmp.config.sources({
				{ name = 'cmp_git' },
			}, {
				{ name = 'buffer' },
			}),
})

cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})


  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })



require'luasnip'.filetype_extend("c++", {"rails"})
require'luasnip'.filetype_extend("c", {"rails"})
require'luasnip'.filetype_extend("rust", {"rails"})
require'luasnip'.filetype_extend("lua", {"rails"})
require'luasnip'.filetype_extend("go", {"rails"})
-----------------------------------------------------------------------------------
--nVim-tree
require'nvim-tree'.setup {-- BEGIN_DEFAULT_OPTS
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
		width = 25,
		height = 10,
		side = "left",
		preserve_window_proportions = false,
		number = false,
		relativenumber = false,
		signcolumn = "yes",
		mappings = {
			custom_only = false,
			list = {
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
}
vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>lua require'nvim-tree'.toggle(true)<CR>", { noremap = true, silent = true })

--------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------
--toggleterm 终端
local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 20,
  -- TODO: add my own keymapping to <space-t>
	open_mapping = [[<c-\>]],
	hide_numbers = false,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 3,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "double",
		winblend = 3,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

----------------------------------------------------------------------------------
--telescope 模糊查
vim.api.nvim_set_keymap("n", "ff", [[<cmd>lua require('telescope.builtin').find_files()<cr>]],{})
vim.api.nvim_set_keymap("n", "fg", [[<cmd>lua require('telescope.builtin').live_grep()<cr>]],{})
vim.api.nvim_set_keymap("n", "fb", [[<cmd>lua require('telescope.builtin').buffers()<cr>]],{})
vim.api.nvim_set_keymap("n", "fm", [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]],{})
vim.api.nvim_set_keymap("n", "fs", [[<cmd>lua require('telescope.builtin').lsp_references()<cr>]],{})
vim.api.nvim_set_keymap("n", "fc", [[<cmd>lua require('telescope.builtin').treesitter()<cr>]],{})
vim.api.nvim_set_keymap("n", "fp", [[<cmd>lua require('telescope.builtin').grep_string()<cr>]],{})

------------------------------------------------------------------------------------
--gitsigns 支持
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
		border = 'single',
		style = 'minimal',
		relative = 'cursor',
		row = 0,
		col = 1
	},
	yadm = {
		enable = false
	},

	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns
		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigati on
		map('n', 'tj', function()
			if vim.wo.diff then return ']c' end
			vim.schedule(function() gs.next_hunk() end)
			return '<Ignore>'
		end, {expr=true})

	map('n', 'tk', function()
		if vim.wo.diff then return '[c' end
		vim.schedule(function() gs.prev_hunk() end)
		return '<Ignore>'
	end, {expr=true})

--map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
--map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
--map('n', '<leader>hS', gs.stage_buffer)
--map('n', '<leader>hu', gs.undo_stage_hunk)
--map('n', '<leader>hR', gs.reset_buffer)
map('n', 'tv', gs.preview_hunk)
map('n', 'tb', function() gs.blame_line{full=true} end)
-- map('n', '<leader>tb', gs.toggle_current_line_blame)
map('n', 'td', gs.diffthis)
--map('n', '<leader>td', gs.toggle_deleted)
	end

}
-----------------------------------------------------------------------------------
--nvim-tree 树目录
--------------------------------------------------------------------------------
--function 函数列表
require("aerial").setup({
		on_attach = function(bufnr)
			vim.api.nvim_buf_set_keymap(bufnr, 'n', 'fo', '<cmd>AerialToggle!<CR>', {})
			vim.api.nvim_buf_set_keymap(bufnr, 'n', '{', '<cmd>AerialPrev<CR>', {})
			vim.api.nvim_buf_set_keymap(bufnr, 'n', '}', '<cmd>AerialNext<CR>', {})
			vim.api.nvim_buf_set_keymap(bufnr, 'n', '[[', '<cmd>AerialPrevUp<CR>', {})
			vim.api.nvim_buf_set_keymap(bufnr, 'n', ']]', '<cmd>AerialNextUp<CR>', {})
		end,
		backends = { "treesitter", "lsp", "markdown" },
		-- close_behavior= "auto",
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
----------------------------------------------------------------------------------
-- Treesitter 高亮
require'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "cpp", "lua", "rust","go" },
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}
-------------------------------------------------------------------------------
--material
require('material').setup({
    contrast = {
        sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
        floating_windows = false, -- Enable contrast for floating windows
        cursor_line = false, -- Enable darker background for the cursor line
        non_current_windows = false, -- Enable darker background for non-current windows
        popup_menu = false, -- Enable lighter background for the popup menu
    },

    italics = {
        comments = false, -- Enable italic comments
        keywords = false, -- Enable italic keywords
        functions = false, -- Enable italic functions
        strings = false, -- Enable italic strings
        variables = false -- Enable italic variables
    },

    contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
        "terminal", -- Darker terminal background
        "packer", -- Darker packer background
        "qf" -- Darker qf list background
    },

    high_visibility = {
        lighter = false, -- Enable higher contrast text for lighter style
        darker = false -- Enable higher contrast text for darker style
    },

    disable = {
        colored_cursor = false, -- Disable the colored cursor
        borders = false, -- Disable borders between verticaly split windows
        background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
        term_colors = false, -- Prevent the theme from setting terminal colors
        eob_lines = false -- Hide the end-of-buffer lines
    },

    lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

    async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

    custom_highlights = {}, -- Overwrite highlights with your own

    plugins = { -- Here, you can disable(set to false) plugins that you don't use or don't want to apply the theme to
        trouble = true,
        nvim_cmp = true,
        neogit = true,
        gitsigns = true,
        git_gutter = true,
        telescope = true,
        nvim_tree = true,
        sidebar_nvim = true,
        lsp_saga = true,
        nvim_dap = true,
        nvim_navic = true,
        which_key = true,
        sneak = true,
        hop = true,
        indent_blankline = true,
        nvim_illuminate = true,
        mini = true,
    }
})
vim.g.material_style = "palenight"
--Lua:
vim.cmd 'colorscheme material'

-----------------------------------------------------------------------------------
--statusline 状态栏
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
--tabline 缓冲区状态栏
-- Set barbar's options
require'bufferline'.setup {
  animation = true,

  auto_hide = false,

  tabpages = true,

  closable = true,

  clickable = true,

  exclude_ft = {'javascript'},
  exclude_name = {'package.json'},

  icons = true,

  icon_custom_colors = false,

  icon_separator_active = '▎',
  icon_separator_inactive = '▎',
  icon_close_tab = '',
  icon_close_tab_modified = '●',
  icon_pinned = '車',

  insert_at_end = false,
  insert_at_start = false,

  maximum_padding = 1,

  minimum_padding = 1,

  maximum_length = 30,

  semantic_letters = true,

  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

  no_name_title = nil,
}

------------------------------------------------------------------------------------------------------
--blankline 对齐线
vim.opt.list = true
vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
    show_end_of_line = true,
    space_char_blankline = " ",
}
-----------------------------------------------------------------------------------
--commentary 注释
require('kommentary.config').use_extended_mappings()
vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>kommentary_line_increase", {})
vim.api.nvim_set_keymap("x", "<leader>cc", "<Plug>kommentary_visual_increase", {})

vim.api.nvim_set_keymap("n", "<leader>cu", "<Plug>kommentary_line_decrease", {})
vim.api.nvim_set_keymap("x", "<leader>cu", "<Plug>kommentary_visual_decrease", {})

-----------------------------------------------------------------------------------
--nvim-autoparirs 括号补全
local npairs=require('nvim-autopairs')
npairs.setup({
		fast_wrap = {},
	})
npairs.setup({
		fast_wrap = {
			map = '<A-e>',
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
-----------------------------------------------------------------------------------
--autosave 自动保存
require("auto-save").setup { } --自动保存
----------------------------------------------------------------------------------
--lastplace 一次的编辑的位置
require'nvim-lastplace'.setup {
	lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
	lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
	lastplace_open_folds = true
}
-------------------------------------------------------------------------------
--自定义快捷键
vim.api.nvim_set_keymap("n", "<leader>cs", "<cmd>lua require('material.functions').toggle_style()<CR>", {})
vim.api.nvim_set_keymap("i", "<C-l>", "<Right>", {})
vim.api.nvim_set_keymap("n", "<C-h>", ":bp<CR>", {})
vim.api.nvim_set_keymap("n", "<C-l>", ":bn<CR>", {})
vim.api.nvim_set_keymap("n", "<C-q>", ":bd<CR>", {})

vim.api.nvim_set_keymap("n", "<leader>a", ":%s/<C-r><C-w>//g<left><left>", {})

vim.api.nvim_set_keymap("n", "q", ":nohl<CR>", {})
vim.api.nvim_set_keymap("v", "q", "<Esc>", {})

vim.api.nvim_set_keymap("n", "<leader>yy", '"+yy', {})
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', {})
vim.api.nvim_set_keymap("n", "<leader>p", '"+p', {})

vim.api.nvim_set_keymap("n", "<C-w>u", "<C-w>t<C-w>K", {})
vim.api.nvim_set_keymap("n", "<C-w>i", "<C-w>t<C-w>H", {})
vim.api.nvim_set_keymap("n", "zl", "<C-w>3>", {})
vim.api.nvim_set_keymap("n", "zh", "<C-w>3<", {})
