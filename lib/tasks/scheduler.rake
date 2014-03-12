# this is a task for grabbing code from reddit
task scrap_reddit: :environment do

	puts "hiya!"

	# this grabs the source code of reddit.com
	@raw_html = HTTParty.get("http://www.reddit.com")

	# lets turn the raw html into real html we can parse
	@real_html = Nokogiri::HTML(@raw_html)

	# in css we would style up the title links using div#siteTable a.Title
	@real_html.css("div#siteTable a.title").each do |link|
		# this is similar to the stories/index.html.erb view
		

		@story = Story.new
		@story.title = link.text
		@story.link = link[:href]
		@story.save

	end



end