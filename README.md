# Docker MySQL database image used in Serlo repositories

This repository contains a custom `mysql` docker image. Changes we have made:

- With the command `serlo-mysql` you can use the MySQL client `mysql` together
  with default settings (user, password, database) for accessing the `serlo` DB.
- The command line tool `pv` is available as well. It provides a progress bar
  when a `.sql` file is imported. Usage: `pv file.sql | serlo-mysql`

## Requirements
- Docker
- [Git LFS](https://github.com/git-lfs/git-lfs)

## Change DB via migrations

In order to change the DB image via DB migrations do the following:

1. Run MySQL DB in this repository with `make up`.
2. Run DB migrations
3. Check the changes in the DB via `make mysql`.
4. Make a new dump via `make dump` and commit your changes.

## Publish Image

In order to automatically create the latest image, change the version at file `VERSION` and merge into `main` will.

## Publish prereleases

In order to publish a prerelease push to a branch with a name starting with `prerelease`. Then an image with a tag similar to the branch name is published. For example: a remote branch name like `prerelease-feature1` will created an image which you can access via `ghcr.io/serlo/serlo-mysql-database:prerelease-feature1`. This is for example useful when you need DB migrations in order to develop a new feature.


