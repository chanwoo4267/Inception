all:
	@sudo mkdir -p /home/chanwopa/data/wordpress
	@sudo mkdir -p /home/chanwopa/data/mariadb
	@docker-compose -f ./srcs/docker-compose.yml up

down:
	@docker-compose -f ./srcs/docker-compose.yml down

re:
	@docker-compose -f srcs/docker-compose.yml up --build

clean:
	@docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);\
	docker network rm $$(docker network ls -q);\
	sudo rm -rf /home/chanwopa/data/wordpress;\
	sudo rm -rf /home/chanwopa/data/mariadb;\

.PHONY: all re down clean