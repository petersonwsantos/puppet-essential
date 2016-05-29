require 'spec_helper'
describe 'essential' do
  context 'with default values for all parameters' do
    it { should contain_class('essential') }
  end
end
