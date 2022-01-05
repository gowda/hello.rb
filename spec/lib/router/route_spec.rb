# frozen_string_literal: true

require 'router/route'

class TestNoMethodHandler
  def initialize(_)
  end
end

class TestHandler
  def initialize(_)
  end

  def path
    'hello world'
  end
end

describe Route do
  describe 'execute' do
    context 'when class is missing' do
      let(:path) { '/path' }
      let(:env) { Rack::MockRequest.env_for(path) }
      let(:route_array) do
        [path, { klass: 'non_existent_class', method: :path }]
      end

      subject { described_class.new(route_array) }

      it 'raises an exception' do
        expect { subject.execute(env) }.to raise_error(NameError)
      end
    end

    context 'when method is missing' do
      let(:path) { '/path' }
      let(:env) { Rack::MockRequest.env_for(path) }
      let(:route_array) do
        [path, { klass: 'test_no_method_handler', method: :path }]
      end

      subject { described_class.new(route_array) }

      it 'raises an exception' do
        expect { subject.execute(env) }.to raise_error(NoMethodError)
      end
    end

    context 'when class & method are present' do
      let(:path) { '/path' }
      let(:env) { Rack::MockRequest.env_for(path) }
      let(:route_array) { [path, { klass: 'test_handler', method: :path }] }

      subject { Route.new(route_array) }

      it 'raises an exception' do
        expect(subject.execute(env)).to eql('hello world')
      end
    end
  end
end
