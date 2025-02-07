FROM a045580/db-m3-biblioteca
COPY init.sql /docker-entrypoint-initdb.d/
COPY mysql-init.sql /docker-entrypoint-initdb.d/

ENV MYSQL_ROOT_PASSWORD=1f18ac3cd637
ENV MYSQL_DATABASE=biblioteca_m3_recurso