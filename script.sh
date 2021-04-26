#!/bin/bash
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
sudo apt-get update && sudo apt-get install docker.io -y


curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
minikube version
sudo apt install conntrack


wget https://dl.google.com/go/go1.16.3.linux-amd64.tar.gz -O go1.16.3.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.16.3.linux-amd64.tar.gz
export PATH=/usr/local/go/bin
go version


git clone https://github.com/peikiuar/qr-dech-chaincode.git
cd qr-dech-chaincode
go mod vendor
cd ..


# Configuring DNS
AWS_INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
AWS_INSTANCE_PUBLIC_IP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
echo --------------INFO--------------
echo AWS_INSTANCE_ID $AWS_INSTANCE_ID
echo AWS_INSTANCE_PUBLIC_IP $AWS_INSTANCE_PUBLIC_IP
echo ----------SETTING DNS-----------
aws sns publish --topic-arn "arn:aws:sns:us-east-1:763669947983:Route53SNS" --message '{"EC2InstanceIP": "'"$AWS_INSTANCE_PUBLIC_IP"'", "AccountId": "127981432191", "EC2InstanceId": "'"$AWS_INSTANCE_ID"'", "RecordName": "red-test-interoperabilidad-dev.apps.ambientesbc.com", "Event": "ec2:EC2_INSTANCE_LAUNCH", "Public": "true"}' --region "us-east-1"

# git clone https://github.com/crcrios/redTest.git

# minikube start --vm-driver=none

# kubectl apply -f redTest/OneOrgSinCryptoGen

# kubectl get pods
# kubectl cp qr-dech-chaincode fabric-tools:/
# kubectl exec -it fabric-tools -- /bin/sh