name = "World Size Adjuster"
version = "1.0.2"
version_compatible = version
author = "Sherkhan"

local is_ru = locale == "ru" or locale == "ru_RU"

description = is_ru
    and "Выбор целевого размера поверхности и пещер при создании мира. Использует только штатные пресеты генератора и честно показывает применяемый min_size."
    or "Choose surface and cave size targets for new worlds. Uses only native generator presets and clearly reports the applied min_size."

api_version = 10
dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
hamlet_compatible = false

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_only_mod = true
all_clients_require_mod = false
client_only_mod = false

priority = 0

local function label(target, applied)
    if is_ru then
        return "Цель " .. target .. " × " .. target .. " → штатный min_size " .. applied
    end
    return "Target " .. target .. " × " .. target .. " → native min_size " .. applied
end

local size_options = {
    { description = is_ru and "Без изменений" or "Unchanged", data = 0 },
    { description = label(100, 400), data = 100 },
    { description = label(150, 400), data = 150 },
    { description = label(200, 400), data = 200 },
    { description = label(250, 400), data = 250 },
    { description = label(300, 400), data = 300 },
    { description = label(350, 400), data = 350 },
    { description = label(400, 400), data = 400 },
    { description = label(500, 450), data = 500 },
    { description = label(600, 450), data = 600 },
    { description = label(700, 450), data = 700 },
    { description = label(800, 450), data = 800 },
    { description = label(900, 450), data = 900 },
    { description = label(1000, 450), data = 1000 },
}

configuration_options = {
    {
        name = "surface_size",
        label = is_ru and "Размер поверхности" or "Surface size",
        hover = is_ru
            and "Цель для нового мира. Итоговая сетка может отличаться; в скобках указан реально применяемый штатный min_size."
            or "Target for a new world. The final grid may differ; the applied native min_size is shown in each choice.",
        options = size_options,
        default = 200,
    },
    {
        name = "caves_size",
        label = is_ru and "Размер пещер" or "Caves size",
        hover = is_ru
            and "Независимая цель для новых пещер. Без изменений сохраняет настройку генератора."
            or "Independent target for newly generated caves. Unchanged preserves the generator setting.",
        options = size_options,
        default = 0,
    },
}
