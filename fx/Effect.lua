require "common/class"
require "Prop"

Effect = buildClass(Prop)

function Effect:_init( noFrames, x, y, imgname, layer )

  Prop._init( self, x, y, imgname, layer )
  
  self.frameCount = noFrames
  
end

function Effect:registerWithSecretary(secretary)
  Prop.registerWithSecretary(self, secretary)  
  
  return self
end

function Effect:onStep( )
  if self.frameCount <= 0 then
    self:destroy( )
  else
    Prop.onStep(self)
    self.frameCount = self.frameCount - 1
  end
  
end
