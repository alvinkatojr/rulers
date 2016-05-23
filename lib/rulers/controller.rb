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

    def instance_vars
      vars = {}
      instance_variables.each do |name|
        vars[name[1..-1]] = instance_variable_get name.to_sym
      end
      vars
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
      Rulers.to_underscore klass
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
