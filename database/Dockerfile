FROM mysql:8.0

# Copiar scripts de inicialização
COPY init.sql /docker-entrypoint-initdb.d/
COPY mysql-init.sql /docker-entrypoint-initdb.d/

# Definir variáveis de ambiente para configuração do MySQL
ENV MYSQL_ROOT_PASSWORD=1f18ac3cd637
ENV MYSQL_DATABASE=biblioteca_m3_recurso