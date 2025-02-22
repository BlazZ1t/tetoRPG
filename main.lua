
-- WINDOW_WIDTH, WINDOW_HEIGHT = 1920 * 0.8, 1080 * 0.8
-- VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 1920 * 0.8, 1080 * 0.8

function love.load()
    --Add required variables
    anim8 = require 'libraries/anim8'
    sti = require 'libraries/sti'
    push = require('libraries.push')
    camera = require('libraries.camera')
    
    --Camera initializer
    cam = camera()

    --Set camera to the fullscreen and to the monitor dimensions
    love.window.setMode(0, 0)

    --Load gamemap
    gameMap = sti('maps/12.lua')

    --Load sound effects and music
    sounds = {}
    sounds.main_theme = love.audio.newSource("sounds/MainTheme.ogg", "stream")
    sounds.miku_attack = love.audio.newSource("sounds/kamehameha.swf.ogg", "static")
    sounds.miku_attack:setVolume(0.1)
    sounds.main_theme:setVolume(0.1)
    -- sounds.main_theme:play()

    love.graphics.setDefaultFilter("nearest", "nearest")
    -- push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {fullscreen = false})


    background = love.graphics.newImage('assets/background.png')
    
    --Initialize teto table. All the teto parameters are in there
    teto = {}
    teto.sprite_sheet = love.graphics.newImage('assets/sprite_sheet.png')
    teto.pear_sprite_sheet = love.graphics.newImage('assets/sprite_sheet_pear_form.png')

    teto.grid = anim8.newGrid(32, 48, teto.sprite_sheet:getWidth(), teto.sprite_sheet:getHeight())
    teto.pear_grid = anim8.newGrid(32, 48, teto.pear_sprite_sheet:getWidth(), teto.pear_sprite_sheet:getHeight())
    teto.x = 200
    teto.y = 150
    teto.speed = 30


    teto.animations = {}
    --Load animations for normal form movement using anim8
    teto.animations.down = anim8.newAnimation( teto.grid('1-4', 1), 0.15)
    teto.animations.up = anim8.newAnimation( teto.grid('1-4', 2), 0.15)
    teto.animations.left = anim8.newAnimation( teto.grid('1-4', 3), 0.15 )
    teto.animations.right = anim8.newAnimation( teto.grid('1-4', 4), 0.15 )

    --Load animations for pear form movement using anim8
    teto.animations.pear_right = anim8.newAnimation( teto.pear_grid('1-8', 1), 0.15 )
    teto.animations.pear_left = anim8.newAnimation( teto.pear_grid('1-8', 2), 0.15 )
    teto.animations.pear_up = anim8.newAnimation(teto.pear_grid('1-8', 3), 0.15)
    teto.animations.pear_down = anim8.newAnimation(teto.pear_grid('1-8', 4), 0.15)
    

    teto.anim = teto.animations.right

    teto.current_sprite_sheet = teto.sprite_sheet

    --Initialize miku table
    miku = {}
    miku.attack_sprite_sheet = love.graphics.newImage('assets/miku_attack_sprite_sheet.png')
    miku.grid = anim8.newGrid(32, 48, miku.attack_sprite_sheet:getWidth(), miku.attack_sprite_sheet:getHeight())
    miku.animations = {}
    miku.animations.attack = anim8.newAnimation(miku.grid('1-26', 1), 0.23)
    miku.anim = miku.animations.attack
    miku.isAttacking = false
end


function love.update(dt)

    local isMoving = false
    --Check movement inputs as well as pear form input
    if love.keyboard.isDown("w") then
        isMoving = true
        teto.y = teto.y - teto.speed
        if love.keyboard.isDown("space") then
            teto.anim = teto.animations.pear_up
            teto.current_sprite_sheet = teto.pear_sprite_sheet
        else
            teto.anim = teto.animations.up
            teto.current_sprite_sheet = teto.sprite_sheet
        end
    end

    if love.keyboard.isDown("s") then
        isMoving = true
        teto.y = teto.y + teto.speed
        if love.keyboard.isDown("space") then
            teto.anim = teto.animations.pear_down
            teto.current_sprite_sheet = teto.pear_sprite_sheet
        else
            teto.anim = teto.animations.down
            teto.current_sprite_sheet = teto.sprite_sheet
        end
    end

    if love.keyboard.isDown("d") then
        isMoving = true
        teto.x = teto.x + teto.speed
        if love.keyboard.isDown("space") then
            teto.anim = teto.animations.pear_right
            teto.current_sprite_sheet = teto.pear_sprite_sheet
        else
            teto.anim = teto.animations.right
            teto.current_sprite_sheet = teto.sprite_sheet
        end
    end

    if love.keyboard.isDown("a") then
        isMoving = true
        teto.x = teto.x - teto.speed
        if love.keyboard.isDown("space") then
            teto.anim = teto.animations.pear_left
            teto.current_sprite_sheet = teto.pear_sprite_sheet
        else
            teto.anim = teto.animations.left
            teto.current_sprite_sheet = teto.sprite_sheet
        end
    end
    --Miku attack trigger (for now place enter to trigger)
    if love.keyboard.isDown("return") then
        sounds.miku_attack:play()
        miku.isAttacking = true
        miku.anim = miku.animations.attack
    end
    --Set teto to frame 1 of the animation, if she is still
    if isMoving == false then
        teto.anim:gotoFrame(1)
    end
    if miku.isAttacking == false then
        miku.anim:gotoFrame(1)
    end
    teto.anim:update(dt)
    miku.anim:update(dt)

    cam:lookAt(teto.x, teto.y)
end

function love.draw()
    -- push:start()
    cam:attach()
        gameMap:drawLayer(gameMap.layers["Слой тайлов 1"])
        teto.anim:draw(teto.current_sprite_sheet, teto.x, teto.y, nil, 1)
        miku.anim:draw(miku.attack_sprite_sheet, 960, 530, nil, 1)
    cam:detach()
        -- push:finish()
end
