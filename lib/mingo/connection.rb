module Mince
  module Mingo
    require_relative 'config'
    require 'mongo'
    require 'singleton'

    class Connection
      include Singleton

      attr_reader :connection, :db

      def self.connection
        instance.connection        
      end

      def self.db
        instance.db
      end

      def initialize
        @connection = Mongo::Connection.new
        @db = connection.db(database_name)
      end

      # todo: push this into a config class which uses yaml or something like that to pull in the different environment settings?
      def database_name
        Config.database_name
      end
    end
  end
end
