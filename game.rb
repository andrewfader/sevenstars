ROOT_PATH = File.dirname(File.expand_path(__FILE__))
require 'chingu'
require './mario'
class Game < Chingu::Window
  def initialize
    super
    @bg = Background.create
    @mario = Mario.create
    @mario.input = {holding_left: :move_left,
                    holding_right: :move_right,
                    holding_up: :move_up,
                    holding_down: :move_down,
                    released_left: :halt,
                    released_right: :halt,
                    released_up: :halt,
                    released_down: :halt,
                    space: :jump}
  end

  def update

    if @mario.x >= self.width
      @bg.x -= 10
      @mario.x -= 5
    end

    if @mario.x <= 0
      @bg.x += 10
      @mario.x += 5
    end

    if @mario.y >= self.height
      @bg.y -= 10
      @mario.y -= 5
    end

    if @mario.y <= 0
      @bg.y += 10
      @mario.y += 5
    end

    super
  end
end

class Background < Chingu::GameObject
  def initialize options={}
    super(options.merge(image: Gosu::Image["./images/light_world.png"]))
    @x = 0
    @y = 0
  end
end

Game.new.show
