FROM node:10-alpine
RUN npm install -g @11ty/eleventy

WORKDIR /usr/src/page
COPY ./pages /usr/src/page
COPY ./layouts /usr/src/page/_includes

RUN eleventy

#this lines are not in use for multistage build
#EXPOSE 8081
#CMD [ "eleventy", "--serve", "--port=8081"]

FROM nginx:alpine

COPY --from=0 /usr/src/page/_site /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
