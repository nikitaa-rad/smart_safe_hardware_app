require 'net/http'
require 'pry'

class Safe
  attr_reader :state_id, :initial_uri, :locked

  def initialize(initial_uri:, state_id:)
    @initial_uri = initial_uri
    @state_id = state_id
    @locked = false
  end

  def self.run(*args)
    new(*args).run
  end

  def run
    while true do
      state = get_state

      write_state(state)

      sleep 1
    end
  end

  private

  def get_state
    res = Net::HTTP.get(uri)

    state = JSON.parse(res)

    @locked = state['locked']
  end

  def write_state(state)
    open('locked.txt', 'w') { |f|
      f.puts state
    }
  end

  def uri
    @uri ||= URI(initial_uri + state_id.to_s)
  end
end

Safe.run(initial_uri: 'http://localhost:3000/states/', state_id: 1)
