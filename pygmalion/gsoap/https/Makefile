ABBR      = pm
PROJET    = pygmalion

GCC       = gcc
WSDL2H    = wsdl2h
SOAPCPP   = soapcpp2

CFLAGS    =  -O2 -Wall -fno-strict-aliasing -DWITH_OPENSSL
LIBS      = -lm -L/usr/local/lib -lgsoap -lcrypto -lssl -lpthread -lcrypt
LIBPQ     = /usr/local/pgsql/lib/libpq.a #-L/usr/local/pgsql/lib -lpq

INCLUDE = -I/usr/local/pgsql/include

all: clean $(PROJET).h soap server client pgsql

appli: server client pgsql

%.h: %.wsdl
	$(WSDL2H) -c -s -npmns  $^ -o $@

soap: $(PROJET).h $(PROJET).wsdl
	$(SOAPCPP) -1 -c -L -x -t -p$(ABBR) $<

%.o:%.c
	$(GCC) $(CFLAGS) -c $^ $(INCLUDE) -o $@

server: $(ABBR)C.o $(ABBR)Server.o server.o stdsoap2.o
	$(GCC) $(CFLAGS) $^ $(LIBS) $(LIBPQ) -o $@

client: $(ABBR)C.o $(ABBR)Client.o client.o stdsoap2.o
	$(GCC) $(CFLAGS) $^ $(LIBS) -o $@

pgsql: $(ABBR)C.o $(ABBR)Client.o pgsql.o stdsoap2.o
	$(GCC) $(CFLAGS) $^ $(LIBS) -o $@

clean:
	rm -f *.xml *.nsmap $(ABBR)* soap* $(PROJET).h $(PROJETSSL).h *~ *.o

k: clean
	rm -f client server pgsql
kc:
	rm -f client*.pem root*.pem server*.pem
