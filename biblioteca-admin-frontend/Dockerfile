FROM node:18-alpine

WORKDIR /app

# Copiar arquivos de dependências
COPY package*.json ./

# Instalar dependências
RUN npm install

# Copiar código fonte
COPY . .

# Expor porta do React
EXPOSE 3001

# Comando para iniciar a aplicação
ENV PORT=3001

CMD ["npm", "start"]