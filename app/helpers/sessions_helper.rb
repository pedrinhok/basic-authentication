module SessionsHelper

	def sign_in user
		session[:user_id] = user.id
	end

	def sign_out
		session.delete(:user_id)
		@current_user = nil
	end

	def current_user
		@current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
	end

	def signned_in?
		!session[:user_id].nil?
	end

end
