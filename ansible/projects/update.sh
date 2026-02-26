#!/bin/bash

helm repo update
helm -n openobserve -f values.yaml upgrade --install o2 openobserve/openobserve --create-namespace
