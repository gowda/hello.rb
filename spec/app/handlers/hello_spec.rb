# frozen_string_literal: true

require 'hello'

describe Hello do
  describe 'index' do
    context 'when missing' do
      it 'returns response' do
        status, headers, = Hello.new({}).index

        expect(status).to eql('200')
        expect(headers).to eql({ 'Content-Type' => 'text/html' })
      end
    end
  end
end
