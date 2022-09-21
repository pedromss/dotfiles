local M = {}

function M.setup(configs)
	-- TODO, attempting this cmd yields a "no backend found" error
	-- I suspect this gets triggered in the Neo-tree buffer rather
	-- than the markdown buffer
	--
	-- local name = "aerial"
	-- augroup(name, { clear = true })
	-- for _, c in ipairs(configs.aerial) do
	-- 	cmd("BufNew", {
	-- 		desc = "Toggle Aerial on open",
	-- 		group = name,
	-- 		pattern = c.pattern,
	-- 		callback = function(x)
	-- 			print("Hi aerial")
	-- 			print(vim.inspect(x))
	-- 			vim.cmd(":AerialOpen")
	-- 		end,
	-- 	})
	-- end
end

return M
