require 'nokogiri'
require 'open-uri'

# Fonction qui prend une URL et renvoie l'adresse e-mail de la mairie correspondante
def get_townhall_email(townhall_url)
  begin
    page = Nokogiri::HTML(URI.open(townhall_url))
  rescue StandardError => erreur
    puts "Erreur lors de l'ouverture de l'URL : #{erreur}"
  end
  # Récupère l'adresse e-mail de la mairie depuis la page
  email = page.xpath('//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text.strip
  return email
end

# URL de la page contenant la liste des communes
url = "http://annuaire-des-mairies.com/val-d-oise.html"

begin
  page = Nokogiri::HTML(URI.open(url))
rescue StandardError => e
  puts "Erreur lors de l'ouverture de l'URL : #{e}"
end

# Sélectionne tous les éléments contenant les noms de communes
townhall_links = page.css('a.lientxt')

# Initialise une variable pour stocker les noms et adresses e-mail des mairies
townhall_emails = []

# Parcourt chaque lien de commune pour récupérer le nom et l'adresse e-mail de la mairie
townhall_links.each do |link|
  townhall_name = link.text
  townhall_url = "http://annuaire-des-mairies.com#{link['href'][1..-1]}"
  townhall_email = get_townhall_email(townhall_url)
  townhall_emails << {townhall_name => townhall_email}
end

# Affiche les résultats
puts townhall_emails