# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#

class User < ActiveRecord::Base
	#Indique les champs qui sont modifiables
  attr_accessible :name, :email, :password, :password_confirmation
  #Utilise auttomatiquement le champs password_digest en base
  has_secure_password
  #lien d'association avec 0 ou plusieurs microposts (foreign key implicite)
  has_many :microposts, dependent: :destroy
  #lien d'association avec 0 ou plusieurs relations (foregn key explicite)
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  #utilise l'association has_many through pour définir le tableau followed_users
  has_many :followed_users, through: :relationships, source: :followed
  #lien d'association avec 0 ou plusieurs relations sur l'autre foreign key
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  #utilise l'association has_many through pour définir le tableau followers
  has_many :followers, through: :reverse_relationships, source: :follower
  #permet de récupérer tous les admins dans un tableau
  scope :admin, where(admin: true)
  #appel à un callback qui execute une méthode avant d'executer save
  before_save :create_remember_token
  #décrit la validation des champs
  validates :name, presence: true, length: { maximum: 50 }
  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: 	true, 
  									format: 		{ with: valid_email_regex },
										uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }

  def feed
    Micropost.from_users_followed_by(self)
  end

  #indique si l'utilisateur en suit un autre
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  #créer une relation indiquant que l'utilisateur en suit un autre
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  #détruit une relation indiquant que l'utilisateur en suit un autre
  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  #définit les attributs et méthodes privées
  private

    #Génère un id de session aléatoirement
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end