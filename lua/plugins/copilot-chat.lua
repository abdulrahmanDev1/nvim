return {
  "CopilotC-Nvim/CopilotChat.nvim",
  enabled = false,
  cmd = "CopilotChat",
  keys = {
    { "<leader>a", "", desc = "+ai" },
    {
      "<leader>aa",
      function()
        return require("CopilotChat").toggle()
      end,
      desc = "Toggle (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>ax",
      function()
        return require("CopilotChat").reset()
      end,
      desc = "Clear (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>aq",
      function()
        local input = vim.fn.input("Quick Chat: ")
        if input ~= "" then
          require("CopilotChat").setup({
            auto_insert_mode = true,
            show_help = false,
            auto_follow_cursor = true,
            show_folds = false,
            question_header = "  D7OM ",
            answer_header = "  Copilot ",
            window = {
              layout = "float",
              width = 0.4,
              height = 0.7,
              border = "rounded",
            },
          })
          require("CopilotChat").ask(input)
        end
      end,
      desc = "Quick Chat (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>ac",
      ":CopilotChatCommit<cr>",
      desc = "Commit (CopilotChat)",
      mode = { "n", "v" },
    },
  },
  config = function()
    require("CopilotChat.integrations.cmp").setup()
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "copilot-chat",
      callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
      end,
    })

    require("CopilotChat").setup({
      model = "gpt-4",
      auto_insert_mode = true,
      show_help = true,
      auto_follow_cursor = true,
      show_folds = false,
      question_header = "  D7OM ",
      answer_header = "  Copilot ",
      window = {
        -- layout = "float",
        width = 0.4,
        height = 0.7,
        border = "rounded",
      },
      mappings = {
        close = {
          normal = "q",
          insert = "C-q",
        },
      },
      selection = function(source)
        local select = require("CopilotChat.select")
        return select.visual(source) or select.buffer(source)
      end,
    })
  end,
}
