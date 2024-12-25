#!/bin/bash

set -e  # Exit on error

# Variables from environment
PACKAGE_NAME="$PACKAGE"
PACKAGE_VERSION="$VERSION"
TARBALL="${PACKAGE_NAME}_${PACKAGE_VERSION}.tar.gz"
EXTRACT_DIR="./extracted"
MINIFIED_TARBALL="${PACKAGE_NAME}_${PACKAGE_VERSION}_minified.tar.gz"
CRAN_URL="https://cran.r-project.org/src/contrib/Archive/${PACKAGE_NAME}/${TARBALL}"

# Fetch tarball
if [ ! -f "$TARBALL" ]; then
    curl -L "$CRAN_URL" -o "$TARBALL"
fi

# Extract tarball
mkdir -p "$EXTRACT_DIR"
export COPYFILE_DISABLE=1
tar --no-xattrs -xvf "$TARBALL" -C "$EXTRACT_DIR"

# Clean and repack
rm -rf "$EXTRACT_DIR/$PACKAGE_NAME/tests" \
           "$EXTRACT_DIR/$PACKAGE_NAME/man" \
           "$EXTRACT_DIR/$PACKAGE_NAME/vignettes" \
           "$EXTRACT_DIR/$PACKAGE_NAME/inst"

tar --no-xattrs -czvf "$MINIFIED_TARBALL" -C "$EXTRACT_DIR" .

# Install package
R CMD INSTALL "$MINIFIED_TARBALL"