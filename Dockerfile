
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
RUN echo "bla is $bla"
RUN echo "The PORT is $PORT"
ENV PORT=$bla
RUN echo "The PORT is $PORT"
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /usr/src/app/dist/cicd_demo /usr/share/nginx/html
