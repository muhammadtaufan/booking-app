class InvalidPayload < ArgumentError
  def initialize(msg = 'Invalid payload for API request')
    super
  end
end
