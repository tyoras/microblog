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

  end

end
