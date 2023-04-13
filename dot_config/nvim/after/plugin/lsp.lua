local lsp_status, lsp = pcall(require, "lsp-zero")
if (not lsp_status) then return end

local cmp_action = lsp.cmp_action()

local lsp_util_status, lsp_util = pcall(require, "lspconfig.util")
if (not lsp_util_status) then return end

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'angularls',
    'html',
    'cssls',
    'jsonls',
    'denols'
})

-- fix undefined global 'vim'
lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

lsp.configure('denols', {
    root_dir = lsp_util.root_pattern('deno.json', 'deno.jsonc', 'import_map.json')
})

lsp.configure('tsserver', {
    root_dir = lsp_util.root_pattern('package.json')
})

lsp.configure('nxls', {
    force_setup = true
})

local cmp_status, cmp = pcall(require, 'cmp')
if (not cmp_status) then return end

local lspkind_status, lspkind = pcall(require, 'lspkind')
if (not lspkind_status) then return end

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    sources = {
        { name = 'copilot' },

        --- These are the default sources for lsp-zero
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'path' },
        { name = 'buffer',   keyword_length = 3 },
        { name = 'luasnip',  keyword_length = 2 },
    },
    mapping = cmp_mappings,
    preselect = cmp.PreselectMode.Item,
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        format = lspkind.cmp_format({
            mode = 'symbol_text',  -- show only symbol annotations
            maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(_, vim_item)
                return vim_item
            end
        })
    }
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.dianostics.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.dianostics.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.dianostics.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
