Ruby AI
=========================
This is my first gem. Feedback on best practices is very welcome.

In this game, you write some basic AI to move the player block to the goal.

Getting Started
---------------------

```bash
$ gem install ruby-ai
```

Move to an empty directory of your choice.

```bash
$ ruby-ai init
```

The above command creates an ai.rb file and a levels directory within your current directory.

```bash
$ ruby-ai X
```

Substitute a level number for "X" to load that level. Seven pre-made levels are included, but you can easily add more (see below).

Writing AI
------------------

Simply open the ai.rb file. On each update tick, the
```ruby
def level(num)
  # your code here
end
```
method will be called.

You have two methods at your disposal:
```ruby
look(direction)
```
```ruby
move(direction)
```
The usable directions are:
```ruby
:up, :down, :left, :right
```

The 'look' method will return a tile in the specified direction, or the tile at your current location if no direction in specified.
The 'move' method will move you in the specified direction. Moving twice or hitting a wall will end the game.

You can only see one space in each of the 4 available directions as you go. Each Tile object responds to:
```ruby
tile[:x] #=> the x coordinate of that tile
tile[:y] #=> the y coordinate of that tile
```
The three Tile classes are Goal, Wall, Empty.

Hint:
```ruby
look(:up).kind_of?(Wall)
look(:down).kind_of?(Empty)
```

Ruby AI will flip/rotate the level randomly, so you can't just create a list of moves.

Running the AI
------------------

Load a level and press enter to begin. Press up to increase speed or down to decrease speed. Press enter again to pause. Press escape to exit.

Creating Levels
-----------------------

Each level is represented by a .png image. Each pixel represents one tile. I recommend the MacOS program Paintbrush, since Ruby AI will recognize the pre-made colors.

The Player is orange, a.k.a. 'Tangerine' in Paintbrush.
The Goal is green, a.k.a. 'Spring' in Paintbrush.
Walls are brown, a.k.a. 'Mocha' in Paintbrush.
Empty space is black, a.k.a. 'Licorice' in Paintbrush.

Ruby AI _should_ support levels up to 64x64, but they will load slowly (if at all).
