require 'sqlite3'
require 'rulers/util'

DB = SQLite3::Database.new 'test.db'

module Rulers
  module Model
    class SQLite
      def initialize(data = nil)
        @hash = data
      end

      def self.table
        Rulers.to_underscore(name)
      end

      def self.schema
        return @schema if @schema
        @schema = {}
        DB.table_info(table) do |row|
          @schema[row['name']] = row['type']
        end
        @schema
      end

      def self.to_sql(val)
        case val
        when Numeric
          val.to_s
        when String
          "'#{val}'"
        else
          raise "Can't change #{val} to SQL!"
        end
      end
    end
  end
end
