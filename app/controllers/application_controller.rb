class ApplicationController < ActionController::API
  before_action :authenticate

  rescue_from MethodNotImplemented, with: :unhandled_process
  rescue_from InvalidPayload, with: :unhandled_process

  def json_success_response(data = nil, status = :ok, message = nil)
    response_body = { success: true }

    response_body[:data] = data if data.present?
    response_body[:message] = message if message.present?

    render json: response_body, status: status
  end

  def json_error_response(message, status = :unprocessable_entity)
    render json: { success: false, message: message }, status: status
  end

  def unhandled_process(exception)
    Rails.logger.error "Unhandled exception: #{exception.message}"
    json_error_response(exception.message, :unprocessable_entity)
  end

  def handle_unauthorized
    json_error_response('Invalid credentials', :unauthorized)
  end

  def authenticate
    client_name = request.headers['X-API-CLIENT']
    client_secret = request.headers['X-API-SECRET']

    return handle_unauthorized if client_name.nil? || client_secret.nil?

    client = Client.find_by(name: client_name)
    handle_unauthorized if client.nil? || !ActiveSupport::SecurityUtils.secure_compare(client.secret, client_secret)
  end
end
