require 'uri'
require 'net/http'
require 'json'
require 'pp'

module Spark

	SERVER_URL = 'https://sparkapi.com/v1/'
	AUTH_TOKEN = 'Bearer 5uw7dwnhhta09rzo10mwen8qb'

	## function is used to exetue get api
	def self.execute_get_request(api_name)
		server_url = SERVER_URL
		url = URI("#{server_url}#{api_name}")
		http = Net::HTTP.new(url.host, url.port)
  		http.use_ssl = true
		#http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		request = Net::HTTP::Get.new(url)
		request["content-type"] = 'application/json'
		request["authorization"] = AUTH_TOKEN
		request["x-sparkapi-user-agent"] = 'spark_api_app_test'
		request["cache-control"] = 'no-cache'
		sleep 3
		response = http.request(request)
		return JSON.parse(response.read_body)
	end

	def self.get_listing(api_url)
		json_data = execute_get_request(api_url)
	  	#pp json_data
		json_data
	end

	#get listing of records per page limit 25
	def self.get_listing_data(current_page)
		json_data = execute_get_request("listings?_limit=25&_page=#{current_page}")
	  	pp json_data
		hash = {}
		if json_data['D']['Success']
	        # got correct result
	        if json_data['D']['Results'].is_a? Array
	        	json_data['D']['Results'].each do |ele|
	        		#hash[ele['Id']] = ele['ResourceUri']
	        		listing = Listing.find_or_create_by(spark_id:ele['Id'],listing_api_url:ele['ResourceUri'])
	        		listing.update_attributes(list:ele)
	        	end
	        end
	    else
	       #json_data
	    end
	end

	## get pagination data
	def self.get_list_pagination(count)
		total_pages = 0
		pagiantion_data = execute_get_request("listings?_limit=25&_pagination=count")
	  	if pagiantion_data['D']['Success']
	  		total_pages = pagiantion_data['D']['Pagination']['TotalPages'].to_i
	  	end
	  	return total_pages
	end
end
