# frozen_string_literal: true

require 'handler'

class ErrorHandler < Handler
  def http404
    status = '404'
    headers = { 'Content-Type' => 'text/html' }
    response(status, headers) do
      erb(:not_found)
    end
  end
end
