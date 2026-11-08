local CLUTCH = "back" -- Pulley Clutch (LOW = Stop, HIGH = Run)
local GEARSHIFT = "right" -- Pulley Gearshift (HIGH = Down, LOW = Up)
local CONTACT_PIN = "bottom"
local STEP_SIGNAL = "top"   -- Redstone Link Transmitter to stationary gantry controller

local DESCENT_TIME_SECONDS = 5

print("=== [RIG] STARTING CHUNK DRILL CYCLE ===")
print("[1/3] Lowering drills and hose to bedrock...")

redstone.setOutput(GEARSHIFT, true)
redstone.setOutput(CLUTCH, true)

sleep(DESCENT_TIME_SECONDS)

print("[2/3] Bedrock reached. Reversing rotation...")
redstone.setOutput(GEARSHIFT, false)

print("[2/3] Ascending. Waiting for top Redstone Contact...")
while not redstone.getInput(CONTACT_PIN) do
    sleep(0.5)
end


print("[2/3] Drill head seated securely!")
redstone.setOutput(CLUTCH, false)
sleep(1)

print("[3/3] Triggering stationary controller for 16m advance...")
redstone.setOutput(STEP_SIGNAL, true)
sleep(1)
redstone.setOutput(STEP_SIGNAL, false)
print("[3/3] Step dispatched. Going inert for transit.")

