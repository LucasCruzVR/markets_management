class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  protect_from_forgery unless: -> { request.format.json? }

  def record_not_found(error)
    render json: { error: error.message }, status: :not_found
  end

  def formatError(context, model)
    if context.mensagem.present?
      { message: context.mensagem }
    elsif context.send(model)&.errors&.present?
      context.send(model).errors.full_messages
    else
      { message: 'There was an error at request. Please, try again later.' }
    end
  end
end
