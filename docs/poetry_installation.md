# Installing Poetry

Once you know where you will be developing, `poetry` needs to be installed if it
is not already available on your system.

For more information on [Poetry](https://python-poetry.org/docs/),
consult the official documentation and the [Contribution guidelines](../CONTRIBUTING.md).

*Disclaimer for those that already know a lot about Poetry...*

Yes, `poetry` can manage environments directly and there are a lot of other more advanced
uses that are not explored in this repository. This is done on purpose, as an introduction
to this tool in a context that is familiar for most users (i.e., creating virtual environments
with venv/virtualenv/conda). If you are comfortable with `poetry` and especially its use
on compute clusters, feel free to disregard the recommendations below. Remember
to document its use for the project!

## Installing poetry as a standalone tool

This is the recommended way.

`poetry` should be installed through `pipx`.

If working on one of the clusters, you will first need to create and activate a base
virtual environment in which you have write access.

For example, on the Mila cluster:

```
module load python/3.10
python3 -m venv ~/.base_env
source ~/.base_env/bin/activate
```

If on your personal machine, there is no need to first create a virtual environment.

Next, `pipx` and `poetry` can be installed:

```
pip install pipx
pipx install poetry
```

This will install `poetry` locally for the current user, and make it
available for other projects too! If ever you want to remove `poetry`, the following
command can be used to uninstall it : `pipx uninstall poetry`

Unless you want to keep `pipx`, it can be removed using the `pip uninstall pipx`,
which will not affect the `poetry` installation. If you installed `pipx` in a temporary
environment (like in `~/.base_env` in our example above), you can also delete that
environment.

Installing `poetry` this way does not prevent you from using a `conda` environment for your
project's dependencies. To the contrary, it can make things even easier to manage.

After this, you can create your project's virtual environment. Consult the following
documents for more information:

* [How to create a virtual environment for the Mila cluster](environment_creation_mila.md)
* [How to create an environment for the DRAC cluster](environment_creation_drac.md)
* [Creating a Conda Environment](conda_environment_creation.md)

**Reminder**: If installing `poetry` on the cluster this way, you will always need to
load either the `python` or `miniconda` module to use `poetry`, depending on whether
you are using a python virtual environment or conda environments, respectively.
`poetry` requires `python` and without any loaded modules, only `python3`
(`/usr/bin/python3`) is available, and `poetry` will throw an error.

## Installing poetry in a Conda Environment

If the project is using a `conda` environment, `poetry` can also be installed in your
activated project environment. Do note that this is not required, and you can still
[install poetry as a standalone](#installing-poetry-as-a-standalone-tool) even if your
project is using a `conda` environment.

To install poetry in a `conda` environment:

```
conda install poetry
```

If you do install `poetry` with `conda`, check if the installed version of `poetry` is `>= 1.6.0`

If not, you will need to add the following dependency to your project:

```
poetry add "urllib3<2.0.0"
```

This was a dependency requirement for `poetry` before version 1.6.0. Since `poetry` in installed
by `conda`, its own dependency requirements are invisible to itself and installing other
libraries could update `urllib3` and therefore break `poetry`.

See [Creating a Conda Environment](conda_environment_creation.md) for more
information on how to get started with `conda`.

## Using conda with poetry

When using `conda`, it is important to understand that it is both an environment management
tool AND a dependency management tool... and so is `poetry`. The difference is that with `conda`
you can install different versions of python, as well as have access to non
python applications.

To use them together, it is recommended to use `conda` as the environment and python
version manager, while using `poetry` as the dependency manager.

Using `conda` to install non-python dependencies works great, but it is strongly recommended
to avoid installing python dependencies with both `conda` and `poetry` in the same environment.

If you do need to install python dependencies in both (ex. pytorch through conda, and
others using poetry), you need to be cautious as one dependency manager can and will
interfere with the dependencies managed by the other one and will make dependency
conflicts challenging to fix.

If there are no ways around it, you could also manage two environments at the same time 
(one via conda and one via poetry), but it will require an enormous amount of discipline
to work in that kind of context. This is strongly discouraged.

## Considerations when using Poetry in a Compute Cluster environment

### Version concerns on DRAC

As of this writing (February 2025), the newest available version on DRAC for `poetry` is
`2.0.1+computecanada`, and is the version causing problems.

Newer versions of `poetry`, `>=2.0.0` are raising errors when trying to
resolve dependencies when installing projects and adding new dependencies.

If you encounter such issues, please try reinstalling `poetry` at a lesser version:
`pipx install 'poetry<2.0.0', or newer, non-computecanada versions if available.

### Cache management

Whether installing `poetry` as a standalone tool or in a conda environment, cache
management is an important consideration in a shared compute cluster.

If you maintain the default configuration, `poetry`'s cache is located
somewhere in your `$HOME` folder, ex. `$HOME/.cache/pypoetry`.

The cache can get big quite fast. It is also something that can change a lot
over time, which is not ideal for drive that are backed up regularly, like `/projects/`.

Since a cache is supposed to be temporary by nature, and easy to recreate
(most of the time), it can make sense to move the cache to `$SCRATCH`,
as there are very few and limited consequences if it ends up being deleted by the
`purge` policies.

To see current configs and current `cache-dir` path :

```bash
poetry config --list
```

There are a few options available in managing `poetry`'s cache in a cluster environment

### Option 1: move the cache

To set a new cache path:

```bash
poetry config cache-dir /PATH/TO/SCRATCH/.cache/pypoetry
```

### Option 2: clean your caches periodically, or disable them

You can view the existing caches (typically `PyPI` and `_default_cache`) :

```bash
poetry cache list
```

You can clean your caches directly:

```bash
poetry cache clear <CACHE_NAME> --all
```

Or disable them altogether:

```bash
poetry cache clear <CACHE_NAME> --no-cache
```

### Option 3: manually skip cache when installing dependencies

When adding dependencies :

```bash
poetry add <DEPENDENCY_NAME> --no-cache
```

When installing a project:

```bash
poetry install --no-cache
```
