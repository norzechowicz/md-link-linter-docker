# Docker image for  [MD Link Linter](https://github.com/norzechowicz/md-link-linter) 

Simple command line tool that iterates recursively over all folders in selected location, looking for markdown 
files and validating links in those files.
 
## Supported tags

- `latest` [(latest/Dockerfile)](latest/Dockerfile)

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

Validate markdown files in current folder:
```bash
docker run -t --rm -v $PWD:/app norberttech/md-link-linter --exclude=vendor --exclude=node_modules . 
```

