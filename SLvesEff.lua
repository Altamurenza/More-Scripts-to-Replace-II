-- MORE SCRIPTS TO REPLACE (MSR) II
-- AUTHOR	: ALTAMURENZA


-------------------
-- # SLVESEFF.LUA #
-------------------

if not SystemIsReady() then
	EffectAddLeavesInArea(POINTLIST._LEAVESMAIN, 0)
	EffectAddLeavesInArea(POINTLIST._LEAVESBUSINESS, 0)
	EffectAddLeavesInArea(POINTLIST._LEAVESRICHAREA, 0)
end


------------------
-- # MSR II MAIN #
------------------

MSR_II_MAIN = function()
	while not SystemIsReady() or AreaIsLoading() do
		Wait(0)
	end
	
	
	----------------------
	-- # SHARED VARIABLE #
	----------------------
	
	shared.gMoreScriptsToReplace = {}
	
	shared.gMoreScriptsToReplace.Game = type(_G.ClassMusicSetPlayers) == 'function' and 'SE' or 'AE'
	shared.gMoreScriptsToReplace.Path = (shared.gMoreScriptsToReplace.Game == 'SE' and 'Scripts' or 'storage/emulated/0/Android/data/com.rockstargames.bully/files/BullyOrig/Scripts')..'/MSR_II'
	
	
	----------------------
	-- # STIMECYCLE MODS #
	----------------------
	
	shared.gMoreScriptsToReplace.G01 = {}
	shared.gMoreScriptsToReplace.G02 = {}
	
	for ID = 1, 2 do
		LaunchScript('MSR_GRP0'..ID..'.lua')
	end
	
	
	--------------------------
	-- # NON-STIMECYCLE MODS #
	--------------------------
	
	shared.gMoreScriptsToReplace.G03 = {}
	
	for ID = 1, 10 do
		local FILE, ERROR = loadfile(shared.gMoreScriptsToReplace.Path..'/GROUP_03_NonSTC/MOD_'..ID..'.lur')
		
		if FILE then
			FILE()
			
			shared.gMoreScriptsToReplace.G03[ID] = true
		end
		collectgarbage()
	end
end

shared.gMoreScriptsToReplace_MainThread = CreateThread('MSR_II_MAIN')