local user_input = {}

local basic_movement_module = require('user_input.basic_movement')
user_input.basicMovement = basic_movement_module.basicMovement
user_input.basicCamera = basic_movement_module.basicCamera


return user_input