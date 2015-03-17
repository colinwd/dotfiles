bastion() {
	ssh -D 4096 CODAVIS@10.200.60.119
}

snapshot-publish() {
	gradle clean build publish -Purl=http://nexus.westlakerobotics.com:8081/nexus/content/repositories/snapshots
}
