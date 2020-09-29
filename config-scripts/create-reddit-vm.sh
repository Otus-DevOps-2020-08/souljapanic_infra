#!/bin/bash

yc compute instance create --name reddit-app --hostname reddit-app \
	--memory=4 --create-boot-disk image-folder-id=b1grddgb097trkpsvol5,image-name=reddit-full-1600881116,size=10GB \
	--network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 --metadata serial-port-enable=1 \
	--metadata-from-file user-data=metadata_slim.yaml
