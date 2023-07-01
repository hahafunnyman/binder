local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Binder = require(ReplicatedStorage.Packages.Binder)

local binderConfig = {
	TagName = "Lava",
	Ancestors = { workspace },
}

local function constructor(instance: BasePart)
	local touchedConnection: RBXScriptConnection

	touchedConnection = instance.Touched:Connect(function(hit: BasePart)
		local character = hit:FindFirstAncestorOfClass("Model")

		if not character then
			return
		end

		local humanoid = character:FindFirstChildOfClass("Humanoid")

		if not humanoid or humanoid.Health <= 0 then
			return
		end

		humanoid:TakeDamage(100)
	end)

	return function()
		if touchedConnection.Connected then
			touchedConnection:Disconnect()
		end

		instance:Destroy()
	end
end

local binder = Binder.new(binderConfig, constructor)
binder:Start()
