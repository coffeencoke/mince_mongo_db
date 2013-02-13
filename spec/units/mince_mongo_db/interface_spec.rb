require_relative '../../../lib/mince_mongo_db/interface'

describe MinceMongoDb::Interface do

  let(:interface) { described_class }
  let(:primary_key) { MinceMongoDb::Config.primary_key }

  let(:db) { mock 'mongo database' }
  let(:mongo_data_store_connection) { mock 'mongo_data_store_connection', :db => db}
  let(:collection) { mock 'some collection'}
  let(:collection_name) { 'some_collection_name'}
  let(:primary_key) { mock 'primary key'}
  let(:mock_id) { mock 'id' }
  let(:data) { { primary_key => mock_id}}
  let(:return_data) { mock 'return data' }

  before do
    MinceMongoDb::DataStore.stub(:db).and_return(db)
    MinceMongoDb::DataStore.stub(:collection).with(collection_name).and_return(collection)
    MinceMongoDb::Config.stub(primary_key: primary_key)
  end

  it 'uses the correct collection' do
    interface.collection(collection_name).should == collection
  end

  it 'can delete a field' do
    field = mock 'field to delete'
    collection.should_receive(:update).with({}, {'$unset' => { field => 1 } }, multi: true)

    interface.delete_field(collection_name, field)
  end

  it 'can delete all records the match a given set of params' do
    params = mock 'params to condition the deleted records to'
    collection.should_receive(:remove).with(params)

    interface.delete_by_params(collection_name, params)
  end

  it 'can delete a collection' do
    collection.should_receive(:drop)

    interface.delete_collection(collection_name)
  end

  describe "Generating a primary key" do
    let(:unique_id) { mock 'id' }
    it 'should create a reasonably unique id' do
      BSON::ObjectId.should_receive(:new).and_return(unique_id)

      described_class.generate_unique_id('something').should == unique_id.to_s
    end
  end

  it 'can write to the collection' do
    collection.should_receive(:insert).with(data).and_return(return_data)

    interface.add(collection_name, data).should == return_data
  end

  it 'can update a field with a specific value' do
    key = mock 'key'
    value = mock 'value'
    id = mock 'id'
    collection.should_receive(:update).with({ primary_key => id }, { '$set' => { key => value } })

    interface.update_field_with_value collection_name, id, key, value
  end

  it 'can increment a field by a specific amount' do
    key = mock 'key'
    amount = mock 'amount to increment the field by'
    id = mock 'id'
    collection.should_receive(:update).with({ primary_key => id }, { '$inc' => { key => amount } })

    interface.increment_field_by_amount collection_name, id, key, amount
  end

  it 'can read from the collection' do
    collection.should_receive(:find).and_return(return_data)

    interface.find_all(collection_name).should == return_data
  end
  
  it 'can find a record by id' do
    collection.should_receive(:find_one).with(primary_key.to_s => mock_id).and_return(return_data)

    interface.find(collection_name, mock_id).should == return_data
  end

  it 'can replace a record' do
    collection.should_receive(:update).with({primary_key => data[primary_key]}, data)

    interface.replace(collection_name, data)
  end

  it 'can get one document' do
    field = "stuff"
    value = "more stuff"
    mongo_scope = mock first: return_data

    collection.should_receive(:find).with(field => value).and_return(mongo_scope)

    interface.get_for_key_with_value(collection_name, field, value).should == return_data
  end

  it 'can clear the data store' do
    collection_names = %w(collection_1 collection_2 system_profiles)
    db.stub(:collection_names => collection_names)

    db.should_receive(:drop_collection).with('collection_1')
    db.should_receive(:drop_collection).with('collection_2')

    interface.clear
  end

  it 'can get all records of a specific key value' do
    collection.should_receive(:find).with({"key" => "value"}).and_return(return_data)

    interface.get_all_for_key_with_value(collection_name, "key", "value").should == return_data
  end

  it 'can get a record of a specific key value' do
    collection.should_receive(:find).with({"key" => "value"}).and_return([return_data])

    interface.get_for_key_with_value(collection_name, "key", "value").should == return_data
  end

  it 'can get all records where a value includes any of a set of values' do
    collection.should_receive(:find).with({"key1" => { "$in" => [1,2,4]} }).and_return(return_data)

    interface.containing_any(collection_name, "key1", [1,2,4]).should == return_data
  end

  it 'can get all records where the array includes a value' do
    collection.should_receive(:find).with({"key" => "value"}).and_return(return_data)

    interface.array_contains(collection_name, "key", "value").should == return_data
  end

  it 'can push a value to an array for a specific record' do
    collection.should_receive(:update).with({interface.primary_key.to_s => "value"}, { '$push' => { "array_key" => "value_to_push"}}).and_return(return_data)

    interface.push_to_array(collection_name, "value", :array_key, "value_to_push").should == return_data
  end

  it 'can remove a value from an array for a specific record' do
    collection.should_receive(:update).with({interface.primary_key.to_s => "value"}, { '$pull' => { "array_key" => "value_to_remove"}}).and_return(return_data)

    interface.remove_from_array(collection_name, "value", :array_key, "value_to_remove").should == return_data
  end
end
