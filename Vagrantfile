
Vagrant::Config.run do |config|
  
  config.vm.box = "PythonDevBootstrapPrecise"
  config.ssh.guest_port = 22

   config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "manifests"
     puppet.manifest_file  = "init.pp"
     puppet.module_path = "modules"
     puppet.options = "--verbose --debug"
     #puppet.options = "--verbose --noop"
   end
   
end
