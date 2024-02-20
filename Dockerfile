#BUILDER PHASE:
# the purpose is to install all the dependencies and build the application
FROM node:21-alpine3.18 as builder
WORKDIR /app
COPY ./package.json ./
RUN npm install
# we don't have any concern on changing the source code because we don't change it in realtime
# the entire system volume to be copied to the container 
# the system volume that was implemented with docker compose
# was required because we wanted to see the changes in real time
COPY . .
RUN npm run build

# remember that /app/build is the folder that contains the build version of the application

#RUN PHASE:
# New block, the previous is done
FROM nginx
#path taken from the documentation
COPY --from=builder /app/build /usr/share/nginx/html
# NGNIX image already has a default command that starts the server
