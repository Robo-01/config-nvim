
-- List of servers to ignore during install
-- local ignore_install = {}
--
-- -- Helper function to find if value is in table.
-- local function table_contains(table, value)
--     for _, v in ipairs(table) do
--         if v == value then
--             return true
--         end
--     end
--     return false
-- end

-- Build a list of lsp servers to install minus the ignored list.
local servers = {
    "jdtls",
    "pyright",
    "clangd",
    "cssls",
    "jsonls",
    "html",
    "jsonls",
    "gradle_ls",
    "groovyls",
}

-- for _, s in ipairs(servers) do
--     if not table_contains(ignore_install, s) then
--         table.insert(servers, s)
--     end
-- end

require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = false,
})
