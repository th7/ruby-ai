#represents the goal

require 'ruby-ai/tile'
class Goal < Tile
  attr_reader :x, :y
  def initialize(window, coords)
    @image = Gosu::Image.new(window, "#{LIB}/ruby-ai/media/tiny-green.png", false)
    @x = coords[:x]
    @y = coords[:y]
  end

  def draw
    @image.draw(@x, @y, 1)
  end
end
