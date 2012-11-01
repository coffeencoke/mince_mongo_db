module Mince
  module MongoDb
    require 'singleton'
    require_relative 'connection'

    class DataStore
      include Singleton

      def self.collection(collection_name)
        instance.collection(collection_name)
      end

      def self.db
        instance.db
      end

      def collection(collection_name)
        db.collection(collection_name)
      end

      attr_accessor :db

      def initialize
        self.db = Mince::MongoDb::Connection.db
      end
    end
  end
end
