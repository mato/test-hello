#!/bin/sh -l

err()
{
    echo "::error ::$*"
}

die()
{
    err "$@"
    exit 1
}

[ -z "${GITHUB_WORKSPACE}" ] && die "GITHUB_WORKSPACE not set"
[ -z "${GITHUB_REPOSITORY}" ] && die "GITHUB_REPOSITORY not set"
[ -z "${INPUT_PATH}" ] && die "INPUT_PATH not set"
[ -z "${INPUT_API_URL}" ] && die "INPUT_API_URL not set"
[ -z "${INPUT_API_AUTH}" ] && die "INPUT_API_AUTH not set"
[ -z "${INPUT_UPLOAD_PATH}" ] && INPUT_UPLOAD_PATH="${GITHUB_REPOSITORY}"
INPUT_UPLOAD_PATH="$(echo ${INPUT_UPLOAD_PATH} | tr / _)"

PACKAGE_PATH="${GITHUB_WORKSPACE}/${INPUT_PATH}"
[ ! -d "${PACKAGE_PATH}" ] && die "${PACKAGE_PATH}: not a directory"

PACKAGES="$(find "${PACKAGE_PATH}" -type f -name \*.deb -maxdepth 1)"
[ -z "${PACKAGES}" ] && die "${PACKAGE_PATH}: no packages found"
for pkg in "${PACKAGES}"; do
    echo "Uploading ${pkg}"
    curl -fs -X POST -F "file=@${pkg}" -u "${INPUT_API_AUTH}" \
        "${INPUT_API_URL}/api/files/${INPUT_UPLOAD_PATH}" \
        || die "upload failed for ${pkg}"
done
