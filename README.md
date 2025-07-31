# README

## Description

This is the repository for Antenna's documentation portal

## Python Version

This project uses Python version 3.10 and up.

## Build Tool

This project uses `poetry` as a build tool. Using a build tool has the advantage of
streamlining script use as well as fix path issues related to imports.

## Quick setup

This is a short step by step, no nonsense way of setting things up and start working
right away.

For more in depth information, read the other sections below, starting at the
[Detailed documentation section](#detailed-documentation).

### Install poetry

Skip this step if `poetry` is already installed.

Installing `poetry` with `pipx` will make it available to all your other projects, so
you only need to do this once per system (i.e., on your computer, on the MILA cluster, etc.)

1. Install pipx `pip install pipx`
2. Install poetry with pipx: `pipx install poetry`

### Install package and dependencies

```sh
make install
```

#### Manual instructions

1. Install your package : `poetry install`
2. Initialize pre-commit : `pre-commit install`

### MKdocs

To preview the current changes:

```sh
make preview-docs
```

To build the docs locally

```sh
make build-docs
```

To deploy the docs

```sh
make deploy-docs
```

## Detailed documentation

#### Pre-commit

`pre-commit` is installed by default when installing the package using `poetry install`.
This is a very lightweight library. It is used for automated and low effort code
quality and code analysis.

- To use it manually without needing to create an actual commit:

  ```bash
  pre-commit run --all-files
  ```

- To create a git `pre-commit` hook, so the tool runs before each commit automatically,
  execute the following command:

  ```bash
  pre-commit install
  ```

  - This is a hands-off approach to code quality, as most of the work will be done
    automatically each time you create a commit. It will, however, force you to fix
    the remaining warnings after the automatic fixes.

- To remove the `pre-commit` hook, execute `pre-commit clean`

- If you do not want to install `pre-commit` along with your main package, you can use
  `poetry install --without precommit`

- The `pre-commit` configuration executes most of the tools described in the `nox`
  section below, except `pylint`, the stricter cyclomatic `complexity`, `ruff` and,
  of course, `test`.

#### Python library dependencies

To keep things simple, it is recommended to store all new dependencies as main
dependencies, unless you are already familiar with dependency management.

#### How to contribute

Read and follow the [Contributing guidelines](CONTRIBUTING.md)
