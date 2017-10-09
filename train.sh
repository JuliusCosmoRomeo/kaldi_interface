#!/bin/bash

if [ $1 = "--help" ]
then 
  echo "Expected format: /kaldi_interface/train.sh modelname //expects data to be located under /data/models/modelname/wav"
  echo "                 /kaldi_interface/train.sh modelname data-dir [utterance-postfix]"
  echo "Available postfixes are:"
echo "_Kinect-Beam
_Samson
_Kinect-RAW
_Realtek
_Yamaha"
  exit
fi

#TODO: check if data dir correct
if [ $# -lt 1 ]
then
  echo "Not enough parameters. Expected format: /kaldi_interface/train.sh modelname data-dir [utterance-postfix]"
  echo "Available postfixes are:
_Kinect-Beam
_Samson
_Kinect-RAW
_Realtek
_Yamaha"

  exit
else
  if [ -d /models/$1 ]
  then
    echo "Model already exists. To train a model with the name '$1' you need to remove the model in the directory /models/$1 first: exiting"
    exit
  else
    if [ ! -d /data ]
    then 
      echo "No /data-directory found. Please mount your host-directory containing train-/test-data into /data in the docker container."
      exit
    fi
    echo "Training new model with name $1"
    if [ ! -d /models ]
    then 
      echo "Creating /models"
      mkdir /models
    fi
    cd /models/
    echo "Creating model '$1' from default model."
    #clone default model
    #git clone https://github.com/JuliusCosmoRomeo/kaldi-tuda-de.git --branch other_lex --single-branch $1
    git clone https://github.com/JuliusCosmoRomeo/kaldi-tuda-de.git $1
    #copy data to dir
    if [ $# -ge 2 ]
    then
      if [ -f $2/download.sh ]
      then
        cd $2
        echo "Downloading data"
        ./download.sh
      else
        echo "Linking data from $2 to the data dir of the model"
      fi
      ln -s $2/train /models/$1/s5/data/wav/
      ln -s $2/test /models/$1/s5/data/wav/
      ln -s $2/dev /models/$1/s5/data/wav/
      cd /models/
    fi
    if [ -L /models/$1/s5/data/wav/train ]
    then 
      echo "Linked train"
    else 
      echo "Data could not be linked to /models/$1/s5/data/wav/. Not processing further."
      exit
    fi
    if [ -L /models/$1/s5/data/wav/test ]
    then 
      echo "Linked test"
    else 
      echo "Data could not be linked to /models/$1/s5/data/wav/. Not processing further."
      exit
    fi
    if [ -L /models/$1/s5/data/wav/dev ]
    then 
        echo "Linked dev"
    else 
        echo "Data could not be linked to /models/$1/s5/data/wav/. Not processing further."
        exit
    fi 
    cd /models/$1/s5
    echo "Starting maryTTS in the background"
    nohup /opt/mary/marytts-5.1.1/marytts-5.1.1/bin/marytts-server &
    sleep 15s
    if [ $# = 3 ]
    then
      ./run.sh $3
    else 
      ./run.sh
    fi
  fi
fi


