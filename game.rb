ROOT_PATH = File.dirname(File.expand_path(__FILE__))
require 'chingu'
require './mario'
class Game < Chingu::Window
  def initialize
    super
    @mario = Mario.create
    @mario.input = {holding_left: :move_left,
                    holding_right: :move_right,
                    holding_up: :move_up,
                    holding_down: :move_down,
                    # released_left: :halt_left,
                    # released_right: :halt_right,
                    released_up: :halt_up,
                    released_down: :halt_down }
  end
end

Game.new.show
