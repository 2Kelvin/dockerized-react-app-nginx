FROM node:alpine AS react_build
COPY . ./
RUN npm ci
RUN npm run build

FROM nginx:1.29.7-alpine AS web_server
# copy the react build files to nginx web files location
COPY --from=react_build ./build /usr/share/nginx/html/build
# make nginx serve the react build instead by replacing default.conf
RUN rm /etc/nginx/conf.d/default.conf
COPY default.conf /etc/nginx/conf.d/
