function love.load()
  width = 1000
  height = 600
  love.window.setMode(width, height, {resizable=true, vsync=true, minwidth=400, minheight=300})
  tower = love.graphics.newImage('tower.png')
  animationRight = newAnimation(love.graphics.newImage('run2.png'), 50, 65, 1, 1)
  animationLeft = newAnimation(love.graphics.newImage('run2.png'), 50, 65, 2, 1)
  xpos = 200
  ypos = 200
  speed = 10
  lastSpriteSheet = animationRight
end

function love.update(dt)
	if xpos > 0.3 then
		if love.keyboard.isDown('left') then
			xpos = xpos - speed
      animationLeft.currentTime = animationLeft.currentTime + dt
      if animationLeft.currentTime >= animationLeft.duration then
        animationLeft.currentTime = animationLeft.currentTime - animationLeft.duration
      end
		end
	end
	if xpos < width - 50 then
		if love.keyboard.isDown('right') then
			xpos = xpos + speed
      animationRight.currentTime = animationRight.currentTime + dt
      if animationRight.currentTime >= animationRight.duration then
        animationRight.currentTime = animationRight.currentTime - animationRight.duration
      end
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

  isDrawn = false
  if love.keyboard.isDown('right') then
    local spriteNum = math.floor(animationRight.currentTime / animationRight.duration * #animationRight.quads) + 1
    love.graphics.draw(animationRight.spriteSheet, animationRight.quads[spriteNum], xpos, ypos, 0, 4)
    isDrawn = true
    lastSpriteSheet = animationRight
    lastQuad = spriteNum
  end
  if love.keyboard.isDown('left') then
    local spriteNum = math.floor(animationLeft.currentTime / animationLeft.duration * #animationLeft.quads) + 1
    love.graphics.draw(animationLeft.spriteSheet, animationLeft.quads[spriteNum], xpos, ypos, 0, 4)
    isDrawn = true
    lastSpriteSheet = animationLeft
    lastQuad = spriteNum
  end
  if isDrawn == false then
    if lastSpriteSheet == animationRight then
      resetQuad = 1
    else
      resetQuad = 8
    end
    love.graphics.draw(lastSpriteSheet.spriteSheet, lastSpriteSheet.quads[resetQuad], xpos, ypos, 0, 4)
  end
end


function newAnimation(image, width, height, row, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};
    startY = height * (row - 1)
    for y = startY, image:getHeight() - height - (65 - startY), height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end
 
    animation.duration = duration
    animation.currentTime = 0
    return animation
end



