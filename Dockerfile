FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias necesarias para compilar
RUN apt-get update && apt-get install -y \
    build-essential wget uuid-dev libxml2-dev \
    libsqlite3-dev libjansson-dev libedit-dev tzdata pkg-config libssl-dev

# Descargar el código fuente de Asterisk y extraerlo
WORKDIR /usr/src
RUN wget https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-20-current.tar.gz \
    && tar xvf asterisk-20-current.tar.gz

# Compilar e instalar
RUN cd asterisk-20.* \
    && ./configure --with-pjproject-bundled \
    && make \
    && make install \
    && make samples

CMD ["asterisk", "-f"]
