FROM node:24-alpine AS build

WORKDIR /build

COPY package.json .

RUN npm install

COPY index.html index.html
COPY postcss.config.js postcss.config.js
COPY tailwind.config.js tailwind.config.js
COPY vite.config.js vite.config.js
COPY src src

RUN npm run build

FROM nginx:alpine

#LABEL org.opencontainers.image.source https://github.com/romain894/XXX

COPY --from=build /build/dist/ /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]