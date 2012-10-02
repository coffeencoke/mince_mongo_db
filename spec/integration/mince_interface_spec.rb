require_relative '../../lib/mingo'
require 'mince/shared_examples/interface_example'

describe 'Mince Interface with Mingo' do
  before do
    Mince::Config.interface = Mince::Mingo::Interface
  end

  after do
    Mince::Mingo::Interface.clear
  end

  it_behaves_like 'a mince interface'
end

