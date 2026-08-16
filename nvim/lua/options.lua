vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.updatetime = 250
vim.opt.signcolumn = 'auto:2'
vim.opt.wrap = false
vim.opt.wildignore = vim.opt.wildignore + { '.git', '*/node_modules/*', '*/dist*' }
vim.o.winborder = 'rounded'
vim.g.neoformat_try_node_exe = 1

local prettier_filetypes = {
  astro = true,
  css = true,
  graphql = true,
  html = true,
  javascript = true,
  javascriptreact = true,
  json = true,
  jsonc = true,
  less = true,
  markdown = true,
  scss = true,
  svelte = true,
  typescript = true,
  typescriptreact = true,
  vue = true,
  yaml = true,
}

-- Tell Neoformat to use Prettier for the filetypes listed above.
for ft in pairs(prettier_filetypes) do
  vim.g['neoformat_enabled_' .. ft] = { 'prettier' }
end

local function has_local_prettier(bufnr)
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  if bufname == '' then
    return false
  end

  local dir = vim.fn.fnamemodify(bufname, ':p:h')
  return vim.fn.findfile('node_modules/.bin/prettier', dir .. ';') ~= ''
end

local format_group = vim.api.nvim_create_augroup('ShahinAutoFormat', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
  group = format_group,
  pattern = '*.tf',
  callback = function()
    vim.cmd("silent! execute '!terraform fmt -write=true %'")
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = format_group,
  pattern = '*.prisma',
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
  group = format_group,
  pattern = '*.php',
  callback = function()
    vim.cmd("silent! execute '!docker compose exec webserver vendor/bin/php-cs-fixer fix %'")
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = format_group,
  pattern = '*',
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if prettier_filetypes[ft] and has_local_prettier(args.buf) then
      vim.cmd('silent! Neoformat')
    end
  end,
})
