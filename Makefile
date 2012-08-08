# $OpenBSD$

COMMENT =		P2P payment system

DISTNAME =		bitcoin-${V}
V =			0.4.0

CATEGORIES =		net

HOMEPAGE =		http://www.bitcoin.org/

MAINTAINER =		Pascal Stumpf <Pascal.Stumpf@cubes.de>

# MIT
PERMIT_PACKAGE_CDROM =	Yes
PERMIT_PACKAGE_FTP =	Yes
PERMIT_DISTFILES_CDROM =Yes
PERMIT_DISTFILES_FTP =	Yes

WANTLIB =		c gthread-2.0 m pthread stdc++ z

MASTER_SITES =		https://github.com/bitcoin/bitcoin/tarball/v${V}/
DISTFILES =		bitcoin-bitcoin-v${V}-0-gc7eb151.tar.gz

BUILD_DEPENDS =		databases/db/v4 \
			devel/boost

LIB_DEPENDS =		devel/glib2 \

FLAVORS =		upnp
FLAVOR =

.if ${FLAVOR:L:Mupnp}
BUILD_DEPENDS +=	net/miniupnp
MAKE_FLAGS =		USE_UPNP=1
.endif

USE_GMAKE =		Yes

NO_REGRESS =		Yes

MAKE_FILE =		makefile.unix
WRKDIST =		${WRKDIR}/bitcoin-bitcoin-72274ed/src

ALL_TARGET =		bitcoind

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/bitcoind ${PREFIX}/bin

.include <bsd.port.mk>
