class VirtualMachine

	def start
		puts "Starting virtual machine..."
		%x{ vagrant up }
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