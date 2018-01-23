#!/bin/bash

jenkins_private_ip=$(terraform output iaac_jenkins)

if [ -f hosts ]
then
  rm hosts
fi

cat > hosts << EOF
[all]
$(echo > hosts | terraform output iaac_jenkins | sed 's/,/ /g')
$(echo > hosts | terraform output iaac_jenkins_slave | sed 's/,/ /g')

[jenkins]
$(echo > hosts | terraform output iaac_jenkins | sed 's/,/ /g')

[jenkins_slave]
$(echo > hosts | terraform output iaac_jenkins_slave | sed 's/,/ /g')

EOF

scp -i iaac_internal.pem -o StrictHostKeyChecking=no iaac_internal.pem ubuntu@$jenkins_private_ip:~/.ssh/id_rsa 
cp hosts ansible
