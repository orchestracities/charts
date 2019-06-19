#!/bin/sh
mkdir tmp
cd tmp
git clone https://github.com/gravitee-io/gravitee-kubernetes.git && rm -rf gravitee-kubernetes/.git
rm gravitee-kubernetes/gravitee/requirements.lock
rm gravitee-kubernetes/gravitee/requirements.yaml
cp -R gravitee-kubernetes/gravitee ../charts
git clone https://github.com/stakater-charts/pgadmin.git && rm -rf pgadmin/.git
cp -R pgadmin/pgadmin ../charts
cd ..
rm -rf tmp