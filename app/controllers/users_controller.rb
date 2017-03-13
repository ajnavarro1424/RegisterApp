class UsersController < ApplicationController
  def register
  end

  def submit
    if  User.exists?(:username => params[:username])
      redirect_to '/users/register'
      flash[:alert_user] = "That username already exists, try again"

    elsif (!params[:name].present?)
       redirect_to '/users/register'
    else (params[:name].present?)
     @user = User.new
     @user.name = params[:name]
     @user.address = params[:address]
     @user.city = params[:city]
     @user.state = params[:state]
     @user.postal = params[:postal]
     @user.country = params[:country]
     @user.email = params[:email]
     @user.username = params[:username]
     @user.password = params[:password]
     @user.save
     session[:username] = @user.name

     @phone1 = Phone.new
     @phone1.number = params[:number1]
     @phone1.user_id = @user.id
     @phone1.save
     @phone2 = Phone.new
     @phone2.number = params[:number2]
     @phone2.user_id = @user.id
     @phone2.save
     @phone3 = Phone.new
     @phone3.number = params[:number3]
     @phone3.user_id = @user.id
     @phone3.save

     redirect_to '/users/confirmation'
    end
  end

  def confirmation
    if (session[:username].blank?)
     redirect_to '/users/register'
     flash[:alert_hacker] = "We caught you, hacker!"
    else
    end
  end

  def login
    @user_check = User.find_by_username(params[:username_login])
    # puts @user_check.username
    # puts @user_check.password

    if @user_check.password == params[:password_login]
      # session[:user_check] = @user_check.to_yaml
      session[:user] = @user_check.id
      session[:login] = "true"
      redirect_to '/users/login_confirmation'

    else
      flash[:alert_invalid] = "Invalid password given username. Try again."
      redirect_to '/users/register'
    end
  end


  def login_confirmation
    @user = User.find(session[:user])

  end

  def log_out
    session[:login] = "false"
    flash[:alert_logout] = "You have logged out."
    redirect_to "/users/register"

  end

end
