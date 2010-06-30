VERSION=	0.1
DESTDIR?=	/usr/local/libexec/nagios
SRC=		src
INSTALL?=	install -C -o root -g wheel -m 0755
RELEASE_NAME=	reallyenglish-nagios-plugins-${VERSION}
RELEASE_DIR=	../${RELEASE_NAME}
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

clean-release:
	rm -rf ${RELEASE_DIR} ../${RELEASE_NAME}.tgz

release: clean-release
	mkdir -p ${RELEASE_DIR}
	tar cf - . | tar -C ${RELEASE_DIR} --exclude .git -xf - 
	tar -C .. -czf ../${RELEASE_NAME}.tgz ${RELEASE_NAME}
