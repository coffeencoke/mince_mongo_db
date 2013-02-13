module MinceMongoDb # :nodoc:
  require 'singleton'

  # = Config
  #
  # Config specifies the configuration settings
  #
  # @author Matt Simpson
  class Config
    include Singleton

    class << self
      getters = %w(primary_key)
      accessors = %w(database_name database_host username password)

      getters+accessors.each do |field|
        define_method(field) do
          instance.send(field)
        end
      end

      accessors.each do |field|
        define_method("#{field}=") do |val|
          instance.send("#{field}=", val)
        end
      end
    end

    # Returns the primary key identifier for records.  This is necessary because not all databases use the same
    # primary key.
    #
    # @return [Symbol] the name of the primary key field.
    def self.primary_key
      instance.primary_key
    end

    # Returns the name of the database mince is configured to connect to
    def self.database_name
      instance.database_name
    end

    # Sets the name of the database mince is configured to use
    def self.database_name=(val)
      instance.database_name = val
    end

    # Returns the host of the mongo database
    def self.database_host
      instance.database_host
    end

    # Sets the host of the mongo database
    def self.database_host=(val)
      instance.database_host = val
    end

    # Returns the test environment number, useful for when testing with multiple
    # processes in parallel
    def self.test_env_number
      ENV['TEST_ENV_NUMBER']
    end

    attr_accessor :primary_key, :database_name, :database_host, :username, :password

    def initialize
      self.primary_key = '_id'
      self.database_name = 'mince'
      self.database_host = '127.0.0.1'
    end

    def database_name=(name)
      @database_name = [name, self.class.test_env_number].compact.join("-")
    end
  end
end
