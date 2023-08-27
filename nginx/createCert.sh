openssl req -new -x509 -subj "/CN=home" -addext "subjectAltName = DNS:*.home" -keyout cert.key -out cert.crt -nodes -newkey rsa:2045 -sha256
