#Add your own AI code here.
#You have two methods at your disposal:
#  look(direction)
#    use :up, :down, :left, :right, or nothing as your direction
#    returns the tile in the specified direction, or the tile the player is currently standing on
#
#  move(direction)
#    use :up, :down, :left, or :right as your direction
#    moves the player in the specified direction
#
# You can cheat pretty easily if you like, but it's not as fun that way.

class AI
  attr_reader :player

  def initialize(player)
    @player = player
  end

  def level(num)
    puts 'Add your own code to ai.rb'
  end

  private

  #this method is required to allow method calls directly to player object
  #exa. move(:up) vs player.move(:up)
  def method_missing(m, *args)
    player.send(m, *args)
  end
end
