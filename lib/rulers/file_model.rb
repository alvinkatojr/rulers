require "multi_json"

module Rulers
  module Model
    class FileModel
      def initialize(filename)
        @filename = filename

        # if filename is "dir/7.json, @id is 7"
        basename = File.split(filename)[-1]
        @id = File.basename(basename, ".json").to_i

        obj = File.read(filename)
        @hash = MultiJson.load(obj)
      end
    end
  end
end
