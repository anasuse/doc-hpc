
cat > env.list << EOF
TRAVIS_PULL_REQUEST=false
TRAVIS_BRANCH=master
SOURCE_BRANCH=
TRAVIS_REPO_SLUG=anasuse/doc-hpc
LIST_PACKAGES=0
PUBLISH_PRODUCTS=""
EOF

COMMIT=`git rev-parse HEAD`
echo "TRAVIS_COMMIT=$COMMIT" >> env.list

cp ~/.ssh/id_rsa_SLE ssh_key
podman build -t sle-doc-image .
podman run --rm -it sle-doc-image /bin/bash -c '/bin/bash travis.sh'

rm env.list ssh_key
