local Animation = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerCharacterMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)

-- Play an animation on the specified character's humanoid using the given animation ID.
function Animation.PlayAnimation(player: Player, character: Model, animID: string)
    -- Create a new animation instance and set its ID.
    local animation = Instance.new("Animation")
    animation.AnimationId = animID

    local humanoid = character:WaitForChild("Humanoid")
    local animator = humanoid:WaitForChild("Animator")

    local animTrack = animator:LoadAnimation(animation)

    animTrack:Play()

    animTrack.Ended:Connect(function()
        print("Animation Ended")
        PlayerCharacterMovement:Movement(player, true)
        animTrack:Destroy()
    end)
end


return Animation