# Use an official PHP runtime as a parent image with Apache
FROM php:7.4-apache

# Install any needed packages and PHP extensions
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd mysql pdo pdo_mysql

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy the application code to the container
COPY . /var/www/html/

# Give permissions to the writeable directories as per the repository instructions
RUN chmod 666 /var/www/html/include/secrets/secrets.php \
    && chmod 777 /var/www/html/torrents

# Expose port 80 to the outside world
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
