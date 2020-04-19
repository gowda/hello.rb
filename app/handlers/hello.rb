# frozen_string_literal: true

require 'handler'

class Hello < Handler
  def index
    status = '200'
    headers = { 'Content-Type' => 'text/html' }
    response(status, headers) do
      erb(:index)
    end
  end
end
