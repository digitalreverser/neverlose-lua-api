# Игрок в `createmove` — `simulation.player`

[Главная](../../README.md) · [Быстрый старт](../getting-started.md) · [Справочник](../reference.md) · [Примеры](../../examples/README.md)

Второй аргумент `createmove` — состояние локального игрока на текущем тике: объект `simulation.player`.
Если живого локального игрока нет, приходит `nil`. Объект действителен только внутри колбэка.

```lua
events.createmove:set(function(cmd, player)
    if player == nil then return end
    print(player.m_vecAbsOrigin, player.m_fFlags, player.m_nTickBase)

    local weapon = player.weapon
    print(weapon.m_iClip1)

    -- поля гранаты читаются, только когда в руках граната
    local ok, pulled = pcall(function() return weapon.m_bPinPulled end)
    if ok and pulled then
        print(weapon.m_flThrowStrength, weapon.m_fThrowTime)
    end

    print(player:is_jump_throw(0), player.movement.sv_gravity)
end)
```

- Свойства `m_*` — одноимённые поля игрока и оружия в игре; свойства `sv_*` у `player.movement` —
  значения консольных переменных движения.
- Поля гранаты (`m_bPinPulled`, `m_fThrowTime`, `m_flThrowStrength`, …) читаются только у гранаты, поля C4 —
  только у C4, `m_zoomLevel` — только у огнестрельного оружия. С другим оружием в руках чтение вызывает ошибку.

## Справочник

### `simulation.player`

| Обращение | Описание |
|---|---|
| `simulation.player:is_jump_throw(x: number) -> boolean` | Попадает ли момент `curtime + x` в окно прыжкового броска гранаты (0.2 с после прыжка). |
| `simulation.player:eye_position() -> vector` | Позиция глаз: позиция игрока плюс смещение взгляда. |

| Свойство | Тип | Доступ | Описание |
|---|---|---|---|
| `m_vecAbsVelocity` | `vector` | чтение | Поле `m_vecAbsVelocity` игрока. |
| `m_angStashedShootAngles` | `angle` | чтение | Поле `m_angStashedShootAngles` игрока. |
| `m_hGroundEntity` | `entity\|nil` | чтение | Сущность, на которой стоит игрок, или `nil`. |
| `movement` | `simulation.movement` | чтение | Параметры движения — объект `simulation.movement`. |
| `m_bResumeZoom` | `boolean` | чтение | Поле `m_bResumeZoom` игрока. |
| `controller` | `entity\|nil` | чтение | Сущность контроллера игрока. |
| `m_vecWaterJumpVel` | `vector` | чтение | Поле `m_vecWaterJumpVel` игрока. |
| `m_flPlayerMaxSpeed` | `number` | чтение | Поле `m_flPlayerMaxSpeed` игрока. |
| `m_bIsWalking` | `boolean` | чтение | Поле `m_bIsWalking` игрока. |
| `m_iTeamNum` | `integer` | чтение | Поле `m_iTeamNum` игрока. |
| `m_angEyeAngles` | `angle` | чтение | Поле `m_angEyeAngles` игрока. |
| `m_vecStashedVelocity` | `vector` | чтение | Поле `m_vecStashedVelocity` игрока. |
| `pawn` | `entity\|nil` | чтение | Сущность игрока. |
| `m_bIsScoped` | `boolean` | чтение | Поле `m_bIsScoped` игрока. |
| `m_vecBaseVelocity` | `vector` | чтение | Поле `m_vecBaseVelocity` игрока. |
| `m_bIsDefusing` | `boolean` | чтение | Поле `m_bIsDefusing` игрока. |
| `m_MoveType` | `integer` | чтение | Поле `m_MoveType` игрока. |
| `m_flGravityScale` | `number` | чтение | Поле `m_flGravityScale` игрока. |
| `m_flFriction` | `number` | чтение | Поле `m_flFriction` игрока. |
| `m_iShotsFired` | `integer` | чтение | Поле `m_iShotsFired` игрока. |
| `v_angle` | `angle` | чтение | Углы взгляда игрока. |
| `m_fFlags` | `integer` | чтение | Поле `m_fFlags` игрока. |
| `weapon` | `simulation.weapon` | чтение | Оружие в руках — объект `simulation.weapon`. |
| `m_vecAbsOrigin` | `vector` | чтение | Позиция игрока. |
| `m_flVelocityModifier` | `number` | чтение | Поле `m_flVelocityModifier` игрока. |
| `m_vecViewOffset` | `vector` | чтение | Поле `m_vecViewOffset` игрока. |
| `m_bWaitForNoAttack` | `boolean` | чтение | Поле `m_bWaitForNoAttack` игрока. |
| `m_bIsGrabbingHostage` | `boolean` | чтение | Поле `m_bIsGrabbingHostage` игрока. |
| `m_nTickBase` | `integer` | чтение | Поле `m_nTickBase` игрока. |
| `m_flWaterLevel` | `number` | чтение | Поле `m_flWaterLevel` игрока. |
| `m_flWaterJumpTime` | `number` | чтение | Поле `m_flWaterJumpTime` игрока. |

### `simulation.weapon`

| Обращение | Описание |
|---|---|
| `simulation.weapon:max_speed() -> number` | Максимальная скорость игрока с этим оружием в текущем режиме. |
| `simulation.weapon:spread() -> number` | Разброс оружия в текущем режиме. |
| `simulation.weapon:is_gun() -> boolean` | Огнестрельное ли оружие. |
| `simulation.weapon:is_knife() -> boolean` | Нож ли это. |
| `simulation.weapon:has_zoom() -> boolean` | Есть ли у оружия прицел. |

| Свойство | Тип | Доступ | Описание |
|---|---|---|---|
| `m_flThrowStrength` | `number` | чтение | Поле `m_flThrowStrength` оружия. |
| `m_bPinPulled` | `boolean` | чтение | Поле `m_bPinPulled` оружия. |
| `m_flNextHoldFrac` | `number` | чтение | Поле `m_flNextHoldFrac` оружия. |
| `m_bJumpThrow` | `boolean` | чтение | Поле `m_bJumpThrow` оружия. |
| `m_fAccuracyPenalty` | `number` | чтение | Поле `m_fAccuracyPenalty` оружия. |
| `m_bIsHeldByPlayer` | `boolean` | чтение | Поле `m_bIsHeldByPlayer` оружия. |
| `m_nNextHoldTick` | `integer` | чтение | Поле `m_nNextHoldTick` оружия. |
| `m_flWatTickOffset` | `number` | чтение | Поле `m_flWatTickOffset` оружия. |
| `m_bFireOnEmpty` | `boolean` | чтение | Поле `m_bFireOnEmpty` оружия. |
| `m_bRedraw` | `boolean` | чтение | Поле `m_bRedraw` оружия. |
| `m_bInReload` | `boolean` | чтение | Поле `m_bInReload` оружия. |
| `m_bIsHauledBack` | `boolean` | чтение | Поле `m_bIsHauledBack` оружия. |
| `m_flNextPrimaryAttackTickRatio` | `number` | чтение | Поле `m_flNextPrimaryAttackTickRatio` оружия. |
| `m_zoomLevel` | `integer` | чтение | Поле `m_zoomLevel` оружия. |
| `m_weaponMode` | `integer` | чтение | Поле `m_weaponMode` оружия. |
| `m_bBurstMode` | `boolean` | чтение | Поле `m_bBurstMode` оружия. |
| `m_iClip1` | `integer` | чтение | Поле `m_iClip1` оружия. |
| `m_flRecoilIndex` | `number` | чтение | Поле `m_flRecoilIndex` оружия. |
| `m_fThrowTime` | `number` | чтение | Поле `m_fThrowTime` оружия. |
| `m_bStartedArming` | `boolean` | чтение | Поле `m_bStartedArming` оружия. |
| `m_fLastShotTime` | `number` | чтение | Поле `m_fLastShotTime` оружия. |
| `m_nPostponeFireReadyTicks` | `integer` | чтение | Поле `m_nPostponeFireReadyTicks` оружия. |
| `m_nNextSecondaryAttackTick` | `integer` | чтение | Поле `m_nNextSecondaryAttackTick` оружия. |
| `m_nNextPrimaryAttackTick` | `integer` | чтение | Поле `m_nNextPrimaryAttackTick` оружия. |
| `m_iClip2` | `integer` | чтение | Поле `m_iClip2` оружия. |
| `m_flPostponeFireReadyFrac` | `number` | чтение | Поле `m_flPostponeFireReadyFrac` оружия. |
| `m_flNextSecondaryAttackTickRatio` | `number` | чтение | Поле `m_flNextSecondaryAttackTickRatio` оружия. |
| `m_iItemDefinitionIndex` | `integer` | чтение | Номер предмета (тип оружия). |

### `simulation.movement`

| Свойство | Тип | Доступ | Описание |
|---|---|---|---|
| `sv_staminalandcost` | `number` | чтение | Значение консольной переменной `sv_staminalandcost`. |
| `sv_stopspeed` | `number` | чтение | Значение консольной переменной `sv_stopspeed`. |
| `sv_stepsize` | `number` | чтение | Значение консольной переменной `sv_stepsize`. |
| `sv_jump_impulse` | `number` | чтение | Значение консольной переменной `sv_jump_impulse`. |
| `sv_jump_spam_penalty_time` | `number` | чтение | Значение консольной переменной `sv_jump_spam_penalty_time`. |
| `sv_ladder_scale_speed` | `number` | чтение | Значение консольной переменной `sv_ladder_scale_speed`. |
| `sv_standable_normal` | `number` | чтение | Значение консольной переменной `sv_standable_normal`. |
| `sv_noclipaccelerate` | `number` | чтение | Значение консольной переменной `sv_noclipaccelerate`. |
| `sv_autobunnyhopping` | `boolean` | чтение | Значение консольной переменной `sv_autobunnyhopping`. |
| `sv_walkable_normal` | `number` | чтение | Значение консольной переменной `sv_walkable_normal`. |
| `sv_staminarecoveryrate` | `number` | чтение | Значение консольной переменной `sv_staminarecoveryrate`. |
| `sv_enablebunnyhopping` | `boolean` | чтение | Значение консольной переменной `sv_enablebunnyhopping`. |
| `sv_accelerate` | `number` | чтение | Значение консольной переменной `sv_accelerate`. |
| `sv_maxvelocity` | `number` | чтение | Значение консольной переменной `sv_maxvelocity`. |
| `sv_bounce` | `number` | чтение | Значение консольной переменной `sv_bounce`. |
| `sv_staminamax` | `number` | чтение | Значение консольной переменной `sv_staminamax`. |
| `sv_staminajumpcost` | `number` | чтение | Значение консольной переменной `sv_staminajumpcost`. |
| `sv_subtick_movement_view_angles` | `boolean` | чтение | Значение консольной переменной `sv_subtick_movement_view_angles`. |
| `sv_friction` | `number` | чтение | Значение консольной переменной `sv_friction`. |
| `sv_air_max_wishspeed` | `number` | чтение | Значение консольной переменной `sv_air_max_wishspeed`. |
| `sv_jump_precision_enable` | `boolean` | чтение | Значение консольной переменной `sv_jump_precision_enable`. |
| `sv_accelerate_use_weapon_speed` | `boolean` | чтение | Значение консольной переменной `sv_accelerate_use_weapon_speed`. |
| `sv_ladder_dampen` | `number` | чтение | Значение консольной переменной `sv_ladder_dampen`. |
| `sv_maxspeed` | `number` | чтение | Значение консольной переменной `sv_maxspeed`. |
| `sv_noclipspeed` | `number` | чтение | Значение консольной переменной `sv_noclipspeed`. |
| `sv_airaccelerate` | `number` | чтение | Значение консольной переменной `sv_airaccelerate`. |
| `sv_ladder_angle` | `number` | чтение | Значение консольной переменной `sv_ladder_angle`. |
| `sv_water_slow_amount` | `number` | чтение | Значение консольной переменной `sv_water_slow_amount`. |
| `sv_gravity` | `number` | чтение | Значение консольной переменной `sv_gravity`. |
| `sv_timebetweenducks` | `number` | чтение | Значение консольной переменной `sv_timebetweenducks`. |
