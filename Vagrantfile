Vagrant.configure("2") do |config|
	config.vm.box="centos6"
	config.vm.box_url="https://github.com/2creatives/vagrant-centos/releases/download/v6.5.1/centos65-x86_64-20131205.box"

	config.vm.define "sakaidev" do |sakaidev|
		sakaidev.vm.hostname = "sakaidev.sakaiproject.org"
	end

	config.vm.provider :virtualbox do |vb|
		vb.customize ["modifyvm", :id, "--memory", 2048]
	end

	config.vm.network :forwarded_port, guest: 8080, host: 8888
	config.vm.network :forwarded_port, guest: 8000, host: 5005

	config.vm.provision "ansible" do |ansible|
		ansible.playbook = "dev-sakai.yml"
		ansible.sudo = true
		ansible.extra_vars = {
			using_vagrant: true
		}
	end
end