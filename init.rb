class Init
  def initialize(initial_uri:, pin_num:)
    @initial_uri = initial_uri
    @pin_num = pin_num
  end

  def self.call(*args)
    new(*args).call
  end

  def call

  end
end
