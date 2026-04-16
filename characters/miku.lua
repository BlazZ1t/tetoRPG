local miku = {}

function miku.getMiku()
    local miku_table = {}

    miku_table.attack_sprite_sheet = love.graphics.newImage('assets/images/miku_attack_sprite_sheet.png')
    miku_table.grid = anim8.newGrid(32, 48, miku_table.attack_sprite_sheet:getWidth(), miku_table.attack_sprite_sheet:getHeight())
    miku_table.animations = {
        attack = anim8.newAnimation(miku_table.grid('1-26', 1), 0.23, { pauseAtEnd = true }),
    }
    miku_table.anim = miku_table.animations.attack
    miku_table.isAttacking = false
        

    return miku_table 
end

return miku