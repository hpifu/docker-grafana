repository=grafana

.PHONY: deploy remove logs

deploy:
	mkdir -p /var/docker/${repository}/data
	mkdir -p /var/docker/${repository}/log
	mkdir -p /var/docker/${repository}/conf
	cp grafana.ini /var/docker/grafana/conf/grafana.ini
	chown -R 1000:1000 /var/docker/${repository}/data
	chown -R 1000:1000 /var/docker/${repository}/log
	chown -R 1000:1000 /var/docker/${repository}/conf
	docker stack deploy -c stack.yml ${repository}

remove:
	docker stack rm ${repository}

logs:
	docker logs $$(docker ps --filter name=$(repository) -q)
