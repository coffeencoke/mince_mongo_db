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
      self.connection = Mongo::Connection.new(Config.database_host)
    end

    def connection=(con)
      @connection = con
      self.db = connection.db(database_name)
      auth
    end

    def auth
      db.authenticate(Config.username, Config.password) if auth_provided?
    end

    def auth_provided?
      !!Config.username && !!Config.password
    end

    def database_name
      Config.database_name
    end
  end

  class Db
    def initialize
      
    end
  end
end
