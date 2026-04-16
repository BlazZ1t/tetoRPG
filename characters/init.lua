local characters = {}

-- Load individual character files
characters.teto = require('characters.teto')
characters.miku = require('characters.miku')

-- Expose functions to get character tables
function characters.getTeto()
    return characters.teto.getTeto()
end

function characters.getMiku()
    return characters.miku.getMiku()
end

return characters