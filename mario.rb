# require 'chingu'
class Mario < Chingu::GameObject
  ANIMATION_SPEED = 8
  def button_down?(*args)
    $window.button_down?(*args)
  end

  def initialize options={}
    super(options.merge(image: Gosu::Image["./images/marioD02.gif"]))
    @counter = 0
  end

  def move_left
    @x -= 2
    if @down || button_down?(Gosu::KbDown)
      @image = Gosu::Image["./images/marioDL02.gif"]
    elsif @up || button_down?(Gosu::KbUp)
      @image = Gosu::Image["./images/marioUL02.gif"]
    else
      @image = Gosu::Image["./images/marioL02.gif"]
    end

    count
    @left = true
  end

  def count
    if @counter == ANIMATION_SPEED
      @up = false
      @down = false
      @left = false
      @right = false
      @counter = 0
    else
      @counter+=1
    end
  end

  def move_right
    @x += 2
    if @down || button_down?(Gosu::KbDown)
      @image = Gosu::Image["./images/marioDR02.gif"]
    elsif @up || button_down?(Gosu::KbUp)
      @image = Gosu::Image["./images/marioUR02.gif"]
    else
      @image = Gosu::Image["./images/marioR02.gif"]
    end
    count
    @right = true
  end

  def halt_left

  end

  def halt_right

  end

  def move_up
    @y -= 2
    if @left || button_down?(Gosu::KbLeft)
      @image = Gosu::Image["./images/marioUL02.gif"]
    elsif @right || button_down?(Gosu::KbRight)
      @image = Gosu::Image["./images/marioUR02.gif"]
    else
      @image = Gosu::Image["./images/marioU02.gif"]
    end
    count
    @up = true
  end

  def move_down
    @y += 2
    if @left || button_down?(Gosu::KbLeft)
      @image = Gosu::Image["./images/marioDL02.gif"]
    elsif @right || button_down?(Gosu::KbRight)
      @image = Gosu::Image["./images/marioDR02.gif"]
    else
      @image = Gosu::Image["./images/marioD02.gif"]
    end
    count
    @down = true
  end

  def halt_up
  end

  def halt_down
  end
end
