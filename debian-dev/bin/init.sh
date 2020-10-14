#!/bin/sh
set -e

if [ "$DRONE_COMMIT_REF" ]; then
	COMMIT_REF=$DRONE_COMMIT_REF
elif [ "$CI_COMMIT_REF" ]; then
	COMMIT_REF=$CI_COMMIT_REF
elif [ "$CI_COMMIT_TAG" ]; then
	COMMIT_REF="refs/tags/$CI_COMMIT_TAG"
elif [ "$CF_RELEASE_TAG" ]; then
	COMMIT_REF="refs/tags/$CF_RELEASE_TAG"
fi
COMMIT_TAG=${COMMIT_REF#refs/tags/}
export COMMIT_REF COMMIT_TAG

# If COMMIT_REF doesn't exists, then just assume it's the current HEAD
if ! { git show-ref | grep -qs " $COMMIT_REF$"; }; then
	git update-ref "$COMMIT_REF" HEAD
fi

exec "$@"
