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
  #lien d'association avec 0 ou plusieurs microposts
  has_many :microposts, dependent: :destroy
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
    # This is preliminary. See "Following users" for the full implementation.
    Micropost.where("user_id = ?", id)
  end

  #définit les attributs et méthodes privées
  private

    #Génère un id de session aléatoirement
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end