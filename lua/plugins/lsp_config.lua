return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      { "williamboman/mason-lspconfig.nvim" },
      { "hrsh7th/cmp-nvim-lsp" }, -- 👈 required for nvim-cmp integration
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Setup for clangd
      lspconfig.clangd.setup({
        capabilities = capabilities,
        cmd = { "clangd" },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = require("lspconfig.util").root_pattern(
          "compile_commands.json",
          "compile_flags.txt",
          ".git"
        ),
      })

      -- Setup for lua_ls
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      -- Setup for pyright
      lspconfig.pyright.setup({
        capabilities = capabilities,
      })
    end,
  },
}

