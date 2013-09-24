#access methods via brackets

class Tile
  def [](key)
    send(key)
  end

  def inspect
    "#{self.class}, @x=#{x}, @y=#{y}"
  end
end
