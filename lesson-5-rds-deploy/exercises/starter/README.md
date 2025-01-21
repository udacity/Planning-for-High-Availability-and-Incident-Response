# Instructions
1. Open your AWS console

2. Change your region to `us-east-2`. From the AWS console create an S3 bucket in `us-east-2` called `udacity-tf-<your_name>` e.g `udacity-tf-tscotto`
    - click next until created.
    - Update `_config.tf` in the `starter/zone1` folder with your S3 bucket name where you will replace `<your_name>` with your name

3. Change your region to `us-west-1`. From the AWS console create an S3 bucket in `us-west-1` called `udacity-tf-west-<your_name>` e.g `udacity-tf-west-tscotto`
    - click next until created.
    - Update `_config.tf` in the `starter/zone12` folder with your S3 bucket name where you will replace `<your_name>` with your name

4. Setup your CloudShell. Open CloudShell in the `us-east-2` region. Install the following:

- terraform
    - `wget https://releases.hashicorp.com/terraform/1.10.3/terraform_1.10.3_linux_amd64.zip`
    - `unzip terraform_1.10.3_linux_amd64.zip`
    - `mkdir ~/bin`
    - `mv terraform ~/bin`

5. Deploy Terraform infrastructure zone1
    - Clone the starter code from the git repo to a folder CloudShell
    - `cd` into the `starter/zone1` folder
    - `terraform init`
    - `terraform apply`

6. Deploy Terraform infrastructure zone1
    - Clone the starter code from the git repo to a folder CloudShell
    - `cd` into the `starter/zone1` folder
    - `terraform init`
    - `terraform apply`

## Destroy it all
### Step 1: Destroy Resources in Zone 1 Folder

1. Open the **zone1** folder.
2. Run the following command to destroy the specific AWS RDS cluster resource:

   ```
   terraform destroy -target=module.project_rds_p.aws_rds_cluster.udacity_cluster
   ```

   This command will delete the RDS cluster named `udacity_cluster` managed by the `project_rds_p` module in the `zone1` folder.

---

### Step 2: Destroy All Resources in Zone 2 Folder

1. Open the **zone2** folder.
2. Run the following command to destroy **all** Terraform-managed resources in the `zone2` folder:

   ```
   terraform destroy
   ```

   This will remove all resources that are defined in the `zone2` configuration.

---

### Step 3: Destroy All Resources in Zone 1 Folder

1. Return to the **zone1** folder.
2. Run the following command to destroy **all** resources in the `zone1` folder:

   ```
   terraform destroy
   ```

   This will remove all resources that are defined in the `zone1` configuration.