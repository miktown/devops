wget -O /tmp/packer.zip https://releases.hashicorp.com/packer/1.0.3/packer_1.0.3_linux_amd64.zip?_ga=2.40440481.2051338557.1501351921-501475178.1501351921
wget -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.9.11/terraform_0.9.11_linux_amd64.zip?_ga=2.73852946.1888694879.1501353419-1285180126.1501353419
unzip /tmp/packer.zip -d ~/bin
unzip /tmp/terraform.zip -d ~/bin
packer validate deployments/template.json &&
packer build deployments/template.json &&
export TF_VAR_image_id=$(curl -H "Authorization: Bearer $DIGITALOCEAN_API_TOKEN" https://api.digitalocean.com/v2/images?private=true | jq ."images[] | select(.name == \"devops-$CIRCLE_BUILD_NUM\") | .id"
echo $TF_VAR_image_id
cd infra && terraform apply && cd .. &&
git add infra && git commit -m "Deployed $CIRCLE_BUILD_NUM [skip ci]" &&
git push origin master
