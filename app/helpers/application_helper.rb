module ApplicationHelper

  # Retourner un titre basé sur la page.
  def titre(titre_page)
    base_titre = "Marmotte Blog"
    if titre_page.empty?
      base_titre
    else
      "#{base_titre} | #{titre_page}"
    end
  end

  # Retourne le logo de l'application
  def logo
   image_tag("logo.png", :alt => "Marmotte Blog", :class => "round")
  end

end
