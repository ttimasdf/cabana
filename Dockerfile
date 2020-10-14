# build: docker build . --force-rm -t cabana
# Run: docker run -d -p 8080:8080 --name cabana cabana

FROM node:lts-slim as builder

RUN mkdir -p /app
WORKDIR /app/

COPY package.json yarn.lock /app/
RUN yarn

COPY . /app/
RUN yarn && yarn netlify-build && rm -r node_modules/.cache
# RUN yarn run test-ci && yarn run test-puppeteer-build
# CMD ["yarn", "start"]

FROM nginx:stable-alpine
COPY --from=builder /app/build/ /usr/share/nginx/html/
