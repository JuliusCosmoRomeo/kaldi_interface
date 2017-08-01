#/bin/bash
if [ $1 = "--help" ]
then
  echo "Expected format: ./decode.sh modelname test-dir"
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
       text_file_exists=0
       if [ -f text ]
       then
         text_file_exists=1
       fi
       for file in $( find $2 -name "*.wav" ); do
         filename=${file%.wav}
         if ! grep -Fq "${filename##*/}" $2/wav.scp
         then 
           echo "${filename##*/} data/$1/${file##*/}" >> $2/wav.scp
           echo "Wrote to wav.scp"
         fi
         if ! grep -Fq "${filename##*/}" $2/utt2spk
         then
           echo "${filename##*/} ${filename##*/}" >> $2/utt2spk
           echo "Wrote to utt2spk"
         fi
         if ! grep -Fq "${filename##*/}" $2/text 
         then 
           echo "${filename##*/} None" >> $2/text
           echo "Wrote to text"
         fi
       done
       cd ~/kaldi/egs/$1/s5/
       #./decode.sh $2
    fi
  fi
fi
