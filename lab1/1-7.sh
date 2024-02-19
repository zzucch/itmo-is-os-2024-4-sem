#!/usr/bin/env bash

rm -f emails.lst
touch emails.lst

grep -ERiho "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" /etc/ | tr '\n' ', ' >>emails.lst
