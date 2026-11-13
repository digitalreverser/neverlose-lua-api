# Быстрый старт

[Главная](../README.md) · [Справочник](reference.md) · [Примеры](../examples/README.md)

## Создание и загрузка

1. Открой вкладку **Extensions** в меню.
2. Нажми **+**, укажи имя и вставь Lua-код.
3. Нажми **Save**, чтобы сохранить файл, или **Save & Reload**, чтобы сохранить и загрузить его.
4. Список обновляется кнопкой Refresh. Кнопки загрузки и остановки находятся рядом со скриптом.

Чтобы установить готовый пример, скопируй нужный `.lua` из папки [examples](../examples/README.md) в
`C:\neverwin\scripts` и обнови список Extensions.

## Минимальный пример

```lua
print("Script loaded")

local font = render.load_font("verdana.ttf", 14)

events.render:set(function()
    render.text(font, vector2(24, 90), color(255, 255, 255, 255), "", "Hello, Lua!")
end)
```

`print` выводит сообщение при загрузке. Обработчик события `render` вызывается при отрисовке; функции
`render.*` работают только внутри него. Позиция — `vector2(x, y)`, цвет — `color(r, g, b, a)` со
значениями 0..255. **Альфу указывай всегда**: `color(255, 255, 255)` даёт прозрачный цвет.

У `render.text` четвёртый аргумент — флаги (`""`, `"c"` — по центру, `"r"` — по правому краю), текст
идёт с пятого аргумента, и частей может быть несколько: они склеиваются.

## Элемент меню

```lua
local tab = ui.tab("Lua Examples")
local group = tab:group("Overlay")
local enabled = group:toggle("Show example", true)
local font = render.load_font("verdana.ttf", 14)

events.render:set(function()
    if not enabled:get() then
        return
    end
    render.text(font, vector2(24, 90), color(255, 255, 255, 255), "", "Enabled")
end)
```

`enabled:get()` возвращает текущее значение. Остальные элементы и методы — в разделе
[Меню](reference/ui.md).

## Команда и игрок

```lua
events.createmove:set(function(cmd, player)
    if cmd.in_jump.pressed then
        print("jump at tick", globals.tickcount)
    end
    if player then
        print("ammo", player.weapon.m_iClip1, "flags", player.m_fFlags)
    end
end)
```

`cmd` — команда текущего тика, `player` — состояние локального игрока (или `nil`, если его нет).
Оба объекта действительны только внутри колбэка. Подробности — [Команда](reference/cmd.md) и
[Игрок в createmove](reference/simulation.md).

## Игровые события

```lua
events.player_hurt:set(function(e)
    print(e:get_int("dmg_health"), e:get_string("weapon"))
end)
```

Подписка идёт по имени события игры; колбэк получает объект события с методами `get_int`, `get_float`,
`get_bool`, `get_string`, `get_pawn`, `get_controller`. Список событий — в разделе
[События](reference/events.md).

## Файлы и ресурсы

| Путь | Назначение |
| --- | --- |
| `C:\neverwin\scripts` | Основные файлы `.lua` |
| `C:\neverwin\scripts\lib` | Модули для `require` |
| `C:\neverwin\scripts\images` | Изображения |
| `C:\neverwin\scripts\fonts` | Пользовательские шрифты |
| `C:\neverwin\scripts\data` | Файлы модуля `filesystem` |
| `C:\neverwin\scripts\data\db` | Хранилище `database` |

## Контексты и ошибки

- Рисование — только внутри события `render`.
- `trace.*` — внутри `createmove` и колбэков игровых событий.
- `cmd` и `player` — только внутри своего `createmove`, `view_context` — внутри `override_view`.
- `filesystem`, `http`, `utils.interface`, `utils.pattern`, `os.clipboard` требуют **Allow Insecure**.
  Примеры из этого репозитория это разрешение не используют.

Если скрипт не загружается, проверь текст ошибки в выводе Lua, имена функций и допустимый контекст.
Ошибка внутри колбэка события печатается в вывод Lua и остальные колбэки не останавливает.
