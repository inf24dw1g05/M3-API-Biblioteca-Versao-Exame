FROM node:18

WORKDIR /app

COPY package*.json ./

RUN npm install
RUN npm install mysql2

COPY . .

ENV HOST=0.0.0.0
ENV PORT=3000

EXPOSE ${PORT}

CMD ["npm", "start"]