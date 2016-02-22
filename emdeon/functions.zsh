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
