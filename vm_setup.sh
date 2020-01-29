# This script installs docker, gcloud, and kubectl command line tools onto a
# Google Compute Engine VM (Ubuntu 18.04 image). The VM can then be used to
# easily communicate with the Google Kubernetes Engine cluster 

echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get install apt-transport-https ca-certificates
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-sdk
sudo apt-get install kubectl
gcloud init
sudo usermod -a -G docker $USER
gcloud auth configure-docker -y
