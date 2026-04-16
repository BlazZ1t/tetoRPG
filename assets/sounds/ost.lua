local ost = {}

function ost.getOST()
return {
    main_theme = love.audio.newSource("assets/sounds/soundtrack/MainTheme.ogg", "stream"),
}
end

return ost