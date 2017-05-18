FROM localhost:5000/jupytervnc:5.0
ENV BG_NEW_USER username
ENV BG_NEW_UID 1000

# Change user UID
USER root
RUN usermod -u $BG_NEW_UID $BG_USER \
 && usermod -l $BG_NEW_USER $BG_USER \
 && chown -R -h $BG_NEW_USER /var/log/supervisor

USER $BG_NEW_USER
