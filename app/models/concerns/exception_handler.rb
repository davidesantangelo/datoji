module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_error_response('RecordNotFound', e.message, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_error_response('RecordInvalid', e.message, :unprocessable_entity)
    end

    rescue_from ActionController::BadRequest do |e|
      json_error_response('BadRequest', e.message, :bad_request)
    end

    rescue_from ActionController::ParameterMissing do |e|
      json_error_response('ParameterMissing', e.message, :bad_request)
    end

    rescue_from Pagy::OverflowError do |e|
      json_error_response('Overflow Error', e.message, :unprocessable_entity)
    end

    rescue_from ArgumentError do |e|
      json_error_response('ArgumentError', e.message, :unprocessable_entity)
    end
  end
end
