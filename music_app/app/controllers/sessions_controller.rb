class SessionsController < ApplicationController
    def create
        email = params[:user][:email]
        password = params[:user][:password]
        @user = User.find_by_credentials(email, password)
        @user.reset_session_token!#dont know where to put this
        if @user
            login(@user)
            redirect_to user_url(@user)
        else
            @user = User.new(
                email: params[:user][:email],
                password: params[:user][:password]
            )
        end
    end

    def new
        @user = User.new
        render :new
    end

    def destroy
        if logged_in?
            logout!
        end
        redirect_to new_session_url
    end
end
