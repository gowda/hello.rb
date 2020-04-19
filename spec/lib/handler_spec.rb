# frozen_string_literal: true

require 'handler'

describe Handler do
  class TestHandler < Handler
  end

  subject { TestHandler.new({}) }

  describe 'erb' do
    context 'when file is missing' do
      it 'raises exception on missing file' do
        expect { subject.erb(:missing) }.to raise_error(Errno::ENOENT)
      end
    end

    describe 'local variable' do
      before do
        allow(File).to receive(:read)
          .with(File.expand_path('../../app/views/with_message.erb', __dir__))
          .and_return('<%= message %>')
      end

      describe 'when missing' do
        it 'renders blank for variable' do
          expect(subject.erb(:with_message)).to match('')
        end
      end

      describe 'when present' do
        let(:message) { 'hello world' }

        it 'renders blank for variable' do
          expect(subject.erb(:with_message, message: message)).to match('')
        end
      end
    end
  end

  describe 'response' do
    describe 'body' do
      let(:status) { '200' }
      let(:headers) { {} }

      context 'when missing' do
        it 'returns a rack response' do
          expect(subject.response(status, headers)).to eql(
            [status, headers, ['']]
          )
        end
      end

      context 'when string' do
        let(:body) { 'hello world' }

        it 'returns a rack response' do
          expect(subject.response(status, headers, 'hello world')).to eql(
            [status, headers, [body]]
          )
        end
      end

      context 'when block' do
        let(:body) { 'hello world' }

        it 'returns result of block in body' do
          expect(subject.response(status, headers) { body }).to eql(
            [status, headers, [body]]
          )
        end
      end

      context 'when string & block' do
        let(:string_body) { 'string body' }
        let(:block_body) { 'block body' }

        it 'returns result of block in body' do
          expect(
            subject.response(status, headers, string_body) { block_body }
          ).to eql(
            [status, headers, [block_body]]
          )
        end
      end
    end

    describe 'status' do
      let(:status) { '200' }
      let(:headers) { {} }

      context 'when nil' do
        it 'returns 200 as status' do
          expect(subject.response(nil, headers)[0]).to eql('200')
        end
      end

      context 'when blank' do
        it 'returns 200 as status' do
          expect(subject.response('  ', headers)[0]).to eql('200')
        end
      end
    end

    describe 'headers' do
      let(:status) { '200' }
      let(:headers) { { key: :value } }

      it 'returns the headers as is' do
        expect(subject.response(status, headers)[1]).to eql(headers)
      end
    end
  end
end
