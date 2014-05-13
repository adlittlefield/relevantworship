require 'rubygems'
require 'chatterbot/dsl'
require 'nokogiri'   
require 'open-uri'

consumer_key '0jSJcFEOgyNl8Z8oV9nJ9HqTM'
consumer_secret 'QDv2HOIyso0GZOB6YJ5MqQKxSlXvmobw1Ce20PpXhPw8b6PjLm'

secret 'xCHrGdeOKQxLEOA9p6p38bxjzzSYLyuYG2Miw4GsBW5fw'
token '2488515212-sbvGFBugq3ylE0r9c6P9Wz5PpwF3wegkamFiTs7'


# here's a list of users to ignore
blacklist

# here's a list of things to exclude from searches
exclude "hi", "spammer", "junk"


lyric_urls = ['http://www.metrolyrics.com/hillsong-united-lyrics.html', 'http://www.metrolyrics.com/phil-wickham-lyrics.html', 'http://www.metrolyrics.com/chris-tomlin-lyrics.html', 'http://www.metrolyrics.com/kristian-stanfill-lyrics.html', 'http://www.metrolyrics.com/christy-nockels-lyrics.html', 'http://www.metrolyrics.com/david-crowder-lyrics.html', 'http://www.metrolyrics.com/matt-redman-lyrics.html', 'http://www.metrolyrics.com/kari-jobe-lyrics.html']
html_shit = ['<p class="verse">', '</p>', '<br>']
teen_nouns = ['YOLO', 'Snapchat', 'selfie', 'instagram', 'swag']
teen_adjectives = ['cray', 'totes', 'awesomesauce', 'thirsty', 'ratchet', 'turnt up']
teen_verbs = ['throw shade on', 'SMH', 'literally cant even', 'turn down for what', 'twerk', 'put on blast']
teen_people = ['Blue Ivy', 'Kimye', '#oomf', 'Bae', 'Shawty', 'Miley', 'Pharrell\'s Hat', 'Bieber', 'Directioners']
christianism_nouns = ['word', 'Eternity', 'eternity', 'Grace', 'grace', 'heart', 'cross', 'soul', 'love', 'Spirit', 'spirit', 'grave', 'glory', 'light']
christianism_adjectives = ['holy', 'completely', 'everlasting', 'great']
christianism_verbs = ['shine', 'worship', 'fill', 'consume', 'pray', 'seek', 'defeat', 'defeated', 'praise']
christianism_people = ['Lamb', 'Jesus', 'Savior', 'Lord', 'Father', 'King', 'God', 'Creation']


newverse = false
$tweet_length = 142

until $tweet_length < 141
until html_shit.all? { |w| newverse =~ /#{w}/ }
	until ( christianism_nouns.any? { |w| newverse =~ /#{w}/ } or christianism_adjectives.any?  { |w| newverse =~ /#{w}/ } or christianism_verbs.any? { |w| newverse =~ /#{w}/ } or christianism_people.any?  { |w| newverse =~ /#{w}/ } )
		PAGE_URL = lyric_urls[rand(8)]
		page = Nokogiri::HTML(open(PAGE_URL))
		links = page.css("td a")
		songurl = links[rand(12)]["href"] 

		puts songurl

		PAGE_URL = "#{songurl}"

		page = Nokogiri::HTML(open(PAGE_URL))
		songverse = page.css("p.verse")[rand(7)]
			
		newverse = songverse.to_s
	end
end
		
		no_html1 = newverse.gsub!('<br>','')
		no_html2 = no_html1.gsub!('<p class="verse">', '')
		no_html3 = no_html2.gsub!('</p>', '')

		puts "------------------------------------------------------"

		puts no_html3
	
		puts "------------------------------------------------------"
	
		christianism_nouns.each { |x| no_html3.gsub!("#{x}", teen_nouns[rand(5)]) }
		christianism_adjectives.each { |x| no_html3.gsub!("#{x}", teen_adjectives[rand(5)]) }
		christianism_verbs.each { |x| no_html3.gsub!("#{x}", teen_verbs[rand(5)]) }
		christianism_people.each { |x| no_html3.gsub!("#{x}", teen_people[rand(9)]) }
		puts no_html3
	
		puts "------------------------------------------------------"
	
		puts no_html3.length
	
		$tweet_length = no_html3.length
	
		$tweet_length.to_i
	
		$tweet_this_lyric = no_html3.to_s
	
end

if $tweet_length <= 140
	puts "yep"
	puts $tweet_this_lyric
	tweet "#{$tweet_this_lyric}"
else
	nil
end

update_config
