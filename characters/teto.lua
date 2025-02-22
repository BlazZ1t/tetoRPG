local teto = {}

function teto.getTeto()
    local teto_table = {}
    teto_table.sprite_sheet = love.graphics.newImage('assets/images/sprite_sheet.png')
    teto_table.pear_sprite_sheet = love.graphics.newImage('assets/images/sprite_sheet_pear_form.png')
    teto_table.grid = anim8.newGrid(32, 48, teto_table.sprite_sheet:getWidth(), teto_table.sprite_sheet:getHeight())
    teto_table.pear_grid = anim8.newGrid(32, 48, teto_table.pear_sprite_sheet:getWidth(), teto_table.pear_sprite_sheet:getHeight())

    teto_table.animations = {
        down = anim8.newAnimation( teto_table.grid('1-4', 1), 0.15),
        up = anim8.newAnimation( teto_table.grid('1-4', 2), 0.15),
        left = anim8.newAnimation( teto_table.grid('1-4', 3), 0.15 ),
        right = anim8.newAnimation( teto_table.grid('1-4', 4), 0.15 ),

    --Load animations for pear form movement using anim8
        pear_right = anim8.newAnimation( teto_table.pear_grid('1-8', 1), 0.15 ),
        pear_left = anim8.newAnimation( teto_table.pear_grid('1-8', 2), 0.15 ),
        pear_up = anim8.newAnimation(teto_table.pear_grid('1-8', 3), 0.15),
        pear_down = anim8.newAnimation(teto_table.pear_grid('1-8', 4), 0.15)
    }

    teto_table.current_sprite_sheet = teto_table.sprite_sheet
    teto_table.anim = teto_table.animations.right

    teto.isPear = false

    teto_table.x = 200
    teto_table.y = 150
    teto_table.speed = 30

    teto.direction = "right"


    return teto_table
end

return teto