
#/bin/bash

#TODO: check if data dir correct
if [ $# -lt 1 ]
then
  echo "Not enough parameters. Expected format: ./train modelname data-dir"
  exit
else
  if [ -d ~/kaldi/egs/$1 ]
  then
    echo "Model already exists: exiting"
    exit
  else
    echo "Training new model with name $1"
    #clone default model
    #does git have the right authorisation here?
    cd kaldi/egs/
    git clone https://github.com/JuliusCosmoRomeo/kaldi-tuda-de.git $1
    #copy data to dir
    if [ $# -ge 2 ]
    then 
      echo "Copying data from $2 to the data dir of the model"
      cd $2
      cp -r train ~/kaldi/egs/$1/s5/data/wav/
      echo "Copied train"
      cp -r test ~/kaldi/egs/$1/s5/data/wav/
      echo "Copied test"
      cp -r dev ~/kaldi/egs/$1/s5/data/wav/
      echo "Copied dev"
      cd ~/kaldi/egs/
    else
      cp -r /data/wav/train ~/kaldi/egs/$1/s5/data/wav/
      echo "Copied train"
      cp -r /data/wav/test ~/kaldi/egs/$1/s5/data/wav/
      echo "Copied test"
      cp -r /data/wav/dev ~/kaldi/egs/$1/s5/data/wav/
      echo "Copied dev"
    fi
    cd $1/s5
    if [ $# = 3 ]
    then
      ./run.sh $3
    else 
      ./run.sh
    fi
  fi
fi


