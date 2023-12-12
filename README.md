# GenAI on GKE



This repository contains assets related to GenAI workloads on
[Google Kubernetes Engine (GKE)](https://cloud.google.com/kubernetes-engine/).

Please follow below order to get the models tested,


#### Create Infrastructure
Platform module can be used to create a GKE cluster. Please check README file in the platform folder

```commandline
cd platform
```

#### Deploy Jupyterhub
If you have a GKE cluster running already with GPU enabled Node pools then run then follow instructions in the readme mentioned within the jupyternotebook folder , else complete the above step to create the infrastructure

```commandline
cd jupyternotebook
```

#### Run GenAI Models

We have created running and tested notebooks for below mentioned GenAI models

 - Falcon
 ```commandline
cd falcon
```
 - Stable Diffusion
 ```commandline
cd stable-diffusion2
```
 - llama2
 ```commandline
cd llama2-7b-huggingface-gradio
```
 - Openai
 ```commandline
cd openai
```

there are two ways to deploy the workloads either to run the notebooks directly on Jupyter Hub or you can use UI based inference provided through stream lit or Gradio code for which is available in the respective model folders

## Important Note
The use of the assets contained in this repository is subject to compliance with [Google's AI Principles](https://ai.google/responsibility/principles/)

## Licensing

* See [LICENSE](/LICENSE)
