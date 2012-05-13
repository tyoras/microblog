#Contrôleur gérant la création/destruction de lien entre user
class RelationshipsController < ApplicationController
  before_filter :signed_in_user

  #Action de création d'un nouveu lien entre l'utilisateur et une autre personne
  def create
    #récupération du user à suivre à partir des params de la requête
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  #Action de destruction d'un lien entre l'utilisateur et une autre personne
  def destroy
    #récupération du user à ne plus suivre à partir des params de la requête
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end