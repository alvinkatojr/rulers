require "rulers/version"
require "rulers/routing"

module Rulers
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico' ||
         env['PATH_INFO'] == '/apple-touch-icon-precomposed.png' ||
         env['PATH_INFO'] == '/apple-touch-icon.png'
        return [404, {'Content-Type' => 'text/html'}, []]
      end

      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      begin
        text = controller.send(act)
      rescue Exception
        return [500, {'Content-Type' => 'text/html'}, ["You goofed up!"]]
      end

      [200, {'Content-Type' => 'text/html'}, [text]]
    end
  end
  class Controller
    def initialize(env)
      @env = env
    end

    def env
      @env
    end
  end
end
