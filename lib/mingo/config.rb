module Mince # :nodoc:
  module Mingo # :nodoc:
    require 'singleton'

    # = HashyDb Config
    #
    # HashyDb Config specifies the configuration settings for HashyDb
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

      attr_accessor :primary_key, :database_name

      def initialize
        self.primary_key = :_id
        self.database_name = 'mince'
      end

      def database_name=(name)
        env_suffix = if test_env_number.nil? || test_env_number == ''
          ""
        else
          "-#{ENV['TEST_ENV_NUMBER']}"
        end
        @database_name = "#{name}#{env_suffix}"
      end

      def test_env_number
        ENV['TEST_ENV_NUMBER']
      end
    end
  end
end

