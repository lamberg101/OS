PING info (ping /?)

1. ping ip address (ping 12.192.12.1)
	- reply (there is a conn or reply from the dest)
	- request time out (the host is down, or the path is blocked)
	- unreacble (from router, the route to the dest can not be found)

2. ping with domain name (ping google.com)
	- reply (the name/web name works fine)
	- failed (problem with dns)

3. tracert ip_address (tracert 10.125.21.2)
	- will show the complete list, and to know where the problem is.
	- if use ping and failed, use tracert to know which one is failed.
	- where the tracert stops, there is the problem.
