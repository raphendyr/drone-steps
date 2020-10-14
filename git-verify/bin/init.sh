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


# Try to fetch the tag, if it doesn't exists
if ! { git show-ref | grep -qs " $COMMIT_REF$"; }; then
	git fetch --no-tags origin tag "$COMMIT_TAG" || true
	if ! { git show-ref | grep -qs " $COMMIT_REF$"; }; then
		echo "Commit tag $COMMIT_TAG is not available." >&2
		echo "Unable to confirm signature for that tag.." >&2
		exit 1
	fi
fi

add-maintainer-keys

exec "$@"
