ABBR      = moz
PROJET    = comptax
GCC       = gcc
WSDL2H    = wsdl2h
SOAPCPP   = soapcpp2
CFLAGS    = -O2 -Wall -fno-strict-aliasing -DWITH_OPENSSL
LIBS      = -lpthread -lcrypt -lssl -lkrb5 -lpq -lgsoapssl
INCLUDE   = -I/usr/include/postgresql

all: clean $(PROJET).h soap server

%.h: %.wsdl
	$(WSDL2H) -c -s -n$(ABBR)  $^ -o $@

soap: $(PROJET).h $(PROJET).wsdl
	$(SOAPCPP) -1 -c -L -p$(ABBR) $<

%.o:%.c
	$(GCC) $(CFLAGS) -c $^ $(INCLUDE) -o $@ 

server: $(ABBR)C.o $(ABBR)Server.o server.o
	$(GCC) $(CFLAGS) $^ $(LIBS) -o $@

clean:
	rm -f *.xml *.nsmap $(ABBR)* $(PROJET).h *~ *.o
