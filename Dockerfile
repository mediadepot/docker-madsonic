FROM mediadepot/base

# Install apk packages
RUN apk --update upgrade \
 && apk add \
  openjdk8-jre-base \
  unzip \
  wget \
 && rm /var/cache/apk/*

# Set Madsonic Package Information
ENV PKG_NAME madsonic
ENV PKG_VER 6.1.8120
ENV PKG_VERA 6.1
ENV PKG_DATE 20160304
ENV APP_BASEURL http://www.madsonic.org/download
ENV APP_PKGNAME ${PKG_DATE}_${PKG_NAME}-${PKG_VER}-standalone.zip
ENV TRAN_PKGNAME ${PKG_DATE}_${PKG_NAME}-transcode-linux-x64.zip
ENV APP_URL ${APP_BASEURL}/${PKG_VERA}/${APP_PKGNAME}
ENV TRAN_URL ${APP_BASEURL}/transcode/${TRAN_PKGNAME}
ENV APP_BASE /srv/madsonic

#Create sickrage folder structure & set as volumes
RUN mkdir -p ${APP_BASE}/app && \
	mkdir -p ${APP_BASE}/config && \
	mkdir -p ${APP_BASE}/config/transcode

# Download & Install Madsonic
RUN mkdir -p "${APP_BASE}/data/transcode" \
 && wget -O "${APP_BASE}/madsonic.zip" ${APP_URL} \
 && wget -O "${APP_BASE}/transcode.zip" ${TRAN_URL} \
 && unzip "${APP_BASE}/madsonic.zip" -d ${APP_BASE}/app \
 && unzip "${APP_BASE}/transcode.zip" -d "${APP_BASE}/config/transcode" \
 && rm "${APP_BASE}/madsonic.zip" \
 && rm "${APP_BASE}/transcode.zip"


#Copy over start script and docker-gen files
ADD ./start.sh /srv/start.sh
RUN chmod u+x  /srv/start.sh

VOLUME ["/srv/madsonic/app", "/srv/madsonic/config", "/srv/madsonic/data"]

# HTTP ports
EXPOSE 8080
#CMD ["sh"]

CMD ["/srv/start.sh"]