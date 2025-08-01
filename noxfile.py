from pathlib import Path

import nox

nox.options.reuse_existing_virtualenvs = True  # Reuse virtual environments
nox.options.sessions = ["precommit"]


def get_paths(session):
    package_path = Path(session.bin).parent.parent.parent
    main_package = package_path / "src"
    tests = package_path / "tests"
    scripts = package_path / "scripts"
    return {
        "all": [
            main_package,
            tests,
            scripts,
        ],
        "module": [
            main_package,
            scripts,
            scripts,
        ],
    }


#
# Sessions
#
@nox.session()
def pylint(session):
    paths = get_paths(session)
    session.run("poetry", "run", "pylint", *paths["module"], external=True)


@nox.session()
def flake8(session):
    paths = get_paths(session)
    session.run("poetry", "run", "flake8", *paths["all"], external=True)


@nox.session()
def complexity(session):
    paths = get_paths(session)
    session.run("poetry", "run", "flake8", "--max-complexity", "7", *paths["all"], external=True)


@nox.session()
def docformatter(session):
    paths = get_paths(session)
    session.run(
        "poetry",
        "run",
        "docformatter",
        "--config",
        f"{paths['all'][0].parent}/pyproject.toml",
        *paths["all"],
        external=True,
    )


@nox.session()
def check(session):
    paths = get_paths(session)
    session.run("poetry", "run", "black", "--check", *paths["all"], external=True)
    session.run("poetry", "run", "isort", *paths["all"], "--check", external=True)
    session.run("poetry", "run", "flynt", *paths["all"], external=True)
    session.run(
        "poetry",
        "run",
        "docformatter",
        "--config",
        f"{paths['all'][0].parent}/pyproject.toml",
        *paths["all"],
        external=True,
    )
    session.run("poetry", "run", "flake8", *paths["all"], external=True)
    session.run("poetry", "run", "pylint", *paths["module"], external=True)


@nox.session()
def fix(session):
    paths = get_paths(session)
    session.run("poetry", "run", "autoflake", "-v", *paths["all"], external=True)
    session.run("poetry", "run", "autopep8", *paths["all"], external=True)
    session.run("poetry", "run", "black", *paths["all"], external=True)
    session.run("poetry", "run", "isort", *paths["all"], external=True)
    session.run("poetry", "run", "flynt", *paths["all"], external=True)
    session.run(
        "poetry",
        "run",
        "docformatter",
        "--in-place",
        "--config",
        f"{paths['all'][0].parent}/pyproject.toml",
        *paths["all"],
        external=True,
    )


@nox.session()
def precommit(session):
    session.run("poetry", "run", "pre-commit", "run", "--all-files", external=True)


@nox.session()
def autoflake(session):
    paths = get_paths(session)
    session.run("poetry", "run", "autoflake", "-v", *paths["all"], external=True)


@nox.session()
def autopep(session):
    paths = get_paths(session)
    session.run("poetry", "run", "autopep8", *paths["all"], external=True)


@nox.session()
def black(session):
    paths = get_paths(session)
    session.run("poetry", "run", "black", "--check", *paths["all"], external=True)


@nox.session()
def isort(session):
    paths = get_paths(session)
    session.run("poetry", "run", "isort", *paths["all"], "--check", external=True)


@nox.session()
def flynt(session):
    paths = get_paths(session)
    session.run("poetry", "run", "flynt", *paths["all"], external=True)


@nox.session(name="ruff-lint")
def ruff_lint(session):
    paths = get_paths(session)
    session.run("poetry", "run", "ruff", "check", *paths["all"], external=True)


@nox.session(name="ruff-fix")
def ruff_fix(session):
    paths = get_paths(session)
    session.run("poetry", "run", "ruff", "check", "--fix", *paths["all"], external=True)


@nox.session(name="ruff-format")
def ruff_format(session):
    paths = get_paths(session)
    session.run("poetry", "run", "ruff", "format", *paths["all"], external=True)


@nox.session()
def test(session):
    session.run("poetry", "run", "pytest", external=True)
