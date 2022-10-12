# Docker

Generic docker files to create images containing useful tools for development

## Release

To create a new release of any of the docker files hosted by this repository, follow the following steps:

1. Make your changes in a separate branch
2. Make sure to edit the .env file inside the directory containing your Dockerfile to bump the release version
3. Create a PR and validate the GitHub action workflow has no errors during docker build
4. Once merged, a new release will be automatically created using the new version found in the .env file
