#include <stdio.h>

#include "pmH.h"
#include "pm.nsmap"

struct Namespace * namespaces;

void help(void){
  printf("Usage : pygmalion-pgsql opration [arg1 arg2 ...]\n");
  printf("  operation :\n");
  printf("    1 (Connexion)   login password\n");
  printf("    2 (Selection)   num_conn \"requete\"\n");
  printf("    3 (Insertion)   num_conn \"requete\"\n");
  printf("    4 (Deconnexion) num_conn\n");
  exit(0);
}

int main(int argc, char * argv[])
{
  int i, j;
  const char * soap_endpoint = "http://localhost:8060";
  const char * soap_action   = "urn:PygmalionAction";
  if (argc<2) 
    help();
  struct soap * soap = soap_new();
  int val;


  soap_init(soap);
  soap_set_namespaces(soap, pm_namespaces);
  switch(atoi(argv[1])) {

  case 1 :
    if (argc<4) help();
    struct pmns1__pmConnexionResponse rep;
    soap_call_pmns1__pmConnexion(soap, soap_endpoint, soap_action, argv[2], argv[3], &rep);
    if (soap->error)
      soap_print_fault(soap, stderr);
    printf("ID de connexion a utiliser : %d", rep.id);
    break;

  case 2 :
    if (argc<4) help();
    struct pmns1__pmSelectResponse reponse;
    soap_call_pmns1__pmSelect(soap, soap_endpoint, soap_action, atoi(argv[2]), argv[3], &reponse);
    if (soap->error)
      soap_print_fault(soap, stderr);

    struct pmns1__Resultat * resultat = reponse.resultat;
    struct pmns1__Ligne * lignes      = resultat->lignes;
    for (i=0; i<resultat->__sizelignes; i++)
      {
	printf("|");
	for (j=0; j<lignes[i].__sizevaleurs; j++) 
	  printf(" %s |",lignes[i].valeurs[j]);
	printf("\n");
      }
    break;

  case 3:
    if (argc<4) help();
    soap_call_pmns1__pmUpdate(soap, soap_endpoint, soap_action, atoi(argv[2]), argv[3], &val);
    if (soap->error)
      soap_print_fault(soap, stderr);
    break;

  case 4:
    if (argc<3) help();
    soap_call_pmns1__pmDeconnexion(soap, soap_endpoint, soap_action, atoi(argv[2]), &val);
    if (soap->error)
      soap_print_fault(soap, stderr);
    printf("Retour : %d", val);    
    break;
    
  default:
    printf("Opération inconnue\n");
  }
  printf("\n");
  /* 
  int rv = soap_call_pmns1__pmCalcul(&v_soap, argv[1], "urn:PygmalionAction", taux, nb, &val);
  */
  soap_end(soap);
  free(soap);

  return 0;
}
