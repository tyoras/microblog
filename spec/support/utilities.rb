# Retourner un titre basé sur la page.
def titre(titre_page)
  base_titre = "Marmotte Blog"
  if titre_page.nil?
    base_titre
  else
    "#{base_titre} | #{titre_page}"
  end
end

#Effectue les actions de connexion d'un utilisateur
def valid_signin(user)
  fill_in "Email",    with: user.email
  fill_in "Mot de passe", with: user.password
  click_button "Connexion"
end

#Vérifie si une page contient un message d'erreur défini
RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.flash.error', text: message)
  end
end