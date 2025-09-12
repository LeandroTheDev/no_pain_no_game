NoPainNoGainCompatibility = true;
NoPainNoGainName = "NoPainNoGain";
NoPainNoGainIsSinglePlayer = false;

if not isClient() and not isServer() then
    NoPainNoGainIsSinglePlayer = true;
end

function DebugPrintNoPainNoGain(log)
    if NoPainNoGainIsSinglePlayer then
        print("[" .. NoPainNoGainName .. "] " .. log);
    else
        if isClient() then
            print("[" .. NoPainNoGainName .. "-Client] " .. log);
        else
            if isServer() then
                print("[" .. NoPainNoGainName .. "-Server] " .. log);
            else
                print("[" .. NoPainNoGainName .. "-Unkown] " .. log);
            end
        end
    end
end