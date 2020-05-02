require 'net/http'
require_relative 'environment.rb'

class StatesService
  include Environment

  SECRET_KEY = 'secret_key'

  def initialize(initial_uri:)
    @initial_uri = initial_uri
  end

  def self.call(*args)
    new(*args).call
  end

  def call
    response = get_state

    parse_state(response)
  end

  private

  def get_state
    Net::HTTP.post_form(uri, secret_key: SECRET_KEY)
  end

  def parse_state(response)
    state = JSON.parse(response)

    state['locked']
  end

  def uri
    @uri ||= URI(initial_uri)
  end
end

StatesService.call(initial_uri: 'test')