# Время и камера — `globals`, `view_context`

[Главная](../../README.md) · [Быстрый старт](../getting-started.md) · [Справочник](../reference.md) · [Примеры](../../examples/README.md)

```lua
print(globals.curtime, globals.tickcount, globals.tickinterval)

events.override_view:set(function(view)
    view.fov = 100
    view.origin = view.origin + vector(0, 0, 10)
    view.angles = angle(view.angles.x, view.angles.y, 0)
end)
```

`globals` — свойства, а не функции. Объект `view_context` действителен только внутри `override_view`.

## Справочник

### `globals`

| Свойство | Тип | Доступ | Описание |
|---|---|---|---|
| `curtime` | `number` | чтение | Игровое время в секундах. |
| `tickcount` | `integer` | чтение | Номер текущего тика. |
| `tickinterval` | `number` | чтение | Длительность одного тика в секундах. |

### `view_context`

| Свойство | Тип | Доступ | Описание |
|---|---|---|---|
| `origin` | `vector` | чтение и запись | Позиция камеры. Меняется присвоением целого вектора. |
| `angles` | `angle` | чтение и запись | Углы камеры. Меняются присвоением целых углов. |
| `fov` | `number` | чтение и запись | Угол обзора в градусах, 1..179. |
