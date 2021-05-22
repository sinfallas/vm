http_port 3128
icp_port 0
htcp_port 0
snmp_port 0

hosts_file /etc/hosts
coredump_dir /var/spool/squid3
access_log /var/log/squid3/access.log
cache_log /var/log/squid3/cache.log
dns_nameservers 10.64.0.2 10.64.0.1
cache_peer 150.186.32.6 parent 5010 0 no-query round-robin no-digest no-netdb-exchange no-delay login=eojeda1:17221722 connect-fail-limit=5
cache_peer 10.64.2.1 parent 5010 0 no-query round-robin no-digest no-netdb-exchange no-delay login=eojeda1:17221722 connect-fail-limit=5
cache_peer 10.64.2.2 parent 5010 0 no-query round-robin no-digest no-netdb-exchange no-delay login=eojeda1:17221722 connect-fail-limit=5
cache_mem 640 MB
maximum_object_size_in_memory 1024 KB
maximum_object_size 32010 KB
cache_replacement_policy heap LFUDA
memory_replacement_policy heap LFUDA
cache_dir aufs /var/spool/squid3 8192 32 128 
cache_swap_low 90
cache_swap_high 95
check_hostnames off
log_icp_queries off
half_closed_clients off
nonhierarchical_direct off
prefer_direct off
pipeline_prefetch on
quick_abort_min 16 KB
quick_abort_max 16 KB
read_ahead_gap 16 KB
fqdncache_size 2048
ipcache_size 1024
ipcache_high 95
ipcache_low 90
negative_dns_ttl 1 minute
positive_dns_ttl 6 hour
peer_connect_timeout 15 seconds
persistent_request_timeout 1 minutes
request_timeout 3 minute
read_timeout 9 minute
connect_timeout 30 second
forward_timeout 3 minutes
ftp_passive on
ftp_sanitycheck on
visible_hostname idiomas.face.uc.edu.ve
unique_hostname idiomas.face.uc.edu.ve
httpd_suppress_version_string on
cache_effective_user proxy
cache_effective_group proxy
shutdown_lifetime 2 second

acl manager proto cache_object
acl localhost src 127.0.0.1/32
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32
acl localnet src 10.0.0.0/24 # internal network
acl SSL_ports port 443 # https
acl SSL_ports port 563 # snews
acl SSL_ports port 873 # rsync
acl Safe_ports port 80 # http
acl Safe_ports port 21 # ftp
acl Safe_ports port 443 # https
acl Safe_ports port 70 # gopher
acl Safe_ports port 210 # wais
acl Safe_ports port 1025-65535 # unregistered ports
acl Safe_ports port 280 # http-mgmt
acl Safe_ports port 488 # gss-http
acl Safe_ports port 591 # filemaker
acl Safe_ports port 777 # multiling http
acl Safe_ports port 631 # cups
acl Safe_ports port 873 # rsync
acl Safe_ports port 901 # SWAT
acl Safe_ports port 500 # bear
acl Safe_ports port 5223 # whatsapp
acl Safe_ports port 3478 #facetime
acl Safe_ports port 3497 #facetime
acl Safe_ports port 16384 #facetime
acl Safe_ports port 16387 #facetime
acl Safe_ports port 16393 #facetime
acl Safe_ports port 16402 #facetime
acl purge method PURGE
acl CONNECT method CONNECT
# acl bloqueado url_regex -i sex fuck lolita pleasure xxx anal amateur blowjob porn roar silvercash mtree hardcore pink erotica latinatime lipsticklesb bonzi playboy 1by-day ddtprod club.tepolis xlocator karasxxx kara teen zonacaliente extasis deepthroat bootytalk cdgirls modfxmodels tripealo.webcindario pichunter gay teen party sexy putas maracayextrema rumbacaracas adultfriendfinder caracas.olx.com.ve 89.com vecinabella redtube pornotube youporn elbrollo sexyvalencia metacafe rumbaempates rumbavalencia sexycaracas tuestasaqui sonico hi5 tagged pelicula serie peliculasid seriesid rapidshare megaupload fileserver filehosting filefactory softonic fileden mediafire gigasize fileshare torrent filesharing 4shared sendspace badoo enladisco atevip fulltono freakshare turbobit rapidgator sharpfile jumbofile ares limewire emule thepiratebay solovenezolanas cuevana

http_access allow manager localhost
http_access deny manager
http_access allow purge localhost
http_access deny purge
http_access allow localhost
http_access allow SSL_ports
http_access allow Safe_ports
# http_access deny bloqueado
http_access deny to_localhost
always_direct deny all
never_direct allow all
icp_access deny all
htcp_access deny all
snmp_access deny all

refresh_pattern ^ftp:		1440	20%	10080
refresh_pattern ^gopher:	1440	0%	1440
refresh_pattern -i (/cgi-bin/|\?) 0	0%	0
refresh_pattern .		0	20%	4320
refresh_pattern (Release|Package(.gz)*)$	0	20%	2880
refresh_pattern (\.deb|\.udeb)$   129600 100% 129600
hierarchy_stoplist .uc.edu.ve
