# homebrew-rdsql

Official [Homebrew](https://brew.sh) tap for [rdSQL Desktop](https://rdsql.com) — a native
database workspace for PostgreSQL, MySQL, MariaDB, SQLite, DuckDB, Cloudflare D1, CockroachDB,
YugabyteDB, TiDB, PlanetScale, MongoDB, Redis, and S3-compatible object storage.

This repo contains only the Homebrew Cask definition — no application source code. Installers are
downloaded from `rdsql.com`, the same public endpoint the [download page](https://rdsql.com/download)
uses.

## Install

```sh
brew install --cask rdsqlhq/rdsql/rdsql
```

or tap it first:

```sh
brew tap rdsqlhq/rdsql
brew install --cask rdsql
```

## Updating

The Cask's `version` and `sha256` are bumped automatically by
[`rdsql-desktop`](https://github.com/rdsqlhq/rdsql-desktop)'s release workflow whenever a new
version is tagged — this repo should not normally need manual edits.
