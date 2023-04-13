-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- for easily changing a line to comment
    use "preservim/nerdcommenter"

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use { "ellisonleao/gruvbox.nvim" }
    use('Mofiqul/vscode.nvim')
    use "rebelot/kanagawa.nvim"
    use({ 'projekt0n/github-nvim-theme', tag = 'v0.0.7' })
    use 'sainnhe/gruvbox-material'
    use { "catppuccin/nvim", as = "catppuccin" }

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')

    -- a fork of nvim-treesitter that fixes inline html
    use({ "elgiano/nvim-treesitter-angular", branch = "topic/jsx-fix" })

    use('ThePrimeagen/harpoon')
    use('mbbill/undotree')
    use('kdheepak/lazygit.nvim')
    -- lsp stuffs
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }
    use('onsails/lspkind.nvim')
    use('jose-elias-alvarez/null-ls.nvim')
    use('MunifTanjim/prettier.nvim')
    use {
        'nvim-tree/nvim-tree.lua',
        -- latest has a bug with FindFileToggle. Use this until that resolves
        commit = '16f2806d5968157fd6f76542c9ac358c684a3a03',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
    }
    use('windwp/nvim-autopairs')
    use('windwp/nvim-ts-autotag')
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
    }
    use('norcalli/nvim-colorizer.lua')
    use {
        'zbirenbaum/copilot.lua',
        event = { 'VimEnter' },
        config = function()
            vim.defer_fn(function()
                require('copilot').setup {
                    filetypes = {
                        javascript = true,
                        typescript = true,
                        lua = true,
                        markdown = true,
                        html = true,
                        css = true,
                        ["*"] = false
                    },
                    suggestion = { enabled = false },
                    panel = { enabled = false }
                }
            end, 100)
        end,
    }

    use {
        'zbirenbaum/copilot-cmp',
        after = { 'copilot.lua' },
        config = function()
            require('copilot_cmp').setup()
        end
    }

    -- install without yarn or npm
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    use { 'windwp/windline.nvim' }
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
end)
