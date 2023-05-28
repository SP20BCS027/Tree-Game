local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local Beams = character:WaitForChild("OwnerBeams")

local function UnAssignBeams()
    for _, beam in pairs(Beams:GetChildren()) do 
        beam.Attachment0 = nil
        beam.Attachment1 = nil
    end
end

task.spawn(function()
    local ClaimParts = Remotes.GetNoOwnerHouses:InvokeServer()
    while task.wait(1) do 
        ClaimParts = Remotes.GetNoOwnerHouses:InvokeServer()

        if Remotes.IsPlayerOwner:InvokeServer() then 
            UnAssignBeams()
            return
        end

        for house, part in pairs(ClaimParts) do
                Beams[house].Attachment0 = character.HumanoidRootPart.RootAttachment
                Beams[house].Attachment1 = part.BeamAttachment
        end
    end
end)