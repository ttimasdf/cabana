# build: docker build . -f Dockerfile.build --force-rm -t cabana:build && docker build . --cache-from=cabana:build --force-rm -t cabana
# Run: docker run -d -p 80:80 --name cabana cabana

FROM node:lts as builder

RUN mkdir -p /app
WORKDIR /app/

COPY package.json yarn.lock /app/
RUN yarn

COPY . /app/
RUN yarn && yarn netlify-build
# RUN yarn run test-ci && yarn run test-puppeteer-build
# CMD ["yarn", "start"]

FROM nginx:stable-alpine
COPY --from=builder /app/build/ /usr/share/nginx/html/
