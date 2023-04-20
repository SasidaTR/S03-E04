require 'nokogiri'
require 'open-uri'

begin
  page = Nokogiri::HTML(URI.open("https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=900"))
rescue StandardError => erreur
  puts "Erreur lors de l'ouverture de l'URL : #{erreur}"
end

emails = page.xpath('//a[contains(@href, "mailto") and contains (@href, "assemblee")]/text()').map(&:text).map(&:strip)

nommails = []

emails.each do |email|
  prenom, nom = email.split("@")[0].split(".").map(&:capitalize)
  nommails << {
    "first_name" => prenom,
    "last_name" => nom,
    "email" => email
  }
end

puts nommails