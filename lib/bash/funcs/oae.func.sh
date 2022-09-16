# This itself is handy to be on your bashrc, but theres room for improvement 
# and extra functions in here
function oae() {
    org=$1
    app=$2
    env=$3
    echo "ORG=${org} APP=${app} ENV=${env} make"
}