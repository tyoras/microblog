#encoding: utf-8
class MicropostsController < ApplicationController
  #callback avant d'excuter une action du controller
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  #action de validation / création en base d'un nouveau micropost
  def create
  	@micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost créé!"
      redirect_to root_path
    else
    	#si le message enregistré n'est pas valide, on envoie aucun élément au feed
    	@feed_items = []
      render 'pages/home'
    end
  end

  #action de suppression en base d'un micropost
  def destroy
  	@micropost.destroy
    redirect_back_or root_path
  end

  private
  	#vérifie que c'est le bon user qui demande l'action, redirige vers l'accueil si non
    def correct_user
		  @micropost = current_user.microposts.find(params[:id])
		#catch d'exception
		rescue
		  redirect_to root_path
		end

end