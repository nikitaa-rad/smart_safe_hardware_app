require 'rpi_gpio'

class GpioController
  attr_reader :pin_num

  def initialize(pin_num:)
    @pin_num = pin_num

    set_numbering
    setup_signal
  end

  def set_high
    gpio.set_high pin_num if gpio.low? pin_num
  end

  def set_low
    gpio.set_low pin_num if gpio.high? pin_num
  end

  def clean_up
    gpio.clean_up
  end

  private

  def gpio
    RPi::GPIO
  end

  def set_numbering
    gpio.set_numbering :bcm
  end

  def setup_signal
    gpio.setup pin_num, as: :output
  end
end
