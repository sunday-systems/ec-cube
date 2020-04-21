#!/bin/bash

envsubst '$APACHE_HOST_NAME $APACHE_DOCUMENT_ROOT' < /etc/httpd/conf/httpd.conf.template > /etc/httpd/conf/httpd.conf
envsubst '$PHP_MEMORY_LIMIT' < /etc/php.ini.template > /etc/php.ini

if [ ! -d ${ECCUBE_APP_ROOT} ]; then
    GIT_URL="https://${GIT_AUTH_USER}:${GIT_AUTH_TOKEN}@github.com/${GIT_REPO_USER}/${GIT_REPO_PROJECT}.git"
    echo >&1 "not found eccube in ${ECCUBE_APP_ROOT}. git clone start from ${GIT_URL}"
    git clone -b ${GIT_REPO_BRANCH} ${GIT_URL} ${ECCUBE_APP_ROOT}
    cd ${ECCUBE_APP_ROOT}
    git config --local user.name ${GIT_LOCAL_USER_NAME}
    git config --local user.email ${GIT_LOCAL_USER_EMAIL}
    composer install -d ${ECCUBE_APP_ROOT}
else
    echo >&1 "found eccube. git pull start"
    cd ${ECCUBE_APP_ROOT}
    git pull
fi

chown -R apache:apache /var/www

/usr/sbin/httpd -DFOREGROUND