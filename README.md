# Medium Task for GSoC-R 2025 Project: Optimizing a performance testing workflow by reusing minified R package versions between CI runs

## Description

Write a YAML snippet that:
Checks if a precompiled artifact for a specific historical version of data.table exists.
If it is found, it downloads and installs the artifact, else it builds the version from source, minifies it, and then uploads it as an artifact for future runs. (Name the artifacts based on version numbers for keeping them distinct)
Implement a fallback mechanism in the workflow to build the missing version from source in case artifact retrieval fails.
