## aws-utils

> ssm
* aws ssm start-session utils
* you should create your own conf.yaml under the ssm directory. 
* to exec ssm/ssm.sh, you should register the ssm.sh to the PATH
* Dependancies
  * yq 
    + install 
```sh   
brew install yq
```
* Launch
```
export PATH="${PWD}:$PATH"
ssm.sh
```
