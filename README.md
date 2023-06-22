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
where form me `privacyidea_radius.pm` is located in config/mods-config/perl
If you need the `privacyidea_radius.pm` file you can retrieve it once you have installed privacyIDEA and you can find it under `/usr/share/privacyidea/freeradius/privacyidea_radius.pm`
- you must create a symlink under mods-enabled with
```
$> cd ../mods-enabled/
$> ln -s ../mods-available/perl perl
```
- append to config/users file the string:
```
DEFAULT Auth-Type := perl
```
- create new file located in config/sites-available/privacyidea (you can use my file in repository `privacyidea`)

- create a symlink under config/sites-enabled like this:
```
$> cd config/sites-enabled
$> ln -s ../sites-available/privacyidea privacyidea
```
- create a file rlm_perl.ini under config/ folder like this
```
# RLM_PERL.INI
[Default]
URL = https://your_privacyIDEA_installation/validate/check
#REALM = someRealm
#RESCONF = someResolver
SSL_CHECK = true
#DEBUG = true
TIMEOUT = 30
```
- change the path in privacyidea_radius.pm:
```
our @CONFIG_FILES = ("/etc/privacyidea/rlm_perl.ini", "/etc/freeradius/rlm_perl.ini", "/opt/privacyIDEA/rlm_perl.ini");
```

After this changes, you must restart your container: if there are some issues check the `radiusd.log`
