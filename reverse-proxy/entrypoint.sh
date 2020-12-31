KEY="/etc/ssl/private/u-berlioz.key"
CERT="/etc/ssl/certs/u-berlioz.crt"
if [ ! -f "$KEY" ] && [ ! -f "$CERT" ];
then
apk add openssl;

openssl \
  req \
  -x509 \
  -nodes \
  -days 365 \
  -subj "/C=TR/ST=Ordu/O=utkusarioglu./CN=u-berlioz.dev" \
  -addext "subjectAltName=DNS:u-berlioz.dev" \
  -newkey rsa:2048 \
  -keyout /etc/ssl/private/u-berlioz.key \
  -out /etc/ssl/certs/u-berlioz.crt;
fi

# sleep 10;

# Main shell script that is run at the time that the Docker image is run
# Go to default.conf directory
cd /etc/nginx/conf.d;
# ENV VARS
# A list of environment variables that are passed to the container and their defaults
# CRT - double check that the file exists
# export CRT="${CRT:=hellotls.crt}";
# if [ -f "/etc/ssl/certs/$CRT" ]
# then
#     # set crt file in the default.conf file
#     sed -i "/ssl_certificate \//c\\\tssl_certificate \/etc\/ssl\/certs\/$CRT;" default.conf;
# fi
# # KEY - double check that the file exists
# export KEY="${KEY:=hellotls.key}";
# if [ -f "/etc/ssl/private/$KEY" ]
# then
#     # set key file in the default.conf file
#     sed -i "/ssl_certificate_key \//c\\\tssl_certificate_key \/etc\/ssl\/private\/$KEY;" default.conf;
# fi
# Needed to make sure nginx is running after the commands are run
nginx -g 'daemon off;'; nginx -s reload;