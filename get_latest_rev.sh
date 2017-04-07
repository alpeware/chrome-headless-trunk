#!/bin/bash

curl -q https://download-chromium.appspot.com/rev/Linux_x64?type=snapshots | awk '{print $2}' | sed 's/"\|,//g'
