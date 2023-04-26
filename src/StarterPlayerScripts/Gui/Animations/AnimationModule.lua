local Animation = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)

function Animation.playAnimation(player, character, animID)

    local animation = Instance.new("Animation")
	animation.AnimationId = animID

	local humanoid = character:WaitForChild("Humanoid")
	local animator = humanoid:WaitForChild("Animator")
	local animTrack = animator:LoadAnimation(animation)
	
	animTrack:Play()
	animTrack.Ended:Connect(function()
		print("Animation Ended")
		PlayerMovement:Movement(player, true)
		animTrack:Destroy()
	end)
end

return Animation