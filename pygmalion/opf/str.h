#ifndef __str_h__
#define __str_h__
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <ctype.h>

/* To Lower Case */
char *str_tolower (const char *ct);
/* To Upper Case */
char *str_toupper (const char *ct);
/* CApitalize */
char *str_capitalize (const char *ct);
char *str_firstcap (const char *ct);
char *str_uncapitalize (const char *ct);
/* String join */
char *str_join_old (char *cs, ...);
void  str_join (char **c1, char *cs, ...);
void  str_cat (char **c1, char* c2);
char *str_sub (const char *s, unsigned int start, unsigned int end);
char *toCppUUID(char * uuid);

#endif
