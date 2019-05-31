function love.load()
  width = 1000
  height = 600
  love.window.setMode(width, height, {resizable=true, vsync=true, minwidth=400, minheight=300})
  tower = love.graphics.newImage("tower.png")
  luegi = love.graphics.newImage("luegi.jpeg")
  xpos = 200
  ypos = 200
  speed = 10
end

function love.update(dt)
	if xpos > 0.3 then
		if love.keyboard.isDown('left') then
			xpos = xpos - speed
		end
	end
	if xpos < width - 0.3 then
		if love.keyboard.isDown('right') then
			xpos = xpos + speed
		end
	end
	if ypos > 0.3 then
		if love.keyboard.isDown('up') then
			ypos = ypos - speed
		end
	end
	if ypos < height - 100 then
		if love.keyboard.isDown('down') then
			ypos = ypos + speed
		end
	end
end

function love.draw()
  love.graphics.setBackgroundColor(255, 255, 255)
  love.graphics.draw(tower, 570, 290, .15, .15)
  love.graphics.draw(luegi, xpos, ypos, .4, .4)
end



