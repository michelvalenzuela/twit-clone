module API
    class Base < Grape::API

        
      http_basic do |email, password|
        @user = User.find_by_email(email)
        @user && @user.valid_password?(password)
      end
      
      mount API::V1::Base
    end

end