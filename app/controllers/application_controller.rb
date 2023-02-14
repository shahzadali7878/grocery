# frozen_string_literal: true

class ApplicationController < ActionController::API
  def render_unprocessable_entity(entity)
    render json: { errors: entity.errors.full_messages.to_sentence },
           status: :unprocessable_entity
  end
end
