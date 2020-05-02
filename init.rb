require 'net/http'
require 'json'

require_relative 'environment'
require_relative 'system_data_loader'

class Init
  include Environment
  include SystemDataLoader

  def self.call
    new.call
  end

  def call
    response = post_form

    parsed_body = JSON.parse(response.body)
    box_id = parsed_body['id']

    store_box_id(box_id)
  end

  private

  def post_form
    Net::HTTP.post_form(uri, secret_key: secret_key, pin_num: pin_num)
  end

  def uri
    URI(initial_uri)
  end

  def store_box_id(box_id)
    open('box_id.txt', 'w') { |f| f.puts box_id }
  end

end

Init.call
