FROM node:current-alpine

WORKDIR /app

ADD package.json package-lock.json /app/
RUN npm install
ADD app.js geocoder.js /app/

RUN apk add --no-cache curl && \
    mkdir -p \
        /app/geonames_dump/admin1_codes \
        /app/geonames_dump/admin2_codes \
        /app/geonames_dump/all_countries \
        /app/geonames_dump/alternate_names \
        /app/geonames_dump/cities && \
    cd /app/geonames_dump && \
    curl -L -o cities/cities1000.zip http://download.geonames.org/export/dump/cities1000.zip && \
    cd cities && unzip cities1000.zip && rm cities1000.zip

ENTRYPOINT ["npm"]
CMD ["start"]

