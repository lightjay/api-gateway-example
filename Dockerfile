FROM amazon/aws-lambda-nodejs:12

COPY ./app/. package*.json ./

RUN npm install

CMD [ "app.handler" ]