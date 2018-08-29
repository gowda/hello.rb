require 'spec_helper'
require 'json'
require 'hello'

describe Hello do
  samples = JSON.parse(fixture_file('samples.json').read)
  samples.each do |sample|
    context "when #{name}" do
      it "greets" do
        expect(Hello.new(sample['name']).greet).to eq(sample['greeting'])
      end
    end
  end
end
