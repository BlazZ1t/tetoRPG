local function basicMovement(teto, dt)
    local isMoving = false

    vx = 0
    vy = 0

    if teto.isPear then
        teto.current_sprite_sheet = teto.pear_sprite_sheet
    else
        teto.current_sprite_sheet = teto.sprite_sheet

    end
    --Check movement inputs as well as pear form input
    if love.keyboard.isDown("w") then
        isMoving = true
        teto.direction = "up"
        vy = teto.speed * -1
        if teto.isPear then
            teto.anim = teto.animations.pear_up
        else
            teto.anim = teto.animations.up
        end
    end

    if love.keyboard.isDown("s") then
        isMoving = true
        teto.direction = "down"
        vy = teto.speed
        if teto.isPear then
            teto.anim = teto.animations.pear_down
        else
            teto.anim = teto.animations.down
        end
    end

    if love.keyboard.isDown("d") then
        isMoving = true
        teto.direction = "right"
        vx = teto.speed
        if teto.isPear then
            teto.anim = teto.animations.pear_right
        else
            teto.anim = teto.animations.right
        end
    end

    if love.keyboard.isDown("a") then
        isMoving = true
        teto.direction = "left"
        vx = teto.speed * -1
        if teto.isPear then
            teto.anim = teto.animations.pear_left
        else
            teto.anim = teto.animations.left
        end
    end

    teto.hitbox:setLinearVelocity (vx, vy)

    

    function love.keypressed( key )
        if key == "space" then
            teto.isPear = not teto.isPear
        end
    end

    if isMoving == false then
        if teto.isPear then
            if teto.direction == "left" then
                teto.anim = teto.animations.pear_left
            end
            if teto.direction == "right" then
                teto.anim = teto.animations.pear_right
            end
            if teto.direction == "up" then
                teto.anim = teto.animations.pear_up
            end
            if teto.direction == "down" then
                teto.anim = teto.animations.pear_down
            end
        else
            if teto.direction == "left" then
                teto.anim = teto.animations.left
            end
            if teto.direction == "right" then
                teto.anim = teto.animations.right
            end
            if teto.direction == "up" then
                teto.anim = teto.animations.up
            end
            if teto.direction == "down" then
                teto.anim = teto.animations.down
            end
        end
        teto.anim:gotoFrame(1)
    end

    teto.anim:update(dt)
end

local function basicCamera(teto, cam, dt)

    cam:lookAt(teto.x, teto.y)
    --Camera no longer goes outbound
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()
    
    if  cam.x < width/2 then
        cam.x = width/2
    end

    if  cam.y < height/2 then
        cam.y = height/2
    end

    local mapWidth = gameMap.width * gameMap.tilewidth
    local mapHeight = gameMap.height * gameMap.tileheight

    if cam.x > (mapWidth - width/2) then
        cam.x = (mapWidth - width/2)
    end

    if cam.y > (mapHeight - height/2) then
        cam.y = (mapHeight - height/2)
    end

    world:update(dt)

    teto.x, teto.y = teto.hitbox:getX(), teto.hitbox:getY()
end

return {
    basicMovement = basicMovement,
    basicCamera = basicCamera
}