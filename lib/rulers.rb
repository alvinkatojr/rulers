require "rulers/version"
require "rulers/routing"
require "rulers/util"
require "rulers/depencies"

module Rulers
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico' ||
         env['PATH_INFO'] == '/apple-touch-icon-precomposed.png' ||
         env['PATH_INFO'] == '/apple-touch-icon.png'
        return [404, {'Content-Type' => 'text/html'}, []]
      end

      if env['PATH_INFO'] == '/'
        return [200, {'Content-Type' => 'text/html'}, [File.read "public/index.html"]]
        # Sets the home controller and index action
        # env={'PATH_INFO' => '/home/index.html'}

        # Sets a redirect
        # return [301, { 'Location' => '/home/index.html'}, []]
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
end
