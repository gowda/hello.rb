# frozen_string_literal: true

require 'app'

describe App do
  describe 'GET /' do
    it 'returns 200 status' do
      get '/'

      expect(last_response.headers['Content-Type']).to eql('text/html')
      expect(last_response.status).to eql(200)
    end

    it 'returns "hello world" in body' do
      content = <<~CONTENT
        <html>
          <body>
            <h2>hello world!</h2>
          </body>
        </html>
      CONTENT

      get '/'

      expect(last_response.headers['Content-Type']).to eql('text/html')
      expect(last_response.body).to eql(content)
    end
  end

  describe 'GET /non-existent' do
    it 'returns 404 status' do
      get '/non-existent'

      expect(last_response.headers['Content-Type']).to eql('text/html')
      expect(last_response.status).to eql(404)
    end

    it 'returns "not found" in body' do
      content = <<~CONTENT
        <html>
          <body>
            <h4>not found</h4>
          </body>
        </html>
      CONTENT
      get '/non-existent'

      expect(last_response.headers['Content-Type']).to eql('text/html')
      expect(last_response.body).to eql(content)
    end
  end
end
