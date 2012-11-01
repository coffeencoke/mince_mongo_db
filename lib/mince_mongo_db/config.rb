module MinceMongoDb # :nodoc:
  require 'singleton'

  # = Config
  #
  # Config specifies the configuration settings
  #
  # @author Matt Simpson
  class Config
    include Singleton

    # Returns the primary key identifier for records.  This is necessary because not all databases use the same
    # primary key.
    #
    # @return [Symbol] the name of the primary key field.
    def self.primary_key
      instance.primary_key
    end

    def self.database_name
      instance.database_name
    end

    def self.database_name=(val)
      instance.database_name = val
    end

    def self.test_env_number
      ENV['TEST_ENV_NUMBER']
    end

    attr_accessor :primary_key, :database_name

    def initialize
      self.primary_key = :_id
      self.database_name = 'mince'
    end

    def database_name=(name)
      @database_name = [name, self.class.test_env_number].compact.join("-")
    end
  end
end
