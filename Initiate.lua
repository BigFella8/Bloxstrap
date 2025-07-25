local hidegui = getgenv().hideui or false
local cloneref: () -> () = cloneref or function(...): (...any) -> (...any) return (...) end
local httpservice = cloneref(game:GetService('HttpService'))
local getasync: () -> () = function(string: string): (string) -> (string)
    return game:HttpGet(string, true)
end
makefolder('Bloxstrap');
makefolder('Bloxstrap/Main');
    makefolder('Bloxstrap/Main/Functions');
    makefolder('Bloxstrap/Main/Configs');
    makefolder('Bloxstrap/Main/Fonts')
    makefolder('Bloxstrap/Images')
local install: () -> () = function(config: {path: string, setup: boolean}): (table) -> ()
    config = config or {}
    
    for i: number, v: table in httpservice:JSONDecode(getasync('https://api.github.com/repos/BigFella8/Bloxstrap/contents/')) do
        if v.name:find('.lua') then
            writefile(`Bloxstrap/{v.name}`, `return loadstring(game:HttpGet('https://raw.githubusercontent.com/BigFella8/Bloxstrap/refs/heads/main/{v.name}', true))()`);
        elseif v.name:find('.mp3') or v.name:find('.png') then
            writefile(`Bloxstrap/{v.name}`, game:HttpGet(`https://raw.githubusercontent.com/BigFella8/Bloxstrap/refs/heads/main/{v.name}`));
        end;
    end;
    writefile(`Bloxstrap/Main/Bloxstrap.lua`, `return loadstring(game:HttpGet('https://raw.githubusercontent.com/BigFella8/Bloxstrap/refs/heads/main/Main/Bloxstrap.lua', true))()`);
    for i: number, v: table in httpservice:JSONDecode(getasync('https://api.github.com/repos/BigFella8/Bloxstrap/contents/Main/Functions')) do
        writefile(`Bloxstrap/Main/Functions/{v.name}`, `return loadstring(game:HttpGet('https://raw.githubusercontent.com/BigFella8/Bloxstrap/refs/heads/main/Main/Functions/{v.name}', true))()`);
    end;
    writefile("Bloxstrap/Main/Configs/Default.json", "{}")
end;

if (not isfolder('Bloxstrap') or #listfiles('Bloxstrap') <= 6) then
    install({})
end

local Bloxstrap: table = loadfile('Bloxstrap/Main/Bloxstrap.lua')()
Bloxstrap.start() 
Bloxstrap.Visible(not hidegui)
