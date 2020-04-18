#/bin/bash
PREFIX="ffmd/"
TAG=latest

BUILDER='docker build'
if type buildah &>/dev/null ; then
	BUILDER='buildah bud'
fi

${BUILDER} --no-cache -t "${PREFIX}debian:babel-base" .
for file in $(ls -1 */Dockerfile); do
	image_name=$(dirname $file)
	${BUILDER} -t "${PREFIX}${image_name}:${TAG}" "${image_name}"
done
