# :: Header
    FROM alpine:3.13


# :: Run
    USER root

    # :: prepare
        RUN set -ex; \
            mkdir -p /ftp;

    # :: install
        RUN set -ex; \
            apk --update --no-cache add \
                curl \
                vsftpd;

    # :: copy root filesystem changes
        COPY ./rootfs /


# :: Start
    RUN chmod +x /usr/local/bin/entrypoint.sh
    ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
    CMD ["/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]