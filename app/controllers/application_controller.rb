class ApplicationController < ActionController::API
  private

  # 共有秘密鍵を使用
  def generate_jwt(user)
    payload = { user_id: user.id, exp: 60.hours.from_now.to_i }
    secret = Rails.application.secrets.secret_key_base
    JWT.encode(payload, secret)
  end

  def decode_token
    header = request.headers['Authorization']
    if header
      token = header.split(' ').last
    else
      raise 'Authorization header is missing'
    end
    begin
      decoded = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      User.find(decoded['user_id'])
    rescue JWT::DecodeError
      raise 'Invalid token'
    end
  end
end
