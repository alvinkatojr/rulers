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

      def self.create(values)
        values.delete "id"
        keys = schema.keys - ["id"]
        vals = keys.map do |key|
          if values[key]
            to_sql(values[key])
          else
            "null"
          end
        end

        DB.execute<<~SQL
        INSERT INTO #{table} (#{keys.join ","})
        SQL

        raw_vals = keys.map { |k| values[k] }
        data = Hash[keys.zip raw_vals]
        sql = "SELECT last_insert_rowid();"
        data['id'] = DB.execute(sql)[0][0]
        self.new(data)
      end

      def self.count
        DB.execute(<<~SQL)[0][0]
        SELECT COUNT(*) FROM #{table}
        SQL
      end
    end
  end
end
