require "parseconfig"
require 'open-uri'
require 'zlib'
require 'json'

class PhishTank

	def initialize
		config = ParseConfig.new("phishTank.config")
		@sites_file = config["sites_file"]
		@url = config["url"]
	end

	def get_sites
		puts "Fetching json site data..."
		json_string = get_json
		puts "Parsing json..."
		json = parse_json(json_string)
		puts "Parsing site data..."
		sites = parse_sites(json)
		puts "Data initialization complete."
		return sites
	end

	Site = Struct.new(:id, :detail_url, :url, :submit_time, :verified, :verified_time, :online, :target)

private

	def get_json
		if File.exists?(@sites_file) && (Time.now - File.mtime(@sites_file)) < 3600
			puts "Using local copy."
			return File.read(@sites_file)
		end
		
		puts "Fetching new up-to-date copy."
		Zlib::GzipReader.open(open(@url)) do |gz|
			json_string = gz.read
			File.write(@sites_file, json_string)
			return json_string
		end
	end

	def parse_json(json_string)
		return JSON.parse(json_string)
	end

	def parse_sites(json)
		return json.collect do |site_json|
			Site.new(site_json["phish_id"],
				site_json["phish_detail_url"],
				site_json["url"],
				site_json["submission_time"],
				(site_json["verified"] == "yes" ? true : false),
				site_json["verification_time"],
				(site_json["online"] == "yes" ? true : false),
				site_json["target"])
		end
	end

end
