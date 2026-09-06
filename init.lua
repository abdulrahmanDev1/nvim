-- Neovim 0.12's built-in documentColor handler can crash on malformed
-- colors returned by some LSP servers. This config already uses
-- nvim-highlight-colors for previews, so disable the native handler globally.
vim.lsp.document_color.enable(false)

require("config.lazy")
-- config.keymaps is loaded by LazyVim on the VeryLazy event (after its own
-- default keymaps), so requiring it here would apply our maps too early and
-- let LazyVim's defaults (e.g. <C-/> terminal) clobber our overrides.
require("custom.hl").setup_highlights()
