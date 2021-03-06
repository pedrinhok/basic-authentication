class UsersController < ApplicationController

  before_action :authenticate, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      f(:success, t("flash.users.created"))
      redirect_to users_path
    else
      f(:danger, @user.errors)
      render :new
    end
  end

  def update
    if @user.update(user_params)
      f(:success, t("flash.users.updated"))
      redirect_to users_path
    else
      f(:danger, @user.errors)
      render :edit
    end
  end

  def destroy
    sign_out if @user.id == @current_user.id
    @user.destroy
    f(:success, t("flash.users.destroyed"))
    redirect_to users_path
  end

  private

    def set_user
      @user = User.find_by(id: params[:id])
      if @user.nil?
        f(:danger, t("errors.messages.not_found", record: t("user")))
        redirect_to users_path
      end
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
