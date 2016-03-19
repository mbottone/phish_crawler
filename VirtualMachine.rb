class VirtualMachine

	def start
		puts "Starting virtual machine..."
		%x{ vagrant up }
	end

	def get_html(url)
		puts "Pulling HTML for #{url}..."
		return %x{ vagrant ssh -c '/vagrant/get_html #{url}' }
	end

	def stop
		puts "Stopping virtual machine..."
		%x{ vagrant halt }
	end

	def destroy
		puts "Destroying virtual machine..."
		%x{ vagrant destroy -f }
	end

end