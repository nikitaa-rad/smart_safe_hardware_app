require 'rpi_gpio'

require_relative 'system_data_loader'

class GpioController
  include SystemDataLoader

  attr_reader :gpio_pin_num

  def initialize
    @gpio_pin_num = pin_num

    set_numbering
    setup_signal
  end

  def set_high
    gpio.set_high gpio_pin_num if gpio.low? gpio_pin_num
  end

  def set_low
    gpio.set_low gpio_pin_num if gpio.high? gpio_pin_num
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
    gpio.setup gpio_pin_num, as: :output
  end
end
