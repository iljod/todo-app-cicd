FROM node:lts-alpine
RUN apk add --no-cache python3 g++ make
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --production --frozen-lockfile && yarn cache clean
COPY . .
EXPOSE 3000
CMD ["node", "src/index.js"]
