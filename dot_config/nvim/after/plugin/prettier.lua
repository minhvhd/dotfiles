local status, null_ls = pcall(require, 'null-ls')
if (not status) then return end

local group = vim.api.nvim_create_augroup('lsp_format_on_save', { clear = false })
local event = 'BufWritePre'
local async = event == 'BufWritePost'

null_ls.setup({
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.keymap.set('n', '<leader>f', function()
                vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = '[lsp] format' })

            -- format on save
            -- vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
            -- vim.api.nvim_create_autocmd(event, {
                -- buffer = bufnr,
                -- group = group,
                -- callback = function()
                    -- -- call custom fn
                    -- vim.lsp.buf.format({ bufnr = bufnr, async = async })
                -- end,
                -- desc = '[lsp] format on save'
            -- })
        end

        if client.supports_method('textDocument/rangeFormatting') then
            vim.keymap.set('x', '<leader>f', function()
                vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = '[lsp] format' })
        end
    end
})

local prettier_status, prettier = pcall(require, 'prettier')
if (not prettier_status) then return end

prettier.setup({
    bin = 'prettierd',
    filetypes = {
        "css",
        "html",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "markdown",
        "scss",
        "yaml",
        "lua"
    }
})
