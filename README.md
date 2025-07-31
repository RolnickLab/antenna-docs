# README

## Description

Repository template that focuses on simplicity and ease of use.

This is ideal for quick projects or code publication.

The purpose of this template is to help with code quality, structure, and
reproducibility.

This template is not intended to be used as is for libraries or applications that will
be maintained over time. Several things are missing from it, like change logs,
advanced tools and coding standards (though it can be expanded for such uses).

This template creates a python package, contained in [src/](./src), that will
contain your different modules.

For more information about python packages and modules,
[Python Modules and Packages – An Introduction](https://realpython.com/python-modules-packages/).

## Initialization

Please follow these steps:

1. Set up the repository:
    * Automatic way—On the [template's GitHub page](https://github.com/RolnickLab/lab-basic-template),
      create a new repository by using the `Use this template` button, near the top right corner.
      Do not include all branches.
        * If you already have existing code, transfer it either in [src/](src) or [scripts/](scripts),
          depending on its nature
            * Modules (python code that is meant to be _imported_ in other python files) should go into the
              [src folder](src/README.md)
            * Python scripts that are meant to be executed via the command line
              should go into the [scripts folder](scripts/README.md)

    * It can also be done manually (though longer and more error-prone):
        1. Clone or download the `lab-basic-template` repository (this repository)
        2. Either start a new GitHub repository or select an existing one (the target repository)
        3. Copy the files and folders of the `lab-basic-template` repository into your target repository.
            * Do not copy the `.git` folder from the `lab-basic-template`.
            * Move your existing code
                * Modules (python code that is meant to be _imported_ in other python files) should go into the
                  [src folder](src/README.md)
                * Python scripts that are meant to be executed via the command line
                  should go into the [scripts folder](scripts/README.md)


2. Rename the python package (optional step)—This will allow you to use `from <package_name> import ...`
   instead of `from src import ...`  :
    1. Rename [src folder](src) to your package name
        * Make sure the name is in `snake_case`, like other python modules and packages.
        * Bad examples : `my-package`, `MyPackage`, `My Package`
        * Good example : `my_package`
    2. Set the package name on line #2 of the [pyproject.toml](pyproject.toml) file by replacing `src` with the
       same package name used above.
    3. Rename `src/` to your `<package_name>` on line #13 and #18 of the [nox configuration file](noxfile.py)


3. Write your name on line #5 and write a short description on line #4 in [pyproject.toml](pyproject.toml)


4. Follow the rest of the instructions in this README


5. Remove this section (_Initialization_) from the README of your target repository and modify its title
   and description

**Important note**
If you are planning to use this for a new project and expect to use the DRAC cluster
as well as other clusters/locations, it is recommended to first set up your environment
on DRAC. The versions of Python libraries are often a bit behind compared to the Mila
cluster.

This will make your project more portable and will prevent many dependency management
problems while working across different clusters.

Installing this module for the first time (see [Installation](#installation))
will create the `poetry.lock` file, which will set the different library versions used
by the project, and therefore help with reproducibility and reduce the classic but
annoying "but it works on my machine" situation.

However, this `poetry.lock` file can be problematic when using locally compiled python
wheels, [like is recommended in their documentation](#drac-specific-install-directives).

If working on multiple different clusters, it might be better to add the `poetry.lock`
file to your `.gitignore`, and manage your dependencies with either explicit versions or
with [Tilde requirements](https://python-poetry.org/docs/dependency-specification/#tilde-requirements).

## Python Version

This project uses Python version 3.10 and up.

## Build Tool

This project uses `poetry` as a build tool. Using a build tool has the advantage of
streamlining script use as well as fix path issues related to imports.

If you prefer using `uv` as a dependency manager, you can take a look at the 
[uv-version branch](https://github.com/RolnickLab/lab-basic-template/blob/uv-version/README_UV.md).

Be aware that not all projects might be compatible, or easy to work with uv, 
especially if you prefer managing your environments with `conda`, or if you require 
non-python dependencies to be installed via `conda`.

## Quick setup

This is a short step by step, no nonsense way of setting things up and start working
right away.

For more in depth information, read the other sections below, starting at the
[Detailed documentation section](#detailed-documentation).

**Reminder:** When working on the clusters, you will always need to load the
appropriate module before you can activate your environment

* For python virtual environments: `module load python/<PYTHON_VERSION>`
* For conda environments : `module load anaconda/3`

### Install poetry

Skip this step if `poetry` is already installed.

Installing `poetry` with `pipx` will make it available to all your other projects, so
you only need to do this once per system (i.e., on your computer, on the MILA cluster, etc.)

See [Installing Poetry as a Standalone section](docs/poetry_installation.md#installing-poetry-as-a-standalone-tool)
if working on a compute cluster.

1. Install pipx `pip install pipx`
2. Install poetry with pipx: `pipx install poetry`
    1. If installing poetry on DRAC, consider installing with `pipx install 'poetry<2.0.0'`.
       See [Poetry version concerns on the clusters](docs/poetry_installation.md#version-concerns-on-drac)

### Create project's virtual environment

1. Read the documentation on the specific cluster if required:
    * [How to create a virtual environment for the Mila cluster](docs/environment_creation_mila.md)
    * [How to create an environment for the DRAC cluster](docs/environment_creation_drac.md)
2. Create environment : `virtualenv <PATH_TO_ENV>`
    * Or, using venv : `python3 -m venv <PATH_TO_ENV>`
3. Activate environment : `source <PATH_TO_ENV>/bin/activate`

Alternatively, if you want or need to use `conda`:

1. Read the documentation about [conda environment creation](docs/conda_environment_creation.md)
2. Create the environment : `conda env create python=<PYTHON_VERSION_NUMBER> -n <NAME_OF_ENVIRONMENT>`
3. Activate environment : `conda activate <NAME_OF_ENVIRONMENT>`

### Install package and dependencies

1. Install your package : `poetry install`
2. Initialize pre-commit : `pre-commit install`

### Development

1. [Add required dependencies](./CONTRIBUTING.md#adding-dependencies)
2. Create some new modules in the [src](src) folder!

## Detailed documentation

### Environment Management

This section and those following go into more details for the different setup steps.

Your project will need a virtual environment for your dependencies.

* [How to create a virtual environment for the Mila cluster](docs/environment_creation_mila.md)
* [How to create an environment for the DRAC cluster](docs/environment_creation_drac.md)
* [How to create a Conda environment](docs/conda_environment_creation.md)
* [Migrating to DRAC from another environment](docs/migrating_to_drac.md)

There are different ways of managing your python version in these environments. On the
clusters, you have access to different python modules, and through `conda` you have access
to practically all the python versions that exist.

However, on your own system, if you do not wish to use `conda`, you will have to either
manually install different versions of python manually for them to be usable by `poetry`
or use a tool like [pyenv](https://github.com/pyenv/pyenv).

Do note that `conda` is not available on the DRAC cluster, and there are some extra steps
to use `conda` on the Mila cluster compared to a workstation.

Once you know in which environment you will be working, we can proceed to install `poetry`.

`poetry` can be installed a number of ways, depending on the environment choice, and if
you are working on your local machine vs. a remote cluster. See the following
documentation to help you determine what is best for you.

* [How to install poetry](docs/poetry_installation.md)
    * Do not skip
      the [Poetry recommendations when working on a cluster](docs/poetry_installation.md#considerations-when-using-poetry-in-a-compute-cluster-environment)
      if developing directly on a compute cluster.

### Installation

Once the virtual environment is built and `poetry` is installed, follow these steps to
install the package's dependencies:

1. Make sure your virtual environment is active
2. Install the package and its dependencies using the following command:
    * `poetry install`
    * Alternatively, you can also install using `pip install -e .`, which will install
      your package, [configured scripts](https://python-poetry.org/docs/pyproject#scripts)
      and main dependencies, but without creating a `poetry.lock` file. This approach
      will also ignore existing `poetry.lock` files

#### DRAC Specific Install Directives

This is in accordance with the
official [DRAC documentation](https://docs.alliancecan.ca/wiki/Python#Creating_and_using_a_virtual_environment),
adapted for use with `poetry`.

It is common practice, though not enforced, to re-create your Python environment inside
your job. Since most nodes on the DRAC cluster do not have access to the internet, the
dependencies are therefore installed from pre-built wheels. If this does not apply to
you, or if you work on Cedar, which nodes do have access to the internet, you can
disregard the following.

To install the dependencies from these wheels, use the following steps:

1. Create your environment like specified in [environment_creation_drac.md](docs/environment_creation_drac.md)
2. Instead of using `poetry install`, use `pip install -e . --no-index`
    * This will install the package, [configured scripts](https://python-poetry.org/docs/pyproject#scripts)
      as well as the dependencies. However, `pip` can only install main dependencies and
      will not be able to install `poetry` defined groups

### Development

If you want to contribute to this repository, some development dependencies need to be
installed and used.

#### Pre-commit

`pre-commit` is installed by default when installing the package using `poetry install`.
This is a very lightweight library. It is used for automated and low effort code
quality and code analysis.

* To use it manually without needing to create an actual commit:
    ```bash
    pre-commit run --all-files
    ```

* To create a git `pre-commit` hook, so the tool runs before each commit automatically,
  execute the following command:
    ```bash
    pre-commit install
    ```
    * This is a hands-off approach to code quality, as most of the work will be done
      automatically each time you create a commit. It will, however, force you to fix
      the remaining warnings after the automatic fixes.


* To remove the `pre-commit` hook, execute `pre-commit clean`
* If you do not want to install `pre-commit` along with your main package, you can use
  `poetry install --without precommit`
* The `pre-commit` configuration executes most of the tools described in the `nox`
  section below, except `pylint`, the stricter cyclomatic `complexity`, `ruff` and,
  of course, `test`.

#### Manual checks and fixes with Nox

[Nox, a python bases automation tool](https://nox.thea.codes/en/stable/)

* To use `nox`, you first need to install it, along with the full dev dependencies
  with the following command:

```bash
poetry install --with dev
```

To execute a specific session, use the following command : `nox -s <session_name>`

* Main `nox` sessions:
    * No sessions specified; executing `nox` : Runs the pre-commit configuration
    * `check` Runs all checks on the code base without modifying the code
    * `fix` : Runs the autoflake, autopep8, black, isort, docformatter and flynt tools on the code base
    * `flake8` : Runs the `flake8` linter
    * `autoflake` : Run the `autoflake` lint fixer to remove unused imports and variables
    * `autopep8` : Run the `autopep8` lint fixer to automatically fix most other `flake8` warnings
    * `black` : Runs the code formatter
    * `isort` : Runs the import sorter
    * `flynt` : Runs the `f-string formatter
    * `docformatter` : Runs the docstring formatter
    * `test` : Runs tests found in the `tests/` folder with `pytest`


* `pylint`
    * While not enforced by the pre-commit tool, running Pylint on your code can help
      with code quality, readability and even catch errors or bad coding practices.
        * For more information, see the [Pylint library](https://pylint.readthedocs.io/en/stable/)


* `complexity` - Cyclomatic Complexity check (McCabe)
    * While not enforced by the pre-commit tool, running a complexity check on your code can help
      with code quality, readability and even catch errors or bad coding practices.
        * For more information, see [McCabe Checker](https://github.com/PyCQA/mccabe)


* `ruff` - Experimental sessions:
    * `ruff-lint` : Check lint using the `ruff` linter. This linter is stricter
      than `flake8`, but less than `pylint`
    * `ruff-fix` : Check lint using the `ruff` linter and automatically fix the
      warnings that can be fixed by `ruff`
    * `ruff-format` : Format the code using the `ruff` formatter

You are, of course, encouraged to create new sessions and even use `nox` to automate
other parts of your projects.

#### Python library dependencies

To keep things simple, it is recommended to store all new dependencies as main
dependencies, unless you are already familiar with dependency management.

#### How to contribute

Read and follow the [Contributing guidelines](CONTRIBUTING.md)


