class ApplicationController < ActionController::API
  rescue_from NotImplementedError, with: :unhandled_process
  rescue_from ArgumentError, with: :unhandled_process

  def json_success_response(data = nil, status = :ok, message = nil)
    response_body = { success: true }

    response_body[:data] = data if data.present?
    response_body[:message] = message if message.present?

    render json: response_body, status: status
  end

  def json_error_response(message, status = :unprocessable_entity)
    render json: { success: false, message: message }, status: status
  end

  def unhandled_process
    json_error_response('Sorry unable to process your booking', :unprocessable_entity)
  end
end
