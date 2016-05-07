require_relative "flappyman/window.rb"
require_relative "flappyman/player.rb"
require "pathname"

module Flappyman
  module_function

  def run
    window = Flappyman::Window.new
    window.show
  end

  def asset_dir
    Pathname.new("#{Dir.pwd}/assets")
  end

  def restart
    run
  end

  def quit(window)
    window.close
  end
end
