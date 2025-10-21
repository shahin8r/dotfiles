local dap = require('dap')
local dapui = require('dapui')
local virtualtext = require('nvim-dap-virtual-text')
local mason_dap = require('mason-nvim-dap')

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/home/shahin/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js' },
}

dap.configurations.php = {
  {
    name = 'Listen for Xdebug',
    type = 'php',
    request = 'launch',
    port = 9000,
    pathMappings = { ['/var/www/html'] = "${workspaceFolder}" }
  },
  {
    name = 'Launch currently open script',
    type = 'php',
    request = 'launch',
    program = '${file}',
    cwd = '${fileDirname}',
    port = 0,
    runtimeArgs = { '-dxdebug.start_with_request=yes' },
    env = {
      XDEBUG_MODE = "debug, develop",
      XDEBUG_CONFIG = "client_port=${port}"
    }
  },
  {
    name = 'Listen for PHPUnit Xdebug',
    type = 'php',
    request = 'launch',
    port = 9001,
    pathMappings = { ['/var/www/html'] = "${workspaceFolder}" },
    log = 'true'
  }
}

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

virtualtext.setup()
dapui.setup()
mason_dap.setup({
  ensure_installed = { 'php' }
})
