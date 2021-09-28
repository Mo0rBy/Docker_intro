# BUILDING OUR OWN IMAGE

# Choose the image
FROM nginx

LABEL MAINTAINER=johnsmith@gmail.com
# Adds a label telling people who the author/maintainer is

# Copy index.html from localhost to container
COPY index.html /usr/share/nginx/html/index.html 

# Portmap the container (port 80)
EXPOSE 80

# CMD to launch the Nginx web server
CMD ["nginx", "-g", "daemon off;"]
