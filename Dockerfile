
### STAGE 1: Build ###
FROM node:19-alpine AS build
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build
### STAGE 2: Run ###
FROM nginx:1.23.3-alpine
ARG bla
ENV PORT=$bla
RUN echo "The PORT is $PORT"
COPY nginx.conf /etc/nginx/config.template
## replace $PORT with the port from cloud run
RUN sed -n -e 5p /etc/nginx/config.template
RUN sh -c "envsubst '\$PORT'  < /etc/nginx/config.template > /etc/nginx/nginx.conf"
RUN sed -n -e 5p /etc/nginx/nginx.conf
COPY --from=build /usr/src/app/dist/cicd_demo /usr/share/nginx/html
EXPOSE $PORT
CMD ["nginx", "-g", "daemon off;"]
