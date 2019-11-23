# methods being used for authentication

# app/controllers/concerns/authenticable.rb
module Authenticable
  # get the current user
  def current_user
    return @current_user if @current_user

    header = request.headers['Authorization']
    return nil if header.nil?

    decoded = JsonWebToken.decode(header)
    @current_user =
      begin User.find(decoded[:user_id])
      rescue ActiveRecord::RecordNotFound
      end
  end
end