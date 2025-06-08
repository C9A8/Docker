FROM node:16-alpine

WORKDIR /app

COPY . .

RUN npm install
RUN npx prisma generate
RUN npm run build

EXPOSE 30000

CMD ["node","./dist/index.js"]