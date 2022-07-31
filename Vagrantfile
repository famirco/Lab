Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/focal64"
    config.vm.network "forwarded_port", guest: 22, host: 221
  
    config.vm.provider "VirtualBoxe" do |vb|
    end
  
    config.vm.define "ansible" do |ansible|
      ansible.vm.box = "ubuntu/focal64"
      ansible.vm.hostname = "ansible"
      ansible.vm.provider :VirtualBox do |v|
        v.customize ['modifyvm', :id, '--memory', '2048']
        v.customize ['modifyvm', :id, '--cpus', '2']
      end
    end
  end
  ######coment