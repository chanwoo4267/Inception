FROM debian:buster

RUN apt-get update && apt-get install -y mariadb-server

EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/db_init.sh /var/www/
COPY ./tools/initial_db.sql /var/www/

RUN chmod +x /var/www/db_init.sh

CMD ["/var/www/db_init.sh"]