# Contributing to this repository

## Adding dependencies

Please make sure to add dependencies using `Poetry`, so the project environment
is kept up to date and functional for other users.

Note that this should not be done while on the DRAC cluster and using pre-built wheels, 
as those library versions do not exist elsewhere and Poetry will install Pypi versions, 
not local versions.

To add a new dependency:

```
poetry add <dependency_name>
```

To add a new dependency with a specific version:

```
poetry add "<dependency_name>==<x.x.x>"
```

To add a new dependency and specify a version with some ability to update 
([see Tilde requirements for more information](https://python-poetry.org/docs/dependency-specification/#tilde-requirements)).
This is useful when you want to limit the version number but still allow bug fixes.

```
poetry add <dependency_name>~<x.x.x>

```
For example, `poetry add requests~2.31` will limit the possible versions to `2.31.X`, 
where X will the version that can change. Using `poetry add requests~2.31.2` is the 
equivalent of `poetry add "requests>=2.31.0,<2.32"`

To add a new dependency to a specific group of dependencies 
(for example, the development dependencies):

```
poetry add --group dev <dependency_name>
```

To make a whole group optional, add the following to your `pyproject.toml` file, where 
`<group_name>` is the name of your group:

```
[tool.poetry.group.<group_name>]
optional = true
```

If you do add dependencies directly with pip, make sure to also add them 
(preferably with a version number) to the `[tool.poetry.dependencies]` section of 
the `pyproject.toml` file.

## Design patterns
Here are two recommendations to help structure your code and make it both easier to 
understand and maintain when using classes and object-oriented design.

First, a polymorphic approach, using abstract classes and their concrete implementation,
should be prioritized in order to increase maintainability and extensibility. 

Therefore, new additions should try to follow this design pattern and either implement
new concrete classes or create new abstract classes and their implementations for 
completely new behavior or needs.

Avoid multiple levels of inheritance; the approach should be _AbstractClass -> 
[ConcreteClass1, ConcreteClass2, ...]_ and not 
_AbstractClass -> ChildClass -> GrandChildClass -> ..._

Next, a dependency-injection approach should be preferred, as well as a composition 
approach when creating new modules or extending existing ones.

Functional approaches are also acceptable, and even encouraged when appropriate. However,
classes are still strongly recommended for data management/representation. 
This can be done with either regular classes, `dataclasses`, or `pydantic` models.

## Tests

New contributions should include appropriate tests. Pytest is the preferred library to 
use for testing in this project.

To get started and to learn more about testing in Python:

* [Getting started with testing](https://realpython.com/python-testing/)
* [Testing in the contest of Machine Learning](https://fullstackdeeplearning.com/course/2022/lecture-3-troubleshooting-and-testing/)
* [Pytest Documentation](https://docs.pytest.org/en/stable/how-to/index.html)

## Docstring and type hinting

Docstring format should follow the Numpy or Google standards, and the same standard 
should be used throughout the repository. 

Type hinting is strongly recommended as per the PEP8 standard: 
https://docs.python.org/3/library/typing.html

## Manual checks and fixes with Nox

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