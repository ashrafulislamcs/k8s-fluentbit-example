FROM node:16-alpine3.14

WORKDIR /usr/src/app

COPY package.json .

RUN npm i

ADD . /usr/src/app

RUN npm run build

EXPOSE 3000

CMD [ "npm", "start" ]
