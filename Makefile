override port = 2222

.PHONY: clean-docker-images

colima:
	@echo "\033[0;32mColima stop\033[0m"
	@colima stop
	@echo "\033[0;32mColima start\033[0m"
	@colima start

clean:
	@echo "\033[0;32mRemoving all Docker images and Clear Port ${port}\033[0m"
	@docker image prune -f
	@docker container stop $(docker container ls -aq) || true
	@docker container rm $(docker container ls -aq) || true
	@docker rmi $$(docker images -q) || true
	@kill -9 $$(lsof -t -i:${port})
	# @docker stop $(docker ps -qa) 
	# @docker rm $(docker ps -qa)
	# @docker rmi -f $(docker images -qa) 
	@docker volume rm $(docker volume ls -q)
	@docker network rm $(docker network ls -q)
	
up:
	@docker compose up

down:
	@docker compose down
		
ps:
	@echo "\033[0;32mDocker Container\033[0m"
	@docker ps -a
	@echo "\033[0;32mDocker Compose\033[0m"
	@docker compose ps -a

rebuild:
	@kill -9 $$(lsof -t -i:${port}) || true
	@docker image prune -f
	@docker compose up -d

rebuild-all:
	@docker container stop $(docker container ls -aq) || true
	@docker container rm $(docker container ls -aq) || true
	@kill -9 $$(lsof -t -i:${port}) || true
	@docker compose down
	@docker image prune -f 
	@docker compose build --no-cache
	@docker compose up

images:
	@echo "\033[0;32mDocker Image\033[0m"
	@docker images

# cmd get paassword : docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword