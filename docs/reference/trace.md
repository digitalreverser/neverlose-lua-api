# Трассировки — `trace`

[Главная](../../README.md) · [Быстрый старт](../getting-started.md) · [Справочник](../reference.md) · [Примеры](../../examples/README.md)

Трассировки работают внутри `createmove` и колбэков игровых событий.

```lua
events.createmove:set(function(cmd, player)
    local me = entity.local_pawn()
    if not me then return end
    local from = me:origin() + vector(0, 0, 64)
    local to = from + cmd.viewangles:forward() * 4096
    local filter = trace.filter(me, trace.mask.shot)      -- пропустить себя, маска выстрела
    local result = trace.ray(from, to, filter)
    if result.fraction < 1 then
        print(result.endpos, result.normal, result.enthit)
    end
    local box = trace.aabb(from, to, vector(-16, -16, 0), vector(16, 16, 72), filter)
end)
```

**Маски — `trace.mask.<имя>`:** `solid`, `defaultplayersolid`, `npcsolid`, `water`, `opaque`, `opaque_and_npcs`, `blocklos`, `blocklos_and_npcs`, `visible`, `visible_and_npcs`, `shot`, `shot_brushonly`, `shot_hull`, `solid_brushonly`, `defaultplayersolid_brushonly`, `npcsolid_brushonly`, `npcworldstatic`, `npcworldstatic_fluid`, `playersolid_brushonly`, `floortrace`.

**Флаги содержимого — `trace.contents.<имя>`:** `empty`, `solid`, `trigger`, `sky`, `hitbox`, `player_clip`, `npc_clip`, `block_los`, `block_light`, `ladder`, `pickup`, `nodraw`, `window`, `grate`, `world_geometry`, `water`, `slime`, `touch_triggers`, `player`, `npc`, `debris`, `physics_prop`, `nav_ignore`, `nav_local_ignore`, `postprocessing_volume`, `unused3`, `carried_object`, `pushaway`, `server_entity_on_client`, `carried_weapon`, `static_level`, `block_sound`, `team1`, `team2`, `grenadeclip`, `droneclip`, `moveable`, `opaque`, `monster`, `chicken`, `thrown_grenade`, `dropped_hostage`.

Значения — целые числа; флаги содержимого складываются обычным `+`.

## Справочник

### `trace`

| Обращение | Описание |
|---|---|
| `trace.filter([skip], [mask: integer], [group: integer]) -> trace.filter` | Создаёт фильтр трассы: `skip` — сущность или массив сущностей, которые пропускаются; `mask` — маска из `trace.mask`; `group` — группа коллизий. |
| `trace.ray(from: vector, to: vector, filter: trace.filter) -> trace.result` | Трасса луча от `from` до `to`. |
| `trace.aabb(from: vector, to: vector, mins: vector, maxs: vector, filter: trace.filter) -> trace.result` | Трасса бокса с размерами `mins`..`maxs` от `from` до `to`. |
| `trace.contents` | Таблица флагов содержимого. |
| `trace.mask` | Таблица готовых масок. |

### `trace.filter`

| Свойство | Тип | Доступ | Описание |
|---|---|---|---|
| `collision_group` | `integer` | чтение и запись | Группа коллизий. |
| `interacts_with` | `integer` | чтение и запись | Маска содержимого, с которым сталкивается трасса. |
| `ignore_entities` | `entity\|table` | чтение и запись | Сущности, которые трасса пропускает. |

### `trace.result`

| Свойство | Тип | Доступ | Описание |
|---|---|---|---|
| `fraction` | `number` | чтение | Пройденная доля пути, 0..1; 1 — препятствий нет. |
| `endpos` | `vector` | чтение | Точка, где трасса остановилась. |
| `startpos` | `vector` | чтение | Начальная точка. |
| `normal` | `vector` | чтение | Нормаль поверхности в точке попадания. |
| `startsolid` | `boolean` | чтение | Началась ли трасса внутри препятствия. |
| `enthit` | `entity\|nil` | чтение | Сущность, в которую попала трасса, или `nil`. |
