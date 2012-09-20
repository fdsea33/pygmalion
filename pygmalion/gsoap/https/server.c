#include <stdio.h>
#include <stdlib.h>
#include "pmH.h"
//#include "pm.nsmap"
#include "PMBinding.nsmap"
#include <unistd.h>		/* defines _POSIX_THREADS if pthreads are available */
#ifdef _POSIX_THREADS
# include <pthread.h>
#endif
#include <signal.h>		/* defines SIGPIPE */
#include <math.h>
#include "libpq-fe.h"
//#include "pmStub.h"

/*
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "libpq-fe.h"

// serveur SOAP
#include "pmH.h"
#include "pm.nsmap"
#include <openssl/crypto.h>
#include <pthread.h>
//#include "stdsoap2.h"
//#include <openssl/ssl.h>
*/
#define MAX_CONN 100

//struct Namespace * namespaces;
//static int id_generator=0;
//static PGconn * conn[MAX_CONN];

static unsigned int gFreeConnID[MAX_CONN];
static unsigned int gFreeLast=MAX_CONN-1;
//static int gUsedState[MAX_CONN]; // Boolean : Used or Not
static PGconn * gConn[MAX_CONN];


/******************************************************************************\
 *
 *	Forward decls
 *
\******************************************************************************/

void *process_request(void*);
int CRYPTO_thread_setup();
void CRYPTO_thread_cleanup();
void sigpipe_handle(int);

/******************************************************************************\
 *
 *	Main
 *
\******************************************************************************/

int main()
{
  int m, s;
  pthread_t tid;
  struct soap soap, *tsoap;
 
  unsigned int i;

  for(i=0;i<MAX_CONN;i++){
    gConn[i]=NULL;
    gFreeConnID[i]=i;
  }

  soap_ssl_init(); /* init OpenSSL (just once) */
  if (CRYPTO_thread_setup())
    {
      fprintf(stderr, "Cannot setup thread mutex\n");
      exit(1);
    }
  soap_init(&soap);
  if (soap_ssl_server_context(&soap,
			      SOAP_SSL_NO_AUTHENTICATION,
			      //			      SOAP_SSL_DEFAULT,
			      "server.pem", /* keyfile: required when server must authenticate to clients (see SSL docs on how to obtain this file) */
			      "password", /* password to read the key file */
			      "cacert.pem", /* optional cacert file to store trusted certificates */
			      NULL, /* optional capath to directory with trusted certificates */
			      NULL, /* DH file, if NULL use RSA */
			      NULL, /* if randfile!=NULL: use a file with random data to seed randomness */
			      NULL /* optional server identification to enable SSL session cache (must be a unique name) */    ))
    {
      soap_print_fault(&soap, stderr);
      exit(1);
    }
  m = soap_bind(&soap, NULL, 18060, 100); // use port 18000
  if (m < 0)
    {
      soap_print_fault(&soap, stderr);
      exit(1);
    }
  fprintf(stderr, "Socket connection successful: master socket = %d\n", m);
  for (;;)
    {
      s = soap_accept(&soap);
      fprintf(stderr, "Socket connection successful: slave socket = %d\n", s);
      if (s < 0)
	{
	  soap_print_fault(&soap, stderr);
	  break;
	}
      tsoap = soap_copy(&soap); /* should call soap_ssl_accept on a copy */
      if (!tsoap)
	break;
      if (soap_ssl_accept(tsoap))
	{
	  soap_print_fault(tsoap, stderr);
	  soap_done(tsoap);
	  free(tsoap);
	  continue; /* when soap_ssl_accept fails, we should just go on */
	}
      pthread_create(&tid, NULL, &process_request, (void*)tsoap);
    }
  soap_done(&soap); /* deallocates SSL context */
  CRYPTO_thread_cleanup();
  return 0;
}


void *process_request(void *soap)
{
   pthread_detach(pthread_self());
   soap_serve((struct soap*)soap);
   soap_destroy((struct soap*)soap);
   soap_end((struct soap*)soap);
   soap_done((struct soap*)soap);
   free(soap);
   return NULL;
} 

/******************************************************************************\
 *
 *	Service methods
 *
\******************************************************************************/


SOAP_FMAC5 int SOAP_FMAC6 pmns1__pmConnexion(struct soap* aSoap, 
					     char * aLogin, 
					     char * aPassword, 
					     char * aDatabase,
					     struct pmns1__pmConnexionResponse * aReponse)
{
  char pConninfo[1024];
  long pId;

  printf(">> Connexion (%s)...",aLogin);
  if (gFreeLast<=0)
    return soap_sender_fault(aSoap, "Connection failed", "No more connections allowed.");
  
  pId = gFreeConnID[gFreeLast--];
  
  //  reponse->id=id_generator++;
  sprintf(pConninfo,"host='%s' dbname=%s user=%s password=%s sslmode=require",
	  "localhost", aDatabase, aLogin, aPassword);
  gConn[pId] = PQconnectdb(pConninfo);//PQsetdbLogin("localhost","5432",NULL,NULL,"gestsea",login,pwd);
  if (PQstatus(gConn[pId]) != CONNECTION_OK)
    {
      fprintf(stderr, "Connection to database failed : %s\n", PQerrorMessage(gConn[pId]));
      PQfinish(gConn[pId]);
      gFreeConnID[++gFreeLast] = pId;
      //      id_generator--;
      return soap_sender_fault(aSoap, "Connection failed", PQerrorMessage(gConn[pId]));
    }
  aReponse->id = pId;
  
  printf("OK\n");
  return SOAP_OK;
}


SOAP_FMAC5 int SOAP_FMAC6 pmns1__pmDeconnexion(struct soap* aSoap, 
					       int aId, 
					       int * aReturn)
{
  *aReturn=0;
  printf(">> Deconnexion [%d]", aId);
  if (gConn[aId]!=NULL) {
    if (PQstatus(gConn[aId]) == CONNECTION_OK) {
      PQfinish(gConn[aId]);
      gFreeConnID[++gFreeLast]=aId;
      *aReturn=1;
      printf("...OK");
    }
  }
  return SOAP_OK;
}



SOAP_FMAC5 int SOAP_FMAC6 pmns1__pmSelect(struct soap* p_soap, int id, char *query, struct pmns1__pmSelectResponse * reponse)
{
  int nb_colonnes, nb_lignes, i, j;

  printf(">> Select [%d] : %s\n", id, query);
  PGresult * result = PQexec(gConn[id], query);
  if (PQresultStatus(result) != PGRES_TUPLES_OK) {
    fprintf(stderr, "SELECT query failed: %s", PQerrorMessage(gConn[id]));
    PQclear(result);
    return soap_sender_fault(p_soap, "SELECT query failed", "La requete est incorrecte et n'a pas pu etre executee");
  }
 
  nb_colonnes = PQnfields(result);
  nb_lignes = PQntuples(result);

  // Allocation d'un resultat
  struct pmns1__Resultat * resultat = (struct pmns1__Resultat *) malloc(sizeof(struct pmns1__Resultat));
  reponse->resultat                 = resultat;

  // Allocation des lignes
  struct pmns1__Ligne * lignes = (struct pmns1__Ligne *) malloc(nb_lignes*sizeof(struct pmns1__Ligne));
  resultat->lignes             = lignes;
  resultat->__sizelignes       = nb_lignes;

  // Allocations des colonnes des lignes
  char ** valeurs;
  for (i=0; i<nb_lignes; i++) 
    {
      valeurs                 = (char **) malloc (nb_colonnes*sizeof(char *));
      lignes[i].valeurs       = valeurs;
      lignes[i].__sizevaleurs = nb_colonnes;
      for (j=0; j<nb_colonnes; j++) 
	valeurs[j] = strdup(PQgetvalue(result,i,j));
    }
  PQclear(result);

  return SOAP_OK;
}


SOAP_FMAC5 int SOAP_FMAC6 pmns1__pmUpdate(struct soap* p_soap, int id, char *query, int *return_)
{
  printf(">> Update [%d] : %s\n", id,query);
  PGresult * result = PQexec(gConn[id], query);
  if (PQresultStatus(result) != PGRES_COMMAND_OK) {
    fprintf(stderr, "COMMAND query failed: %s", PQerrorMessage(gConn[id]));
    PQclear(result);
    return soap_sender_fault(p_soap, "COMMAND query failed", "La requete est incorrecte et n'a pas pu etre executee");
  }
  PQclear(result);
  return SOAP_OK;
}

SOAP_FMAC5 int SOAP_FMAC6 pmns1__pmCalcul(struct soap* p_soap, double taux, int nb, double *return_)
{
  printf(">> Calcul\n");
  //  double tm=taux/12;
  //*return_= tm/(1-pow(1+tm,-nb));
  //  sleep(2);
  *return_ = nb+taux;
  return SOAP_OK;
}



/******************************************************************************\
 *
 *	OpenSSL
 *
\******************************************************************************/

#ifdef WITH_OPENSSL

#if defined(WIN32)
# define MUTEX_TYPE		HANDLE
# define MUTEX_SETUP(x)		(x) = CreateMutex(NULL, FALSE, NULL)
# define MUTEX_CLEANUP(x)	CloseHandle(x)
# define MUTEX_LOCK(x)		WaitForSingleObject((x), INFINITE)
# define MUTEX_UNLOCK(x)	ReleaseMutex(x)
# define THREAD_ID		GetCurrentThreadId()
#elif defined(_POSIX_THREADS)
# define MUTEX_TYPE		pthread_mutex_t
# define MUTEX_SETUP(x)		pthread_mutex_init(&(x), NULL)
# define MUTEX_CLEANUP(x)	pthread_mutex_destroy(&(x))
# define MUTEX_LOCK(x)		pthread_mutex_lock(&(x))
# define MUTEX_UNLOCK(x)	pthread_mutex_unlock(&(x))
# define THREAD_ID		pthread_self()
#else
# error "You must define mutex operations appropriate for your platform"
# error	"See OpenSSL /threads/th-lock.c on how to implement mutex on your platform"
#endif

struct CRYPTO_dynlock_value
{ MUTEX_TYPE mutex;
};

static MUTEX_TYPE *mutex_buf;

static struct CRYPTO_dynlock_value *dyn_create_function(const char *file, int line)
{ struct CRYPTO_dynlock_value *value;
  value = (struct CRYPTO_dynlock_value*)malloc(sizeof(struct CRYPTO_dynlock_value));
  if (value)
    MUTEX_SETUP(value->mutex);
  return value;
}

static void dyn_lock_function(int mode, struct CRYPTO_dynlock_value *l, const char *file, int line)
{ if (mode & CRYPTO_LOCK)
    MUTEX_LOCK(l->mutex);
  else
    MUTEX_UNLOCK(l->mutex);
}

static void dyn_destroy_function(struct CRYPTO_dynlock_value *l, const char *file, int line)
{ MUTEX_CLEANUP(l->mutex);
  free(l);
}

void locking_function(int mode, int n, const char *file, int line)
{ if (mode & CRYPTO_LOCK)
    MUTEX_LOCK(mutex_buf[n]);
  else
    MUTEX_UNLOCK(mutex_buf[n]);
}

unsigned long id_function()
{ return (unsigned long)THREAD_ID;
}

int CRYPTO_thread_setup()
{ int i;
  mutex_buf = (MUTEX_TYPE*)malloc(CRYPTO_num_locks() * sizeof(pthread_mutex_t));
  if (!mutex_buf)
    return SOAP_EOM;
  for (i = 0; i < CRYPTO_num_locks(); i++)
    MUTEX_SETUP(mutex_buf[i]);
  CRYPTO_set_id_callback(id_function);
  CRYPTO_set_locking_callback(locking_function);
  CRYPTO_set_dynlock_create_callback(dyn_create_function);
  CRYPTO_set_dynlock_lock_callback(dyn_lock_function);
  CRYPTO_set_dynlock_destroy_callback(dyn_destroy_function);
  return SOAP_OK;
}

void CRYPTO_thread_cleanup()
{ int i;
  if (!mutex_buf)
    return;
  CRYPTO_set_id_callback(NULL);
  CRYPTO_set_locking_callback(NULL);
  CRYPTO_set_dynlock_create_callback(NULL);
  CRYPTO_set_dynlock_lock_callback(NULL);
  CRYPTO_set_dynlock_destroy_callback(NULL);
  for (i = 0; i < CRYPTO_num_locks(); i++)
    MUTEX_CLEANUP(mutex_buf[i]);
  free(mutex_buf);
  mutex_buf = NULL;
}

#endif

/******************************************************************************\
 *
 *	SIGPIPE
 *
\******************************************************************************/

void sigpipe_handle(int x) { }

