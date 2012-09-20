GCC      = gcc -Wall -O0 -ggdb -g3 -fstack-protector-all
INCLUDE  = -I/usr/include/libxml2
PROG     = xs2xpi
XSL-HTM  = schema-html.xsl
XSLTPROC = xsltproc

all: $(PROG)

test: k $(PROG)
	./$(PROG) opf.xml test
	cat test/base/src/* test/base/public/* test/build/src/* | wc -l

text: k $(PROG)
	./$(PROG) opf.xml opf-pygmalion.xml test
	cat test/base/src/* test/base/public/* test/build/src/* | wc -l

gen: $(PROG) Makefile
	rm -fr /home/brice/Moz/extensions/opf
	./$(PROG) opf.xml /home/brice/Moz/extensions/opf

ext: $(PROG) Makefile
	rm -fr /home/brice/Moz/extensions/opf
	./$(PROG) opf.xml opf-sql.xml /home/brice/Moz/extensions/opf

extm: $(PROG) Makefile
		./$(PROG) opf.xml opf-sql.xml -m /home/brice/Moz/extensions/opf

stf: $(PROG)
	rm -fr /home/brice/Moz/extensions/opf
	./$(PROG) stf.xml /home/brice/Moz/extensions/opf

%.html:%.xml $(XSL-HTM)
	$(XSLTPROC) -o $@ $(XSL-HTM) $<

uuid.h: uuidgen.sh
	./uuidgen.sh 256
%.o:%.c
	$(GCC) -c $(INCLUDE) $^ -o $@ 

$(PROG): uuid.h str.o main.o 
	$(GCC) $^ -L/usr/lib/ -lxml2 -o $@

clean:
	rm -f *.o *~

clean-test:
	rm -fr test

k: clean clean-test
	rm -fr $(PROG)