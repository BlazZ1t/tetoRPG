local sounds = {}

sounds.ost = require('assets.sounds.ost')
sounds.sfx = require('assets.sounds.sfx')


function sounds.getOST()
    return sounds.ost.getOST()
end

function sounds.getSFX()
    return sounds.sfx.getSFX()
end

return sounds