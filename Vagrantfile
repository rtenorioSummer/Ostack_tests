cluster = {
  "controller" => { :ip => "10.0.0.11",
                    :netmask => "255.255.255.0",
                    :gateaway => "10.0.0.1"},
  "compute1" => { :ip => "10.0.0.31",
                 :netmask => "255.255.255.0",
                 :gateaway => "10.0.0.1"}
}

Vagrant.configure(2) do |config|

  cluster.each_with_index do |(hostname, info), index|

    config.vm.define hostname
    config.vm.box = "centos/7"
    config.vm.network "private_network",
                      ip: "#{info[:ip]}",
                      netmask: "#{info[:netmask]}"
   # config.vm.provision "shell",
   #                     run: "always",
   #                     inline: "route add default gw #{info[:gateaway]}"
    config.vm.hostname = hostname


         config.vm.provision :ansible do |ansible|
 		ansible.playbook= "playbooks/"+hostname+"/playbook.yml"
 	end
  end
end
