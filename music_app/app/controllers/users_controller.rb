class UsersController < ApplicationController
    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(params)

        if @user.save 
            login(@user)
            redirect_to user_url(@user)
        else
            render :new
        end
    end

    def show
        @user = User.find(params)
        render :show
    end

    
end
