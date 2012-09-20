#include "str.h"



/* To Lower Case */
char *str_tolower (const char *ct)
{
  char *s = NULL;
  
  if (ct) {
    int i;
    s = malloc (sizeof (*s) * (strlen (ct) + 1));
    if (s) {
      for (i = 0; ct[i]; i++)
	s[i] = tolower (ct[i]);
      s[i] = '\0';
    }
  }
  return s;
}

/* To Upper Case */
char *str_toupper (const char *ct)
{
  char *s = NULL;
  
  if (ct) {
    int i;
    s = malloc (sizeof (*s) * (strlen (ct) + 1));
    if (s) {
      for (i = 0; ct[i]; i++)
	s[i] = toupper (ct[i]);
      s[i] = '\0';
    }
  }
  return s;
}

char *str_capitalize (const char *ct)
{
  char *s =NULL;
  s = str_tolower(ct);
  s[0] = toupper(s[0]);
  return s;
}

char *str_firstcap (const char *ct)
{
  char *s =NULL;
  s = strdup(ct);
  s[0] = toupper(s[0]);
  return s;
}

char *str_uncapitalize (const char *ct)
{
  char *s =NULL;
  s = strdup(ct);
  s[0] = tolower(s[0]);
  return s;
}


/* String join */
char *str_join_old (char *cs, ...)
{
  va_list va;
  const char *ct;
  char *s = NULL;
  size_t size = 0;
  
  va_start (va, cs);
  while ((ct = va_arg (va, char *)) != NULL) {
    void *tmp = NULL;
    size += strlen (ct) + strlen (cs);
    tmp = realloc (s, sizeof (*s) * (size + 1));
    if (tmp) {
      if (!s) {
	s = tmp;
	strcpy (s, ct);
      } else {
	s = tmp;
	strcat (s, cs);
	strcat (s, ct);
      }
    } else {
      fprintf (stderr, "Memoire insuffisante\n");
      free (s);
      s = NULL;
      exit (EXIT_FAILURE);
    }
  }
  return s;
}

/* String join */
 void str_join (char **c1, char *cs, ...)
{
  //  fprintf(stderr,"join2");
  va_list va;
  
  //  fprintf(stderr,"ok1");
  va_start (va, cs);
  //  fprintf(stderr,"ok2");
  while (cs != NULL) {
    //    fprintf(stderr,"|%s",cs);
    str_cat(c1, cs);
    cs = va_arg(va, char *);
  }
  //  fprintf(stderr,"ok3");
  va_end(va);
}


void str_cat (char **c1, char* c2)
{
  if (strlen(c2)<=0)
    return;
  char * first = strdup(*c1);
  size_t size = 1;
  if (first==NULL) {
    fprintf(stderr,"str_cat: Memory not allocated\n");
    exit(0);
  }
  size += strlen(first);
  size += strlen(c2);
  first = (char*)realloc((char*)first, size*sizeof(char));
  if (!first) {
    fprintf(stderr,"str_cat: Memory failure\n");
    exit(0);
  }
  
  free(*c1);
  *c1 = strcat(first, c2);
}



/*
void str_cat (char **c1, char* c2)
{
  char * tmp;
  size_t size = 0;
  if (*c1!=NULL)
    size = strlen(*c1);
  size += strlen(c2);
  tmp = (char*)malloc((size + 1)*sizeof(char));
  if (!tmp) {
    fprintf(stderr,"Memory failure\n");
    exit(0);
  }
  tmp[0] ='\0';
  if (*c1!=NULL)
    strcat (tmp, *c1);
  strcat (tmp, c2);
  *c1 = tmp;
}
*/

char *str_sub (const char *s, unsigned int start, unsigned int end)
{
  char *new_s = NULL;
  
  if (s && start < end) {
    new_s = malloc (sizeof (*new_s) * (end - start + 3));
    if (new_s) {
      int i;
      for (i = start; i <= end; i++)
	new_s[i-start] = s[i];
      new_s[i-start] = '\0';
    } else {
      fprintf (stderr, "Memoire insuffisante\n");
      exit (EXIT_FAILURE);
    }
  }
  return new_s;
}



char *toCppUUID(char * uuid)
{
  char *s=""; 
  str_cat(&s, "{ 0x");
  str_cat(&s, str_sub(uuid,0,7));
  str_cat(&s, ", 0x");
  str_cat(&s, str_sub(uuid,9,12));
  str_cat(&s, ", 0x");
  str_cat(&s, str_sub(uuid,14,17));
  str_cat(&s, ", {0x");
  str_cat(&s, str_sub(uuid,19,20));
  str_cat(&s, ", 0x");
  str_cat(&s, str_sub(uuid,21,22));
  str_cat(&s, ", 0x");
  str_cat(&s, str_sub(uuid,24,25));
  str_cat(&s, ", 0x");
  str_cat(&s, str_sub(uuid,26,27));
  str_cat(&s, ", 0x");
  str_cat(&s, str_sub(uuid,28,29));
  str_cat(&s, ", 0x");
  str_cat(&s, str_sub(uuid,30,31));
  str_cat(&s, ", 0x");
  str_cat(&s, str_sub(uuid,32,33));
  str_cat(&s, ", 0x");
  str_cat(&s, str_sub(uuid,34,35));
  str_cat(&s, "} }");
  return s;
}
