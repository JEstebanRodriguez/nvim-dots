local dap = require("dap")

dap.adapters.coreclr = {
  type = "executable",
  command = "/home/juan/netcoredbg/netcoredbg",
  args = { "--interpreter=vscode" },
  env = { ASPNETCORE_ENVIRONMENT = "Development", DOTNET_ENVIRONMENT = "Development" },
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
    end,
    env = {
      ASPNETCORE_ENVIRONMENT = "Development",
      DOTNET_ENVIRONMENT = "Development",
    },
  },
}
