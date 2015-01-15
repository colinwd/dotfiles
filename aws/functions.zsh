dev() {
    ssh -i ~/.ssh/build.pem ec2-user@$0
}

nonprod() {
    ssh -i ~/.ssh/wlr-nonprod.pem ec2-user@$0
}
