module Environment
  @@env = ARGV[0]

  INITIAL_URI = {
    'development' => 'http://192.168.0.100:3003/boxes',
    'production' => 'prod_uri'
  }

  def initial_uri
    INITIAL_URI[@@env]
  end
end
