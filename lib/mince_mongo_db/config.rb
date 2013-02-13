module MinceMongoDb # :nodoc:
  require 'singleton'

  # = Config
  #
  # Config specifies the configuration settings
  #
  # @author Matt Simpson
  #
  # The following fields can be changed:
  # * database_name - Defaults to 'mince'
  # * database_host - Defaults to '127.0.0.1'
  # * username - Defaults to nil
  # * password - Defaults to nil
  #
  # The following fields cannot be changed:
  # * primary_key
  # * test_env_number
  #
  # You can change a field by passing a hash:
  #
  #   MinceMongoDb::Config.options = {
  #     username: 'my_db_user',
  #     password: 'my_db_passw0rd'
  #   }
  #
  # Or you can change a field individually:
  #
  #   MinceMongoDb::Config.username = 'my_db_user'
  #
  # If you are running tests in parallel, make sure that
  # ENV['TEST_ENV_NUMBER'] is set for the instance number for each
  # parallel test.  This number is amended to the database name.
  class Config
    include Singleton

    OPTIONS = %w(database_name database_host username password)

    class << self
      getters = %w(primary_key)
      accessors = OPTIONS

      (getters+accessors).each do |field|
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

    def self.options
      {
        database_name: database_name,
        database_host: database_host,
        username: username,
        password: password
      }
    end

    def self.options=(new_options)
      whitelist_keys(new_options).each do |key, value|
        send("#{key}=", value)
      end
    end

    def self.whitelist_keys(options)
      options.select{|key, value| OPTIONS.include?(key.to_s) }
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
