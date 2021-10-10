# CANimator
## 1.04A
A crappy alternative to Roblox's stock animator script.
## features

 - Directional leaning
 - Smoother transitions
 - Movement speed based FOV adjustment
 
 ## Limitations
 
 - !!! R6 ONLY !!!
- No emote handler
- No separate walk/run animations
- No tool hold animation
 - Still buggy
 - Not very performant
 - No priority replication or custom priority system
## To-be-added (in order of priority)
- [ ] Remove dependence on R6
- [ ]  Animated strafing and walking backwards
- [ ] Landing animation support
- [ ] Fix initial startup
- [ ] Better handling of jumping and falling
 - [ ] Priority replication/custom priority system
 - [ ] Performance improvements???
 <br><br><br><br><br>

## Why you should use CANimator

 - It's ***configurable***
CANimator comes with a very extensive config ModuleScript
 - It's ***barebones***
 CANimator does not include what (I think) doesn't need to be in an animator script. It does *not* include an emote handler. It does *not* include a tool hold animation for you to inevitably groan at having to override. It does what it needs to and nothing else.
 - It's ***Smoother***
 -CANimator focuses on improving the core feature set of Roblox's stock animator. Combined with edited character movement [(see here)](https://devforum.roblox.com/t/simulating-smoother-character-movement/776344) the result can be a much better experience for players, both visually and feeling-ing-ly..?
 - It ***Would make me very happy :)***
 <3
<br><br><br><br><br>
# How to use
1. [Get CANimator](https://github.com/respendiant/CANimator/edit/main/README.md) and put it in StarterPlayerScripts
<br>
2. Configure it how you like
<br>
3. Add your animations
<br>
4. Profit
<br><br><br><br><br>
# Configuration guide

    config.maxWalkspeed = The walkspeed you want CANimator to weight all it's animations to. 
    
      
    
    config.DoFOVAdjustment = Do you want field of view adjustment or not
    
    config.fovValue = the FOV value you want CANimator to modify
    
    config.fovAdjustmentPath = the camera who's FOV you want CANimator to modify
    
    config.FOVMult = By how much should the fov be multiplied by. The equation is FOV + (current walkspeed / max walkspeed) * FOVMult. For instance, 90 + (8/16) * 1.2 = 90.6
    
      
    
    --Animations
    
    config.name = {
    
    ["id"] = The ID of the animation as a string: "rbxassetid://#########"
    
    ["priority"] = The priority you want the animation to be. Uses the AnimationPriority Enum.
    CURRENTLY DOES NOTHING UNTIL ROBLOX FIXES REPLICATION.
    
    }
    
      
    
    --Leaning
    
    config.DoLeaning = Do you want leaning or not
    
    config.leanAmount = 5 The amount CANimator should tilt the player. More is more
    
    config.leanEasing = .08 The amount of easing CANimator should apply.
    Lower is longer, multiply by 60/framerate
    
    config.jumpLeanAmount = -9 The amount of easing CANimator should apply when a player jumps.
    Negative is tilting back, so lower is more
    
    config.MagnitudeCutoff = 1.59 THIS IS "CUSTOM" AND NEEDS MANUAL TUNING.
    To figure out what you should set it, uncomment the line print(magnitude) and pay attention to value
    in output. Idk I'll fix this later. Maybe.
    
    config.fallLeanAmount = 5 The amount of easing CANimator should apply when a player is falling.
    Positive is tilting forward, so higher is more.
    
    config.climbUpLeanAmount = 10 The amount of easing CANimator should apply when a player is
    climbing upward. Higher is more.
    
    config.climbDownLeanAmount = 10 The amount of easing CANimator should apply when a player is
    climbing downward. Higher is more.
<br><br><br><br><br>
# API
none atm. soontm.
