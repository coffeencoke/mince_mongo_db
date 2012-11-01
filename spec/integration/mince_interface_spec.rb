require_relative '../../lib/mince_mongo_db'
require 'mince/shared_examples/interface_example'

describe 'Mince Interface with MongoDb' do
  before do
    Mince::Config.interface = MinceMongoDb::Interface
  end

  it_behaves_like 'a mince interface'
end

