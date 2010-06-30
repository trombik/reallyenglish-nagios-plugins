DESTDIR?=	/usr/local/libexec/nagios
SRC=		src
INSTALL?=	install -C -o root -g wheel -m 0755
PLUGINS=	check_ciss_status \
	check_if_carp \
	check_if_lagg \
	check_varnishd \
	check_zfs_capacity \
	check_zfs_status

install:
.for p in ${PLUGINS}
	${INSTALL} ${SRC}/${p}/${p} ${DESTDIR}
.endfor
