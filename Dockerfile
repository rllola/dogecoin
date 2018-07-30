FROM ubuntu

RUN apt-get update

RUN apt-get -y install build-essential libtool autotools-dev autoconf pkg-config libssl-dev libboost-all-dev libdb5.3-dev libdb5.3++-dev libevent-dev libminiupnpc-dev protobuf-compiler

WORKDIR /usr/src

# Copying Dogecoin
COPY . .

# Autogen
RUN ./autogen.sh

# Configure
RUN ./configure --with-incompatible-bdb --disable-tests --disable-gui-tests --disable-bench

# Make
RUN make

# Build
RUN build

RUN chmod +x src/dogecoind src/dogecoin-cli
RUN ln -s /usr/src/dogecoin/src/dogecoind /usr/bin/dogecoind
RUN ln -s /usr/src/dogecoin/src/dogecoin-cli /usr/bin/dogecoin-cli

EXPOSE 22555 22556 44555 44556

CMD ["dogecoind", "-printtoconsole"]
