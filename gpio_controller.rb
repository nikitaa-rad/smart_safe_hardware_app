class GpioController
  attr_reader :pin_num

  def initialize(pin_num:)
    @pin_num = pin_num

    set_numbering
    setup_signal
  end

  def set_high
    gpio.set_high pin_num
  end

  def set_low
    gpio.set_low pin_num
  end

  private

  def gpio
    RPi::GPIO
  end

  def set_numbering
    gpio.set_numbering :bcm
  end

  def setup_signal
    # RPi::GPIO.setup PIN_NUM, :as => :output, :initialize => :high
    gpio.setup pin_num, as: :output
  end
end

gpio_controller = GpioController.new(22)

gpio_controller.set_high

sleep 5

gpio_controller.set_low
