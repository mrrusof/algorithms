require 'rmagick'

class Grid

  def initialize col_size: 19, row_size: 30, x_margin: 10, y_margin: 30
    @col_size = col_size
    @row_size = row_size
    @x_margin = x_margin
    @y_margin = y_margin
  end

  def x_to_pixels x
    x * @col_size + @x_margin
  end

  def y_to_pixels y
    y * @row_size + @y_margin
  end

  class << self
    def default
      @default ||= Grid.new
    end
  end

end

class Animation

  attr_reader :frames

  def initialize name, w, h, default_delay: 50
    @name = name
    @frames = Magick::ImageList.new
    @frames.new_image w, h
    @default_delay = default_delay
    frame.delay = @default_delay
  end

  def write_frame
    frame.write("#{@name}#{@frames.scene}.gif")
  end

  def write name=@name
    @frames.write("#{name}.gif")
  end

  def next
    @frames << frame.copy
    frame.delay = @default_delay
    self
  end

  def frame
    cur_image
  end

  # So that Draw#annotate works with an instance of Animation
  def cur_image
    @frames.cur_image
  end
end

class Text
  attr_accessor :text, :x, :y

  def initialize canvas, text,
                 color: 'black',
                 bold: false,
                 x: 0,
                 y: 0,
                 size: 32,
                 grid: Grid.default
    @canvas = canvas
    @text = text
    @draw = Magick::Draw.new
    @draw.font_family = 'courier'
    @draw.font_weight = 700 if bold
    @draw.pointsize = size
    @x = x
    @y = y
    @grid = grid
    self.color color
  end

  def put x, y
    putx x
    puty y
    self
  end

  def putx x
    @x = x
    self
  end

  def puty y
    @y = y
    self
  end

  def movex x
    rect = Magick::Draw.new
    rect.fill = 'white'
    rect.rectangle(9 + 19 * @x,
                   9 + 30 * @y,
                   29 + 19 * (@x + @text.length - 1),
                   35 + 30 * @y)
    rect.draw @canvas
    putx x
  end

  def color color
    @color = color
    self
  end

  def pixels_x
    @grid.x_to_pixels @x
  end

  def pixels_y
    @grid.y_to_pixels @y
  end

  def draw
    color = @color
    @draw.annotate(@canvas, 1,1,pixels_x, pixels_y, @text) {
      self.fill = color
    }
    self
  end
end
