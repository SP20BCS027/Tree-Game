local ScalingUI = {}

function ScalingUI.IncreaseBy2Point5Percent(currentScale)
	local newScale = UDim2.new(currentScale.X.Scale * 1.025, currentScale.X.Offset, currentScale.Y.Scale * 1.025, currentScale.Y.Offset)
	return newScale
end

function ScalingUI.IncreaseBy5Percent(currentScale)
	local newScale = UDim2.new(currentScale.X.Scale * 1.05, currentScale.X.Offset, currentScale.Y.Scale * 1.05, currentScale.Y.Offset)
	return newScale
end 

function ScalingUI.IncreaseBy10Percent(currentScale)
	local newScale = UDim2.new(currentScale.X.Scale * 1.1, currentScale.X.Offset, currentScale.Y.Scale * 1.1, currentScale.Y.Offset)
	return newScale
end 

function ScalingUI.IncreaseBy50Percent(currentScale)
	local newScale = UDim2.new(currentScale.X.Scale * 1.5, currentScale.X.Offset, currentScale.Y.Scale * 1.5, currentScale.Y.Offset)
	return newScale
end 

return ScalingUI