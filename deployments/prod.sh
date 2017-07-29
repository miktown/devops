wget -O packer.zip https://releases.hashicorp.com/packer/1.0.3/packer_1.0.3_linux_amd64.zip?_ga=2.40440481.2051338557.1501351921-501475178.1501351921
unzip packer.zip
./packer_validate_deployments/template.json
./packer_build_deployments/template.json
