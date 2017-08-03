#!/bin/bash

echo "Your available commands are:" 
echo "/kaldi_interface/train.sh modelname //expects data to be located under /data/models/modelname/wav"
echo "/kaldi_interface/train.sh modelname data-dir [utterance-postfix]"
echo "/kaldi_interface/decode.sh modelname test-dir"
echo "_______________________________________________________________________________"
echo "Available utterance-postfixes are:"
echo "_Kinect-Beam"
echo '_Samson' 
echo '_Kinect-RAW'
echo '_Realtek'
echo '_Yamaha'
exit

