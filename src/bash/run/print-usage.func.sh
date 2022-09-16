#!/bin/bash

do_print_usage(){
   # if $run_unit is --help, then message will be "--help deployer PURPOSE"
   cat << EOF_USAGE
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
   This is a generic bash funcs runner script:
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

   You can also execute one or multiple actions with the
   $0 --action <<action-name>>
   or
   $0 -a <<action-name>> -a <<action-name-02>>


   where the <<action-name>> is one of the following

EOF_USAGE

   find src/bash/run/ -name *.func.sh \
      | perl -ne 's/(.*)(\/)(.*).func.sh/$3/g;print'| perl -ne 's/-/_/g;print "do_" . $_' | sort

# animals['key']='value' to set value
# "${animals[@]}" to expand the values
# "${!animals[@]}" (notice the !) to expand the keys
# for key in ${!hashmap[@]}; do echo $key; done
# for value in ${hashmap[@]}; do echo $value; done
declare -A apps_orgs=( ["sms"]="csi" ["sms"]="csi" )

echo -e "\n"
echo "[#] START generate templates ==============================================="
while read -r env
do
    for key in ${!apps_orgs[@]}; do
      echo ORG=\'${apps_orgs[$key]}\' APP=\'$key\' ENV=\'$env\' make do-tpl-gen # to generate the templates
    done
# TODO: make env listing dynamic
# for env in `ls cnf/env/${ORG}/${APP}/${ENV}.env.json`; do echo $env; done
done < <(cat <<EOF_ENVS_01
  dev
  tst
  prd
  all
EOF_ENVS_01
)
echo -e "[#] STOP generate templates ===============================================\n"

echo -e
echo "[#] START run provisioning tasks =========================================="
while read -r env
do
  echo " =========================== [ $env env ] ================================== "
  while read -r action ; do
    for key in "${!apps_orgs[@]}"; do

      echo ORG=\"${apps_orgs[$key]}\" ENV=\"$env\" APP="$key" make $action
    done
  done < <(ls -1 src/bash/run | egrep 'provision|divest'|sed -e 's/.func.sh//g')
  echo -e "\n"
  echo -e "[#] STOP run provisioning tasks =================================\n"

  #echo \# STOP  $env env
done < <(cat <<EOF_ENVS
  dev
  tst
  prd
EOF_ENVS
)


   exit 1
}
