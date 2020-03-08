#!/bin/bash -e

SDIR=$(dirname $0)
CONF="conf.yaml"

if [ ! -f $SDIR/$CONF ]; then 
  CONF=$SDIR/ssm/$CONF
fi 

function haveYq() {
  which yq > /dev/null
  if [ "$?" == "1" ]; then 
    echo "Instal yq first. ==> https://mikefarah.gitbook.io/yq"
  fi 
}

function _print_ec2() {
  echo "Select EC2"
  len=$(yq r $CONF --length ec2)
  for (( i=0; i<$len; i++ )); do
    echo $i: $(yq r $CONF -j "ec2.[$i]" |  jq  .'name')
  done
}

function _print_profile() {
  echo "Select profile"
  len=$(yq r $CONF --length profile)
  for (( i=0; i<$len; i++ )); do
    echo $i: $(yq r $CONF -j "profile.[$i]" | jq  .'name')
  done
}

function print(){
  if [ "$1" == "ec2" ]; then 
    _print_ec2
  fi 
  if [ "$1" == "profile" ]; then 
    _print_profile
  fi 
}

function main() {
  haveYq
  print "ec2"
  read ec2_idx
  print "profile"
  read prof_idx

  inst=$(yq r $CONF ec2.[$ec2_idx].'id')
  prof=$(yq r $CONF profile.[$prof_idx].'name')

  aws ssm start-session --target $inst --profile $prof

}

main