#!/usr/bin/env bash

do_check_install_poetry() {
  ver=$(poetry --version 2>/dev/null)
  err=$?
  test $err -eq 0 && ver="${ver//Poetry version /}"

  export POETRY_VERSION=1.2.0

  test "$ver" != $POETRY_VERSION && {
    curl -sSL https://install.python-poetry.org | python -
    sudo ln -sfn "$HOME/.local/bin/poetry" /usr/bin/poetry
    sudo chmod 700 /usr/bin/poetry
    sudo chmod 775 $HOME/.bashrc
    echo "source $HOME/.local/share/pypoetry/venv/bin/activate" >> $HOME/.bashrc
  }

  poetry --version

  poetry self update
  export exit_code=0
}
