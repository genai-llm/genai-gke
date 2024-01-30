# GenAI on GKE

[![Deploy using Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://ssh.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/genai-llm/genai-gke.git&cloudshell_tutorial=stable-diffusion2/tutorial.md&cloudshell_workspace=./)

This repository contains assets related to AI/ML workloads on
[Google Kubernetes Engine (GKE)](https://cloud.google.com/kubernetes-engine/).


## Important Note
The use of the assets contained in this repository is subject to compliance with [Google's AI Principles](https://ai.google/responsibility/principles/)

## Licensing

* See [LICENSE](/LICENSE)


**Below are the variables required to get the GKE cluster up with Autopilot / standard , private / public , TPU enabled / Disabled , GPU Enabled / Disabled etc . So please go through below varibales to understand if those are required to be changed or not.**
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

Stable Diffusion has  [`two files`](./stable_diffusion_on_ray.ipynb) to be tested on notebooks
