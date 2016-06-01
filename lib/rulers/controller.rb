require 'rulers/file_model'
require 'erubis'
require 'rack/request'

module Rulers
  class Controller
    include Rulers::Model
    attr_reader :env

    def initialize(env)
      @env = env
    end

    def request
      @request ||= Rack::Request.new(@env)
    end

    def params
      request.params
    end

    def response(text, status = 200, headers = {})
      raise 'Already responded!' if @response
      a = [text].flatten
      @response = Rack::Response.new(a, status, headers)
    end

    def get_response # Only for Rulers
      @response
    end

    def render_response(*args)
      response(render(*args))
    end

    def instance_vars
      vars = {}
      instance_variables.each do |name|
        vars[name[1..-1]] = instance_variable_get(name.to_sym)
      end
      vars
    end

    def instance_hash
      h = {}
      instance_variables.each do |i|
        h[i] = instance_variable_get(i)
      end
      h
    end

    # Alternative render that uses view object
    def render(view_name, locals={})
      filename = File.join 'app', 'views', controller_name, "#{view_name}.html.erb"
      template = File.read filename
      v = View.new
      v.set_vars(instance_hash)
      v.evaluate(template)
    end

    def render(view_name, locals = instance_vars)
      filename = File.join 'app', 'views', controller_name, "#{view_name}.html.erb"
      template = File.read filename
      eruby = Erubis::Eruby.new(template)
      eruby.result(locals.merge(:env => env))
    end

    def controller_name
      klass = self.class
      klass = klass.to_s.gsub(/Controller$/, '')
      Rulers.to_underscore(klass)
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
