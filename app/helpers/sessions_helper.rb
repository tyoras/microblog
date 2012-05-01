#encoding: utf-8
#Module copartagé entre les vues et controlleurs pour gérer la session
module SessionsHelper
	#Connexion : enregistre le token de session de l'utilisateur courant dans un cookie
	def sign_in(user)
		#valorisation du cookie avec le token
		cookies.permanent[:remember_token] = user.remember_token
		#assignation de l'utilisateur courant dans une variable d'instance
		current_user = user
	end

	#Indique si le user est connecté
 	def signed_in?
    !current_user.nil?
  end

  #redirection vers la page de connexion pour les users non connectés 
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Veuillez vous connecter pour accéder à cette page."
    end
  end

	#méthode d'assignation à une variable d'instance
	def current_user=(user)
    @current_user = user
  end

  #getter récupérant le user en base si nécessaire
  def current_user
    @current_user ||= user_from_remember_token
  end

  #teste si un user est celui qui est connecté
  def current_user?(user)
    user == current_user
  end

  #Déconnexion : détruit le cookie de session
  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end

  #redirige vers une adresse qui a été précedement enregistrée dans la session 
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  #enregistre dans la session l'adresse demandée
  def store_location
    session[:return_to] = request.fullpath
  end

  private

  	#Récupère l'utilisateur à partir de son token de session
    def user_from_remember_token
      remember_token = cookies[:remember_token]
      User.find_by_remember_token(remember_token) unless remember_token.nil?
    end

    #vide l'adresse enregistrée dans la session
    def clear_return_to
      session.delete(:return_to)
    end
end