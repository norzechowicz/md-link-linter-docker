# Docker image for  [MD Link Linter](https://github.com/norzechowicz/md-link-linter) 

Simple command line tool that iterates recursively over all folders in selected location, looking for markdown 
files and validating links in those files.
 
## Supported tags

- `latest`
- `0.0.11`
- `0.0.10`
- `0.0.9`

Each tag matches [MD Link Linter](https://github.com/norzechowicz/md-link-linter) release. Latest represents unreleased version.

### Install

Install the container:

```
docker pull norberttech/md-link-linter
```

### Usage

Display help: 
```bash
docker run -t --rm norberttech/md-link-linter --help
```

Validate markdown files in a current folder:
```bash
docker run -t --rm -v $PWD:/app norberttech/md-link-linter --exclude=vendor --exclude=node_modules . 
```

### Building Image

```bash
docker build --build-arg MD_LINK_LINT_VERSION=1.x@dev --platform=linux/amd64 --tag=norberttech/md-link-linter:latest .
```