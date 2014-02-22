
Vagrant.configure("2") do |config|

  config.vm.box     = 'PythonDevBootstrapPrecise'
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  #network
  config.vm.network :private_network, ip: "192.168.33.10"
  
  #shared
  config.vm.synced_folder "~/Development/Projects", "/projects", type: 'nfs'

  #virtualbox
  if defined? VagrantVbguest
    config.vbguest.auto_update = true
  end
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--memory", "512"]
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "init.pp"
    puppet.module_path = "modules"
    puppet.options = "--verbose --debug"
    #puppet.options = "--verbose --noop"
  end
end