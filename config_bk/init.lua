require("base")
require("maps")
require("highlights")
require("plugins")
print("init")

local has = function(x)
  return vim.fn.has(x) == 1
end

-- local is_mac = has "macuix"
-- local is_win = has "win32"
-- 
-- if is_mac then
--   require('macos')
-- elseif is_win then
--   require('windows')
-- else
--   vim.opt.clipboard:append{"unnamedplus"}
-- end

vim.opt.clipboard:append{"unnamedplus"}

