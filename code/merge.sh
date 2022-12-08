#!/bin/bash

cat *.csv | grep -v '"name","rate"' | sort -t',' -n -k 2,2 -r | head -3 > best3stock.csv
