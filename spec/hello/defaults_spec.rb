require 'spec_helper'
require 'defaults'

describe 'Defaults' do
  context 'PREFIX' do
    it 'is "Hello"' do
      expect(PREFIX).to eq("Hello")
    end
  end

  context 'NAME' do
    it 'is "world"' do
      expect(NAME).to eq("world")
    end
  end
end
