# Команда — `cmd`

[Главная](../../README.md) · [Быстрый старт](../getting-started.md) · [Справочник](../reference.md) · [Примеры](../../examples/README.md)

Объект `cmd` приходит первым аргументом в `createmove` и действителен только внутри колбэка.

```lua
events.createmove:set(function(cmd, player)
    -- углы команды
    cmd.viewangles.y = cmd.viewangles.y + 1
    cmd.viewangles = angle(10, 90, 0)

    -- кнопки
    if cmd.in_jump.pressed then print("jump pressed this tick") end
    cmd.in_duck.down = true                     -- зажать
    cmd.in_attack:remove()                      -- убрать кнопку из команды

    cmd.upmove = 0
    local forward, left = cmd.forwardmove, cmd.leftmove
end)
```

- `createmove` вызывается после встроенных функций движения и anti-aim, перед отправкой команды.
- Кнопки: `cmd.in_attack`, `in_attack2`, `in_jump`, `in_duck`, `in_forward`, `in_back`, `in_moveleft`,
  `in_moveright`, `in_use`, `in_reload`, `in_speed`. Каждая — объект `cmd.in_button`.
- Крен (`viewangles.z`) не записывается.

## Справочник

### `cmd`

| Свойство | Тип | Доступ | Описание |
|---|---|---|---|
| `legacy_command_number` | `integer` | чтение | Номер команды. |
| `client_tick` | `integer` | чтение | Тик клиента, к которому относится команда. |
| `viewangles` | `angle` | чтение и запись | Углы команды. Можно присвоить целиком или менять по компонентам (`cmd.viewangles.y = 90`). Крен не записывается. |
| `forwardmove` | `number` | чтение | Движение вперёд-назад, -1..1. |
| `leftmove` | `number` | чтение | Движение влево-вправо, -1..1. |
| `upmove` | `number` | чтение и запись | Вертикальное движение, -1..1. |
| `subtick_moves` | `cmd.subtick_moves` | чтение | Шаги субтика этой команды — объект `cmd.subtick_moves`. |
| `input_history` | `cmd.input_history` | чтение | История ввода этой команды — объект `cmd.input_history`. |

### `cmd.in_button`

| Обращение | Описание |
|---|---|
| `cmd.in_button:remove()` | Убирает кнопку из команды полностью: и состояние, и её события. |

| Свойство | Тип | Доступ | Описание |
|---|---|---|---|
| `state` | `integer` | чтение и запись | Состояние числом: бит 0 — зажата, бит 1 — изменилась в этом тике, бит 2 — прокрутка. |
| `down` | `boolean` | чтение и запись | Зажата ли кнопка. Запись `true` нажимает её, `false` отпускает. |
| `pressed` | `boolean` | чтение | Нажата в этом тике. |
| `released` | `boolean` | чтение | Отпущена в этом тике. |

### `cmd.subtick_moves`

| Обращение | Описание |
|---|---|
| `cmd.subtick_moves:size() -> integer` | Число шагов; то же, что `#moves`. |
| `cmd.subtick_moves:clear()` | Удаляет все шаги. |

Операторы: `#`.

### `cmd.subtick_move_step`

| Свойство | Тип | Доступ | Описание |
|---|---|---|---|
| `index` | `integer` | чтение | Номер шага. |
| `when` | `number` | чтение | Момент шага внутри тика, 0..1. |
| `button` | `integer` | чтение | Кнопка шага (маска) или 0, если шаг без кнопки. |
| `pressed` | `boolean` | чтение | Нажатие (`true`) или отпускание (`false`). |

### `cmd.input_history`

| Обращение | Описание |
|---|---|
| `cmd.input_history:size() -> integer` | Число записей; то же, что `#history`. |

Операторы: `#`.

### `cmd.input_history_entry`

| Свойство | Тип | Доступ | Описание |
|---|---|---|---|
| `index` | `integer` | чтение | Номер записи. |
