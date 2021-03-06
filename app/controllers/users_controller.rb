#encoding: utf-8
class UsersController < ApplicationController
  #callback avant d'excuter une action du controller
  before_filter :signed_in_user, only: [:index, :edit, :update, :following, :followers]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  before_filter :user_connected, only: [:new, :create]

  #action d'affichage d'un user existant
	def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  #action d'affichage de la liste de tout les users
  def index
    @users = User.paginate(page: params[:page])
  end

  #action d'accès à la page de création d'un nouveau user
  def new
  	@user = User.new
  end

  #action de validation / création en base d'un nouveau user
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
    	flash[:success] = "Bienvenue sur Marmotte Blog!"
      redirect_to @user
    else
      render 'new'
    end
  end

  #action d'accès à la page de modification d'un user existant
  def edit
  end

  #action de validation / modification en base d'un user existant
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profil mis à jour"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  #action de suppression de user
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Utilisateur supprimé."
    redirect_to users_path
  end

  #action d'accès à la page d'affichage des gens suivis par l'utilisateur connecté
  def following
    @title = "Following"
    @info = "Les personnes que vous suivez"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  #action d'accès à la page d'affichage des gens qui suivent l'utilisateur connecté
  def followers
    @title = "Followers"
    @info = "Les personnes qui vous suivent"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end


  private

    #redirection vers la page d'accueil si user connecté
    def user_connected
     redirect_to(root_path) if signed_in?
    end

    #redirection vers l'accueil si ce n'est pas le bon user qui est connecté
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    #empêche les users non admin d'effectuer une action en les redirigeant sur l'accueil
    def admin_user
      redirect_to(root_path) unless (current_user.admin? && !current_user?(@user))
    end
end