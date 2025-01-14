Object = require 'libraries/classic/classic'

function love.load()
    local object_files = {}
    reursiveEnumerate('objects', object_files)
    requireFiles(object_files)

    hyperCircle = HyperCircle(400, 300, 50, 120, 10)
end


function reursiveEnumerate(folder, files)
    local items = love.filesystem.getDirectoryItems(folder)
    print(items)
    for _, item in ipairs(items) do
        local file = folder .. '/' .. item
        local file_info = love.filesystem.getInfo(file)
        print(file .. '  ' .. file_info.type)
        if file_info.type == 'file' then
            table.insert(files, file)
        elseif file_info.type == 'directory' then
            reursiveEnumerate(file, files)
        end
    end
end

function requireFiles(files)
    for _, path in ipairs(files) do
        local file = path:sub(1, -5)
        require(file)
    end
end

function love.update(dt)
    hyperCircle:draw(dt)
end

function love.draw()
    hyperCircle:draw()
end

function love.run()
    if love.math then
	       love.math.setRandomSeed(os.time())
    end

    if love.load then love.load(arg) end

    -- We don't want the first frame's dt to include time taken by love.load.
    if love.timer then love.timer.step() end

    local dt = 0

    -- Main loop time.
    while true do
        -- Process events.
        if love.event then
	    love.event.pump()
	    for name, a,b,c,d,e,f in love.event.poll() do
	        if name == "quit" then
		    if not love.quit or not love.quit() then
		        return a
		    end
	        end
		love.handlers[name](a,b,c,d,e,f)
	    end
        end

    	-- Update dt, as we'll be passing it to update
    	if love.timer then
    	    love.timer.step()
    	    dt = love.timer.getDelta()
    	end

    	-- Call update and draw
    	if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled

    	if love.graphics and love.graphics.isActive() then
    	    love.graphics.clear(love.graphics.getBackgroundColor())
    	    love.graphics.origin()
                if love.draw then love.draw() end
    	    love.graphics.present()
    	end

    	if love.timer then love.timer.sleep(0.001) end
    end
end
