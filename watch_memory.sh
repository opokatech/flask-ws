#!/bin/bash

while true
do
    clear
    ps uax | head -1
    ps uax | grep "[p]ython app.py"
    sleep 1
done
