FROM alpine:3.5

ENV WINEDEBUG=fixme-all

RUN apk --no-cache add wine freetype ncurses curl && \
	curl -O https://www.python.org/ftp/python/2.7.13/python-2.7.13.amd64.msi && \
	wine64 msiexec ADDLOCAL="all" /i python-2.7.13.amd64.msi /qn && \
	rm python-2.7.13.amd64.msi && \
	apk del curl
