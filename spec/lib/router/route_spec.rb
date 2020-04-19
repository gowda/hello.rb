# frozen_string_literal: true

require 'router/route'

describe Route do
  describe 'execute' do
    context 'when class is missing' do
      let(:path) { '/path' }
      let(:env) { Rack::MockRequest.env_for(path) }
      let(:route_array) do
        [path, { klass: 'NonExistentClass', method: :path }]
      end

      subject { described_class.new(route_array) }

      it 'raises an exception' do
        expect { subject.execute(env) }.to raise_error(NameError)
      end
    end

    context 'when method is missing' do
      class Testnomethodhandler
        def initialize(_)
        end
      end

      let(:path) { '/path' }
      let(:env) { Rack::MockRequest.env_for(path) }
      let(:route_array) do
        [path, { klass: 'testnomethodhandler', method: :path }]
      end

      subject { described_class.new(route_array) }

      it 'raises an exception' do
        expect { subject.execute(env) }.to raise_error(NoMethodError)
      end
    end

    context 'when class & method are present' do
      class Testhandler
        def initialize(_)
        end

        def path
          'hello world'
        end
      end

      let(:path) { '/path' }
      let(:env) { Rack::MockRequest.env_for(path) }
      let(:route_array) { [path, { klass: 'testhandler', method: :path }] }

      subject { Route.new(route_array) }

      it 'raises an exception' do
        expect(subject.execute(env)).to eql('hello world')
      end
    end
  end
end
