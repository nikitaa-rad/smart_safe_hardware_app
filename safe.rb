require 'states_service'
require 'gpio_controller'

class Safe
  SLEEP_DURATION = 4

  attr_reader :state_id, :initial_uri, :pin_num

  def initialize(initial_uri:, state_id:, pin_num:)
    @initial_uri = initial_uri
    @state_id = state_id
    @pin_num = pin_num
  end

  def self.run(*args)
    new(*args).run
  end

  def run
    while true do
      state = StatesService.call(initial_uri: initial_uri)

      set_state(state)

      sleep SLEEP_DURATION
    end
  end

  private

  def gpio_controller
    @gpio_controller ||= GpioController.new(pin_num: pin_num)
  end

  def set_state(state)
    gpio_controller.set_low

    gpio_controller.set_high if state
  end
end

Safe.run(initial_uri: 'http://localhost:3000/states/', state_id: 1, pin_num: 22)
