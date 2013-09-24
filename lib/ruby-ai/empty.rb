#represents an empty space

require 'ruby-ai/tile'
class Empty < Tile
  attr_reader :x, :y

  def initialize(window, coords)
    @x = coords[:x]
    @y = coords[:y]
  end
end
