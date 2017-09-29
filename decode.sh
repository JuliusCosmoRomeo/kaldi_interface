#!/bin/bash
if [ $1 = "--help" ]
then
  echo "Expected format: /kaldi_interface/decode.sh modelname test-dir"
  exit
fi


if [ $# -lt 2 ]
then
  echo "Not enough parameters. Expected format: /kaldi_interface/decode modelname test-dir"
  echo "Available modelnames: "
  ls kaldi/egs/
  exit
else 
  if [ ! -d /models ]
  then 
    echo "The directory /models does not exist. Please put your pre-built models into the /models-directory or train a new model with the train.sh-command."
    exit
  fi
  if [ -d /models/$1 ]
  then 
    echo "Model $1 found."
    if [ -f /models/$1/s5/decode.sh ]
    then 
       text_file_exists=0
       if [ -f $2/text ]
       then
         text_file_exists=1
       fi
       cd /models/$1/s5/data
       ln -s $2/* ./
       
       rm ./wav.scp
       dir_name=$2
       if [ ${dir_name: -1} = "/" ]
       then
         dir_name=${dir_name::-1}
       fi
       dir_name=${dir_name##*/}
       echo $dir_name

       if [ ! -d $dir_name ]
         then
         mkdir $dir_name
       fi
       cd $dir_name
       for file in $( find ./ -name "*.wav" ); do
         filename=${file%.wav}
	 echo "Found file $file"
         if ! grep -Fq "${filename##*/}" ./wav.scp
         then 
           echo "${filename##*/} data/decoding/${file##*/}" >> ./wav.scp
           echo "Wrote to wav.scp"
         fi
         if ! grep -Fq "${filename##*/}" ./utt2spk
         then
           echo "${filename##*/} ${filename##*/}" >> ./utt2spk
           echo "Wrote to utt2spk"
         fi
	 if [ text_file_exists = 0 ]
	 then
           if ! grep -Fq "${filename##*/}" ./text 
           then 
             echo "${filename##*/} None" >> ./text
             echo "Wrote to text"
           fi
	 fi
       done
       nohup /opt/mary/marytts-5.1.1/marytts-5.1.1/bin/marytts-server &
       sleep 15s
       cd /models/$1/s5/
       wget -O decode.sh https://raw.githubusercontent.com/JuliusCosmoRomeo/kaldi-tuda-de/master/s5/decode.sh
       time ./decode.sh data/$dir_name
       rm -r /models/$1/s5/data/$dir_name
    fi
  else 
    echo "Model $1 does not exist in the /models-directory"
    exit
  fi
fi
