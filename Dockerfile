# Dockerfile
# This file containerizes the SWE 645 student survey static web app using Nginx.
# It copies all HTML/CSS/image files into an Nginx web server container.

FROM nginx:alpine

# Remove default nginx page
RUN rm -rf /usr/share/nginx/html/*

# Copy all website files into the nginx web root
COPY index.html /usr/share/nginx/html/
COPY survey.html /usr/share/nginx/html/
COPY error.html /usr/share/nginx/html/
COPY img.jpg /usr/share/nginx/html/

# Expose port 80 for web traffic
EXPOSE 80

# Nginx starts automatically - no CMD needed (inherited from base image)
