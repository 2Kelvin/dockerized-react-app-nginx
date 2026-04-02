FROM node:alpine AS react_build
COPY . ./
RUN npm ci
RUN npm run build
# removing any dev dependencies that were previously installed
RUN npm prune --production

FROM nginx:1.29.7-alpine AS web_server
# copy the react build files to nginx web files location (html folder)
COPY --from=react_build ./build /usr/share/nginx/html/
# make nginx serve the react build files instead by replacing default.conf
RUN rm /etc/nginx/conf.d/default.conf
COPY default.conf /etc/nginx/conf.d/
