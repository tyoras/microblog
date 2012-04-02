class SessionsController < ApplicationController

	def new
  end

  #Authentifie et met en place la session
  def create
    #on cherche l'utilisateur par email
  	user = User.find_by_email(params[:email])
    #si on le trouve et qu'il a le bon mot de passe
    if user && user.authenticate(params[:password])
      #on créer la session
      sign_in user
      #puis on va sur le profil
      redirect_to user
    else
      #si authentification ratée => message d'erreur
      flash.now[:error] = 'Combinaison Email / Mot de passe invalide !' # Not quite right!
      render 'new'
    end
  end

  #Déconnexion : détruit la session puis retrourne sur l'accueil
  def destroy
    sign_out
    redirect_to root_path
  end

end
