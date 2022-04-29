--[[
	This file is part of CANimator.

    CANimator is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    CANimator is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with CANimator.  If not, see <https://www.gnu.org/licenses/>.
]]

local config = {}

config.player = game.Players.LocalPlayer
config.camera = game.Workspace.CurrentCamera
config.character = config.player.Character or config.player.CharacterAdded:Wait()
config.humanoid = config.character:WaitForChild("Humanoid")

config.maxWalkspeed = game.StarterPlayer.CharacterWalkSpeed

config.DoFOVAdjustment = true
config.fovValue = workspace.CurrentCamera.FieldOfView
config.fovAdjustmentPath = workspace.CurrentCamera
config.FOVMult = 1.2 --By how much should the fov be multiplied by. The equation is FOV + (current walkspeed / max walkspeed) * FOVMult. For instance, 90 + (8/16) * 1.2 = 90.6

--Animations
config.idle = {
	["id"] = "rbxassetid://5886873421";
	["priority"] = Enum.AnimationPriority.Core;
}
config.idleFidget = {
	["id"] = "rbxassetid://7518462905";
	["priority"] = Enum.AnimationPriority.Core;
}
config.walk = {
	["id"] = "rbxassetid://7545464904";
	["priority"] = Enum.AnimationPriority.Core;
}
config.walkLeft = {
	["id"] = "rbxassetid://7545464904";
	["priority"] = Enum.AnimationPriority.Core;
}
config.walkRight = {
	["id"] = "rbxassetid://7545464904";
	["priority"] = Enum.AnimationPriority.Core;
}
config.walkBack = {
	["id"] = "rbxassetid://7545464904";
	["priority"] = Enum.AnimationPriority.Core;
}
config.run = {
	["id"] = "rbxassetid://7545464904";
	["priority"] = Enum.AnimationPriority.Core;
}

config.jump = {
	["id"] = "rbxassetid://5630206596";
	["priority"] = Enum.AnimationPriority.Core;
}
config.fall = {
	["id"] = "rbxassetid://5630198981";
	["priority"] = Enum.AnimationPriority.Core;
}
config.land = {
	["id"] = "rbxassetid://6769696062";
	["priority"] = Enum.AnimationPriority.Core;
}
config.climb = {
	["id"] = "rbxassetid://5630196519";
	["priority"] = Enum.AnimationPriority.Core;
}
config.sit = {
	["id"] = "rbxassetid://7702856232";
	["priority"] = Enum.AnimationPriority.Core;
}

--Leaning
config.DoLeaning = true
config.leanAmount = 5 --More is more
config.leanEasing = .08 --Lower is longer , multiply by 60/framerate
config.jumpLeanAmount = -9 --Negative is tilting back, so lower is more
config.MagnitudeCutoff = 1.59 --THIS IS CUSTOM AND NEEDS MANUAL TUNING. To figure out what you should set it, uncomment the line print(magnitude) and pay attention to values in output. Idk I'll fix this later
config.fallLeanAmount = 5 --Positive is tilting forward, so higher is more.
config.climbUpLeanAmount = 10 --Higher is more
config.climbDownLeanAmount = 10 -- Higher is more

return config
