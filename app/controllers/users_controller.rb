class UsersController < ApplicationController
    before_action :require_admin, only: [:edit, :update, :ban, :destroy]
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

    def resend_confirmation_instructions
        @user = User.find(params[:id])
        unless @user.confirmed?
            @user.resend_confirmation_instructions
            redirect_to @user, notice: "Confirmation Instruction were  resent"
        else
            redirect_to @user, alert: "User already confirmed.."
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

 
    private

    def user_params
    params.require(:user).permit(*User::ROLES)
    end

    def require_admin
        unless current_user.admin?
            redirect_to root_path, alert: "You are not authorized to perform this action "
        end
    end

  
end