local debug = getSandboxOptions():getOptionByName(
    "NoPainNoGain.ConsoleDebug"):getValue();

function xpUpdate.randXp()
    return ZombRand(70 * GameTime.getInstance():getInvMultiplier()) == 0;
end

local function isSleepy(player)
    local sleepLevel = player:getStats():getFatigue();

    if sleepLevel > 0.6 then
        if debug then
            DebugPrintNoPainNoGain("Sleepy true, xp ignored");
        end
        return true;
    end
    return false;
end

local function onPlayerMove(player)
    local enduranceLevel = player:getStats():getEndurance();

    if player:IsRunning() or player:isSprinting() then
        if player:IsRunning() then
            if enduranceLevel < 0.25 then
                player:addRightLegMuscleStrain(2000);
                if xpUpdate.randXp() then
                    if not isSleepy(player) then addXp(player, Perks.Fitness, 4); end
                    if debug then
                        DebugPrintNoPainNoGain("Run fitness: 4, strain: 2000");
                    end
                end
            elseif enduranceLevel < 0.5 then
                player:addRightLegMuscleStrain(1000);
                if xpUpdate.randXp() then
                    if not isSleepy(player) then addXp(player, Perks.Fitness, 4); end
                    if debug then
                        DebugPrintNoPainNoGain("Run fitness: 4, strain: 1000");
                    end
                end
            elseif enduranceLevel < 0.75 then
                player:addRightLegMuscleStrain(500);
                if xpUpdate.randXp() then
                    if not isSleepy(player) then addXp(player, Perks.Fitness, 3); end
                    if debug then
                        DebugPrintNoPainNoGain("Run fitness: 3, strain: 500");
                    end
                end
            else
                if xpUpdate.randXp() then
                    if not isSleepy(player) then addXp(player, Perks.Fitness, 1); end
                    if debug then
                        DebugPrintNoPainNoGain("Run fitness: 1, strain: 0");
                    end
                end
            end
        else
            if enduranceLevel < 0.25 then
                player:addRightLegMuscleStrain(1000);
                if xpUpdate.randXp() then
                    if not isSleepy(player) then addXp(player, Perks.Fitness, 3); end
                    if debug then
                        DebugPrintNoPainNoGain("Move fitness: 3, strain: 1000");
                    end
                end
            elseif enduranceLevel < 0.5 then
                player:addRightLegMuscleStrain(500);
                if xpUpdate.randXp() then
                    if not isSleepy(player) then addXp(player, Perks.Fitness, 2); end
                    if debug then
                        DebugPrintNoPainNoGain("Move fitness: 2, strain: 500");
                    end
                end
            elseif enduranceLevel < 0.75 then
                if xpUpdate.randXp() then
                    if not isSleepy(player) then addXp(player, Perks.Fitness, 1); end
                    if debug then
                        DebugPrintNoPainNoGain("Move fitness: 1, strain: 0");
                    end
                end
            end
        end

        if player:getInventoryWeight() > player:getMaxWeight() * 0.5 then
            if enduranceLevel < 0.25 then
                player:addBackMuscleStrain(2000);
                if xpUpdate.randXp() then
                    if not isSleepy(player) then addXp(player, Perks.Strength, 3); end
                    if debug then
                        DebugPrintNoPainNoGain("Weight strength: 1, strain: 2000");
                    end
                end
            elseif enduranceLevel < 0.5 then
                player:addBackMuscleStrain(1000);
                if xpUpdate.randXp() then
                    if not isSleepy(player) then addXp(player, Perks.Strength, 2); end
                    if debug then
                        DebugPrintNoPainNoGain("Weight strength: 2, strain: 1000");
                    end
                end
            elseif enduranceLevel < 0.75 then
                player:addBackMuscleStrain(500);
                if xpUpdate.randXp() then
                    if not isSleepy(player) then addXp(player, Perks.Strength, 1); end
                    if debug then
                        DebugPrintNoPainNoGain("Weight strength: 1, strain: 500");
                    end
                end
            end
        end
    else
        if enduranceLevel < 0.25 then
            player:addRightLegMuscleStrain(500);
            if xpUpdate.randXp() then
                if not isSleepy(player) then addXp(player, Perks.Fitness, 2); end
                if debug then
                    DebugPrintNoPainNoGain("Walk fitness: 2, strain: 500");
                end
            end
        elseif enduranceLevel < 0.5 then
            player:addRightLegMuscleStrain(250);
            if xpUpdate.randXp() then
                if not isSleepy(player) then addXp(player, Perks.Fitness, 2); end
                if debug then
                    DebugPrintNoPainNoGain("Walk fitness: 2, strain: 250");
                end
            end
        else
            if xpUpdate.randXp() then
                if not isSleepy(player) then addXp(player, Perks.Fitness, 1); end
                if debug then
                    DebugPrintNoPainNoGain("Walk fitness: 1, strain: 0");
                end
            end
        end
    end
end

local function onPlayerHitTree(player, weapon)
    if isSleepy(player) then return end;

    local enduranceLevel = player:getStats():getEndurance();

    if weapon and weapon:getType() ~= "BareHands" then
        if enduranceLevel < 0.25 then
            player:addCombatMuscleStrain(weapon, 1, 1000);
            if not isSleepy(player) then addXp(player, Perks.Strength, 12); end
            if debug then
                DebugPrintNoPainNoGain("Tree hit strength: 5, strain: 1000");
            end
        elseif enduranceLevel < 0.5 then
            player:addCombatMuscleStrain(weapon, 1, 500);
            if not isSleepy(player) then addXp(player, Perks.Strength, 6); end
            if debug then
                DebugPrintNoPainNoGain("Tree hit strength: 2, strain: 500");
            end
        elseif enduranceLevel < 0.75 then
            player:addCombatMuscleStrain(weapon, 1, 250);
            if not isSleepy(player) then addXp(player, Perks.Strength, 3) end
            if debug then
                DebugPrintNoPainNoGain("Tree hit strength: 1, strain: 250");
            end
        else
            if not isSleepy(player) then addXp(player, Perks.Strength, 1) end
        end
    end
end

local function onPlayerHit(player, weapon, hitObject, damage, hitCount)
    if isSleepy(player) then return end;

    local enduranceLevel = player:getStats():getEndurance();

    -- Fitness give
    if not weapon:isRanged() then
        if enduranceLevel < 0.25 then
            player:addCombatMuscleStrain(weapon, 1, 1000);
            if not isSleepy(player) then addXp(player, Perks.Fitness, 3); end
            if debug then
                DebugPrintNoPainNoGain("Hit fitness: 3, strain: 1000");
            end
        elseif enduranceLevel < 0.5 then
            player:addCombatMuscleStrain(weapon, 1, 500);
            if not isSleepy(player) then addXp(player, Perks.Fitness, 2); end
            if debug then
                DebugPrintNoPainNoGain("Hit fitness: 2, strain: 500");
            end
        elseif enduranceLevel < 0.75 then
            player:addCombatMuscleStrain(weapon, 1, 250);
            if not isSleepy(player) then addXp(player, Perks.Fitness, 1); end
            if debug then
                DebugPrintNoPainNoGain("Hit fitness: 1, strain: 250");
            end
        end
    end

    -- Strength give
    if not weapon:isRanged() and player:getLastHitCount() > 0 then
        if enduranceLevel < 0.25 then
            player:addCombatMuscleStrain(weapon, 1, 1000 * player:getLastHitCount());
            if not isSleepy(player) then addXp(player, Perks.Strength, player:getLastHitCount() * 10); end
            if debug then
                DebugPrintNoPainNoGain("Hit strength: 3, strain: " .. 1000 * player:getLastHitCount());
            end
        elseif enduranceLevel < 0.5 then
            player:addCombatMuscleStrain(weapon, 1, 500 * player:getLastHitCount());
            if not isSleepy(player) then addXp(player, Perks.Strength, player:getLastHitCount() * 5); end
            if debug then
                DebugPrintNoPainNoGain("Hit strength: 2, strain: " .. 500 * player:getLastHitCount());
            end
        elseif enduranceLevel < 0.75 then
            player:addCombatMuscleStrain(weapon, 1, 250 * player:getLastHitCount());
            if not isSleepy(player) then addXp(player, Perks.Strength, player:getLastHitCount() * 3); end
            if debug then
                DebugPrintNoPainNoGain("Hit strength: 1, strain: " .. 250 * player:getLastHitCount());
            end
        else
            if not isSleepy(player) then addXp(player, Perks.Strength, player:getLastHitCount() * 1); end
        end
    end
end

Events.OnPlayerMove.Add(onPlayerMove);
Events.OnWeaponHitXp.Add(onPlayerHit);
Events.OnWeaponHitTree.Add(onPlayerHitTree);
