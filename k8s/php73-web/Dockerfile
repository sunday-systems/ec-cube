FROM centos:centos7.6.1810

RUN yum -y update \
&& sed -i -e '/override_install_langs/s/$/,ja_JP.utf8/g' /etc/yum.conf \
&& cp -f /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
&& yum -y install https://centos7.iuscommunity.org/ius-release.rpm \
&& yum -y install git2u yum-utils \
&& yum-config-manager --disable ius \
&& yum -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm \
&& yum -y install http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm \
&& yum -y install gettext mod_ssl zip unzip postgresql96 mysql-community-client \
&& yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm \
&& yum -y install --enablerepo=remi,remi-php73 php php-common php-gd php-opcache php-mbstring php-mcrypt php-pecl-apc php-xml php-pecl-imagick php-pdo php-pgsql php-mysql php-process php-soap php-xmlrpc php-pecl-zip php-json php-cURL php-intl \
&& yum clean all \
&& php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
&& php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
&& php -r "unlink('composer-setup.php');" \
&& localedef -f UTF-8 -i ja_JP ja_JP.UTF-8

ENV LANG="ja_JP.UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8" \
    TZ="Asia/Tokyo" \
    COMPOSER_ALLOW_SUPERUSER=1 \
    ECCUBE_APP_ROOT="/var/www/vhosts/eccube" \
    APACHE_HOST_NAME="md4eccube.sundaysys.com" \
    APACHE_DOCUMENT_ROOT="/var/www/vhosts/eccube" \
    PHP_MEMORY_LIMIT="256M" \
    GIT_REPO_USER="sunday-systems" \
    GIT_REPO_PROJECT="ec-cube" \
    GIT_REPO_BRANCH="md4eccube" \
    GIT_AUTH_USER="secret" \
    GIT_AUTH_TOKEN="secret" \
    GIT_LOCAL_USER_NAME="secret" \
    GIT_LOCAL_USER_EMAIL="secret"

COPY httpd.conf.template /etc/httpd/conf/
COPY auth.conf /etc/httpd/conf.d/
COPY php.ini.template /etc/
COPY entrypoint.sh /root/

RUN chmod +x /root/entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/root/entrypoint.sh"]