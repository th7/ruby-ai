#holds player state, handles lose conditions

require 'ruby-ai/tile'

class Player < Tile
  attr_accessor :pause, :stop
  attr_reader :x, :y, :moved

  def initialize(window, coords)
    @image = Gosu::Image.new(window, "#{LIB}/ruby-ai/media/tiny-orange.png", false)
    @tiles = window.tiles
    @x = coords[:x]
    @y = coords[:y]
    @moved = false
    @pause = true
    @stop = false
  end

  def look(dir=nil, num=1)
    return @tiles.find {|t| t.x == x && t.y == y} unless dir
    at = send(dir, num)
    tile = @tiles.find do |tile|
      tile.x == at[:x] && tile.y == at[:y]
    end
    tile
  end

  def move(dir)
    if moved? || hit_wall?(dir)
      @stop = true
      return
    end

    to = send(dir)
    @x = to[:x]
    @y = to[:y]
    myputs "Moved #{dir}."
  end

  def stop=(val)
    if val
      puts 'Game Over.'
      @stop = true
    end
  end

  private

  def up(num=1)
    {:x => @x, :y => @y - num * 10}
  end

  def down(num=1)
    {:x => @x, :y => @y + num * 10}
  end

  def left(num=1)
    {:x => @x - num * 10, :y => @y}
  end

  def right(num=1)
    {:x => @x + num * 10, :y => @y}
  end

  def moved?
    if @moved
      puts 'Already moved!'
      true
    else
      @moved = true
      false
    end
  end

  def moved=(val)
    @moved = val
  end

  def hit_wall?(dir)
    if look(dir).kind_of?(Wall)
      puts "You moved #{dir} and knocked yourself out against a wall."
      true
    else
      false
    end
  end

  def draw
    @image.draw(@x, @y, 1)
  end

  def myputs(string)
    @count ||= 0
    @count += 1
    puts "#{@count}. " + string
  end
end
