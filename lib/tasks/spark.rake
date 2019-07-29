require "#{Rails.root}/app/lib/spark.rb"
require 'json'
require 'pp'


namespace :spark do
  desc "Get listing information from spark"
  	task listing: :environment do
	  	total_pages = Spark.get_list_pagination("listings?_limit=25&_pagination=count")
	  	current_page = 1
	  	while current_page <= total_pages
		  puts "GeeksforGeeks #{current_page}"
		  Spark.get_listing_data(current_page)
		  current_page += 1
		end
	end
end
