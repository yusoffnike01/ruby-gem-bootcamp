class UsersController < ApplicationController
    def index
       @users=User.all.order(:created_at)
    end

    def show 
        @users = User.find(params[:id])
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        @user.update(user_params)
        if @user.update(user_params)
            redirect_to @user, notice: "User was successfuly updated"
        else 
            render :edit
        end
         
    end

    def ban 
        puts "saya"
        @user = User.find(params[:id])
        if @user.access_locked?
            @user.access_locked?
        else
            @user.lock_access!
        end
        redirect_to @user, notice: "User ban status updated"
    end

    def destroy
        puts "masuk x"
        @users = User.find(params[:id])
        @users.destroy
        redirect_to users_path, notice: "Successfully Deleted User"
    end


    private

    def user_params
    params.require(:user).permit(*User::ROLES)
    end

  
end