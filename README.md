# tpl-gen

## INTRO
The best shell envokable shell generator out there ... 

## SETUP & INSTALL

## Pre-requesites
- bash
- make
- docker
- jq


## GET THE SOURCE
To avoid any file permissions errors use a conventional dir to clone the project into.
```bash
mkdir -p ~/opt/ ; cd $_ # ~/opt/ is just a convention
git clone git@github.com:csitea/tpl-gen.git
cd ~/opt/tpl-gen
find . | sort | less
```

## CHECK THE USAGE
The make is usually used for oneliners to deploy / install project components
```bash
make
```

The `./run` is usually used for oneliners to run quick actions
```bash
./run --help



```

### SETUP DOCKER ENVIRONMENT
The tpl-gen docker has all the needed binaries create configuration files from templates.
```bash
# always go to the project root dir - aka the product dir
cd ~/opt/tpl-gen

make clean-install-tpl-gen  # install without reusing layers
make install-tpl-gen        # install from cached layers (faster)

# generate the templates 
ORG=org APP=app ENV=dev make do-tpl-gen
```


