#!/bin/bash

dconf dump /com/gexperts/Tilix/ > tilix_$(date +%Y%m%d-%H%M%S).bkp.conf

