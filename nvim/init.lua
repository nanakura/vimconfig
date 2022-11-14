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
	use 'rafamadriz/friendly-snippets'

	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-cmdline'

	use { "nvim-neo-tree/neo-tree.nvim", branch = "v2.x",
		requires = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons", "MunifTanjim/nui.nvim", } }


	use 'akinsho/toggleterm.nvim'

	use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}}--模糊搜索
	use 'lewis6991/gitsigns.nvim'--git修改
	use 'stevearc/aerial.nvim'--函数列表
	use 'nvim-treesitter/nvim-treesitter'--高亮

	-- use 'mjlbach/onedark.nvim'--主题
	use 'folke/tokyonight.nvim'

	use 'nvim-lualine/lualine.nvim'--状态栏
	use { 'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'} }
	use 'lukas-reineke/indent-blankline.nvim'--对齐线

	use 'b3nj5m1n/kommentary'--注释
	use 'Pocco81/auto-save.nvim' --autosave 自动保存
	use 'windwp/nvim-autopairs'--括号补全
	use 'ethanholz/nvim-lastplace'--打开上一次位置

end,

git = { depth = 1, clone_timeout = 300, --default_url_format = 'git@github.com:%s',
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

local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr }
	local opts1 = { noremap=true, silent=true }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'gp', vim.diagnostic.goto_prev, opts1 )
	vim.keymap.set('n', 'gn', vim.diagnostic.goto_next,  opts1)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
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
vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]
local border = {
      {"╭", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╮", "FloatBorder"},
      {"│", "FloatBorder"},
      {"╯", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╰", "FloatBorder"},
      {"│", "FloatBorder"},
}

local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end


--在悬停窗口中自动显示线路诊断
vim.o.updatetime = 250
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

--local signs = { Error = "", Warn = "", Hint = "", Info = "" }
local signs = { Error = "", Warn = "", Hint = "", Info = "ﴞ" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
	virtual_text = true,
    signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = false,
})

vim.diagnostic.config({
	virtual_text = {
		prefix = '●',--'x'
	}
})

local lsp_flags = {
	debounce_text_changes = 150,
}
local capabilities = vim.lsp.protocol.make_client_capabilities()

require'lspconfig'.clangd.setup({
	handlers=handlers,
	flags = lsp_flags,
	on_attach = on_attach,
	capabilities = capabilities,
})

require'lspconfig'.glslls.setup({
	handlers=handlers,
	on_attach = on_attach,
	capabilities = capabilities,
})

require'lspconfig'.sumneko_lua.setup ({
	-- handlers=handlers,
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		client.server_capabilities.document_formatting = false
		client.server_capabilities.document_range_formatting = false
		on_attach(client, bufnr)
	end,
	flags = {
		debounce_text_changes = 150,
	},

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
	-- handlers=handlers,
	flags = lsp_flags,
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
	},
})

require('lspconfig')['rust_analyzer'].setup{
	-- handlers=handlers,
	on_attach = on_attach,
	flags = lsp_flags,
	settings = {
		["rust-analyzer"] = {}
	}
}

-----------------------------------------------------------------------------------
-- luasnip setup
local kind_icons = {
	Text = "",
    Method = "",
	Function = "",
    Constructor = "",
	Field = "",
	Variable = "",
	Class = "ﴯ",
	Interface = "",
	Module = "",
	Property = "ﰠ",
	Unit = "",
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
local MAX_LABEL_WIDTH = 40

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end



require("luasnip.loaders.from_vscode").lazy_load()
local luasnip = require("luasnip")
local cmp = require('cmp')
cmp.setup{
	expand = function(args)
		require('luasnip').lsp_expand(args.body)
	end,

	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
		-- documentation=cmp.config.disable,
	},

	mapping = {
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<C-n>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-p>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		['<C-u>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
		["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
    },

	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip'},
		{ name = 'path'},
		{ name = 'buffer'},
	},

	view = {
		entries = {name = 'custom' ,},
		-- entries= {window.documentation.width=10},
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

		vim_item.menu = ({
        	nvim_lsp = "[LSP]",
			luasnip  = "[Snp]",
			buffer   = "[Buf]",
			paht     = "[Pat]",
		})[entry.source.name]
			return vim_item
		end
	},
}
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = 'buffer' },
	})
})

cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
		{ name = 'path' }
    }, {
		{ name = 'cmdline' }
	})
})
 ----------------------------------------------------------------------------------

 local cfg={
	debug = false, -- set to true to enable debug logging
	log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
	-- default is  ~/.cache/nvim/lsp_signature.log
	verbose = false, -- show debug line number

	bind = true, -- This is mandatory, otherwise border config won't get registered.
               -- If you want to hook lspsaga or other signature handler, pls set to false
	doc_lines = 0, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);

	max_height = 3, -- max height of signature floating_window
	max_width = 200, -- max_width of signature floating_window
	noice = false, -- set to true if you using noice to render markdown
	wrap = false, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
	floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

	floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:

	floating_window_off_x = 1, -- adjust float windows x position.
	floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines

	close_timeout = 4000, -- close floating window after ms when laster parameter is entered
	fix_pos = true,  -- set to true, the floating window will not auto-close until finish all parameters
	hint_enable = false, -- virtual hint enable
	hint_prefix = "🐼 ",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
	hint_scheme = "String",
	-- hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
	hi_parameter='Search',
	handler_opts = {
		border = "rounded"   -- double, rounded, single, shadow, none
	},

	always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

	auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
	extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
	zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

	padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

	transparency = nil, -- disabled by default, allow floating win transparent value 1~100
	shadow_blend = 100, -- if you using shadow as border use this set the opacity
	shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
	timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
	toggle_key = '<C-e>', -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
	select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
	move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
}
require'lsp_signature'.setup(cfg) -- no need to specify bufnr if you don't use toggle_key

-----------------------------------------------------------------------------------
--neo-tree
require("neo-tree").setup({
    close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    sort_case_insensitive = false, -- used when sorting files and directories in the tree
    sort_function = nil , -- use a custom function for sorting files and directories in the tree 
    default_component_configs = {
		container = {
			enable_character_fade = true
		},
		indent = {
			indent_size = 2,
			padding = 1, -- extra padding on left hand side
			-- indent guides
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			highlight = "NeoTreeIndentMarker",
			-- expander config, needed for nesting files
			with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "ﰊ",
			-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
			-- then these will never be used.
			default = "*",
			highlight = "NeoTreeFileIcon"
		},
		modified = {
			symbol = "[+]",
			highlight = "NeoTreeModified",
		},
		name = {
			trailing_slash = false,
			use_git_status_colors = true,
			highlight = "NeoTreeFileName",
		},
		git_status = {
			symbols = {
				-- Change type
				added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted   = "✖",-- this can only be used in the git_status source
				renamed   = "",-- this can only be used in the git_status source
				-- Status type
				untracked = "",
				ignored   = "",
				unstaged  = "",
				staged    = "",
				conflict  = "",
			}
		},
    },
    window = {
		position = "left",
		width = 25,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
        mappings = {
            ["<space>"] = {
                "toggle_node",
                nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use 
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<esc>"] = "revert_preview",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["w"] = "open_with_window_picker",
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            ["a"] = { "add", config = { show_path = "none"} },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
        }
    },
    nesting_rules = {},
    filesystem = {
    filtered_items = {
		visible = false, -- when true, they will just be displayed differently than normal items
		hide_dotfiles = true,
		hide_gitignored = true,
		hide_hidden = true, -- only works on Windows for hidden files/directories
		hide_by_name = {
		--"node_modules"
		},
		hide_by_pattern = { -- uses glob style patterns
			--"*.meta",
			--"*/src/*/tsconfig.json",
		},
		always_show = { -- remains visible even if other settings would normally hide it
			--".gitignored",
		},
		never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
			--".DS_Store",
			--"thumbs.db"
		},
		never_show_by_pattern = { -- uses glob style patterns
			--".null-ls_*",
		},
    },
          follow_current_file = false, -- This will find and focus the file in the active buffer every
                                       -- time the current file is changed while the tree is open.
          group_empty_dirs = false, -- when true, empty folders will be grouped together
          hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                                                  -- in whatever position is specified in window.position
                                -- "open_current",  -- netrw disabled, opening a directory opens within the
                                                  -- window like netrw would, regardless of window.position
                                -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
          use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                                          -- instead of relying on nvim autocmd events.
          window = {
            mappings = {
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["H"] = "toggle_hidden",
              ["/"] = "fuzzy_finder",
              ["D"] = "fuzzy_finder_directory",
              ["f"] = "filter_on_submit",
              ["<c-x>"] = "clear_filter",
              ["[g"] = "prev_git_modified",
              ["]g"] = "next_git_modified",
            }
          }
        },
        buffers = {
          follow_current_file = true, -- This will find and focus the file in the active buffer every
          group_empty_dirs = true, -- when true, empty folders will be grouped together
          show_unloaded = true,
          window = {
            mappings = {
              ["bd"] = "buffer_delete",
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
            }
          },
        },
	git_status = {
        window = {
            position = "float",
            mappings = {
				["A"]  = "git_add_all",
				["gu"] = "git_unstage_file",
				["ga"] = "git_add_file",
				["gr"] = "git_revert_file",
				["gc"] = "git_commit",
				["gp"] = "git_push",
				["gg"] = "git_commit_and_push",
            }
        }
	}
})
vim.keymap.set('n', '<leader>e', ':Neotree toggle reveal<CR>',{})

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
--------------------------------------------------------------------------------
--function 函数列表
require("aerial").setup({
  backends = { "treesitter", "lsp", "markdown", "man" },

  layout = {
    max_width = { 30, 0.2 },
    width = nil,
    min_width = 10,

    win_opts = {},

    default_direction = "prefer_right",

    placement = "window",
  },

  attach_mode = "window",

  close_automatic_events = {},

  keymaps = {
    ["?"] = "actions.show_help",
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.jump",
    ["<2-LeftMouse>"] = "actions.jump",
    ["<C-v>"] = "actions.jump_vsplit",
    ["<C-s>"] = "actions.jump_split",
    ["p"] = "actions.scroll",
    ["<C-j>"] = "actions.down_and_scroll",
    ["<C-k>"] = "actions.up_and_scroll",
    ["{"] = "actions.prev",
    ["}"] = "actions.next",
    ["[["] = "actions.prev_up",
    ["]]"] = "actions.next_up",
    ["q"] = "actions.close",
    ["o"] = "actions.tree_toggle",
    ["za"] = "actions.tree_toggle",
    ["O"] = "actions.tree_toggle_recursive",
    ["zA"] = "actions.tree_toggle_recursive",
    ["l"] = "actions.tree_open",
    ["zo"] = "actions.tree_open",
    ["L"] = "actions.tree_open_recursive",
    ["zO"] = "actions.tree_open_recursive",
    ["h"] = "actions.tree_close",
    ["zc"] = "actions.tree_close",
    ["H"] = "actions.tree_close_recursive",
    ["zC"] = "actions.tree_close_recursive",
    ["zr"] = "actions.tree_increase_fold_level",
    ["zR"] = "actions.tree_open_all",
    ["zm"] = "actions.tree_decrease_fold_level",
    ["zM"] = "actions.tree_close_all",
    ["zx"] = "actions.tree_sync_folds",
    ["zX"] = "actions.tree_sync_folds",
  },

  lazy_load = true,

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

  manage_folds = false,

  link_folds_to_tree = false,

  link_tree_to_folds = true,

  nerd_font = "auto",

  open_automatic = false,

  post_jump_cmd = "normal! zz",

  close_on_select = false,

  update_events = "TextChanged,InsertLeave",

  show_guides = false,

  guides = {
    -- When the child item has a sibling below it
    mid_item = "├─",
    -- When the child item is the last in the list
    last_item = "└─",
    -- When there are nested child guides to the right
    nested_top = "│ ",
    -- Raw indentation
    whitespace = "  ",
  },

  -- Options for opening aerial in a floating win
  float = {
    -- Controls border appearance. Passed to nvim_open_win
    border = "rounded",

    relative = "cursor",

    max_height = 0.9,
    height = nil,
    min_height = { 8, 0.1 },
  },

  lsp = {
    -- Fetch document symbols when LSP diagnostics update.
    -- If false, will update on buffer changes.
    diagnostics_trigger_update = true,

    -- Set to false to not update the symbols when there are LSP errors
    update_when_errors = true,

    -- How long to wait (in ms) after a buffer change before updating
    -- Only used when diagnostics_trigger_update = false
    update_delay = 300,
  },

  treesitter = {
    -- How long to wait (in ms) after a buffer change before updating
    update_delay = 300,
  },

  markdown = {
    -- How long to wait (in ms) after a buffer change before updating
    update_delay = 300,
  },

  man = {
    -- How long to wait (in ms) after a buffer change before updating
    update_delay = 300,
  },
})
vim.keymap.set('n', '<leader>fo', '<cmd>AerialToggle!<CR>')

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
--tokeyonight
require("tokyonight").setup({
  style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  light_style = "day", -- The theme is used when the background is set to light
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  sidebars = { "qf", "help" },
  day_brightness = 0.3,
  hide_inactive_statusline = false,
  dim_inactive = false,
  lualine_bold = false,
})
vim.cmd[[ colorscheme tokyonight-moon ]]

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
--lastplace 上一次编辑的位置
require'nvim-lastplace'.setup {
	lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
	lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
	lastplace_open_folds = true
}
-------------------------------------------------------------------------------
--自定义快捷键
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
