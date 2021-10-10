
copy:
	cp ./*.sh  ${HOME}/

status:
	docker compose ls
	docker container ls -a 
	docker volume ls
	docker network ls
	docker images ls

watch:
	watch -n 5 make status 