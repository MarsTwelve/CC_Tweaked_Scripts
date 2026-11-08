-- ====================================================================
-- STATIONARY GANTRY MOTOR CONTROLLER
-- File: /scripts/gantry_controller.lua
-- ====================================================================

local CLUTCH_SIDE  = "right"
local TRIGGER_SIDE = "top"
local RUNTIME      = 13     -- 16m advance at 32 RPM
-- Safety initialization: Immediately hold clutch stopped
redstone.setOutput(CLUTCH_SIDE, true)

term.clear()
term.setCursorPos(1, 1)
print("[GANTRY CONTROLLER] Holding position. Waiting for rig signal...")

while true do
    os.pullEvent("redstone")

    if redstone.getInput(TRIGGER_SIDE) then
        print("[GANTRY CONTROLLER] Signal received! Advancing 16m...")

        -- Release clutch (engage shaft)
        redstone.setOutput(CLUTCH_SIDE, false)
        sleep(RUNTIME)

        -- Halt shaft
        redstone.setOutput(CLUTCH_SIDE, true)
        print("[GANTRY CONTROLLER] Step complete. Holding position.")

        -- Wait until transmitter completely depowers
        while redstone.getInput(TRIGGER_SIDE) do
            sleep(0.5)
        end

        -- Purge any stale redstone events queued while running
        while os.peekEvent and os.peekEvent("redstone") do
            os.pullEvent("redstone")
        end
    end
end