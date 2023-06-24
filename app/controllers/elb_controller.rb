# frozen_string_literal: true

class ElbController < ApplicationController
  def ok
    render json: { result: 'ok' }, status: :ok
  end
end
