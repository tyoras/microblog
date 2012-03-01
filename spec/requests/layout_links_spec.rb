require 'spec_helper'

describe "LayoutLinks" do

  describe "GET /layout_links" do

		it "should have Accueil at '/'" do
		  get '/'
		  response.should have_selector('title', :content => "Accueil")
		end

		it "should have Contact at '/contact'" do
		  get '/contact'
		  response.should have_selector('title', :content => "Contact")
		end

		it "should have A Propos at '/about'" do
		  get '/about'
		  response.should have_selector('title', :content => "A Propos")
		end

		it "should have Aide at '/help'" do
		  get '/help'
		  response.should have_selector('title', :content => "Aide")
		end

		it "should have Inscription at '/signup'" do
		  get '/signup'
		  response.should have_selector('title', :content => "Inscription")
		end

  end

	it "devrait avoir le bon lien sur le layout" do
			visit root_path
			click_link "A Propos"
			response.should have_selector('title', :content => "A Propos")
			click_link "Aide"
			response.should have_selector('title', :content => "Aide")
			click_link "Contact"
			response.should have_selector('title', :content => "Contact")
			click_link "Accueil"
			response.should have_selector('title', :content => "Accueil")
			click_link "S'inscrire !"
			response.should have_selector('title', :content => "Inscription")
		end
end
