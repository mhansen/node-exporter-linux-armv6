# Node-Exporter for armV6 cpus
This is a dockerfile for building the node exporter image for armV6 cpus, such as the on used on the raspberry pi zero w (Version 1). If you are here, you know what node-extractor does :)

## Build instructions
Due to the limited performance of such cpus, building the image directly on platform is not recomended and cross compilation is. Below, are the recomended instruction for building the image and deploying the container

1. Create the cross-compiler builder:
```
docker buildx create --name mybuilder --use
```
2. Build the docker image and save it as tar:
```
docker buildx build --platform linux/arm/v6 -t <image_name> -f node-exporter.Dockerfile --output type=docker,dest=<tar_file>.tar .
```
3. Send the tar file to the target device (over scp for example)
4. On the target device, load the image:
```
docker load < <tar_file>.tar
```
5. Run the container
```
docker run -d --name node-exporter -p 9100:9100 <image_name>
```
