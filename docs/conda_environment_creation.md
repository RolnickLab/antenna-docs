# Creating a Conda Environment

First, read the [Conda section](https://docs.mila.quebec/Userguide.html#conda)
in Mila's documentation.

## Install Conda

If you still need to install a newer version of Conda, or if you want to install
it on your personal computer:

```
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
bash ~/miniconda.sh -b -p ${HOME}/.conda
rm ~/miniconda.sh
```

You can also initialize `conda` for your shell using the following:

```
export PATH=${HOME}/.conda/bin:$PATH
conda init 
```

## Environment Creation

Creating a Conda Environment is relatively straightforward.

First, if you are on the Mila cluster and want to use the pre-installed `conda`:

```
module load anaconda/3
```

Create an empty environment:

```
conda env create python=3.11 -n <name_of_env>
```

You can also create an environment from an environment file:

_environment.yml_

```
name: <name_of_environment>
channels:
  - conda-forge
dependencies:
  - python=3.11
```

And create the environment with the following command:

```
conda env create -f environment.yml
```

## Conda Environment Activation

Once created, the environment must be activated:

```
conda activate <name_of_environment>
```
