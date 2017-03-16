sss() {
    ssh -i ~/.ssh/current.pem ec2-user@$1
}

bastion() {
	ssh -D 4096 CODAVIS@10.200.60.119
}

pf() {
    ssh -L $1:$2:$1 CODAVIS@pl-bastion1.emdeon.net
}

snapshot-publish() {
	gradle clean build publish -Purl=http://nexus.westlakerobotics.com:8081/nexus/content/repositories/snapshots
}

wlr-clone() {
    git clone git@git.westlakerobotics.com:westlakerobotics/$1
}

mobius() {
    echo "changing to mobius"
    chmod 777 ~/.ssh/current.pem
    cp ~/.ssh/medical-billing-dev.pem ~/.ssh/current.pem
    chmod 400 ~/.ssh/current.pem
    export AWS_ENV=mobius
    echo "mobius" > ~/.dotfiles/emdeon/current_env
    echo "changed to mobius"
}

assumeRole() {
    session_info=$(aws sts assume-role --role-arn arn:aws:iam::$1 --role-session-name "$2")
    mig_secret_key=`echo $session_info | jq '.Credentials.SecretAccessKey' -r`
    mig_session_token=`echo $session_info | jq '.Credentials.SessionToken' -r`
    mig_access_key=`echo $session_info | jq '.Credentials.AccessKeyId' -r`
    export AWS_ACCESS_KEY_ID=$mig_access_key
    export AWS_SECRET_ACCESS_KEY=$mig_secret_key
    export AWS_SESSION_TOKEN=$mig_session_token
    export AWS_SECURITY_TOKEN=$mig_session_token
}

assumeErx() {
    aws_role_credentials user arn:aws:iam::661740953475:role/erx/ErxDevelopers wlr
}

assumeMobius() {
   aws_role_credentials user arn:aws:iam::822825227953:role/mobius/MobiusDevelopers mobius
}

# i3 display switching functions
dock() {
    xrandr --output DisplayPort-1 --primary
    xrandr --output eDP --off
}

undock() {
    xrandr --output eDP --primary --auto
}
