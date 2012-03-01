  # Retourner un titre basé sur la page.
  def titre(titre_page)
    base_titre = "Marmotte Blog"
    if titre_page.nil?
      base_titre
    else
      "#{base_titre} | #{titre_page}"
    end
  end