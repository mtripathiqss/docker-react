# For regular use named builders can be used as following
FROM node:alpine as builder
# for AWS use unnamed builder as following, named builder fails while deploying over AWS
#FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
 
FROM nginx
# expose port 80 for aws elastic beanstalk
#EXPOSE 80
# For AWS, use --from=0 instead of --from=builder
COPY --from=builder /app/build /usr/share/nginx/html