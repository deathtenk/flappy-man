require "gosu"
require_relative "../flappyman.rb"
require_relative "collider.rb"

module Flappyman
  class Pipe < Flappyman::Collider
    attr_accessor :base_speed, :x, :y, :angle

    def initialize
      @image = Gosu::Image.new("#{Flappyman.asset_dir.to_s}/pipe.png")
      @x = @y = @vel_x = @vel_y = @angle = 0.0
      @base_speed = 2.5
    end

    def warp(x, y)
      @x, @y = x, y
    end
 
    def draw
      @image.draw_rot(@x, @y, 1, @angle)
    end
  end
end
