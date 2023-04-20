require 'nokogiri'
require 'open-uri'

begin
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
rescue StandardError => erreur
  puts "Erreur lors de l'ouverture de l'URL : #{erreur}"
end

cours = []

# Sélectionne tous les éléments contenant les informations sur les cryptomonnaies et leurs cours
rows = page.xpath('//table//tr')

# Parcourt chaque élément sélectionné
rows.each do |row|
  # Extrait le nom et le cours de chaque cryptomonnaie
  name = row.xpath('./td[2]').text.strip
  price = row.xpath('./td[5]').text.strip
  infos = {name => price}
  cours << infos

  puts cours
end