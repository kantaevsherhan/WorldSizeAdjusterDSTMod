-- World Size Adjuster
-- The current DST generator accepts named world_size presets, not arbitrary
-- tile dimensions. Keep this mapping deliberately small and native.

local MOD_TAG = "[World Size Adjuster]"

local TARGET_TO_NATIVE = {
    [100] = { preset = "medium", min_size = 400 },
    [150] = { preset = "medium", min_size = 400 },
    [200] = { preset = "medium", min_size = 400 },
    [250] = { preset = "medium", min_size = 400 },
    [300] = { preset = "medium", min_size = 400 },
    [350] = { preset = "medium", min_size = 400 },
    [400] = { preset = "medium", min_size = 400 },
    [500] = { preset = "huge", min_size = 450 },
    [600] = { preset = "huge", min_size = 450 },
    [700] = { preset = "huge", min_size = 450 },
    [800] = { preset = "huge", min_size = 450 },
    [900] = { preset = "huge", min_size = 450 },
    [1000] = { preset = "huge", min_size = 450 },
}

local surface_target = tonumber(GetModConfigData("surface_size")) or 0
local caves_target = tonumber(GetModConfigData("caves_size")) or 0

print(string.format(
    "%s selected targets: surface=%s, caves=%s",
    MOD_TAG,
    surface_target == 0 and "unchanged" or tostring(surface_target),
    caves_target == 0 and "unchanged" or tostring(caves_target)
))

local function apply_target(level)
    if type(level) ~= "table" then
        print(MOD_TAG .. " warning: level pre-init received no level table")
        return
    end

    local is_cave = level.location == "cave"
    local target = is_cave and caves_target or surface_target
    local layer = is_cave and "caves" or "surface"

    if target == 0 then
        print(string.format("%s %s: unchanged", MOD_TAG, layer))
        return
    end

    local native = TARGET_TO_NATIVE[target]
    if native == nil then
        print(string.format("%s %s: unsupported target %s; unchanged", MOD_TAG, layer, tostring(target)))
        return
    end

    level.overrides = level.overrides or {}
    local previous = level.overrides.world_size
    level.overrides.world_size = native.preset

    print(string.format(
        "%s %s: requested=%dx%d, previous world_size=%s, applied world_size=%s (native min_size=%d; final grid is determined after baking)",
        MOD_TAG,
        layer,
        target,
        target,
        tostring(previous),
        native.preset,
        native.min_size
    ))
end

AddLevelPreInitAny(apply_target)
