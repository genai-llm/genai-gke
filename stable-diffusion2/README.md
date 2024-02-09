
# GenAI on GKE

There are two ways to deploy the GenAI workloads on GCP

1) Using shell editor tutorial

2) Using manual approach

# Using shell editor tutorial

Click button below
#
[![Deploy using Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://ssh.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/genai-llm/genai-gke.git&cloudshell_tutorial=stable-diffusion2/tutorial.md&cloudshell_workspace=./)

This repository contains assets related to AI/ML workloads on
[Google Kubernetes Engine (GKE)](https://cloud.google.com/kubernetes-engine/).


## Important Note
The use of the assets contained in this repository is subject to compliance with [Google's AI Principles](https://ai.google/responsibility/principles/)

## Licensing

* See [LICENSE](/LICENSE)


**Below are the variables required to get the GKE cluster up with Autopilot / standard , private / public , TPU enabled / Disabled , GPU Enabled / Disabled etc . So please go through below variables to understand if those are required to be changed or not.**
#

<!-- BEGIN TFDOC -->
##  [`GKE Infra Variables`](../platform/platform/variables.tf)

| name | description | type | required | default |
|---|---|:---:|:---:|:---:|
| project_id | Project in which GKE cluster will be created | <code>string</code> | ✓ |  |
| region | Compute zone or region. | <code>string</code> | ✓ |  |
| services | GCP services to be enabled | <code>list(string)</code> | ✓ |  |
| service_config | Configure service API activation i.e. wether to deiable or not on destroy | <code title="object&#40;&#123;&#10;  labels   &#61; optional&#40;map&#40;string&#41;&#41;&#10;  metadata &#61; optional&#40;map&#40;string&#41;&#41;&#10;&#125;&#41;">object&#40;&#123;&#8230;&#125;&#41;</code> |  | <code>null</code> |
| create_network | Whether you need a new VPC | <code>bool</code> |  |  |
| network_name | VPC Network Name | <code>string</code> |  |  |
| subnetwork_name | VPC Sub-Network Name | <code>string</code> |  |  |
| subnetwork_cidr | VPC Sub-Network CIDR | <code>string</code> |  |  |
| subnetwork_region | Subnet region | <code>string</code> |  |  |
| subnetwork_private_access | Whether subnet has Private google access enabled | <code>bool</code> |  |  |
| subnetwork_description | VPC Sub-Network description | <code>string</code> |  |  |
| network_secondary_ranges | subnet secondary ranges to help pods and service ip allocation  | <code>map(list(object({ range_name = string, ip_cidr_range = string })))</code> |  |  |
| create_cluster | Create a new cluster or use current cluster | <code>bool</code> |  |  |
| private_cluster | Create public or private cluster | <code>bool</code> |  |  |
| autopilot_cluster | Create autopilot or standard cluster | <code>bool</code> |  |  |
| cluster_name | Cluster Name | <code>string</code> |  |  |
| cluster_regional | Create regional or zonal cluster | <code>bool</code> |  |  |
| cluster_labels | labels to be attached to cluster | <code>map</code> |  |  |
| kubernetes_version | Version of K8s | <code>string</code> |  | latest |
| cluster_region | Region for cluster | <code>string</code> |  |  |
| cluster_zones | Cluster Zones  | <code>string</code> |  |  |
| ip_range_pods | name for pod range | <code>string</code> |  |  |
| ip_range_services | name for service range | <code>string</code> |  |  |
| monitoring_enable_managed_prometheus | enable managed prometheus | <code>bool</code> |  |  |
| master_authorized_networks | master authorized networks | <code>list(object({cidr_block=string,display_name= optional(string)}))</code> |  |  |
| all_node_pools_oauth_scopes | list of allowed api's| <code>list(string)</code> |  |  |
| all_node_pools_labels | labels to be applied on node pools | <code>map(string)</code> |  |  |
| all_node_pools_metadata | metadata to be applied on node pools | <code>map(string)</code> |  |  |
| all_node_pools_tags | tags to be applied on node pools | <code>map(string)</code> |  |  |
| enable_tpu | enable or diable TPU | <code>bool</code> |  | false  |
| enable_gpu | enable or diable gpu | <code>bool</code> |  | true  |
| cpu_pools | Information about cpu node pools ( please check example in shared terraformtfvars file ) | <code>list(map(any))</code> |  |  |
| tpu_pools | Information about tpu node pools ( please check example in shared terraformtfvars file ) | <code>list(map(any))</code> |  |  |
| gpu_pools | Information about gpu node pools ( please check example in shared terraformtfvars file ) | <code>list(map(any))</code> |  |  |
<!-- END TFDOC -->

**Simlilarly below is the file for updating variables for creating Jupyternotebook**

## [`Jupyternotebook Variables`](../jupyternotebook/variables.tf)

| name | description | sensitive |
|---|---|:---:|
| project_id | Project containing the GKE cluster |  |
| region | Region of GKE Cluster |  |
| cluster_name | GKE Cluster name |  |


Also If any changes are required in terms of how the jupyternotebook needs to be deployed changes are required to the below file
[`config`](../jupyternotebook/jupyter_config/config.yaml)

**we have pre-baked a container image used in the above config file to spin up the jupyter notebook capable of running the genai workloads on gke --> us-docker.pkg.dev/genai-poc-403304/jupyter-gpu/jupyter-gpu:mistralv2
which has all required pytorch and cuda components already installed**


Stable Diffusion has  [`two files`](./stable_diffusion_on_ray.ipynb) to be tested on notebooks

# Using manual approach

## Architecture
Defaults:
- Creates a new VPC & subnet (can be disabled)
- Creates Private Clusters with external endpoints disabled
- Registers the cluster with fleet in current project
- Solution uses Anthos Connect Gateway to connect to private clusters

You'll be performing the following activities:

1. Set project-id for gcloud CLI
2. Update terraform variable values to create infrastructure
3. Update terraform variable values to provide workload configuration
4. Create a GCS bucket to store terraform state
5. Create GKE Cluster with Fleet Membership Enabled
6. Created Jupyternotebook K8s Object to spin Notebooks
7. Deploy Demo stable-diffusion2 workload


To get started, click **Next**.

## Step 0: Set your project
To set your Cloud Platform project for this terminal session use:
```bash
gcloud config set project [PROJECT_ID]
```
All the resources will be created in this project

## Step 1: Provide Inputs Parameters for Terraform to Provision GKE Cluster

Here on step 1 you need to update the terraform tfvars file (located in ./platform/platform/terraform.tfvars) to provide the input parameters to allow terraform code execution to provision GKE resources. This will include the input parameters in the form of key value pairs. Update the values as per your requirements.

<walkthrough-editor-open-file filePath="./platform/platform/terraform.tfvars"> Open terraform.tfvars
</walkthrough-editor-open-file>

Update all values where required.

**Tip**: Click the highlighted text above to open the file in your cloudshell editor.

You can find tfvars examples in the tfvars_examples folder at location ./platform.




## Step 2: Configure Terraform GCS backend

You can also configure the GCS bucket to persist the terraform state file for further usage. To configure the terraform backend you need to have a GCS bucket already created.


### Create GCS Bucket
In case you don't have a GCS bucket already, you can create using terraform or gcloud command as well. Refer below for the gcloud command line to create a new GCS bucket.
```bash
gcloud storage buckets create gs://BUCKET_NAME
```
**Tip**: Click the copy button on the side of the code box to paste the command in the Cloud Shell terminal to run it.


### Modify PLATFORM Terraform State Backend

Modify the ./platform/backend.tf and uncomment the code and update the backend bucket name.
<walkthrough-editor-open-file filePath="./platform/platform/backend.tf"> Open ./platform/platform/backend.tf
</walkthrough-editor-open-file>

After changes file will look like below:
```terraform
terraform {
 backend "gcs" {
   bucket  = "BUCKET_NAME"
   prefix  = "terraform/state"
 }
}
```

Refer [here](https://cloud.google.com/docs/terraform/resource-management/store-state) for more details.



## Step 3: Run Terrafrom Plan and Apply

Run Terrform plan and check the resources to be created , please make changes if any required to terraform files as required and then run terrafrom apply
```bash
cd ~/genai-gke/platform/platform/
terraform plan
terraform apply
```


## Step 4: Provide Inputs Parameters for Terraform to Provision jupyternotebook workloads

Here on step 4 you need to update the terraform variable file (located in ./jupyternotebook/variables.tf) to provide the input parameters to allow terraform code execution to provision Jupyternotebook. Please update the helm values for changing the resource allocation or the image used in the file (located in ./jupyternotebook/jupyter_config/config.yaml )

<walkthrough-editor-open-file filePath="./jupyternotebook/variables.tf"> Open variables.tf
</walkthrough-editor-open-file>

<walkthrough-editor-open-file filePath="./jupyternotebook/jupyter_config/config.yaml"> Open config.yaml
</walkthrough-editor-open-file>


Also Update the Backend here
<walkthrough-editor-open-file filePath="./jupyternotebook/backend.tf"> Open backend.tf
</walkthrough-editor-open-file>

## Step 5: Run Terrafrom Plan and Apply

Run Terrform plan and check the resources to be created , please make changes if any required to terraform files as required and then run terrafrom apply
```bash
cd ~/genai-gke/jupyternotebook
terraform plan
terraform apply
```

## Step 6: Create a Notebook on Jupyternotebook
Open the exposed service for creating the notebook
Copy the content from the stable-diffusion2 pynb files and paste it on the open notebook and run the same to test.
<walkthrough-editor-open-file filePath="./stable-diffusion2/stable_diffusion_inference_on_ray.ipynb"> Demo stablediffusion1 pynb
</walkthrough-editor-open-file>

<walkthrough-editor-open-file filePath="./lstable-diffusion2/stable_diffusion_on_ray.ipynb"> Demo stablediffusion2 pynb
</walkthrough-editor-open-file>

## Step 7: Delete resources created

You can now delete the resources by running below command in the ~/genai-gke/jupyternotebook and then in  ~/genai-gke/platform/platform/ folders


```bash
terraform destroy
```
