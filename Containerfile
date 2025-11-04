FROM fedora:latest
#Pulls latest Fedora image from registry.
RUN dnf install -y nginx hostname tuxpaint \
    && dnf clean all
    #Installs nginx, hostname and tuxpaint packages and creates a /data directory
RUN echo "Hello, from container ${hostname}" > /usr/share/nginx/html/index.html \
    #Putting HTML code into the html file.
    && sed -i '/::*80/s/^/#/' /etc/nginx/nginx.conf \
    #Removes IPV6 binding to port 80 inside the nginx.conf file (-i == in place) via replacing the * with #
    && mkdir /data 
    #Preferred method for running multiple is &&, as the ; would run the next command regardless of the success of the previous one.
    #&& checks the exit status of the previous command before running the next one.
EXPOSE 80
#Opens port 80 for external access
CMD nginx -g 'daemon off;'
#Every layer/step is its own image. The 'Using cache' message indicates that the layer was not changed and was reused from a previous build.
#The address at the end is the image ID for that layer. And therefore, that image.
#When this file is modified, everything below the modification will be rebuilt and everything above will be reused from cache.