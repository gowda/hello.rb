# frozen_string_literal: true

require 'router'
require 'router/route'

describe Router do
  subject { described_class.new }

  describe 'get' do
    let(:path) { '/path' }
    let(:route_array) { [path, { klass: 'test', method: 'path' }] }

    before { subject.get(path, to: 'test#path') }

    it 'adds route' do
      expect(subject.routes).to eql({ get: [route_array] })
    end
  end

  describe 'configure' do
    let(:route_array) { ['/path', { klass: 'test', method: 'path' }] }

    before do
      subject.configure do
        get '/path', to: 'test#path'
      end
    end

    it 'returns the configured path' do
      expect(subject.routes).to eql({ get: [route_array] })
    end
  end

  describe 'route for' do
    context 'when path is a string' do
      let(:path) { '/path' }
      let(:route) { Route.new([path, { klass: 'test', method: 'index' }]) }

      context 'matching path' do
        let(:env) { Rack::MockRequest.env_for(path) }

        before do
          subject.get(path, to: 'test#index')
        end

        it 'returns a route' do
          expect(subject.route_for(env)).to eql(route)
        end
      end

      context 'not matching path' do
        let(:env) { Rack::MockRequest.env_for('/non-existent') }

        it 'returns nil' do
          expect(subject.route_for(env)).to eql(nil)
        end
      end
    end

    context 'when path is a regular expression' do
      let(:path) { '/path' }
      let(:path_re) { /patc?h/ }
      let(:route) { Route.new([path_re, { klass: 'test', method: 'index' }]) }

      before do
        subject.get(path_re, to: 'test#index')
      end

      context 'matching path' do
        let(:env) { Rack::MockRequest.env_for(path) }

        it 'returns a route' do
          expect(subject.route_for(env)).to eql(route)
        end
      end

      context 'not matching path' do
        let(:env) { Rack::MockRequest.env_for('/non-existent') }

        it 'returns nil' do
          expect(subject.route_for(env)).to eql(nil)
        end
      end
    end
  end
end
