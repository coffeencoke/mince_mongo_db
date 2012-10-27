require_relative '../../../lib/mingo/data_store'

describe Mince::Mingo::DataStore do
  let(:db) { mock }
  let(:collection) { mock }
  let(:collection_name) { mock }

  before do
    described_class.instance.db = db
  end

  it 'can return a specific collection and provides access to the db' do
    db.stub(:collection).with(collection_name).and_return(collection)

    described_class.collection(collection_name).should == collection
    described_class.db.should == db
  end
end
