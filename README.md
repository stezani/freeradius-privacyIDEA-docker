# freeradius-privacyIDEA-docker
a dockerfile ready to go with freeradius and privacyIDEA

# Build container
in same folder of Dockerfile you must use:
```
docker buildx build . -t <container_name>
```

Then after build, this image is stored in local registry on host machine. 
If you want use docker-compose.yaml file to run the image, you must change the image name inside the file (for me is frlep).
Then with simple `docker-compose up -d``` the container start.

