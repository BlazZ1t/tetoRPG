
-- WINDOW_WIDTH, WINDOW_HEIGHT = 1920 * 0.8, 1080 * 0.8
-- VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 1920 * 0.8, 1080 * 0.8

function love.load()
    --Add required libraries
    anim8 = require 'libraries/anim8'
    sti = require 'libraries/sti' 
    push = require('libraries.push')
    camera = require('libraries.camera')
    local characters = require('characters')
    local sounds = require('assets.sounds')
    user_input = require('user_input')
    
    --Camera initializer
    cam = camera()

    --Set camera to the fullscreen and to the monitor dimensions
    love.window.setMode(0, 0)

    --Load gamemap
    gameMap = sti('assets/maps/12.lua')

    --Load sound effects and music
    ost = sounds.getOST()
    sfx = sounds.getSFX()
    -- ost.main_theme:play()

    love.graphics.setDefaultFilter("nearest", "nearest")
    -- push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {fullscreen = false})


    background = love.graphics.newImage('assets/images/background.png')
    
    teto = characters.getTeto()
    miku = characters.getMiku()
end


function love.update(dt)

    user_input.basicMovement(teto, dt)

    --Miku attack trigger (for now place enter to trigger)
    if love.keyboard.isDown("return") then
        sfx.miku_attack:play()
        miku.isAttacking = true
        miku.anim = miku.animations.attack
    end
    --Set teto to frame 1 of the animation, if she is still
    
    if miku.isAttacking == false then
        miku.anim:gotoFrame(1)
    end
    
    miku.anim:update(dt)

    cam:lookAt(teto.x, teto.y)
end

function love.draw()
    -- push:start()
    cam:attach()
        gameMap:drawLayer(gameMap.layers["Слой тайлов 1"])
        teto.anim:draw(teto.current_sprite_sheet, teto.x, teto.y, nil, 3.5, 3.5, 16, 24)
        miku.anim:draw(miku.attack_sprite_sheet, 960, 530, nil, 3, 3, 16, 24)
    cam:detach()
        -- push:finish()
end
