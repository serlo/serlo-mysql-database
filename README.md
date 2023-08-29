# Docker MySQL database image used in Serlo repositories

This repository contains a custom `mysql` docker image. Changes we have made:

- With the command `serlo-mysql` you can use the MySQL client `mysql` together
  with default settings (user, password, database) for accessing the `serlo` DB.
- The command line tool `pv` is available as well. It provides a progress bar
  when a `.sql` file is imported. Usage: `pv file.sql | serlo-mysql`

## Change DB via migrations

In order to change the DB image via DB migrations in https://github.com/serlo/db-migrations do the following:

1. Run MySQL DB in this repository with `make up`.
2. Run DB migrations in `db-migrations`, e.g. via `yarn migrate:run`.
3. Check the changes in the DB via `make mysql`.
4. Make a new dump via `make dump` and commit your changes.

## Publish prereleases

In order to publish a prerelease push to a branch with a name starting with `prerelease`. Then an image with a tag similar to the branch name is published. When you for example an image to a branch named `prerelease-feature1` an image is created which you can access via `eu.gcr.io/serlo-shared/serlo-mysql-database:prerelease-feature1`. This is for example useful when you need DB migrations in order to develop a new feature.
