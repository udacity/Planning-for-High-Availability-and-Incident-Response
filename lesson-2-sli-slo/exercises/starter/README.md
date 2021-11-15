# Instructions
## You will use the following for BOTH hands-on exercises in lesson 2
1. Open your AWS console

2. Change your region to `us-east-2`. From the AWS console create an S3 bucket in `us-east-2` called `udacity-tf-<your_name>` e.g `udacity-tf-tscotto`
    - click next until created.
    - Update `_config.tf` in the `zone1` folder with your S3 bucket name where you will replace `<your_name>` with your name

3. Setup your CloudShell. Open CloudShell in the `us-east-2` region. Install the following:

- helm
    - `export VERIFY_CHECKSUM=false`
    - `curl -sSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash`

- terraform
    - `wget https://releases.hashicorp.com/terraform/1.0.7/terraform_1.0.7_linux_amd64.zip`
    - `unzip terraform_1.0.7_linux_amd64.zip`
    - `mkdir ~/bin`
    - `mv terraform ~/bin`
    - `export TF_PLUGIN_CACHE_DIR="/tmp"`

- kubectl
    - `curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/kubectl`
    - `chmod +x ./kubectl`
    - `mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin`
    - `echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc`

4. Deploy Terraform infrastructure
    - Clone the starter code from the git repo to a folder CloudShell
    - `cd` into the `starter` folder
    - `terraform init`
    - `terraform apply`

**NOTE** The first time you run `terraform apply` you may see errors about the Kubernetes namespace. Running it again **AFTER** performing the step below should clear up those errors.

5. Setup Kubernetes config so you can ping the EKS cluster
   - `aws eks --region us-east-2 update-kubeconfig --name udacity-cluster`
   - Change kubernetes context to the new AWS cluster
     - `kubectl config use-context <cluster_name>`
       - e.g ` arn:aws:eks:us-east-2:139802095464:cluster/udacity-cluster`
    - `kubectl create namespace monitoring`
   - Confirm with: `kubectl get pods --all-namespaces`

6. Install Prometheus and Grafana

    `kubectl create secret generic additional-scrape-configs --from-file=prometheus-additional.yaml --namespace monitoring`

    `helm repo add prometheus-community https://prometheus-community.github.io/helm-charts`

    `helm install prometheus prometheus-community/kube-prometheus-stack -f "values.yaml" --namespace monitoring`

Get the DNS of your load balancer provisioned to access Prometheus. You can find this by opening your AWS console and going to EC2 -> Load Balancers and selecting the load balancer provisioned. The DNS name of it will be listed below that you can copy and paste into your browser. Copy that into your web browser with the port `:9090` appended to access Prometheus. It will look something like this:
`ab8ec64a7ad1d4a03b4c8039511bb2c6-3e6b8d197cd16333.elb.us-east-2.amazonaws.com:9090`

Do the same for Grafana. You'll need to select each load balancer instance and click the `Tags` tab to see the name to identify which is Prometheus and which one is Grana.

Login to Grafana with `admin` for the username and `prom-operator` for the password.

7. At the end of your exercise, run `terraform destroy` and allow it to destroy all your resources