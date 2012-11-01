module MinceMongoDb
  require_relative 'config'
  require 'mongo'
  require 'singleton'

  class Connection
    include Singleton

    attr_accessor :connection, :db

    def self.connection
      instance.connection
    end

    def self.db
      instance.db
    end

    def initialize
      self.connection = Mongo::Connection.new
    end

    def connection=(con)
      @connection = con
      self.db = connection.db(database_name)
    end

    def database_name
      Config.database_name
    end
  end
end
