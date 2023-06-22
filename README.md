# freeradius-privacyIDEA-docker
a dockerfile ready to go with freeradius and privacyIDEA

## Build container
in same folder of Dockerfile you must use:
```
docker buildx build . -t <container_name>
```

Then after build, this image is stored in local registry on host machine. 
If you want use docker-compose.yaml file to run the image, you must change the image name inside the file (for me is frlep).
Then with simple `docker-compose up -d` the container start.

## Prepare container for privacyIDEA
if you start the container with docker-compose, you must create two folder as specified in the yaml file:
```
config <--- here the container share with host machine the freeradius config folder (located on container inside in /etc/raddb)
log <--- for radiusd.log file
```

Once first startup the container will creates the basic files to run. My advice is to stopping the container, then modify these files:
- conf/clients.conf with your clients. Here's a sample:
```
client client_name{
  ipaddr = client_ip_address/31
  secret = super_secret_password
}
```
- conf/mods-available/perl with
```
perl {
  filename = ${modconfdir}/${.:instance}/privacyidea_radius.pm
  perl_flags = "-T"
}
```
