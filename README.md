A modified version of the [Binder library](https://quenty.github.io/NevermoreEngine/api/Binder/) from [Quenty's Nevermore engine](https://github.com/Quenty/NevermoreEngine).

A key feature of this version of Binder is *ancestry filtering*. ROBLOX instances binded under a `Binder` are observed within a specific ancestor(s). Take a look at the following code:
```lua
local binderConfig = {
     TagName = "KillBrick",
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

         if not humanoid then
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
```
*(This `KillBrick` binder only observes its instances as long as they're in `game.Workspace`)*
