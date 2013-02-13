module MinceMongoDb
  module Interface
    require_relative 'data_store'
    require_relative 'config'

    def self.generate_unique_id(*args)
      BSON::ObjectId.new.to_s
    end

    def self.primary_key
      Config.primary_key
    end

    def self.delete_field(collection_name, key)
      collection(collection_name).update({}, {"$unset" => { key => 1 } }, multi: true)
    end

    def self.delete_by_params(collection_name, params)
      collection(collection_name).remove(params)
    end

    def self.add(collection_name, hash)
      collection(collection_name).insert(hash)
    end

    def self.replace(collection_name, hash)
      collection(collection_name).update({primary_key => hash[primary_key]}, hash)
    end

    def self.update_field_with_value(collection_name, primary_key_value, field_name, new_value)
      collection(collection_name).update({primary_key => primary_key_value}, {'$set' => { field_name => new_value } })
    end

    def self.increment_field_by_amount(collection_name, primary_key_value, field_name, amount)
      collection(collection_name).update({primary_key => primary_key_value}, {'$inc' => { field_name => amount } })
    end

    def self.get_all_for_key_with_value(collection_name, key, value)
      get_by_params(collection_name, key.to_s => value)
    end

    def self.get_for_key_with_value(collection_name, key, value)
      get_all_for_key_with_value(collection_name, key, value).first
    end

    def self.get_by_params(collection_name, hash)
      collection(collection_name).find(hash)
    end

    def self.find_all(collection_name)
      collection(collection_name).find
    end

    def self.find(collection_name, value)
      collection(collection_name).find_one({primary_key.to_s => value})
    end

    def self.push_to_array(collection_name, identifying_value, array_key, value_to_push)
      collection(collection_name).update({primary_key.to_s => identifying_value}, {'$push' => {array_key.to_s => value_to_push}})
    end

    def self.remove_from_array(collection_name, identifying_value, array_key, value_to_remove)
      collection(collection_name).update({primary_key.to_s => identifying_value}, {'$pull' => {array_key.to_s => value_to_remove}})
    end

    def self.containing_any(collection_name, key, values)
      collection(collection_name).find({key.to_s => {"$in" => values}})
    end

    def self.array_contains(collection_name, key, value)
      collection(collection_name).find(key.to_s => value)
    end

    def self.clear
      db.collection_names.each do |collection_name|
        db.drop_collection collection_name unless collection_name.include?('system')
      end
    end

    def self.delete_collection(collection_name)
      collection(collection_name).drop
    end

    def self.insert(collection_name, data)
      data.each do |datum|
        add collection_name, datum
      end
    end

    def self.set_data(data)
      clear

      data.each do |key, value|
        insert key, value
      end
    end

    def self.data
      db.collection_names.map do |collection_name|
        find_all collection_name
      end
    end

    def self.collection(collection_name)
      DataStore.collection(collection_name)
    end

    def self.db
      DataStore.db
    end
  end
end
