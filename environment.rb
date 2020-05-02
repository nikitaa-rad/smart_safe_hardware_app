module Environment
  @@env = ARGV[0]

  URI = {
    'development' => 'http://localhost:3003',
    'production' => 'prod_uri'
  }

  def initial_uri
    URI[@@env]
  end
end
