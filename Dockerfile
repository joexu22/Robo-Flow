# Use the recommended base image
FROM dorowu/ubuntu-desktop-lxde-vnc

# Switch to root user to install software
USER root

# Set a default VNC password.
# It's recommended to change this for security.
ENV VNC_PASSWORD=password

# Switch back to the default user
USER 1000
