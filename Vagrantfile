cluster = {
  "controller" => { :ip => "10.0.0.11",
                    :netmask => "255.255.255.0",
                    :gateaway => "10.0.0.1"},
  "compute" => { :ip => "10.0.0.31",
                 :netmask => "255.255.255.0",
                 :gateaway => "10.0.0.1"}
}

# Here starts the configuration: Do not change the 2
Vagrant.configure(2) do |config|

  # Here loops over the cluster list to get diferent machine parameters
  cluster.each_with_index do |(hostname, info), index|

    # HERE IS THE TRICK:
    # Multiple machines shall be initialized this way,
    # not using the generic config.vm
    config.vm.define hostname do |this_vm|
      this_vm.vm.box = "centos/7"
      this_vm.vm.network "private_network",
                      ip: "#{info[:ip]}",
                      netmask: "#{info[:netmask]}"
      this_vm.vm.hostname = hostname


      this_vm.vm.provision :ansible do |ansible|
 		        ansible.playbook= "playbook.yml"
      end
    end
  end
end
