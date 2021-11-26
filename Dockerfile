# Stage 1 - Build App

FROM node:14-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm install && npm install jquery
COPY . ./
RUN npm run build

# Stage 2 - Run App

FROM nginx:stable-alpine
COPY --from=build /app/dist/quiz-frontend /usr/share/nginx/html
COPY /nginx.conf /etc/nginx/conf.d/default.conf
