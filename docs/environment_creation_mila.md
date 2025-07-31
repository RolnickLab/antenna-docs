# Creating a Virtual Environment on the Mila Cluster

On the Mila cluster, both `venv` and `virtualenv` can be used to create a virtual
environment.

First, load the python module:

```
module load python/3.10
```

Then, for `venv`:

```
python3 -m venv <PATH_TO_ENV>
```

or for `virtualenv`:

```
virtualenv <PATH_TO_ENV>
```

where `<PATH_TO_ENV>` is where the environment will be created. It normally
should be inside your project's folder (but ignored by git), and is commonly named,
`.venv`. 

* _On a side note, `.env` is generally reserved for a text file listing 
  environment variables, used by various tools like `python-dotenv` and `docker compose`_

You can then activate your environment using the following commandline:

```
source <PATH_TO_ENV>/bin/activate
```

After the environment is created and activated, follow the [Poetry Instructions](../README.md#install-package-and-dependencies)

If working and using `poetry` on a cluster, go over the
[Cluster recommendations with Poetry](poetry_installation.md#considerations-when-using-poetry-in-a-compute-cluster-environment)