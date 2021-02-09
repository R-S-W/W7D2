class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?

    def current_user
        return nil if session[:session_token].nil?
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        !!current_user
    end

    def log_in_user!(user)
        @current_user = user
        session[:session_token] = user.reset_session_token
        #and cookie
    end

    def logout!
        current_user.try(:reset_session_token)
        session[:session_token] = nil
    end

    def require_logged_in!
        redirect_to new_session_url unless logged_in?
    end

    # def require_logged_out!

    # end
        


end
