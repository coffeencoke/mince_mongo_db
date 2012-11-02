require_relative '../../../lib/mince_mongo_db/connection'

describe MinceMongoDb::Connection do
  subject { described_class.instance }

  let(:mongo_connection) { mock 'a mongo connection object', :db => db }
  let(:db) { mock 'db'}
  let(:database_name) { mock }

  before do
    MinceMongoDb::Config.stub(database_name: database_name)
    subject.connection = mongo_connection
  end

  it 'is a mongo connection' do
    subject.connection.should == mongo_connection
  end
end
