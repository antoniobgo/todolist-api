class ApplicationController < ActionController::API
  SECRET = 'yoursecretword'

  def authentication
    # making a request to a secure route, token must be included in the headers
    decode_data = decode_user_data(request.headers['token'])
    # byebug
    # getting user id from a nested JSON in an array.
    user_id = decode_data[0]['user_data'] if decode_data
    # find a user in the database to be sure token is for a real user
    user = User.find_by_id(user_id)

    # The barebone of this is to return true or false, as a middleware
    # its main purpose is to grant access or return an error to the user

    if user
      true
    else
      render json: { message: 'invalid credentials' }
    end
  end

  # turn user data (payload) to an encrypted string  [ A ]
  def encode_user_data(payload)
    JWT.encode payload, SECRET, 'HS256'
  end

  # turn user data (payload) to an encrypted string  [ B ]
  def encode_user_data(payload)
    JWT.encode payload, SECRET, 'HS256'
  end

  # decode token and return user info, this returns an array, [payload and algorithms] [ A ]
  def decode_user_data(token)
    JWT.decode token, SECRET, true, { algorithm: 'HS256' }
  rescue StandardError => e
    puts e
  end

  # decode token and return user info, this returns an array, [payload and algorithms] [ B ]
  def decode_user_data(token)
    JWT.decode token, SECRET, true, { algorithm: 'HS256' }
  rescue StandardError => e
    puts e
  end
end
