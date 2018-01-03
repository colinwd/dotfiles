#!/bin/sh

unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_SECURITY_TOKEN ROLE_ARN

CODE_BRANCH=${1}
CONFIG_BRANCH=${2}
RUN_CFN=${3}
RUN_VPC=${4}
RUN_TEAM=${5}
RUN_TEST=${6}
ACCOUNT_ALIAS=${7}
VERBOSITY=${8}

ROLE_ARN=arn:aws:iam::822825227953:role/Cie-Administrator
DEV_JENKINS_URL=internal-cie-jenki-jenkinsm-a0jl1nf7gpev-1591815137.us-east-1.elb.amazonaws.com

export AWS_REGION=us-east-1
export AWS_DEFAULT_REGION=${AWS_REGION}
export AWS_PROFILE=emdeon-nonprod

SESSION=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1`
credentials=`aws sts assume-role --role-arn ${ROLE_ARN} --role-session-name ${SESSION} --query 'Credentials.{AKI:AccessKeyId,SAK:SecretAccessKey,ST:SessionToken}' --output text`

export AWS_ACCESS_KEY_ID=`echo ${credentials} | awk '{print $1}'`
export AWS_SECRET_ACCESS_KEY=`echo ${credentials} | awk '{print $2}'`
export AWS_SESSION_TOKEN=`echo ${credentials} | awk '{print $3}'`
export AWS_SECURITY_TOKEN=${AWS_SESSION_TOKEN}

JENKINS_PASSWORD=`sekuran decrypt -a cie/jenkins/password.txt -b cie-chc-dev-nimbus`

curl -k \
  -X POST "https://${DEV_JENKINS_URL}/job/kreinto-master/build" \
  --user "admin:${JENKINS_PASSWORD}" \
  --form json='{"parameter":[
      {"name":"codeGitRepository", "value":"git@gitlab.emdeon.net:cie/kreinto-jenkins.git"},
      {"name":"codeGitBranch", "value":"'${CODE_BRANCH}'"},
      {"name":"configGitRepository", "value":"git@gitlab.emdeon.net:cie/kreinto-configs.git"},
      {"name":"configGitBranch", "value":"'${CONFIG_BRANCH}'"},
      {"name":"runCfn", "value":"'${RUN_CFN}'"},
      {"name":"runVpc", "value":"'${RUN_VPC}'"},
      {"name":"runTeam", "value":"'${RUN_TEAM}'"},
      {"name":"runTest", "value":"'${RUN_TEST}'"},
      {"name":"accountAlias", "value":"'${ACCOUNT_ALIAS}'"},
      {"name":"verbosity", "value":"v"}
  ]}'
