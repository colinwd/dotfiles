sss() {
    ssh -i ~/.ssh/current.pem ec2-user@$1
}

bastion() {
	ssh -D 4096 CODAVIS@10.200.60.119
}

snapshot-publish() {
	gradle clean build publish -Purl=http://nexus.westlakerobotics.com:8081/nexus/content/repositories/snapshots
}

dev() {
    echo "changing to dev"
    cp ~/code/infrastructure/gradle.properties.dev ~/code/infrastructure/gradle.properties
    chmod 777 ~/.ssh/current.pem
    cp ~/.ssh/build.pem ~/.ssh/current.pem
    chmod 400 ~/.ssh/current.pem
    export AWS_ENV=dev
    echo "dev" > ~/.dotfiles/emdeon/current_env
    echo "changed to dev"
}

nonprod() {
    echo "changing to nonprod"
    cp ~/code/infrastructure/gradle.properties.nonprod ~/code/infrastructure/gradle.properties
    chmod 777 ~/.ssh/current.pem
    cp ~/.ssh/wlr-nonprod.pem ~/.ssh/current.pem
    chmod 400 ~/.ssh/current.pem
    export AWS_ENV=nonprod
    echo "nonprod" > ~/.dotfiles/emdeon/current_env
    echo "changed to nonprod"
}

cert() {
    echo "changing to cert"
    cp ~/code/infrastructure/gradle.properties.prod ~/code/infrastructure/gradle.properties
    chmod 777 ~/.ssh/current.pem
    cp ~/.ssh/wlr-cert.pem ~/.ssh/current.pem
    chmod 400 ~/.ssh/current.pem
    export AWS_ENV=cert
    echo "cert" > ~/.dotfiles/emdeon/current_env
    echo "changed to cert"
}
