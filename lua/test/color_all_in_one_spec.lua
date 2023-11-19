local cwd = vim.fn.getcwd()

describe("color-all-in-one", function()
  local assert_eq = assert.is_equal
  local assert_true = assert.is_true
  local assert_false = assert.is_false

  before_each(function()
    vim.api.nvim_command("cd " .. cwd)
  end)

    local caio = require('color-all-in-one')
  describe("[setup]", function()
    it("setup", function()
      caio.setup()
    end)
  end)
end)