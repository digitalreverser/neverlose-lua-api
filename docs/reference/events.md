# События — `events`

[Главная](../../README.md) · [Быстрый старт](../getting-started.md) · [Справочник](../reference.md) · [Примеры](../../examples/README.md)

Каждое событие — объект `events.<имя>`. Подписка, отписка и вызов своего события:

```lua
local function on_render()
    -- рисование
end

events.render:set(on_render)       -- подписаться
events.render:unset(on_render)     -- отписаться
events.render(on_render)           -- то же, что :set(on_render)
events.render(on_render, false)    -- то же, что :unset(on_render)

events.my_signal:set(function(a, b) print(a, b) end)
events.my_signal:fire(1, "two")    -- вызвать подписчиков своего события
```

Повторный `:set` той же функции второй подписки не создаёт. Ошибка в колбэке печатается в вывод Lua и
остальных подписчиков не останавливает. `:fire` вызывает подписчиков текущего скрипта.

## События

| Событие | Аргументы колбэка | Когда вызывается |
|---|---|---|
| `render` | — | Каждый кадр; только здесь работают функции `render.*` |
| `createmove` | `cmd`, `player: simulation.player` | Каждый тик при сборке команды |
| `override_view` | `view: view_context` | При расчёте камеры |
| `shutdown` | — | При выгрузке скрипта |
| `menu_toggled` | `open: boolean` | При открытии и закрытии меню |
| `level_init` | `map: string` | При загрузке карты |
| `level_shutdown` | — | При выходе с карты |
| `frame_stage` | `stage: integer` | На стадиях обработки кадра |
| `player_esp` | `player: entity`, `box: {left, top, right, bottom}` | При отрисовке ESP игрока |
| *игровое событие* (`player_hurt`, `player_death`, `round_start`, …) | `e: game_event` | Когда событие происходит в игре |

## Игровые события

Подписка по имени события игры. Колбэк получает объект события; он действителен только внутри колбэка.

```lua
events.player_hurt:set(function(e)
    local victim = e:get_pawn("userid")
    print(e:name(), e:get_int("dmg_health"), e:get_string("weapon"))
    if victim then print(victim:health()) end
end)
```

| Обращение | Описание |
|---|---|
| `e:name() -> string` | Имя события. |
| `e:get_int(key: string) -> integer` | Целое поле события. |
| `e:get_float(key: string) -> number` | Дробное поле события. |
| `e:get_bool(key: string) -> boolean` | Булево поле события. |
| `e:get_string(key: string) -> string` | Строковое поле события. |
| `e:get_controller(key: string) -> entity\|nil` | Контроллер игрока из поля события. |
| `e:get_pawn(key: string) -> entity\|nil` | Pawn игрока из поля события. |

## Справочник

### `event`

| Обращение | Описание |
|---|---|
| `event:set(fn: function) -> nothing` | Подписывает функцию на событие. Повторная подписка той же функции ничего не добавляет. |
| `event:unset(fn: function) -> nothing` | Снимает подписку функции. |
| `event:fire(...) -> nothing` | Вызывает всех подписчиков события в порядке подписки и передаёт им свои аргументы. |

Операторы: `вызов`, `==`.
