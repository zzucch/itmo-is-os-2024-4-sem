#!/usr/bin/env bash

if [[ ! -d ./results ]]; then
	mkdir -p ./results
fi

cp ./factorial/results/* ./results/
cp ./parallel_factorial/results/* ./results/
cp ./parallel_filereader/results/* ./results/
