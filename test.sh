#!/bin/bash

if [ ! $(id -u) -eq 0 ]; then
    echo 'ur not root'
    echo ''
else
    echo 'OK，你是root'
fi

read
