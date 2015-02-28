require "PhysObject"

Player = {}
Player.__index = Player

setmetatable(Player, {
    __index = PhysObject,
    __metatable = PhysObject,
    __call = function(cls, ...)
      local self = setmetatable({}, cls)
      self:_init(...)
      return self
    end,
  }
)

function Player:_init( )
  PhysObject._init( self )
  self.velocity.max = {x = 4, y = -1}
end

function Player:draw( playerDirection )
  local x, y = self:getPosition( )
  love.graphics.setColor( 255, 255, 255 )
  image = love.graphics.newImage("gfx/character.png")

  -- animate
  if (playerDirection == "left") then
    love.graphics.draw(image, x, (y-32), rotation, 1, 1)
  elseif (playerDirection == "right") then
    love.graphics.draw(image, (x+32), (y-32), rotation, -1, 1)
  elseif (playerDirection == "jump") then
    image = love.graphics.newImage("gfx/character_jump.png")
    love.graphics.draw(image, x, (y-32))
  else
    love.graphics.draw(image, x, (y-32), rotation, 1, 1)
  end

  love.graphics.rectangle( "fill", x, y, 32, 64 )
end
 

