-- ====================================================================
-- UNIVERSAL MULTI-MACHINE DISPATCHER
-- File: /startup.lua
-- ====================================================================

term.clear()
term.setCursorPos(1, 1)

local ROLE_FILE = "/role.txt"

-- If no role is configured, prompt the user to pick one
if not fs.exists(ROLE_FILE) then
    print("=== UNASSIGNED AUTOMATION COMPUTER ===")
    print("Available scripts in /scripts:")

    local files = fs.list("/scripts")
    for _, f in ipairs(files) do
        print(" - " .. f)
    end

    write("\nEnter script filename (e.g., mining_rig.lua): ")
    local chosen = read()

    local f = fs.open(ROLE_FILE, "w")
    f.write(chosen)
    f.close()
    print("Role saved to " .. ROLE_FILE)
end

-- Read role
local rf = fs.open(ROLE_FILE, "r")
local roleScript = rf.readLine()
rf.close()

-- Abort window
print(string.format("[INFO] Role: %s (Press any key in 3s to abort)...", roleScript))
local abortTimer = os.startTimer(3)
local event, p1
local aborted = false

repeat
    event, p1 = os.pullEvent()
    aborted = (event == "key" or event == "char")
until aborted or (event == "timer" and p1 == abortTimer)

if aborted then
    print("\nManual override triggered. Dropped to terminal.")
    print("Type 'rm role.txt' to reassign this machine's purpose.")
    return
end

-- Execute the designated application
local targetPath = fs.combine("/scripts", roleScript)
if fs.exists(targetPath) then
    print("[INFO] Starting " .. targetPath .. "...\n")
    shell.run(targetPath)
else
    print("[ERROR] Script not found: " .. targetPath)
end