# Rancher Logging

* Installs [Fluentd](https://www.fluentd.org/) and flexvolume log driver to collect container logs in Rancher

## Introduction

This chart bootstraps a [Fluentd](https://www.fluentd.org/) daemonset and a [Log-Aggregator](https://github.com/rancher/log-aggregator) flexvolume on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.
It's use for sends logs to log target config in rancher.

## Prerequisites

- Rancher 2.1+

## 自定义 fluentd 配置路径

以下为日志收集中 fluentd 配置的相关默认路径，如果主机对应路径有变化，请通过应答自定义主机路径。

### 主机日志路径

```bash
fluentd.fluentd-linux.cluster.dockerRoot=/var/lib/docker
fluentd.fluentd-linux.cluster.custom=/var/lib/rancher/fluentd/etc/config/custom
fluentd.fluentd-linux.cluster.varlogcontainers=/var/log/containers
fluentd.fluentd-linux.cluster.varlogpods=/var/log/pods
fluentd.fluentd-linux.cluster.rkelog=/var/lib/rancher/rke/log
fluentd.fluentd-linux.cluster.customlog=/var/lib/rancher/log-volumes
fluentd.fluentd-linux.cluster.fluentdlog=/var/lib/rancher/fluentd/log
fluentd.fluentd-linux.cluster.libsystemddir=/usr/lib64
```

