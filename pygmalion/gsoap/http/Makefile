ABBR      = pm
PROJET    = pygmalion

GCC       = gcc
WSDL2H    = wsdl2h
SOAPCPP   = soapcpp2

LIBS      = -lm -L/usr/local/lib -lgsoap
LIBPQ     = /usr/local/pgsql/lib/libpq.a -lcrypt -lssl #-L/usr/local/pgsql/lib -lpq

INCLUDE = -I/usr/local/pgsql/include


all: clean base server client pgsql

appli: server client pgsql

base: $(PROJET).h soap

%.h: %.wsdl
	$(WSDL2H) -c -s -npmns  $^ -o $@

soap: $(PROJET).h $(PROJET).wsdl
	$(SOAPCPP) -1 -c -x -t -n -p$(ABBR) $<

%.o:%.c
	$(GCC) -O2 -Wall -fno-strict-aliasing -c $^ $(INCLUDE) -o $@

server: $(ABBR)C.o $(ABBR)Server.o server.o
	$(GCC)  $^ $(LIBS) $(LIBPQ) -o $(PROJET)-server

client: $(ABBR)C.o $(ABBR)Client.o client.o
	$(GCC)  $^ $(LIBS) -o $(PROJET)-client

pgsql: $(ABBR)C.o $(ABBR)Client.o pgsql.o
	$(GCC)  $^ $(LIBS) -o $(PROJET)-pgsql

clean:
	rm -f *.xml *.nsmap $(ABBR)* soap* $(PROJET).h *~ *.o

k: clean
	rm $(PROJET)-*