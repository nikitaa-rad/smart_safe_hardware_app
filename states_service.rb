require 'net/http'
require 'json'

require_relative 'environment'
require_relative 'system_data_loader'

class StatesService
  include Environment
  include SystemDataLoader

  def self.call
    new.call
  end

  def call
    response = get_state

    state = parse_state(response.body)

    state
  end

  private

  def get_state
    http = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Get.new(uri.request_uri)
    request['Secret-Key'] = secret_key

    http.request(request)
  end

  def parse_state(body)
    state = JSON.parse(body)

    state['locked']
  end

  def uri
    @uri ||= URI.parse("#{initial_uri}/#{box_id}")
  end
end
