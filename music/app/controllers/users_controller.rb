class UsersController < ApplicationController
    before_action :require_logged_in!, except: [:create, :new]


    def create
        @user =  User.new(user_params)
        if @user.save
            p "Saved user."
            redirect_to bands_url
        else
            render json: @user.errors.full_messages
            # redirect_to new_user_url
        end
    end

    def new
        @user  = User.new
        render :new
    end

    def show
        @user = User.find(email: user_params[:email])
        render :show
    end




    private
    def user_params
        params.require(:user).permit(:email, :password)
    end
end