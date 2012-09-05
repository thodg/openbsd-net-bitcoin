# $OpenBSD$

COMMENT =		P2P payment system

DISTNAME =		bitcoin-${V}
V =			0.6.3
GITHUB_TAG =		g6e0c5e3

CATEGORIES =		net

HOMEPAGE =		http://www.bitcoin.org/

MAINTAINER =		Thomas de Grivel <thomas@lowh.net>

# MIT
PERMIT_PACKAGE_CDROM =	Yes
PERMIT_PACKAGE_FTP =	Yes
PERMIT_DISTFILES_CDROM =Yes
PERMIT_DISTFILES_FTP =	Yes

WANTLIB =		c gthread-2.0 m pthread stdc++ z

MASTER_SITES =		https://github.com/bitcoin/bitcoin/tarball/v${V}/
DISTFILES =		bitcoin-bitcoin-v${V}-0-${GITHUB_TAG}.tar.gz

BUILD_DEPENDS =		databases/db/v4.8 \
			devel/boost

LIB_DEPENDS =		devel/glib2 \
			databases/db/v4.8

FLAVORS =		upnp
FLAVOR ?=

CXXFLAGS += -DAI_ADDRCONFIG=0

MAKE_FLAGS =		CXXFLAGS="${CXXFLAGS}" \
			BOOST_INCLUDE_PATH=${PREFIX}/include \
			BOOST_LIB_PATH=${PREFIX}/lib \
			BOOST_LIB_SUFFIX=-mt \
			BDB_INCLUDE_PATH=${PREFIX}/include/db4.8 \
			BDB_LIB_PATH=${PREFIX}/lib/db4.8 \
			BDB_LIB_SUFFIX= \
			OPENSSL_INCLUDE_PATH=/usr/include \
			OPENSSL_INCLUDE_PATH=/usr/lib

.if ${FLAVOR:L:Mupnp}
BUILD_DEPENDS +=	net/miniupnp
MAKE_FLAGS +=		USE_UPNP=1
.endif

NO_REGRESS =		Yes

USE_GMAKE =		Yes
MAKE_FILE =		makefile.unix
WRKDIST =		${WRKDIR}/bitcoin-bitcoin-bbe1084/src

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/bitcoind ${PREFIX}/bin

.include <bsd.port.mk>
