
## Troubleshooting

### Problem
NAT chain DOCKER: iptables failed: iptables -t nat -N DOCKER: iptables v1.8.7 (legacy): can't initialize iptables table `nat': Permission denied (you must be root)

### Solution:
Put "priviledged: true" in your docker-compose
