local MOD_TAG = "[World Size Adjuster]"

-- Logging only. World generation changes live exclusively in modworldgenmain.lua.
AddPrefabPostInit("world", function(inst)
    if not TheWorld.ismastersim then
        return
    end

    inst:DoTaskInTime(0, function()
        local width, height = TheWorld.Map:GetSize()
        print(string.format("%s loaded map grid: %d x %d tiles", MOD_TAG, width, height))
    end)
end)
