# World Size Adjuster / Настройка размера мира

Server-side world-generation mod for the current Steam version of Don't Starve Together. It provides independent Surface and Caves choices in the standard Mods configuration screen.

Серверный мод генерации мира для актуальной Steam-версии Don't Starve Together. В стандартном меню модов доступны независимые настройки поверхности и пещер.

## Important limitation / Важное ограничение

The October 13, 2026 game scripts do **not** expose an arbitrary final map width/height through the supported mod API. `world_size` is a named preset. On PC, `scripts/map/forest_map.lua` maps it to these `min_size` values: tiny=1, small=50, medium=400, default/large=425, huge=450. The generator calls `WorldSim:SetWorldSize(min_size, min_size)`, builds the story and extra regions, commits it, then calls `WorldSim:ConvertToTileMap(min_size)`. Only after that does it read the actual grid using `WorldSim:GetWorldSize()`.

Скрипты игры от 13 октября 2026 года **не предоставляют штатного API для произвольной точной ширины/высоты итоговой карты**. `world_size` — именованный пресет, а `min_size` — минимальный параметр запекания, не гарантия точного размера. Размер массива карты, площадь суши и `min_size` — разные величины.

For that reason, the UI accepts targets from 100 to 1000 but explicitly displays the native value actually applied. Targets 100–400 use `medium` (min_size 400) to retain enough room for required tasks and set pieces; targets 500–1000 use `huge` (min_size 450), the largest native preset. A target of 200 therefore does **not** promise a 200×200 final grid. No finished map is cropped or resized.

Поэтому меню принимает цели 100–1000, но прямо показывает реально применяемое штатное значение. Цели 100–400 используют `medium` (min_size 400), чтобы сохранить место для обязательных задач и объектов; цели 500–1000 используют максимальный штатный `huge` (min_size 450). Выбор 200 не обещает итоговую сетку 200×200. Готовая карта не обрезается.

## Installation / Установка

1. Extract the mod folder into `Don't Starve Together/mods/WorldSizeAdjuster`.
2. Enable it on the host/server. Clients do not need the mod.
3. On a dedicated cluster, install and enable it for both Master and Caves shard environments; the same configuration provides independent values for each layer.
4. Configure it before creating/regenerating a world. Existing saves are never resized.

1. Распакуйте папку мода в `Don't Starve Together/mods/WorldSizeAdjuster`.
2. Включите мод у хозяина/на сервере. Клиентам мод не требуется.
3. На выделенном кластере установите и включите мод для окружения Master и Caves; одна конфигурация содержит независимые значения слоёв.
4. Настройте мод до создания/перегенерации мира. Существующие сохранения не изменяются.

## Settings / Настройки

- Surface / Поверхность: default target 200; applies native `medium` (min_size 400).
- Caves / Пещеры: default Unchanged / Без изменений.
- Targets: Unchanged, 100, 150, 200, 250, 300, 350, 400, 500, 600, 700, 800, 900, 1000.

Each option states the applied native min_size. Logs use the prefix `[World Size Adjuster]` and show selected targets, the overridden preset and the loaded map grid.

## Ocean, borders and extra regions / Океан, границы и дополнительные области

The surface task set supplies `ocean_prefill_setpieces` and ocean population definitions. `forest_map.lua` builds the story and calls `storygen:AddRegionsToMainland()` before committing and converting the world to a tile map. Ocean generation later converts impassable tiles and places water depths/set pieces inside the baked grid. This mod does not replace these stages, remove tasks/set pieces, or crop their results.

Набор задач поверхности задаёт `ocean_prefill_setpieces` и население океана. `forest_map.lua` строит граф мира и вызывает `storygen:AddRegionsToMainland()` до фиксации и преобразования в тайловую карту. Затем генератор океана превращает непроходимые тайлы в воду и размещает глубины/объекты внутри запечённой сетки. Мод не заменяет эти этапы, не удаляет задачи и не обрезает результат.

## Verifying the actual dimensions / Проверка фактического размера

After a shard loads, inspect `server_log.txt` for:

```text
[World Size Adjuster] loaded map grid: WIDTH x HEIGHT tiles
```

With console commands enabled, the server-side Lua expression is:

```lua
local w, h = TheWorld.Map:GetSize(); print(w, h)
```

Test a fresh cluster with caves enabled, enter a cave entrance and return, and verify required progression landmarks on several seeds. Large worlds consume more generation time, memory and save space.

## Icon / Иконка

The included `modicon.tex` is a BC3 OpenGL KTEX texture with mipmaps and premultiplied alpha. `modicon.xml` is its DST atlas, and `modinfo.lua` references both files. `modicon.png` is retained only as the editable source image.

## Validation status / Статус проверки

- Checked against the installed `scripts.zip` dated 2026-10-13.
- Uses the current `AddLevelPreInitAny`, `GetModConfigData`, `AddPrefabPostInit`, `WorldSim` preset path and runtime `TheWorld.Map:GetSize()` found in that archive.
- No game scripts are included or modified.
- Available static structure/reference checks passed; no standalone Lua parser/compiler was installed.
- Actual multi-seed generation and Surface↔Caves traversal still require an in-game or dedicated-server run; the mod is not claimed to be fully play-tested.
