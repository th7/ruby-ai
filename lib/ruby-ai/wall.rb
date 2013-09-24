#represents a wall

require 'ruby-ai/tile'
class Wall < Tile
  attr_reader :x, :y

  def initialize(window, coords)
    @image = Gosu::Image.new(window, "#{LIB}/ruby-ai/media/tiny-brown.png", true)
    @x = coords[:x]
    @y = coords[:y]
  end

  def draw
    @image.draw(@x, @y, 1)
  end
end
