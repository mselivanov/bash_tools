#!/bin/bash

docker image rm $(docker images --format {{.ID}} $1)

