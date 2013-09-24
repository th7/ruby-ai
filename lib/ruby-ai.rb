#displays game, passes commands
LIB = File.expand_path(File.dirname(__FILE__))

require 'gosu'
require 'texplay'
require 'ruby-ai/goal'
require 'ruby-ai/wall'
require 'ruby-ai/empty'
require 'ruby-ai/player'
require 'ruby-ai/ui'

class RubyAI < Gosu::Window
  attr_reader :tiles

  COLORS = {
    :player => [1.0, 0.5764706134796143, 0.0, 1.0], #orange, paintbrush 'tangerine'
    :goal => [0.0, 0.9764706492424011, 0.0, 1.0], #green, paintbrush 'spring'
    :wall => [0.5803921818733215, 0.32156863808631897, 0.0, 1.0], #brown, paintbrush 'mocha'
    :empty => [0.0, 0.0, 0.0, 1.0], #black, paintbrush 'licorice'
  }

  DIMS = {:x => 64, :y => 64}

  def initialize(level)

    super(DIMS[:x] * 10, DIMS[:y] * 10, false)

    self.caption = 'Ruby AI'
    @drawn = []
    @ui = UI.new(self)
    @drawn << @ui
    @tiles = []
    @level = level

    load_level

    @ai = AI.new(@player)
    unless @ai.respond_to?('level', "#{@level}")
      puts "Your AI class must define a method 'level(num)'"
      @player.stop = true
    end
    @ai_tick = 0.5
    @last_ai_update = Time.now
  end

  def load_level
    level_image = Gosu::Image.new(self, "#{Dir.pwd}/levels/level#{@level}.png", false)
    puts "Loading #{level_image.width * level_image.height} tiles."
    image_dims = {:x => level_image.width, :y => level_image.height}

    reverse = {:x => [true, false].sample, :y => [true, false].sample}
    # reverse = {:x => false, :y => false}
    rotate_by = [0, 90, 180, 270].sample
    # rotate_by = 270

    count = 0
    coords = {}
    mods = centering_modifiers(image_dims)

    image_dims[:x].times do |x|
      image_dims[:y].times do |y|
        count += 1
        if count > 99
          print '.'
          count = 0
        end

        coords[:x] = x
        coords[:y] = y

        [:x, :y].each do |dim|
          coords[dim] = image_dims[dim] - 1 - coords[dim] if reverse[dim]
        end

        (rotate_by / 90).times do
          rotate90!(image_dims, coords)
        end

        pixel = level_image.get_pixel(x, y)
        add_tile(pixel, (coords[:x] + mods[:x]) * 10, (coords[:y] + mods[:y]) * 10)
      end
    end
    puts 'Done.'
  end

  def centering_modifiers(image_dims)
    mods = {:x => 0, :y => 0}
    [:x, :y].each do |dim|
      if image_dims[dim] < DIMS[dim]
        diff = DIMS[dim]- image_dims[dim]
        mods[dim] = diff / 2
      end
    end
    mods
  end

  def rotate90!(dims, coords)
    old = coords[:y]
    coords[:y] = coords[:x]
    coords[:x] = dims[:y] - 1 - old
  end

  def add_tile(pixel, x, y)
    if pixel_equal?(pixel, COLORS[:wall])
      wall = Wall.new(self, {:x => x, :y => y})
      @tiles << wall
      @drawn << wall
    elsif pixel_equal?(pixel, COLORS[:player])
      @player = Player.new(self, {:x => x, :y => y})
      @drawn << @player

      empty = Empty.new(self, {:x => x, :y => y})
      @tiles << empty
    elsif pixel_equal?(pixel, COLORS[:goal])
      @goal = Goal.new(self, {:x => x, :y => y})
      @tiles << @goal
      @drawn << @goal
    elsif pixel_equal?(pixel, COLORS[:empty])
      empty = Empty.new(self, {:x => x, :y => y})
      @tiles << empty
    end
  end

  def pixel_equal?(pixel, values)
    4.times do |i|
      return false unless rough_equal?(pixel[i], values[i])
    end
    true
  end

  def rough_equal?(float1, float2)
    one = (float1 * 100).to_i
    two = (float2 * 100).to_i
    one == two
  end

  def update
    if won?
      @ui.text = 'Success! Press <enter> to exit.'
      return
    end

    if @player.stop
      @ui.text = 'Game over. Press <enter> to exit.'
      return
    end

    if @player.pause
      @ui.text = 'Paused. Press <enter> to resume.'
      return
    end

    @ui.text = ''

    if Time.now - @last_ai_update > @ai_tick
      @last_ai_update = Time.now
      @player.send(:moved=, false)
      @ai.level(@level.to_i)
    end
  end

  def won?
    return true if @won
    if @player.x == @goal.x && @player.y == @goal.y
      puts 'Success!'
      @won = true
    end
  end

  def draw
    @drawn.each {|o| o.send(:draw)}
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    elsif id == Gosu::KbReturn
      if @player.stop || @won
        exit
      end
      if @player.pause
        @player.pause = false
      else
        @player.pause = true
      end
    elsif id == Gosu::KbDown
      @ai_tick = @ai_tick * 2 unless @ai_tick > 1
    elsif id == Gosu::KbUp
      @ai_tick = @ai_tick / 2 unless @ai_tick < 0.01
    end
  end


end
