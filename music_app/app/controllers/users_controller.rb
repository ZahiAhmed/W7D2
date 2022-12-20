class UsersController < ApplicationController
    def new
        @user = User.new
        render :new
    end

    def create
        debugger
        @user = User.new(user_params)

        if @user.save 
            login!(@user)
            redirect_to user_url(@user)
        else
            render :new
        end
    end

    def show
        @user = User.find(user_params)
        render :show
    end

    private

    def user_params
        params.require(:user).permit(:email, :password, :session_token)
    end

end
