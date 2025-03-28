module ExceptionHandler
  extend ActiveSupport::Concern
  included do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
    rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
    rescue_from StandardError, with: :handle_standard_error
  end

  private

  # 404
  def handle_record_not_found(exception)
    render json: { error: "Record not found", details: exception.message }, status: :not_found
  end

  # 422
  def handle_record_invalid(exception)
    render json: { error: "Invalid record", details: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  # 400
  def handle_parameter_missing(exception)
    render json: { error: "Missing parameter", details: exception.message }, status: :bad_request
  end

  # 500
  def handle_standard_error(exception)
    logger.error "Exception Class: #{exception.class.name}"
    logger.error "Exception Message: #{exception.message}"
    logger.error exception.backtrace.join("\n")
    render json: {
      error: "Internal Server Error",
      details: exception.message
    }, status: :internal_server_error
  end
end
