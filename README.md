We prepared an interface for easier training of Kaldi-models and easier decoding with existing models on own audio-data

The complete documentation can be found within documentation.docx

The most important excerpts:

# What the Dockerfile does
We prepared a Dockerfile (can be found here https://github.com/JuliusCosmoRomeo/kaldi_interface)
The Dockerfile prepares the Kaldi-setup, downloads Marytts (described later under the chapter “Mary”) and the Kaldi Interface that I developed for easier training and decoding.
At the end of the Docker build the docker-image internally looks as follows (the most important directories are listed): 
/opt/kaldi – contains the Kaldi setup
/opt/mary/marytts-5.1.1/marytts-5.1.1 – contains the Mary TTS setup of the specific version 5.1.1 
/kaldi_interface – contains the train.sh and the decode.sh that can be run via docker run
/data – this directory needs to be mounted into the docker-container. The complete structure of how the data-directory on the Host-system should look like can be found in the chapter Train a model

