FROM klakegg/hugo:0.78.2-alpine AS build
RUN apk add -U git
COPY . /src
RUN make init
RUN make build
RUN exit 0

FROM nginx:1.19.4-alpine
RUN mv /usr/share/nginx/html/index.html /usr/share/nginx/html/old-index.html
COPY --from=build /src/public /usr/share/nginx/html
EXPOSE 80
