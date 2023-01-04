# image-updater
Tool to update image tags in Kubernetes manifests

```
image-updater -l tag phillip/image-updater-test/values.yaml v0.2
```

# How To Use
In order to use this you need to supply a `GITHUB_TOKEN` environment variable to the running docker. That way it can authenticate with githubs api.
