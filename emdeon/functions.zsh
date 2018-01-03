sss() {
    ssh -i ~/.ssh/current.pem ec2-user@$1
}

bastion() {
	ssh -D 4096 CODAVIS@pl-bnaaebas01.emdeon.net
}

pf() {
    ssh -L $1:$2:$1 CODAVIS@pl-bastion1.emdeon.net
}

assumeRole() {
    # Clear out any previously set credentials
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    unset AWS_SESSION_TOKEN
    unset AWS_SECURITY_TOKEN

    # Get credentials and extract values from JSON
    session_info=$(aws --profile "$3" sts assume-role --role-arn arn:aws:iam::$1 --role-session-name "$2")
    mig_secret_key=`echo $session_info | jq '.Credentials.SecretAccessKey' -r`
    mig_session_token=`echo $session_info | jq '.Credentials.SessionToken' -r`
    mig_access_key=`echo $session_info | jq '.Credentials.AccessKeyId' -r`

    # Set environment variables if the call succeeded
    if [ ! -z "$mig_access_key" ]; then
        export AWS_ACCESS_KEY_ID=$mig_access_key
    fi
    if [ ! -z "$mig_secret_key" ]; then
        export AWS_SECRET_ACCESS_KEY=$mig_secret_key
    fi
    if [ ! -z "$mig_session_token" ]; then
        export AWS_SESSION_TOKEN=$mig_session_token
        export AWS_SECURITY_TOKEN=$mig_session_token
    fi
}

assumeErx() {
    assumeRole 661740953475:role/erx/ErxDevelopers wlr emdeon-nonprod
}

assumeMobius() {
   assumeRole 822825227953:role/mobius/MobiusDevelopers mobius emdeon-nonprod
}

assumeEva() {
    assumeRole 798858686812:role/Developers eva emdeon-nonprod
}

assumeCie() {
    assumeRole 822825227953:role/Cie-Developer cie emdeon-nonprod
}

assumeCieProd() {
    assumeRole 487169392947:role/Cie-Developer cie emdeon-prod
}
