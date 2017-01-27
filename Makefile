demo:
	# Setup
	bash 1-setup-network.sh
	bash 2-setup-nginx-lb.sh
	docker service ls
	# Create some services
	bash 3-create-service.sh service-abc
	bash 3-create-service.sh service-xyz
	# Wait containers"
	sleep 10; docker service ls; docker ps
	sleep 10; docker service ls; docker ps
	sleep 10; docker service ls; docker ps
	# Finished
	@make how-to

cleanup:
	docker service rm nginx-lb
	docker service rm service-abc
	docker service rm service-xyz
	docker network rm demo-network


how-to:
	$(eval PORT=`docker service inspect nginx-lb -f '{{with index .Endpoint.Ports 0}}{{.PublishedPort}}{{end}}'`)
	@echo
	@echo "Set this domains on /etc/hosts:"
	@echo "127.0.0.1  service-abc.demo"
	@echo "127.0.0.1  service-xyz.demo"
	@echo
	@echo "And check this out:"
	@echo "http://service-abc.demo:$(PORT)/"
	@echo "http://service-xyz.demo:$(PORT)/"
	@echo
	@echo "You can check hostnames at /hostname.html:"
	@echo "http://service-abc.demo:$(PORT)/hostname.html"

create-service:
	@if [ -z $(name) ]; then echo "Usage: make create-service name=service-name"; exit 1; fi
	bash 3-create-service.sh $(name)
