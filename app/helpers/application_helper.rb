module ApplicationHelper

  # Retourner un titre basé sur la page.
  def titre
    base_titre = "Marmotte Blog"
    if @titre.nil?
      base_titre
    else
      "#{base_titre} | #{@titre}"
    end
  end

  # Retourne le logo de l'application
  def logo
   image_tag("logo.png", :alt => "Marmotte Blog", :class => "round")
  end

end
