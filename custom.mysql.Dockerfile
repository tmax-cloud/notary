FROM mariadb:10.4

COPY ./notarysql/mysql-initdb.d /docker-entrypoint-initdb.d
