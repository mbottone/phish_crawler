require 'nokogiri'

class HTMLFormFinder

	def generate_request(html, url)

		doc = Nokogiri::HTML(html)
		form = find_form(doc)

		if !form.nil?
			return create_request_with_form(form, url)
		else
			return nil
		end

	end

	def find_form(doc)

		forms = doc.css("form")
		if forms.length == 0
			return nil
		elsif forms.length == 1
			return forms[0]
		else
			#find form
			return nil
		end

	end

	def create_request_with_form(form, url)

		request_url = create_request_url(url, form["action"])

	end

	def create_request_url(url, action)
		return "#{ url }#{ action }"
	end

end