
--
-- config variables
--

lsp_servers = {
    'bashls',
    --'clandg',
    'cssls',
    'hls',
    'html',
    'jedi_language_server',
    'jsonls',
    'rust_analyzer',
    'sumneko_lua',
    --'svls',
    --'texlab',
    'vimls',
    'yamlls',
}


--
-- general option
--

-- commands
vim.cmd([[
command W w
command Q q
]])

-- mappings
vim.g.mapleader = " "

local map = vim.api.nvim_set_keymap
map ('', '//', ':nohlsearch<CR>', {silent = true})
map ('n', ';', ':', {noremap = true})
map ('n', '<leader>b', ':bnext<CR>', {silent = false, noremap = true})
map ('n', '<leader>B', ':bprev<CR>', {silent = false, noremap = true})

-- buffers
vim.opt.undofile = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.hidden = true
vim.opt.clipboard = 'unnamedplus'
-- ui
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.textwidth = 79
vim.opt.colorcolumn = '+1'
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8
vim.opt.number = true
vim.opt.signcolumn = 'yes'
vim.opt.wrap = false
-- formatting
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1


--
-- plugins
--

-- install packer if it isn't present
local packer_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
    vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_path})
    vim.cmd 'packadd packer.nvim'
end

local packer = require('packer')

-- packer initalization
packer.init {
    display = {
        open_fn = function ()
            return require('packer.util').float { border = 'single' }
        end,
        prompt_border = 'single',
    },
    auto_clean = true,
    compile_on_sync = true,
}

-- packer auto update
--vim.cmd([[
--    augroup packer_user_config
--        autocmd!
--        autocmd BufWritePost init.lua source <afile> | PackerSync
--    augroup end
--]])


-- packer startup and module load
packer.startup(function(use)

    --
    -- package manager
    --

    -- https://github.com/wbthomason/packer.nvim
    use {
        'wbthomason/packer.nvim',
    }

    --
    -- ui
    --

    -- https://github.com/RRethy/nvim-base16
    use {
        'RRethy/nvim-base16',
        config = function ()
            vim.cmd('colorscheme base16-onedark')
        end
    }
    -- https://github.com/kyazdani42/nvim-web-devicons
    use {
        'kyazdani42/nvim-web-devicons',
        after = 'nvim-base16',
        config = function ()
            local web_devicons = require('nvim-web-devicons')
            web_devicons.setup { default = true, }
        end
    }
    -- https://github.com/Famiu/feline.nvim
    use {
        'Famiu/feline.nvim',
        after = 'nvim-web-devicons',
        config = function ()
            local feline = require('feline')
            feline.setup { preset = 'slant' }
        end
    }
    -- https://github.com/akinsho/bufferline.nvim
    use {
        'akinsho/bufferline.nvim',
        after = 'nvim-web-devicons',
        config = function ()
            local bufferline = require('bufferline')
            bufferline.setup {
                options = {
                    show_close_icon = false,
                    show_buffer_close_icons = false,
                    numbers = function (opts)
                        return opts.raise(opts.id)
                    end
                }
            }
        end
    }
    -- https://github.com/lukas-reineke/indent-blankline.nvim
    use {
        'lukas-reineke/indent-blankline.nvim',
        event = 'VimEnter',
        config = function ()
            local blankline = require('indent_blankline')
            blankline.setup { char = '▏', }
        end
    }
    -- https://github.com/onsails/lspkind-nvim
    use {
        'onsails/lspkind-nvim',
        event = 'VimEnter',
        config = function()
            require('lspkind').init({
                with_text = false,
            })
        end
    }

    --
    -- formatting
    --

    -- https://github.com/windwp/nvim-autopairs
    use {
        'windwp/nvim-autopairs',
        after = 'nvim-cmp',
        config = function ()
            local nvim_autopairs = require('nvim-autopairs')
            local nvim_autopairs_cmp = require('nvim-autopairs.completion.cmp')
            nvim_autopairs.setup  {}
            nvim_autopairs_cmp.setup {
                map_cr = true,
                map_complete = true,
                auto_select = true,
                insert = false,
                map_char = { all = '(', tex = '{' }
            }
        end
    }

    --
    -- lsp
    --

    -- https://github.com/williamboman/nvim-lsp-installer
    use {
        'williamboman/nvim-lsp-installer',
        event = 'VimEnter',
        config = function ()
            local lsp_installer = require('nvim-lsp-installer')
            local lsp_installer_servers = require('nvim-lsp-installer.servers')
            lsp_installer.on_server_ready(function(server)
                local opts = {}
                server:setup(opts)
                vim.cmd [[ do User LspAttachBuffers ]]
            end)
            for _, lsp_name in ipairs(lsp_servers) do
                local ok, lsp = lsp_installer_servers.get_server(lsp_name)
                if ok then
                    --print(lsp_name .. ' ok')
                    if not lsp:is_installed() then
                        lsp:install()
                    end
                end
            end
        end
    }
    -- https://github.com/neovim/nvim-lspconfig
    use {
        'neovim/nvim-lspconfig',
        after = { 'nvim-lsp-installer', 'cmp-nvim-lsp' },
        config = function ()
            local lspconfig = require('lspconfig')
            local cmp_nvim_lsp = require('cmp_nvim_lsp')

            local signs = { Error = '', Warning = '', Hint = '', Information = '' }
            for type, icon in pairs(signs) do
                local hl = 'LspDiagnosticsSign' .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
            end
            vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                virtual_text = false,
                signs = true,
                underline = true,
                update_in_insert = true,
            })
            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = 'single',
            })
            vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                border = 'single',
            })
            vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]

            local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
            for _, lsp_name in ipairs(lsp_servers) do
                lspconfig[lsp_name].setup {
                    capabilities = capabilities,
                }
            end
        end
    }
    -- https://github.com/hrsh7th/nvim-cmp
    use {
        'hrsh7th/nvim-cmp',
        after =  { 'lspkind-nvim', 'LuaSnip' },
        config = function ()
            local cmp = require('cmp')
            local lspkind = require('lspkind')
            local luasnip = require('luasnip')
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                formatting = {
                    format = function(entry, vim_item)
                        vim_item.kind = lspkind.presets.default[vim_item.kind]
                        vim_item.menu = ({
                            nvim_lsp = '[LSP]',
                            nvim_lua = '[Lua]',
                            path = '[PATH]',
                            buffer = '[BUF]',
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                mapping = {
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                    ['<Tab>'] = function(fallback)
                        if vim.fn.pumvisible() == 1 then
                            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
                        elseif luasnip.expand_or_jumpable() then
                            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
                        else
                            fallback()
                        end
                    end,
                    ['<S-Tab>'] = function(fallback)
                        if vim.fn.pumvisible() == 1 then
                            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
                        elseif luasnip.jumpable(-1) then
                            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
                        else
                            fallback()
                        end
                    end,
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'nvim_lua' },
                    { name = 'path' },
                    { name = 'buffer' },
                }
            })
        end
    }
    -- https://github.com/hrsh7th/cmp-nvim-lsp
    use {
        'hrsh7th/cmp-nvim-lsp',
        after = 'nvim-cmp',
    }
    -- https://github.com/hrsh7th/cmp-nvim-lua
    use {
        'hrsh7th/cmp-nvim-lua',
        after = 'nvim-cmp',
    }
    -- https://github.com/saadparwaiz1/cmp_luasnip
    use {
        'saadparwaiz1/cmp_luasnip',
        after =  { 'nvim-cmp', 'LuaSnip' },
    }
    -- https://github.com/hrsh7th/cmp-path
    use {
        'hrsh7th/cmp-path',
        after = 'nvim-cmp',
    }
    -- https://github.com/hrsh7th/cmp-buffer
    use {
        'hrsh7th/cmp-buffer',
        after = 'nvim-cmp',
    }
    -- https://github.com/L3MON4D3/LuaSnip
    use {
        'L3MON4D3/LuaSnip',
        event = 'VimEnter',
    }
    -- https://github.com/ray-x/lsp_signature.nvim
    use {
        'ray-x/lsp_signature.nvim',
        event = 'VimEnter',
        config = function ()
            local lsp_signature = require('lsp_signature')
            lsp_signature.setup {
                bind = true,
                doc_lines = 2,
                floating_window = true,
                fix_pos = true,
                hint_enable = true,
                hint_prefix = ' ',
                hint_scheme = 'String',
                hi_parameter = 'Search',
                max_height = 22,
                max_width = 60,
                handler_opts = {
                    border = 'single',
                },
                zindex = 200,
                padding = '',
            }
        end
    }
    -- https://github.com/nvim-treesitter/nvim-treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        --event = 'BufRead'
        config = function ()
            local treesitter_config = require('nvim-treesitter.configs')
            treesitter_config.setup {
                ensure_installed = 'maintained',
                highlight = {
                    enable = true,
                    disable = {},
                    use_languagetree = true
                },
            }
        end
    }

    --
    -- vcs
    --

    -- https://github.com/lewis6991/gitsigns.nvim
    use {
        'lewis6991/gitsigns.nvim',
        requires = 'https://github.com/nvim-lua/plenary.nvim',
        config = function ()
            require('gitsigns').setup {
            }
        end
    }

end)

