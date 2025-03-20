# 使用官方 PHP Apache 镜像
FROM php:7.4-apache

# 设置工作目录
WORKDIR /var/www/html

# 安装必要的 PHP 扩展和依赖
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install mysqli \
    && docker-php-ext-enable mysqli

# 启用 Apache 重写模块
RUN a2enmod rewrite

# 复制项目文件到容器中
COPY . /var/www/html

# 设置文件权限
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# 暴露端口
EXPOSE 80

# 启动 Apache
CMD ["apache2-foreground"]
