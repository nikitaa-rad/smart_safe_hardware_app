require_relative 'states_service'
require_relative 'gpio_controller'

class Safe
  SLEEP_DURATION = 4

  def self.run
    new.run
  end

  def run
    while true do
      state = StatesService.call

      set_state(state)

      sleep SLEEP_DURATION
    end
  end

  private

  def gpio_controller
    @gpio_controller ||= GpioController.new
  end

  def set_state(state)
    gpio_controller.set_high

    gpio_controller.set_low if state
  end
end

Safe.run
