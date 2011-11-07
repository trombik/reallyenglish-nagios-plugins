VERSION=	0.9
DESTDIR?=	/usr/local
SRC=		src
INSTALL?=	install -C -o root -g wheel -m 0755
RELEASE_NAME=	reallyenglish-nagios-plugins-${VERSION}
RELEASE_DIR?=	../${RELEASE_NAME}
RELEASE_HOST?=	blog.jp.reallyenglish.com
RELEASE_HOST_DIST_DIR=	blog.reallyenglish.com
PLUGINS=	check_ciss_status \
	check_if_carp \
	check_if_lagg \
	check_varnishd \
	check_zfs_capacity \
	check_raid_amrstat \
	check_zfs_status \
	check_mpt

all:

install:
.for p in ${PLUGINS}
	${INSTALL} ${SRC}/${p}/${p} ${DESTDIR}/libexec/nagios
.endfor

clean-release:
	rm -f ../${RELEASE_NAME}.tgz

publish:	release
	scp ../${RELEASE_NAME}.tgz ${RELEASE_HOST}:
	ssh -t ${RELEASE_HOST} sudo cp ${RELEASE_NAME}.tgz /usr/home/tomoyukis/${RELEASE_HOST_DIST_DIR}/
	
release: clean-release
	mkdir -p ${RELEASE_DIR}
	tar cf - . | tar -C ${RELEASE_DIR} --exclude .git -xf - 
	tar -C .. -czf ../${RELEASE_NAME}.tgz ${RELEASE_NAME}
	rm -rf ${RELEASE_DIR}

distinfo:	release
	(cd .. &&  sha256 ${RELEASE_NAME}.tgz && md5 ${RELEASE_NAME}.tgz)
