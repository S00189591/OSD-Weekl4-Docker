
FROM node AS builder

WORKDIR /week4docker

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:1.13.12-alpine

COPY --from=builder /week4docker/dist/week4docker /usr/share/nginx/html

COPY ./nginx.conf /etc/nginx/conf.d/default.conf

CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'