class ReportOutput

	def initialize(url)

		@url = url
		@folder = "reports/" + url.gsub(/[^0-9A-Za-z.\-]/, '_')
		%x{ mkdir #{@folder} }

	end

	def output_html(html)

		File.open("#{@folder}/index.html", 'w') { |file| file.write(html) }

	end

	def output_screenshot

		%x{ wkhtmltopdf #{@url} #{@folder}/screenshot.pdf }

	end

end