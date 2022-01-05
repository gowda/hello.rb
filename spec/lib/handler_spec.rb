# frozen_string_literal: true

require 'handler'

class TestHandler < Handler
end

describe Handler do
  subject { TestHandler.new({}) }

  describe 'erb' do
    describe 'layout' do
      context 'when missing' do
        before do
          allow(File).to receive(:read)
            .with(File.expand_path('../../app/views/layout.erb', __dir__))
            .and_raise(Errno::ENOENT.new('No such file or directory'))
        end

        context 'without locals' do
          before do
            allow(File).to receive(:read)
              .with(File.expand_path('../../app/views/template.erb', __dir__))
              .and_return('test message')
          end

          it 'renders only the template' do
            expect(subject.erb(:template)).to eql('test message')
          end
        end

        context 'with locals' do
          before do
            allow(File).to receive(:read)
              .with(File.expand_path('../../app/views/template.erb', __dir__))
              .and_return('<%= message %>')
          end

          it 'renders only the template' do
            expect(subject.erb(:template, message: 'test message'))
              .to eql('test message')
          end
        end
      end

      context 'when present' do
        before do
          allow(File).to receive(:read)
            .with(File.expand_path('../../app/views/layout.erb', __dir__))
            .and_return('wrapped <%= yield %> message')
        end

        context 'without locals' do
          before do
            allow(File).to receive(:read)
              .with(File.expand_path('../../app/views/template.erb', __dir__))
              .and_return('test content')
          end

          it 'renders only the template' do
            expect(subject.erb(:template)).to eql(
              'wrapped test content message'
            )
          end
        end

        context 'with locals' do
          before do
            allow(File).to receive(:read)
              .with(File.expand_path('../../app/views/template.erb', __dir__))
              .and_return('<%= message %>')
          end

          it 'renders only the template' do
            expect(subject.erb(:template, message: 'test content'))
              .to eql('wrapped test content message')
          end
        end
      end
    end

    context 'when template file is missing' do
      before do
        allow(File).to receive(:read)
          .with(File.expand_path('../../app/views/layout.erb', __dir__))
          .and_return('<%= yield %>')

        allow(File).to receive(:read)
          .with(File.expand_path('../../app/views/missing.erb', __dir__))
          .and_raise(Errno::ENOENT.new('No such file or directory'))
      end

      it 'raises exception on missing file' do
        expect { subject.erb(:missing) }.to raise_error(Errno::ENOENT)
      end
    end

    describe 'local variable' do
      before do
        allow(File).to receive(:read)
          .with(File.expand_path('../../app/views/layout.erb', __dir__))
          .and_return('<%= yield %>')

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
