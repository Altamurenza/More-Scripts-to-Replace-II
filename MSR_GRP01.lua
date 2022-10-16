-- MORE SCRIPTS TO REPLACE (MSR) II - GROUP 1
-- AUTHOR	: ALTAMURENZA


main = function()
	---------------------
	-- # THE KEY OF MSR #
	---------------------
	
	main = nil
	
	
	------------------------------
	-- # RE-DEFINE IMPORT SCRIPT #
	------------------------------
	
	_G.ImportScript = function(FILE)
		-- # QUALIFY THE CRITERIA #
		if string.find(FILE, 'Library/', 1) or string.find(FILE, '\Library', 1) or string.find(FILE, 'Test/', 1) or string.find(FILE, '\Test', 1) then
			-- # WAIT FOR STREAM #
			while IsStreamingBusy() do
				Wait(0)
			end
			
			-- # IMPORT FROM IMG ARCHIVE #
			ImportScript(FILE)
		else
			-- # CALL THE FILE #
			local SCRIPT, MESSAGE = loadfile(shared.gMoreScriptsToReplace.Path..'/GROUP_01_STC/MOD_'..(_G.FILE_LOAD_ORDER or '?')..'_IMPORT/'..FILE)

			-- # EXECUTE LOADED FILE #
			if SCRIPT then
				SCRIPT()
			else
				-- # PRINT ERROR #
				_G[shared.gMoreScriptsToReplace.Game == 'SE' and 'TextPrintString' or 'MinigameSetAnnouncement'](
					shared.gMoreScriptsToReplace.Game == 'SE' and "'/GROUP_01_STC/MOD_"..(_G.FILE_LOAD_ORDER or '?')..".lur' is requiring '/GROUP_01_STC/MOD_"..(_G.FILE_LOAD_ORDER or '?').."_IMPORT/"..FILE.."' in order to work!" or FILE..' is required!',
					shared.gMoreScriptsToReplace.Game == 'SE' and 10 or true,
					shared.gMoreScriptsToReplace.Game == 'SE' and 2 or nil
				)
			end
			
			-- # REMOVE LOADED FILE FROM THE MEMORY #
			collectgarbage()
		end
	end
	
	
	---------------------------
	-- # CALL, INIT, & LAUNCH #
	---------------------------
	
	for ORDER = 1, 5 do
		-- # SET GLOBAL #
		_G.FILE_LOAD_ORDER = ORDER
		
		-- # LOAD #
		local SCRIPT, MESSAGE = loadfile(shared.gMoreScriptsToReplace.Path..'/GROUP_01_STC/MOD_'..ORDER..'.lur')
		
		if SCRIPT then
			SCRIPT()
			
			-- # SWAP, ADD, & EXECUTE #
			if type(main) == 'function' then
				_G['GROUP_01_MAIN_0'..ORDER..'_DAT'] = {[1] = main, [2] = false}; main = nil
				_G['GROUP_01_MAIN_0'..ORDER..'_MOD'] = function()
					-- # FIND CURRENT SEQUENCE #
					local CURRENT_SEQ = 0
					
					for ORDER = 1, 5 do
						if type(_G['GROUP_01_MAIN_0'..ORDER..'_DAT']) == 'table' and _G['GROUP_01_MAIN_0'..ORDER..'_DAT'][2] == false then
							CURRENT_SEQ = ORDER
							
							break
						end
					end
					
					-- # RE-DEFINE IMPORT SCRIPT IN CURRENT THREAD #
					_G.ImportScript = function(FILE)
						-- # QUALIFY THE CRITERIA #
						if string.find(FILE, 'Library/', 1) or string.find(FILE, '\Library', 1) or string.find(FILE, 'Test/', 1) or string.find(FILE, '\Test', 1) then
							-- # WAIT FOR STREAM #
							while IsStreamingBusy() do
								Wait(0)
							end
							
							-- # IMPORT FROM IMG ARCHIVE #
							ImportScript(FILE)
						else
							-- # CALL THE FILE #
							local SCRIPT, MESSAGE = loadfile(shared.gMoreScriptsToReplace.Path..'/GROUP_01_STC/MOD_'..CURRENT_SEQ..'_IMPORT/'..FILE)
							
							-- # CHECK THE LOADED FILE #
							if SCRIPT then
								SCRIPT()
							else
								-- # PRINT ERROR #
								_G[shared.gMoreScriptsToReplace.Game == 'SE' and 'TextPrintString' or 'MinigameSetAnnouncement'](
									shared.gMoreScriptsToReplace.Game == 'SE' and "'/GROUP_01_STC/MOD_"..CURRENT_SEQ..".lur' is requiring '/GROUP_01_STC/MOD_"..CURRENT_SEQ.."_IMPORT/"..FILE.."' in order to work!" or FILE..' is required!',
									shared.gMoreScriptsToReplace.Game == 'SE' and 10 or true,
									shared.gMoreScriptsToReplace.Game == 'SE' and 2 or nil
								)
							end
							
							-- # REMOVE LOADED FILE FROM THE MEMORY #
							collectgarbage()
						end
					end
					
					-- # ENABLE THE FLAG & EXECUTE MAIN #
					_G['GROUP_01_MAIN_0'..CURRENT_SEQ..'_DAT'][2] = true
					_G['GROUP_01_MAIN_0'..CURRENT_SEQ..'_DAT'][1]()
				end
				
				-- # MULTITHREADING #
				shared.gMoreScriptsToReplace.G01[ORDER] = CreateThread('GROUP_01_MAIN_0'..ORDER..'_MOD')
			end
		end
		
		-- # REMOVE LOADED FILE FROM THE MEMORY #
		collectgarbage()
	end
	
	
	---------------
	-- # CLEAN UP #
	---------------
	
	_G.ImportScript, _G.FILE_LOAD_ORDER = nil, nil
	collectgarbage()
end