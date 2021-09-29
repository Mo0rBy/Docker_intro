FROM node AS app    
# Add "AS app" (creates an alias)
WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install -g npm@latest
RUN npm install express
#RUN node seeds/seed.js

COPY . .

EXPOSE 3000

CMD ["node", "app.js"]


## Above is development build part of file (used for testing and such)

###################
# Build a multi-stage production ready image
FROM node:alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install -g npm@latest
RUN npm install express

# This line of code does the magic to compress the image
# This copies from the development build code
COPY --from=app /usr/src/app /usr/src/app

EXPOSE 3000

CMD ["node", "app.js"]