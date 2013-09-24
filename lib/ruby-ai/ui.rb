#prints text on screen

class UI
  attr_accessor :text

  def initialize(window)
    @font = Gosu::Font.new(window, Gosu::default_font_name, 15)
    @text = 'Press <enter> to begin.'
    @width = window.width
    @height = window.height
  end

  def draw
    @font.draw_rel(@text, @width / 2, @height - 20, 3, 0.5, 0.0, 1.0, 1.0, 0xffffff00)
  end
end
