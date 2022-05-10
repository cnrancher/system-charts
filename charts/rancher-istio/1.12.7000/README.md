# Istio

[Istio](https://istio.io/) is an open platform for providing a uniform way to integrate microservices, manage traffic flow across microservices, enforce policies and aggregate telemetry data.

The documentation here is for developers only, please follow the installation instructions from [istio.io](https://istio.io/docs/setup/kubernetes/install/helm/) for all other uses.

## Introduction

This chart bootstraps all Istio [components](https://istio.io/docs/concepts/what-is-istio/) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Chart Details

This chart can install multiple Istio components as subcharts:
- ingressgateway
- egressgateway
- istiod
- tracing(jaeger)
- kiali

To enable or disable each component, change the corresponding `enabled` flag.

## Prerequisites

- Kubernetes 1.9 or newer cluster with RBAC (Role-Based Access Control) enabled is required
- Helm 3.1.1 or newer or alternately the ability to modify RBAC rules is also required
- If you want to enable automatic sidecar injection, Kubernetes 1.9+ with `admissionregistration` API is required, and `kube-apiserver` process must have the `admission-control` flag set with the `MutatingAdmissionWebhook` and `ValidatingAdmissionWebhook` admission controllers added and listed in the correct order.

## Resources Required

The chart deploys pods that consume minimum resources as specified in the resources configuration parameter.

## Installing the Chart

1. Set and create the namespace where Istio was installed:

    ```bash
    $ NAMESPACE=istio-system
    $ kubectl create ns $NAMESPACE
    ```

1. If you are enabling `kiali`, you need to create the secret that contains the username and passphrase for `kiali` dashboard:

    ```bash
    $ echo -n 'admin' | base64
    YWRtaW4=
    $ echo -n '1f2d1e2e67df' | base64
    MWYyZDFlMmU2N2Rm
    $ cat <<EOF | kubectl apply -f -
    apiVersion: v1
    kind: Secret
    metadata:
      name: kiali
      namespace: $NAMESPACE
      labels:
        app: kiali
    type: Opaque
    data:
      username: YWRtaW4=
      passphrase: MWYyZDFlMmU2N2Rm
    EOF
    ```

1. To install the chart with the release name `istio` in namespace $NAMESPACE you defined above:

    - With [automatic sidecar injection](https://istio.io/docs/setup/kubernetes/sidecar-injection/#automatic-sidecar-injection) (requires Kubernetes >=1.9.0):

        ```bash
        $ helm install istio 
                --set global.systemDefaultRegistry="docker.io" \
                --set global.tag="1.12.7" \
                --set global.jwtPolicy=first-party-jwt \
                --namespace $NAMESPACE
        ```

## Configuration

The Helm chart ships with reasonable defaults.  There may be circumstances in which defaults require overrides.
To override Helm values, use `--set key=value` argument during the `helm install` command.  Multiple `--set` operations may be used in the same Helm operation.

Helm charts expose configuration options which are currently in alpha.  The currently exposed options can be found [here](https://istio.io/docs/reference/config/installation-options/).

## Uninstalling the Chart

To uninstall/delete the `istio` release but continue to track the release:

```bash
$ helm delete istio --namespace $NAMESPACE
```

To uninstall/delete the `istio` release completely and make its name free for later use:

```bash
$ helm delete --purge istio --namespace $NAMESPACE
```

To delete CRDs permanently removes any Istio resources you have created in your cluster. To permanently delete Istio CRDs installed in your cluster:

```bash
$ kubectl get crd | grep --color=never 'istio.io' | awk '{print $1}' \
    | xargs -n1 kubectl delete crd
```