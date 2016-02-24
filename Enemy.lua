require "common/class"
require "Actor"
require "Animation"

Enemy = buildClass(Actor)

function Enemy:_init( )
  Actor._init( self )
  self.velocity.max = {x = 2}
  
  self.anim = Animation( "catanim" )
  
  self:setSize(32, 32)
end

function Enemy:registerWithSecretary(secretary)
  Actor.registerWithSecretary(self, secretary)
  
  -- Register for event callbacks
  secretary:registerEventListener(self, self.onStep, EventType.STEP)
  
  return self
end

function Enemy:moveLeft()
  self:setHorizontalStep(-self.velocity.max.x)
end

function Enemy:moveRight()
  self:setHorizontalStep(self.velocity.max.x)
end

function Enemy:stopMoving()
  self:setHorizontalStep(0)
end

function Enemy:onStep()
  local speed = self:getHorizontalStep()
  local t, r, b, l = self:getBoundingBox(speed, 0, 0)
  local list = self:getSecretary():getCollisions( t, r, b, l, Block )
  
  if table.getn(list) > 0 then
    self:setHorizontalStep(-speed)
  end
  
  self.anim:update( )
end

function Enemy:draw()
  local x, y = self:getPosition()
  
  love.graphics.setColor(255, 255, 255)
  self.anim:draw( x , y )
end
