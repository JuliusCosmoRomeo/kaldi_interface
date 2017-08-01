#/bin/bash
if [ $1 = "--help" ]
then
  echo "Expected format: ./train modelname data-dir"
  exit
fi


if [ $# -lt 2 ]
then
  echo "Not enough parameters. Expected format: ./decode modelname test-dir"
  echo "Available modelnames: "
  ls kaldi/egs/
  exit
else 
  if [ -d ~/kaldi/egs/$1 ]
  then 
    echo "~/kaldi/egs/$1/s5"
    if [ -f ~/kaldi/egs/$1/s5/decode.sh ]
    then 
       cd ~/kaldi/egs/$1/s5/
       ./decode.sh $2
    fi
  fi
fi
