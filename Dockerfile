FROM node:12-buster

RUN mkdir srcs
WORKDIR /srcs
COPY . .
RUN npm install
RUN npm run build-dev
CMD npm run start-prod
