# K8S Operators

A repository to test out the functionality of Kubernetes Operators.

## Usage

### Start Minikube and Enable Ingress

```bash
# start minikube and enable the ingress addon
minikube start && minikube addons enable ingress
```

### Create a New Operator

This guide was adapted from [here](https://book.kubebuilder.io/quick-start.html#create-a-project).

```bash
# set the environment variables
export OPERATOR_NAME=k8sop
export USER_NAME=kallepan
export DOMAIN=server.io 

export GROUP=batch
export KIND=CronJob

# create a new directory for the project
mkdir -p project && cd project

# initialize the project
kubebuilder init --repo github.com/$USER_NAME/$OPERATOR_NAME --domain $DOMAIN --owner $USER_NAME --project-name $OPERATOR_NAME

# create the API
kubebuilder create api --version v1alpha1 --group $GROUP --kind $KIND

# create the webhook
kubebuilder create webhook --group $GROUP --version v1alpha1 --kind $KIND --defaulting --programmatic-validation

# generate the manifests
make manifests

# Install the CRDs into the cluster
make install

# run the controller (for debugging)
make run

# apply the CRD to the cluster
kubectl apply -k config/samples/

# Run the controller in the background
make docker-build docker-push IMG=docker.io/$USER_NAME/$OPERATOR_NAME:latest

# deploy the controller onto the cluster
make deploy IMG=docker.io/$USER_NAME/$OPERATOR_NAME:latest

# uninstall the controller
make undeploy

# uninstall the CRD
make uninstall
```