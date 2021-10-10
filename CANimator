--[[
	Written/updated: 10/10/21
	At the moment, Roblox doesn't replicate priorities. This is written in anticipation of them replicating priorities "soon," but for now you'll have to
	make do with uploading/reuploading animations you want to use with the correct priority in order to change it.

	Also made by Res lol
]]

--[[
	This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
]]

local animator = {}
local RunS = game:GetService("RunService")
local InputS = game:GetService("UserInputService")

local state --Ignore this its for stuff :)
local pastState --Ignore this too

local function animTrackFromID(id, priorityOptional) --Function that returns a useable animation track. Cuts down on clutter.
	local animInstance = Instance.new("Animation")
	animInstance.AnimationId = id
	local animationTrack = humanoid:LoadAnimation(animInstance)
	if priorityOptional ~= nil then --ATM (7/27/21) Roblox does not replicate priorities. Apparently they will "soon."
		animationTrack.Priority = priorityOptional
	end
	return animationTrack
end

--Importing config file
script:WaitForChild("Config")
local config = require(script.Config)

local player = config.player
local character = config.character
      humanoid = config.humanoid

local idle = animTrackFromID(config.idle.id, config.idle.priority)
local walk = animTrackFromID(config.walk.id, config.walk.priority)
local run = animTrackFromID(config.run.id, config.run.priority)
local jump = animTrackFromID(config.jump.id, config.jump.priority)
local fall = animTrackFromID(config.fall.id, config.fall.priority)
local climb = animTrackFromID(config.climb.id, config.climb.priority)
local sit = animTrackFromID(config.sit.id, config.sit.priority)

local maxWalkspeed = config.maxWalkspeed

local fovAdjustmentPath = config.fovAdjustmentPath
local fov = config.fovValue
local FOVMult = config.FOVMult

local doLeaning = config.DoLeaning
local leanAmount = config.leanAmount
local leanEasing = config.leanEasing
local jumpLeanAmount = config.jumpLeanAmount
local magnitudeCutoff = config.MagnitudeCutoff
local fallLeanAmount = config.fallLeanAmount
local climbUpLeanAmount = config.climbUpLeanAmount
local climbDownLeanAmount = config.climbDownLeanAmount


local function zeroAllBaseAnimations() --Function that effectively stops all animations. Dont set weight to 0 or else Roblox cries
	idle:AdjustWeight(.001, 0)
	walk:AdjustWeight(.001, 0)
	run:AdjustWeight(.001, 0)
	jump:AdjustWeight(.001, 0)
	fall:AdjustWeight(.001, 0)
	climb:AdjustWeight(.001, 0)
end

--Tilting the player in the direction they're moving
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local torso = character:WaitForChild("Torso")
local rootJoint = humanoidRootPart.RootJoint;
local leftHipJoint = torso["Left Hip"];
local rightHipJoint = torso["Right Hip"];
local rootJointC0 = rootJoint.C0;
local leftHipJointC0 = leftHipJoint.C0;
local rightHipJointC0 = rightHipJoint.C0;
local force = nil;
local direction = nil;
local forceWithY = nil;
local direction2 = nil;
local value1 = 0;
local value2 = 0;
local value3 = 0;
local jumpTiltDb = false

--humanoid.HipHeight = -.1


function animator.runService()
	
	game:GetService("RunService").RenderStepped:Connect(function()
		--Leaning code
		force = humanoidRootPart.Velocity * Vector3.new(1,0,1);
		forceWithY = humanoidRootPart.Velocity * Vector3.new(1,1,1);
		if force.Magnitude > 2 then
			direction = force.Unit	;
			direction2 = forceWithY.Unit;
			value1 = humanoidRootPart.CFrame.RightVector:Dot(direction);
			value2 = humanoidRootPart.CFrame.LookVector:Dot(direction);
			value3 = humanoidRootPart.CFrame.UpVector:Dot(direction);
		else
			value1 = 0;
			value2 = 0;
			value3 = 0;
		end;
		local magnitude = ( rootJoint.C0.LookVector + CFrame.Angles(math.rad(jumpLeanAmount), 0, 0 ).LookVector ).Magnitude
		--print(magnitude)
		if pastState == Enum.HumanoidStateType.Jumping and magnitude <= magnitudeCutoff  and jumpTiltDb == false then
			rootJoint.C0 = rootJoint.C0:Lerp(rootJointC0 * CFrame.Angles(math.rad(jumpLeanAmount), 0, 0 ), leanEasing);
		elseif state == Enum.HumanoidStateType.Freefall then
			jumpTiltDb = true
			rootJoint.C0 = rootJoint.C0:Lerp(rootJointC0 * CFrame.Angles(math.rad(fallLeanAmount), 0, 0 ), leanEasing);
		else
			rootJoint.C0 = rootJoint.C0:Lerp(rootJointC0 * CFrame.Angles(math.rad(value2 * leanAmount), math.rad(-value1 * leanAmount), 0 ), leanEasing);
			leftHipJoint.C0 = leftHipJoint.C0:Lerp(leftHipJointC0 * CFrame.Angles(math.rad(value1 * leanAmount), 0, 0), leanEasing);
			rightHipJoint.C0 = rightHipJoint.C0:Lerp(rightHipJointC0 * CFrame.Angles(math.rad(-value1 * leanAmount), 0, 0), leanEasing);
		end
		if walk.WeightCurrent <= .001 or walk.IsPlaying == false then --Restart animation if it stops
			walk:Play()
			walk:AdjustWeight(.001, 0)
		end

		if idle.WeightCurrent <= .001 or idle.IsPlaying == false then --Restart animation if it stops
			idle:Play()
			idle:AdjustWeight(.001, 0)
		end

		--Weighted movement code
		if state == Enum.HumanoidStateType.Running or state == Enum.HumanoidStateType.None or state == Enum.HumanoidStateType.Swimming or state == Enum.HumanoidStateType.RunningNoPhysics then
			fall:AdjustWeight(.001, 0)
			local directionalComponent = character.HumanoidRootPart.Velocity.Unit:Dot(humanoidRootPart.CFrame.LookVector)

			walk:AdjustWeight(math.clamp(force.Magnitude/maxWalkspeed,.001, math.huge), .1)
			--idle:AdjustWeight(1-(math.clamp(force.Magnitude/maxWalkspeed,.001, math.huge)), .1)
			idle:AdjustWeight( 1-math.clamp( ( force.Magnitude/maxWalkspeed ) , .001, math.huge ) )


			--FOV code
			fovAdjustmentPath.FieldOfView = fov + (force.Magnitude/maxWalkspeed)*FOVMult

			if directionalComponent >= -.1 then --Play animation if player is moving forward
				walk:AdjustSpeed(humanoid.WalkSpeed / maxWalkspeed)
				--walk:AdjustSpeed(math.clamp(force.Magnitude/humanoid.WalkSpeed,.001, math.huge)) OLD
			else --Play animation in reverse if they aren't
				walk:AdjustSpeed( -(humanoid.WalkSpeed / maxWalkspeed) )
				--walk:AdjustSpeed( -(math.clamp(force.Magnitude/humanoid.WalkSpeed,.001, math.huge)) )
			end
			--idle:AdjustSpeed(1-(math.clamp(force.Magnitude/humanoid.WalkSpeed,.001, math.huge)))
		else
			walk:AdjustWeight(.001, 0)
			idle:AdjustWeight(.001, 0)
		end
	end);
	
end

local function jumpBehavior(oldState)
	jump:Play()
	jump:adjustWeight(1, .15)
	jumpTiltDb = false
end

local function fallBehavior(oldState)
	jump:adjustWeight(.001, .15)
	fall:Play()
	fall:AdjustWeight(1, .15)
end

local function landBehavior(oldState)
	fall:AdjustWeight(.001, 0.1)
	jumpTiltDb = false
	--Add a landing animation at some point lol
end

local function climbBehavior(oldState)
	climb:AdjustWeight(0, 0) --Start the climb animation
	climb:Play()
	climb:AdjustWeight(.001, 0)
	climb:AdjustWeight(1, .15)
	coroutine.wrap(function() --Create a separate routine to contain a loop
		while humanoid:GetState() == Enum.HumanoidStateType.Climbing do --As long as the player is climbing, play the climb animation
			game:GetService("RunService").RenderStepped:Wait()
			fall:AdjustWeight(0, 0) --Force stop the fall anim, just in case :)

			if climb.WeightCurrent <= 0 or climb.IsPlaying == false then --Restart animation if it stops
				climb:Play()
				walk:AdjustWeight(.001, 0)
			end

			local forceWithY = character.HumanoidRootPart.Velocity * Vector3.new(1,1,1);

			local directionalComponent = character.HumanoidRootPart.Velocity.Unit:Dot(humanoidRootPart.CFrame.UpVector)

			if directionalComponent >= 0 then --If player is moving upwards, tilt them upwards
				rootJoint.C0 = rootJoint.C0:Lerp(rootJointC0 * CFrame.Angles(math.rad( forceWithY.Magnitude/maxWalkspeed*climbUpLeanAmount), 0, 0 ), leanEasing);
				climb:AdjustSpeed(forceWithY.Magnitude/maxWalkspeed)
			else --Else tilt them downwards
				rootJoint.C0 = rootJoint.C0:Lerp(rootJointC0 * CFrame.Angles(math.rad( forceWithY.Magnitude/maxWalkspeed*climbDownLeanAmount), 0, 0 ):Inverse(), leanEasing);
				climb:AdjustSpeed( -(forceWithY.Magnitude/maxWalkspeed) )
			end

		end
		climb:AdjustWeight(0, .15) --Stop animation
		coroutine.wrap(function() --(actually stop the animation)
			wait(.15)
			climb:Stop()
		end)()
	end)()
end

local function sitBehavior(oldState)
	sit:Stop()
	sit:Play()
	humanoid.StateChanged:Wait()
	sit:AdjustWeight(0,.15)
	coroutine.wrap(function() wait(.15); sit:Stop(); end)()
end

--State change connections
function animator.humanoidStateChanged()
	
	humanoid.StateChanged:Connect(function(oldState, newState)
		state = newState
		pastState = oldState
		if newState == Enum.HumanoidStateType.Jumping then
			jumpBehavior(oldState)
		elseif newState == Enum.HumanoidStateType.Freefall then
			fallBehavior(oldState)
		elseif newState == Enum.HumanoidStateType.Landed then
			landBehavior(oldState)
		elseif newState == Enum.HumanoidStateType.Climbing then
			climbBehavior(oldState)
		elseif newState == Enum.HumanoidStateType.Seated then
			sitBehavior(oldState)
		end
	end)
	
end

return animator
