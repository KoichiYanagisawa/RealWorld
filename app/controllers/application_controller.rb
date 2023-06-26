# frozen_string_literal: true

class ApplicationController < ActionController::API
  private

  # 共有秘密鍵を使用
  def generate_jwt(user)
    payload = { user_id: user.id, exp: 60.hours.from_now.to_i }
    secret = Rails.application.credentials.secret_key_base
    JWT.encode(payload, secret)
  end

  def decode_token
    header = request.headers['Authorization']
    raise 'Authorization header is missing' unless header

    token = header.split.last

    begin
      decoded = JWT.decode(token, Rails.application.credentials.secret_key_base)[0]
      User.find(decoded['user_i'])
    rescue JWT::DecodeError
      raise 'Invalid token'
    end
  end
end
