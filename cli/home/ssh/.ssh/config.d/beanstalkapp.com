Host *.beanstalkapp.com
	User git
	VisualHostKey no
	# beanstalkapp.com does not have strong ciphers and MACs
	Ciphers aes256-ctr,chacha20-poly1305@openssh.com,aes256-gcm@openssh.com
	MACs hmac-sha2-512,hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com

# vim: ft=sshconfig
