// Routes all cert URLs through a local SOCKS5 proxy server to bastion,
// while keeping non-cert traffic normal

function FindProxyForURL(url, host) {
	if (shExpMatch(url, "*-cert.westlakerobotics*")) {
		return "SOCKS 127.0.0.1:4096";
	} else {
		return "DIRECT";
	}
}
