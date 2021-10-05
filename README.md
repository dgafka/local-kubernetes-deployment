# Testing Helm Charts on Local Kubernetes Cluster

## Running the example
``` Before running go to follow the installation instructions ```

To run the example run `./run-example.sh`  
It first will build example docker image from Dockerfile (which mimic your local application and changes you have made to it)  
And then it will deploy this image to your local cluster.

After running you will get in the console information access to your deployed application. Like the one below:

    Get the application URL by running these commands:
    export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=demo,app.kubernetes.io/instance=demo-chart" -o jsonpath="{.items[0].metadata.name}")
    kubectl --namespace default port-forward $POD_NAME 8080:80

Then visit http://127.0.0.1:8080 to use your application

## Installation for Linux/macOS/Windows

``Important! Before installing, upgrade your local docker to newest version``

### 1. Install [kind](https://kind.sigs.k8s.io/docs/user/quick-start#installation) for chosen OS, to run the cluster on your local machine

**On Linux:**

    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind

**On macOS via Homebrew:**

    brew install kind

**On macOS via Bash:**

```
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-darwin-amd64
    chmod +x ./kind
    mv ./kind /usr/local/bin/kind
```   

**On Windows:**

```
    curl.exe -Lo kind-windows-amd64.exe https://kind.sigs.k8s.io/dl/v0.11.1/kind-windows-amd64
    Move-Item .\kind-windows-amd64.exe c:\some-dir-in-your-PATH\kind.exe
```

### 2. Install [ctlptl](https://github.com/tilt-dev/ctlptl#how-do-i-install-it), to configure Local Kubernetes Cluster with Docker Registry

**On Linux**

```   
   CTLPTL_VERSION="0.5.7"
   curl -fsSL https://github.com/tilt-dev/ctlptl/releases/download/v$CTLPTL_VERSION/ctlptl.$CTLPTL_VERSION.linux.x86_64.tar.gz | sudo tar -xzv -C /usr/local/bin ctlptl
```

**On macOS via Homebrew:**

```
   brew install tilt-dev/tap/ctlptl
```   

**On macOS via Bash:**

```
   CTLPTL_VERSION="0.5.7"
   curl -fsSL https://github.com/tilt-dev/ctlptl/releases/download/v$CTLPTL_VERSION/ctlptl.$CTLPTL_VERSION.mac.x86_64.tar.gz | sudo tar -xzv -C /usr/local/bin ctlptl
```

**On Windows:**

```
   scoop bucket add tilt-dev https://github.com/tilt-dev/scoop-bucket
   scoop install ctlptl
```

### 3. Install [kubectl](https://kubernetes.io/docs/tasks/tools/) for calling Cluster API

**On Linux**

```   
   curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
   sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

**On macOS via Homebrew:**

```
   brew install kubectl 
```

**On Windows:**

```
   curl -LO "https://dl.k8s.io/release/v1.22.0/bin/windows/amd64/kubectl.exe"
   Add the binary in to your PATH
```

### 4. Create Cluster and Registry

```
ctlptl create registry ctlptl-registry --port=5000
ctlptl create cluster kind --registry=ctlptl-registry
```

### 5. As we are using [Helm](https://helm.sh/docs/intro/install/) in this example, we need to install it.
In can be used with general K8S manifests directly too.

**On Linux**

```   
    curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
    sudo apt-get install apt-transport-https --yes
    echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
    sudo apt-get update
    sudo apt-get install helm
```

**On macOS via Homebrew:**

```
   brew install helm
```

**On Windows:**

```
   choco install kubernetes-helm
```