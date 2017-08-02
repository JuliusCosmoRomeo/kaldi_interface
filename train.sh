
#/bin/bash

if [ $1 = "--help" ]
then 
  echo "Expected format: ./train.sh modelname //expects data to be located under /data/models/modelname/wav"
  echo "                 ./train.sh modelname data-dir [utterance-postfix]"
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
  echo "Not enough parameters. Expected format: ./train.sh modelname data-dir [utterance-postfix]"
  echo "Available postfixes are:
_Kinect-Beam
_Samson
_Kinect-RAW
_Realtek
_Yamaha"

  exit
else
  if [ -d /data/models/$1/s5 ]
  then
    echo "Model already exists: exiting"
    exit
  else
    echo "Training new model with name $1"
    #clone default model
    cd /data/models/
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
      
        ln -s $2/train /data/models/$1/s5/data/wav/
        echo "Linked train"
        ln -s $2/test /data/models/$1/s5/data/wav/
        echo "Linked test"
        ln -s $2/dev /data/models/$1/s5/data/wav/
        echo "Linked dev"
        cd /data/models/
     fi
    else
      echo "Linking data from /data/models/$1/wav/ to the data dir of the model"
      ln -s /data/models/$1/wav/train /data/models/$1/s5/data/wav/
      echo "Linked train"
      ln -s /data/models/$1/wav/test /data/models/$1/s5/data/wav/
      echo "Linked test"
      ln -s /data/models/$1/wav/dev /data/models/$1/s5/data/wav/
      echo "Linked dev"
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


