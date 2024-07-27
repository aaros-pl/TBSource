# Use the official PHP 5.6 FPM image from Docker Hub based on Alpine Linux
FROM php:5.6-fpm-alpine

# Install necessary PHP extensions
RUN apk add --no-cache \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysql mysqli pdo pdo_mysql

# Set the working directory inside the container
WORKDIR /var/www/html

# Copy the repository content into the working directory
# COPY app/ .

# Grant the proper permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Start PHP-FPM server
CMD ["php-fpm"]
