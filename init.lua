-- xMonody-x huanbin_xiao@163.com
require('packer').startup({function(use)
	use 'wbthomason/packer.nvim' --补全
	use { "williamboman/mason.nvim" }

	use 'ray-x/lsp_signature.nvim'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/nvim-cmp'
	use 'onsails/lspkind.nvim'--图标
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'
	use 'rafamadriz/friendly-snippets'--片段
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-cmdline'

	use {
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		}
	}


	use 'numToStr/FTerm.nvim'--终端
	use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}}--模糊搜索
	use 'lewis6991/gitsigns.nvim'--git修改
	use 'tveskag/nvim-blame-line'--显示git修改


	use 'stevearc/aerial.nvim'--函数列表
	use 'nvim-treesitter/nvim-treesitter'--高亮
	use 'mjlbach/onedark.nvim'--主题
	use 'nvim-lualine/lualine.nvim'--状态栏
	use 'kdheepak/tabline.nvim'--缓冲区状态栏
	use 'lukas-reineke/indent-blankline.nvim'--对齐线

	use 'b3nj5m1n/kommentary'--注释
	use 'Pocco81/auto-save.nvim' --autosave 自动保存
	use 'windwp/nvim-autopairs'--括号补全
	use 'ethanholz/nvim-lastplace'--打开上一次位置

end,
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
vim.o.scrolloff=5
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
vim.o.swapfile=true
vim.o.breakindent = true
vim.opt.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 200
vim.wo.signcolumn = 'yes'
vim.o.termguicolors = true
vim.o.completeopt = 'menuone,noselect'
vim.cmd[[ colorscheme onedark]]
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

require'lspconfig'.rust_analyzer.setup({

	})

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
--sago
local cfg = {
	debug = false, -- set to true to enable debug logging
	-- log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
	verbose = false, -- show debug line number
	bind = true,
	doc_lines = 10,
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
	max_width = 200,
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
-----------------------------------------------------------------------------------
-- luasnip setup
local luasnip = require 'luasnip'
local lspkind = require('lspkind')
require("luasnip.loaders.from_vscode").lazy_load()
------------------------------------------------------------------------------------
-- nvim-cmp setup
local cmp = require('cmp')
cmp.setup{
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
		{ name = 'path'},
		{ name = 'buffer'},
	},
	view = {
		entries = {name = 'custom' }
	},
	formatting = {
		format = lspkind.cmp_format({
				mode = "symbol",
				menu = ({
						buffer = "[Buf]",
						nvim_lsp = "[Lsp]",
						luasnip = "[Snp]",
						nvim_lua = "[Lua]",
						latex_symbols = "[Lat]",
					})
			}),
	},
}

cmp.setup.filetype('gitcommit', {
		sources = cmp.config.sources({
				{ name = 'cmp_git' },
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

cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
				{ name = 'path' }
			}, {
				{ name = 'cmdline' }
			})
	})
-----------------------------------------------------------------------------------
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
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			highlight = "NeoTreeIndentMarker",
			with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "ﰊ",
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
				added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted   = "✗",-- this can only be used in the git_status source
				renamed   = "",-- this can only be used in the git_status source
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
		width = 27,
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
			-- ["S"] = "split_with_window_picker",
			-- ["s"] = "vsplit_with_window_picker",
			["t"] = "open_tabnew",
			-- ["<cr>"] = "open_drop",
			-- ["t"] = "open_tab_drop",
			["w"] = "open_with_window_picker",
			--["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
			["C"] = "close_node",
			["z"] = "close_all_nodes",
			--["Z"] = "expand_all_nodes",
			["a"] = {
				"add",
				config = {
					show_path = "none" -- "none", "relative", "absolute"
				}
			},
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
			},
			hide_by_pattern = { -- uses glob style patterns
			},
			always_show = { -- remains visible even if other settings would normally hide it
			},
			never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
			},
		},
		follow_current_file = false, -- This will find and focus the file in the active buffer every
		group_empty_dirs = false, -- when true, empty folders will be grouped together
		hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
		use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
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
vim.cmd([[ nnoremap <leader>e :NeoTreeFloat<cr> ]])

----------------------------------------------------------------------------------
--fterm 终端
require'FTerm'.setup({
		border = 'double',
		dimensions  = {
			height = 0.9,
			width = 0.8,
		},
	})

vim.keymap.set('n', '<leader>t', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<leader>d', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
----------------------------------------------------------------------------------
--telescope 模糊查
vim.api.nvim_set_keymap("n", "<leader>ff", [[<cmd>lua require('telescope.builtin').find_files()<cr>]],{})
vim.api.nvim_set_keymap("n", "<leader>fg", [[<cmd>lua require('telescope.builtin').live_grep()<cr>]],{})
vim.api.nvim_set_keymap("n", "<leader>fb", [[<cmd>lua require('telescope.builtin').buffers()<cr>]],{})
vim.api.nvim_set_keymap("n", "<leader>fm", [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]],{})
vim.api.nvim_set_keymap("n", "<leader>fs", [[<cmd>lua require('telescope.builtin').lsp_references()<cr>]],{})
vim.api.nvim_set_keymap("n", "<leader>fc", [[<cmd>lua require('telescope.builtin').treesitter()<cr>]],{})
vim.api.nvim_set_keymap("n", "<leader>fp", [[<cmd>lua require('telescope.builtin').grep_string()<cr>]],{})

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
		map('n', 'tn', function()
			if vim.wo.diff then return ']c' end
			vim.schedule(function() gs.next_hunk() end)
			return '<Ignore>'
		end, {expr=true})

	map('n', 'tp', function()
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
			vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>fo', '<cmd>AerialToggle!<CR>', {})
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
	ensure_installed = { "c", "cpp", "lua", "rust","go","cmake" },
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}
-------------------------------------------------------------------------------
--onedarkpro主题
--[[ require("onedarkpro").setup({
	dark_theme = "onedark_vivid",
	colors = {
		cursorline = "#303030",-- This is optional. The default cursorline color is based on the background
	},
	options = {
		cursorline = true,
		transparency = true,
	},
}) ]]
-----------------------------------------------------------------------------------
--statusline 状态栏
require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'palenight',
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
require'tabline'.setup {
	enable = true,
	options = {
		section_separators = {'', ''},
		component_separators = {'', ''},
		max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
		show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
		show_devicons = true, -- this shows devicons in buffer section
		show_bufnr = false, -- this appends [bufnr] to buffer section,
		show_filename_only = false, -- shows base filename only instead of relative path in filename
		modified_icon = "+", -- change the default modified icon
		modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
		show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
	}
}
-----------------------------------------------------------------------------------
--blankline 对齐线
require('indent_blankline').setup {
	char = '┆',
	show_trailing_blankline_indent = false,
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
vim.api.nvim_set_keymap("i", "<C-l>", "<Right>", {})
vim.api.nvim_set_keymap("n", "<C-h>", ":bp<CR>", {})
vim.api.nvim_set_keymap("n", "<C-l>", ":bn<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>d", ":bd<CR>", {})

vim.api.nvim_set_keymap("n", "<leader>a", ":%s/<C-r><C-w>//g<left><left>", {})

vim.api.nvim_set_keymap("n", "q", ":nohl<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>q", "<C-w>q", {})
vim.api.nvim_set_keymap("v", "q", "<Esc>", {})

vim.api.nvim_set_keymap("n", "<leader>yy", '"+yy', {})
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', {})
vim.api.nvim_set_keymap("n", "<leader>p", '"+p', {})

vim.api.nvim_set_keymap("n", "<C-w>u", "<C-w>t<C-w>K", {})
vim.api.nvim_set_keymap("n", "<C-w>i", "<C-w>t<C-w>H", {})
vim.api.nvim_set_keymap("n", "zl", "<C-w>3>", {})
vim.api.nvim_set_keymap("n", "zh", "<C-w>3<", {})
