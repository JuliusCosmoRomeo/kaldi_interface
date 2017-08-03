#!/bin/bash

echo "Your available commands are:" 
echo "./train.sh modelname //expects data to be located under /data/models/modelname/wav"
echo "./train.sh modelname data-dir [utterance-postfix]"
echo "./decode.sh modelname test-dir"
echo "_______________________________________________________________________________"
echo "Available utterance-postfixes are:"
echo "_Kinect-Beam"
echo '_Samson' 
echo '_Kinect-RAW'
echo '_Realtek'
echo '_Yamaha'
exit

