FROM drupal:9-apache

# Install some utilities
RUN  apt update && apt install -y git vim unzip

# Backup original install
RUN  mv /opt/drupal/ /opt/original_drupal/

# Install PHP module required
RUN docker-php-ext-install bcmath

# Install and create Apigee Kickstart project
RUN cd /opt && php -d memory_limit=-1 /usr/local/bin/composer create-project apigee/devportal-kickstart-project:9.x-dev drupal

# Configure
RUN cp /opt/drupal/web/sites/default/default.settings.php ./web/sites/default/settings.php
RUN mkdir /opt/drupal/web/sites/default/files
RUN mkdir -p /var/www/private
RUN chmod a+rwx /opt/drupal/web/sites/default/files /opt/drupal/web/sites/default/settings.php /var/www/private/
RUN echo "$settings['file_private_path'] = '/var/www/private/';" >> /opt/drupal/web/sites/default/settings.php
