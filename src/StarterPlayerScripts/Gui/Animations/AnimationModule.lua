local Animation = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerCharacterMovement = require(ReplicatedStorage.Libs.PlayerCharacterMovement)

function Animation.PlayAnimation(player: Player, character: Model, animID: string)

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