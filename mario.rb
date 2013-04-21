require 'debugger'
class Mario < Chingu::GameObject
  def button_down?(*args)
    $window.button_down?(*args)
  end

  def initialize options={}
    super(options.merge(image: Gosu::Image["./images/marioD02.gif"]))
    @x = 200
    @y = 200
  end

  [nil,"d","u"].each do |ud|
    [nil,"r","l"].each do |rl|
      next if ud == rl
      var = "#{ud}#{rl}".to_sym
      ivar = "@#{var.to_s}".to_sym
      define_method var do
        if set_ivar = instance_variable_get(ivar)
          set_ivar
        else
          instance_variable_set(ivar, Chingu::Animation.new(frames:
            [Gosu::Image.new($window, "./images/mario#{ud ? ud.upcase : ""}#{rl ? rl.upcase : ""}02.gif"),
            Gosu::Image.new($window, "./images/mario#{ud ? ud.upcase : ""}#{rl ? rl.upcase : ""}03.gif"),
            Gosu::Image.new($window, "./images/mario#{ud ? ud.upcase : ""}#{rl ? rl.upcase : ""}01.gif")])
          )
        end
      end
    end
  end

  def move_left
    @x -= 2
    unless button_down?(Gosu::KbUp)
      @image = l.next
    end
  end

  def move_right
    @x += 2
    unless button_down?(Gosu::KbDown) || button_down?(Gosu::KbUp)
      @image = r.next
    end
  end

  def move_up
    @y -= 2
    if button_down?(Gosu::KbLeft)
      @image = ul.next
    elsif button_down?(Gosu::KbRight)
      @image = ur.next
    else
      @image = u.next
    end
  end

  def move_down
    @y += 2
    if button_down?(Gosu::KbLeft)
      @image = dl.next
    elsif button_down?(Gosu::KbRight)
      @image = dr.next
    else
      @image = d.next
    end
  end

  def halt
    [nil,"d","u"].each do |ud|
      [nil,"r","l"].each do |rl|
        next if ud == rl
        animation = self.send("#{ud}#{rl}".to_sym)
        if animation.frames.include? @image
          @image = animation.next while @image != animation.frames.first
        end
      end
    end
  end

end
