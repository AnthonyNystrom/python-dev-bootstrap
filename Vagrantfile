
Vagrant.configure("2") do |config|

  config.vm.box     = 'PythonDevBootstrapPrecise'
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  if defined? VagrantVbguest
    config.vbguest.auto_update = true
  end

  config.ssh.guest_port = 22
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--memory", "512"]
  end

  config.vm.synced_folder "~/Development/Projects", "/projects"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "init.pp"
    puppet.module_path = "modules"
    puppet.options = "--verbose --debug"
    #puppet.options = "--verbose --noop"
  end

end