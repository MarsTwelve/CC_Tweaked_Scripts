---@diagnostic disable: lowercase-global
--- Stubs for JetBrains Lua linting
redstone = {
    setOutput = function(side, on) end,
    getInput = function(side) return false end,
    setBundledOutput = function(side, mask) end,
    getBundledInput = function(side) return 0 end
}

peripheral = {
    wrap = function(side) return {} end,
    getType = function(side) return "" end,
    getNames = function() return {} end
}

rednet = {
    open = function(side) end,
    broadcast = function(message, protocol) end,
    receive = function(protocol, timeout) return 0, {}, "" end,
    isOpen = function(side) return true end
}

colors = {
    white = 1, orange = 2, magenta = 4, lightBlue = 8,
    yellow = 16, lime = 32, pink = 64, gray = 128,
    lightGray = 256, cyan = 512, purple = 1024, blue = 2048,
    brown = 4096, green = 8192, red = 16384, black = 32768,
    combine = function(...) return 0 end
}