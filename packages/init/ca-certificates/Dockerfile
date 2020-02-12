ARG	BASE_IMAGE=$BASE_IMAGE
FROM	$BASE_IMAGE AS certs

RUN	apk --update --no-cache add \
	ca-certificates


FROM	scratch

COPY 	--from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
