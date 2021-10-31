# Instructions
1. Open your AWS console

2. Change your region to `us-east-2`. From the AWS console create an S3 bucket in `us-east-2` called `udacity-tf-<your_name>` e.g `udacity-tf-tscotto`
    - click next until created.
    - Update `_config.tf` in the `zone1` folder with your S3 bucket name where you will replace `<your_name>` with your name

3. Setup your CloudShell. Open CloudShell in the `us-east-2` region. Install the following:

- terraform
    - `wget https://releases.hashicorp.com/terraform/1.0.7/terraform_1.0.7_linux_amd64.zip`
    - `unzip terraform_1.0.7_linux_amd64.zip`
    - `mkdir ~/bin`
    - `mv terraform ~/bin`
    - `export TF_PLUGIN_CACHE_DIR="/tmp"`

4. Deploy Terraform infrastructure
    - Clone the starter code from the git repo to a folder CloudShell
    - `cd` into the `starter` folder
    - `terraform init`
    - `terraform apply`

5. At the end of your lesson, run `terraform destroy` and allow it to destroy all your resources