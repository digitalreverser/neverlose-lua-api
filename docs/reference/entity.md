# Сущности — `entity`, `hitbox`

[Главная](../../README.md) · [Быстрый старт](../getting-started.md) · [Справочник](../reference.md) · [Примеры](../../examples/README.md)

```lua
local me = entity.local_pawn()
if me and me:is_alive() then
    print(me:classname(), me:health(), me:origin(), me:velocity())
    local gun = me:weapon()
    if gun then print(gun:classname()) end
end

for _, pawn in ipairs(entity.pawns()) do
    if pawn:is_alive() then print(pawn:hitbox_position(0)) end
end

for _, c in ipairs(entity.controllers()) do
    print(c:name(), c:pawn())
end

local smokes = entity.list("C_SmokeGrenadeProjectile")
```

Сущности сравниваются через `==`. Объект сущности может пережить саму сущность: перед использованием
сохранённого объекта проверяй `ent:is_valid()`.

## Справочник

### `entity`

| Обращение | Описание |
|---|---|
| `entity.entindex(i: integer) -> entity\|nil` | Сущность по индексу или `nil`. |
| `entity.handle(h: integer) -> entity\|nil` | Сущность по handle или `nil`. |
| `entity.list([name: string]) -> table` | Таблица сущностей: без аргумента — все, с именем — только сущности этого класса. |
| `entity.gmatch([name: string]) -> iterator` | Итератор по тем же сущностям, что возвращает `entity.list`. |
| `entity.match(name: string) -> entity\|nil` | Первая сущность класса `name` или `nil`. |
| `entity.local_player() -> entity\|nil, entity\|nil` | Локальный игрок: контроллер и pawn. |
| `entity.local_controller() -> entity\|nil` | Контроллер локального игрока или `nil`. |
| `entity.local_pawn() -> entity\|nil` | Pawn локального игрока или `nil`. |
| `entity.controllers() -> table` | Таблица контроллеров всех игроков. |
| `entity.pawns() -> table` | Таблица pawn всех игроков. |

### `entity`

| Обращение | Описание |
|---|---|
| `entity:classname() -> string` | Имя класса сущности, например `C_CSPlayerPawn`. |
| `entity:health() -> integer` | Здоровье. |
| `entity:is_alive() -> boolean` | Жива ли сущность. |
| `entity:owner() -> entity\|nil` | Владелец сущности (например, игрок для оружия) или `nil`. |
| `entity:is_valid() -> boolean` | Существует ли ещё сущность. |
| `entity:origin() -> vector` | Позиция сущности. |
| `entity:velocity() -> vector` | Скорость сущности. |
| `entity:weapon() -> entity\|nil` | Оружие в руках или `nil`. |
| `entity:eye_angles() -> angle\|nil` | Углы взгляда или `nil`. |
| `entity:name() -> string\|nil` | Имя игрока или `nil`. |
| `entity:hitbox_position(i: integer) -> vector\|nil` | Центр хитбокса с номером `i` или `nil`. |
| `entity:hitbox(i: integer) -> hitbox\|nil` | Объект хитбокса с номером `i` или `nil`. |
| `entity:pawn() -> entity\|nil` | Pawn контроллера или `nil`. |

Операторы: `==`.

### `hitbox`

| Обращение | Описание |
|---|---|
| `hitbox:classname() -> string` | Имя класса хитбокса. |
| `hitbox:entity() -> entity` | Сущность, которой принадлежит хитбокс. |
| `hitbox:index() -> integer` | Номер хитбокса. |
| `hitbox:position() -> vector\|nil` | Центр хитбокса в мире. |
