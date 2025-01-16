Object = require 'libraries/classic/classic'
Timer = require 'libraries/hump/timer'
Input = require 'libraries/boipushy/Input'
Camera = require 'libraries/hump/camera'


require 'GameObject'
require 'utils'


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.graphics.setLineStyle('rough')

    resize(3)

    local object_files = {}
    recursiveEnumerate('objects', object_files)
    requireFiles(object_files)

    local room_files = {}
    recursiveEnumerate('rooms', room_files)
    requireFiles(room_files)

    rooms = {}
    current_room = nil

    stage = Stage()
    input = Input()
    camera = Camera()

    input:bind('f3', function() camera:shake(4, 60, 1) end)
end

function love.update(dt)
    stage:update(dt)
    camera:update(dt)
    if current_room then
        current_room:update(dt)
    end
end

function love.draw()
    stage:draw()
    if current_room then
        current_room:draw()
    end
end

function addRoom(room_type, room_name, ...)
    local room = _G[room_type](room_name, ...)
    rooms[room_name] = room
    return room
end

function gotoRoom(room_type, room_name, ...)
    if current_room and rooms[room_name] then
        if current_room.deactivate then current_room:deactivate() end
        current_room = rooms[room_name]
        if current_room.activate then current_room:activate() end
    else current_room = addRoom(room_type, room_name, ...) end
end
