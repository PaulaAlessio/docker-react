# Builder phase
FROM node:alpine as builder 
WORKDIR '/app'
COPY package.json .
RUN npm install 
COPY . .
RUN npm run build
# The stuff we are about is under /app/build

EXPOSE 80
# Run phase
FROM nginx
# With --from=builder specifies the phase we want to copy stuff from
# The destination directoy is given in the usage page of the nginx container.
COPY --from=builder /app/build /usr/share/nginx/html
