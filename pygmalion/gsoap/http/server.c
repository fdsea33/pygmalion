#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "libpq-fe.h"

// serveur SOAP
#include "pmH.h"
#include "pm.nsmap"

#define MAX_CONN 100


struct Namespace * namespaces;
static int id_generator=0;
static PGconn * conn[MAX_CONN];




SOAP_FMAC5 int SOAP_FMAC6 pmns1__pmConnexion(struct soap* p_soap, char *login, char *pwd, struct pmns1__pmConnexionResponse * reponse)
{
  printf(">> Connexion (%s) [%d]...",login, id_generator);
  if (id_generator>=99)
    return soap_sender_fault(p_soap, "Connection failed", "Trop d'utilisateurs sur le serveur");

  reponse->id=id_generator++;
  conn[reponse->id] = PQsetdbLogin("localhost","5432",NULL,NULL,"gestsea",login,pwd);
  if (PQstatus(conn[reponse->id]) != CONNECTION_OK)
    {
      fprintf(stderr, "Connection to database failed : %s\n", PQerrorMessage(conn[reponse->id]));
      PQfinish(conn[reponse->id]);
      id_generator--;
      return soap_sender_fault(p_soap, "Connection failed", "Le nom d'utilisateur ou le mot de passe est incorrect");
    }
  
  printf("OK\n");
  return SOAP_OK;
}


SOAP_FMAC5 int SOAP_FMAC6 pmns1__pmDeconnexion(struct soap* p_soap, int id, int *return_)
{
  printf(">> Deconnexion [%d]\n", id);

  PQfinish(conn[id]);
  *return_=1;

  return SOAP_OK;
}



SOAP_FMAC5 int SOAP_FMAC6 pmns1__pmSelect(struct soap* p_soap, int id, char *query, struct pmns1__pmSelectResponse * reponse)
{
  int nb_colonnes, nb_lignes, i, j;

  printf(">> Select [%d] : %s\n", id, query);
  PGresult * result = PQexec(conn[id], query);
  if (PQresultStatus(result) != PGRES_TUPLES_OK) {
    fprintf(stderr, "SELECT query failed: %s", PQerrorMessage(conn[id]));
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
  PGresult * result = PQexec(conn[id], query);
  if (PQresultStatus(result) != PGRES_COMMAND_OK) {
    fprintf(stderr, "COMMAND query failed: %s", PQerrorMessage(conn[id]));
    PQclear(result);
    return soap_sender_fault(p_soap, "COMMAND query failed", "La requete est incorrecte et n'a pas pu etre executee");
  }
  PQclear(result);
  return SOAP_OK;
}

SOAP_FMAC5 int SOAP_FMAC6 pmns1__pmCalcul(struct soap* p_soap, double taux, int nb, double *return_)
{
  printf(">> Calcul\n");
  double tm=taux/12;
  *return_= tm/(1-pow(1+tm,-nb));
  //  sleep(2);
  //*return_ = nb+taux;
  return SOAP_OK;
}


int main(int argc, char * argv []) 
{
  struct soap * soap;

  if (argc<2) {
    printf("Usage : pygmalion-server port\n");
    return 0;
  }
  
  soap = soap_new();

  // Initialisation du socket
  printf(">> Starting...\n");
  soap_init(soap);
  soap_set_namespaces(soap, pm_namespaces);
  
  // on cree la socket mere de connexion
  if (soap_bind(soap, NULL, atoi(argv[1]), 100)<0) {
    soap_print_fault(soap, stderr);
    return -1;
  }

  // Boucle infinie de réception des requetes
  printf(">> Started\n");
  for (;;)
    {
      //      printf(".");
      //    soap->accept_timeout = 1; // L'attente devient non bloquante
      if (soap_accept(soap)<0){
	soap_print_fault(soap, stderr);
	continue;
      }
      pm_serve(soap);
      soap_destroy(soap);
      soap_end(soap);
    }
  soap_done(soap);
  free(soap);
  printf(">> Terminated\n");
  return 0;
}
