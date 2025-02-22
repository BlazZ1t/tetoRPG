local sfx = {}

function sfx.getSFX()
return {
    miku_attack = love.audio.newSource("assets/sounds/soundeffects/kamehameha.swf.ogg", "static"),
}
end

return sfx