return {
  {
    "williamboman/mason.nvim",
    priority = 1000, -- Make sure this loads before mason-lspconfig
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",
          "lua_ls", -- use lua_ls instead of "lua-language-server"
	  "pyright",
        },
        automatic_installation = true,
      })
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "clangd",
          "lua-language-server",
          "prettier",
        },
        auto_update = true,
        run_on_start = true,
      })
    end,
  },
}

