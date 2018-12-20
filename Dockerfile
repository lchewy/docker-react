# Multistep build

# BUILD PHASE
FROM node:alpine as builder
WORKDIR /app
# copy package.json to above /app directory
COPY package.json . 
RUN npm install
# copy source code to container (/app)
COPY . .
RUN npm run build
# /app/build <-- all the stuff that we care about are in here

# RUN PHASE
# second FROM statement tells docker to stop worry about previous FROM block
FROM nginx
# copy everything from builder's app/build to "/usr/share/nginx/html" <--(nginx default)
COPY --from=builder /app/build /usr/share/nginx/html
# DAAAS IT