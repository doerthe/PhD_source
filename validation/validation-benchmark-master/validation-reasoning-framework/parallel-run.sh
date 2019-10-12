#!/bin/bash

parallel -j $1 -a $2 ./single-run.sh {} $3
