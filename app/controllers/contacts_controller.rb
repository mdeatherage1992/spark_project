class ContactsController < ApplicationController
	def index
		data = Spark.execute_get_request("contacts")
		if data['D']['Results'].present?
			@contacts = data['D']['Results']
		end
	end

	def new
	end

	def create
		input_hash =Hash.new { |hash, key| hash[key] = {} }
		message = 'Problem in creating new contact'
		if contact_params.present?
			input_hash['D'] = {
				'DisplayName': contact_params[:name],
				'PrimaryEmail': contact_params[:email]
			}
			response = Spark.execute_post_request('contacts',input_hash.to_json)
			if response['D']['Success']
				message = 'New contact created sucessfully'
			end
		end
		redirect_to contacts_path, notice: message
	end

	def show
	end

	private
	def contact_params
		params.require(:contact).permit(:name, :email)
	end
end
