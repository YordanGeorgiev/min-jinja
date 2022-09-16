#!/bin/bash

# install the poetry for every python component project on the first level
# of the src/python dir
do_check_install_py_modules(){

  which poetry > /dev/null 2>&1 || {
    do_check_install_poetry
  }

  while read -r f; do
    tgt_dir=$(dirname $f)
    echo working on tgt_dir: $tgt_dir
    cd "$tgt_dir"
    test $? -ne "0" && exit 1 && do_log "FATAL
        do_check_install_py_modules ::: the tgt_dir: $tgt_dir does not exist"

    # if we want to filter by a sub component
    if [[ ! -z "${SUB_COMPONENT:-}"  ]]; then
      if [[ "$tgt_dir" == *"$SUB_COMPONENT"* ]]; then
        test -f poetry.lock && rm -vf poetry.lock
        test -d .venv && rm -rv .venv
        poetry config virtualenvs.create true
        poetry install -v
        test $? -ne "0" && do_log "FATAL failed to install $tgt_dir py modules" && exit 1
      fi
    fi
    cd -
  done < <(find $PRODUCT_DIR/src/python/ -name pyproject.toml)

  export exit_code=0
}
