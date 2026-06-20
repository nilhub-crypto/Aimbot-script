-- Aimbot Module
local Aimbot = {
    Name = "Aimbot",
    Category = "Combat",
    Tooltip = "Automatically aims at enemies",
    Enabled = false,
    Connections = {}
}

function Aimbot:Start()
    print("🎯 Aimbot started!")
    local connection = game:GetService("RunService").Heartbeat:Connect(function()
        if self.Enabled then
            -- Your aimbot logic here
        end
    end)
    table.insert(self.Connections, connection)
end

function Aimbot:Stop()
    for _, conn in ipairs(self.Connections) do
        conn:Disconnect()
    end
    self.Connections = {}
    print("🎯 Aimbot stopped!")
end

return Aimbot
