require 'rulers/version'
require 'rulers/routing'
require 'rulers/util'
require 'rulers/dependencies'
require 'rulers/controller'
require 'rulers/file_model'

module Rulers
  class Application
    def call(env)
      @start_time = Time.now
      if env['PATH_INFO'] == '/favicon.ico' ||
         env['PATH_INFO'] == '/apple-touch-icon-precomposed.png' ||
         env['PATH_INFO'] == '/apple-touch-icon.png'
        return [404, { 'Content-Type' => 'text/html' }, []]
      end

      if env['PATH_INFO'] == '/'
        return [200, { 'Content-Type' => 'text/html' }, [File.read('public/index.html')]]
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
        return [500, { 'Content-Type' => 'text/html' }, ['You goofed up!']]
      end

      [200, { 'Content-Type' => 'text/html' }, [text]]
    end

    def controller_name
      self.class
    end

    def user_agent
      @env[]
    end

    def request_start_time
      @start_time
    end

    def rulers_version
      Rulers::VERSION
    end
  end
end
