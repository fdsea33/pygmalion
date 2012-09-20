#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <libxml/parser.h>
#include <libxml/tree.h>
#include <sys/types.h>
#include <sys/stat.h>

#include "str.h"
#include "uuid.h"


#ifndef LIBXML_TREE_ENABLED
#error "Tree Support disabled !"
#endif

#define CPP_HEADER "/* -*- Mode: C++; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*- */\n"

#define SEN_SCHEMAX "schemax"
#define SEN_ELEMENT "element"
#define SEN_CHOICE "choice"
#define SEN_ATTRIBUTE "attribute"
#define SEN_ENUMERATION "enumeration"

#define SEN_EXTEND "extend"
#define SEN_METHOD "method"
#define SEN_PARAMETER "parameter"
#define SEN_CODE "code"

#define SAN_NAME "name"
#define SAN_VERSION "version"
#define SAN_TYPE "type"
#define SAN_VALUE "value"
#define SAN_USE "use"
#define SAN_MINOCCURS "minOccurs"
#define SAN_MAXOCCURS "maxOccurs"
#define SAN_ELEMENT "element"
#define SAN_DIRECTION "direction"
#define SAN_STATUS "status"

#define SAV_UNBOUNDED "unbounded"
#define SAV_IN "in"
#define SAV_OUT "out"
#define SAV_INOUT "inout"
#define SAV_FROZEN "frozen"

#define NB_ELEMENTS     128
#define NB_ATTRIBUTES    32
#define NB_ENUMERATIONS  64
#define NB_CHOICES       32

#define NB_METHODS      128
#define NB_PARAMETERS    16

#define NAME_SIZE       64

#define F_LOAD     "Load"
#define F_ANALYZE  "Analyze"

#define N_UNKNOWN    0
#define N_OPTIONAL   1
#define N_REQUIRED   2
#define N_PROHIBITED 3

#define D_UNKNOWN 0
#define D_IN      1
#define D_OUT     2
#define D_INOUT   3
char *  IDL_DIR[4] = {"",SAV_IN,SAV_OUT,SAV_INOUT };


#define T_UNKNOWN 0
#define T_STRING  1
#define T_BOOLEAN 2
#define T_FLOAT   3
#define T_UINT32   4
#define T_PATH    5

#define TL_SIZE   6
char *         TL_TYPE[TL_SIZE] = {"unknown","string"              , "boolean" , "float"  , "unsignedInt"  ,"path"}; //XSD based
char *    VARIANT_TYPE[TL_SIZE] = {"unknown","AString"             , "AString" , "Float"  , "Uint32"       ,"AString"};
char *     VARCPP_TYPE[TL_SIZE] = {"unknown","nsString"            , "nsString", "float"  , "PRUint32"     ,"nsString"};
char * VARCPPIN_PREFIX[TL_SIZE] = {"unknown",""                    , ""        , "&"      , "&"            ,""};
char *        IDL_TYPE[TL_SIZE] = {"unknown","AString"             , "boolean" , "float"  , "unsigned long","nsILocalFile"};
char *      IDL_PREFIX[TL_SIZE] = {"unknown","\""                  , ""        , ""       , ""             ,""};
char *      IDL_SUFFIX[TL_SIZE] = {"unknown","\""                  , ""        , ""       , ""             ,""};
char *    CPPDECL_TYPE[TL_SIZE] = {"unknown","nsString"            , "PRBool"  , "float"  , "PRUint32"     ,"nsCOMPtr<nsILocalFile>"};
char *     CPPOUT_TYPE[TL_SIZE] = {"unknown","nsAString &"         , "PRBool *", "float *", "PRUint32 *"   ,"nsILocalFile **"};
char *      CPPIN_TYPE[TL_SIZE] = {"unknown","const nsAString &"   , "PRBool"  , "float"  , "PRUint32"     ,"nsILocalFile *"};
char *   CPPOUT_PREFIX[TL_SIZE] = {"unknown",""                    , "*"       , "*"      , "*"            ,"*"};
char *    CPPIN_PREFIX[TL_SIZE] = {"unknown",""                    , "&"       , "&"      , "&"            ,"&"};
int         GET_ADDREF[TL_SIZE] = {        0,                     0,          0,         0,               0, 1};
//char *    CPP_PREFIX[TL_SIZE] = {"unknown","NS_LITERAL_STRING(\"", ""        , ""       , ""             ,""};
//char *    CPP_SUFFIX[TL_SIZE] = {"unknown","\")"                 , ""        , ""       , ""             ,""};

#define S_IDL_FILE 2048
#define S_CPP_FILE 8192
#define S_HPP_FILE 2048

#define D_BASE   "base"
#define D_BUILD  "build"
#define D_PUBLIC "public"
#define D_SRC    "src"
#define D_MAKEFILE_IN "Makefile.in"

typedef int nsresult;

#define NS_OK 0
#define NS_ERROR_FAILURE 1
#define NS_FAILED(rv) (rv!=NS_OK)?1:0
#define NS_ENSURE_SUCCESS(a,b) if(NS_FAILED(a))return(b);

int gVerbose      = 0;
int gBuildOnlyMethods = 0;
char * gName      = NULL;
char * gParentName    = "element";
char * gParentIdlClassname;
char * gParentCppClassname;
char * gVersion   = "1.0.0";
char * gPrefix    = "ns";
char * gShortName = "";
char * gFamily    = "mozilla.org";
char * gLoad      = "_load";
char * gFile      = "file";
char * gAuthors   = "";
char * gCopyright = "";
char * gLicense   = "Mozilla Public License. See http://www.mozilla.org/MPL/";

static int           gElementNb = 0;
static char      * gElementName [NB_ELEMENTS];
static char    * gElementMarkup [NB_ELEMENTS];
static int         gElementType [NB_ELEMENTS];
static int      gElementToWrite [NB_ELEMENTS];
static int     gElementChildren [NB_ELEMENTS][NB_ELEMENTS];
static int gElementChildrenIsChoice [NB_ELEMENTS][NB_ELEMENTS];
//static int   gElementChildrenChoice [NB_ELEMENTS][NB_ELEMENTS];
//static char *         gElementChildrenConstant [NB_ELEMENTS][NB_ELEMENTS][NB_ELEMENTS];
static unsigned long gElementChildrenMinOccurs [NB_ELEMENTS][NB_ELEMENTS];
static unsigned long gElementChildrenMaxOccurs [NB_ELEMENTS][NB_ELEMENTS];
//static unsigned long   gElementChoiceMinOccurs [NB_ELEMENTS][NB_CHOICES];
//static unsigned long   gElementChoiceMaxOccurs [NB_ELEMENTS][NB_CHOICES];
static int   gElementChildrenNb [NB_ELEMENTS];
static int  gElementAttributeNb [NB_ELEMENTS];
//static int     gElementChoiceNb [NB_ELEMENTS];

static char    * gAttributeName [NB_ELEMENTS][NB_ATTRIBUTES];
static char * gAttributeIdlName [NB_ELEMENTS][NB_ATTRIBUTES];
static char  * gAttributeMarkup [NB_ELEMENTS][NB_ATTRIBUTES];
static int       gAttributeType [NB_ELEMENTS][NB_ATTRIBUTES];
static int       gAttributeNeed [NB_ELEMENTS][NB_ATTRIBUTES];
static int   gAttributeEnumerationNb [NB_ELEMENTS][NB_ATTRIBUTES];

static char       * gEnumerationName [NB_ELEMENTS][NB_ATTRIBUTES][NB_ENUMERATIONS];
static char     * gEnumerationMarkup [NB_ELEMENTS][NB_ATTRIBUTES][NB_ENUMERATIONS];
static char      * gEnumerationValue [NB_ELEMENTS][NB_ATTRIBUTES][NB_ENUMERATIONS];


static int          gChoiceNb = 0;
static char   * gChoiceMarkup [NB_CHOICES];
static char     * gChoiceName [NB_CHOICES];
static int   gChoiceElementNb [NB_CHOICES];
static int     gChoiceElement [NB_CHOICES][NB_ELEMENTS];
static char * gChoiceConstant [NB_CHOICES][NB_ELEMENTS];


static int               gMethodNb =0;
static char          * gMethodName [NB_METHODS];
static char        * gMethodExtend [NB_METHODS];
static int          gMethodElement [NB_METHODS];
static char *          gMethodCode [NB_METHODS];
static unsigned int gMethodParameterNb [NB_METHODS];

static char *       gParameterName [NB_METHODS][NB_PARAMETERS];
static unsigned int gParameterType [NB_METHODS][NB_PARAMETERS];
static unsigned int  gParameterDir [NB_METHODS][NB_PARAMETERS];



static char * gMethodIdlPrototype[NB_METHODS];
static char * gMethodCppFunction[NB_METHODS];

static char * gIdlClassname [NB_ELEMENTS];
static char * gCppClassname [NB_ELEMENTS];
static int  gAlreadyDefined [NB_ELEMENTS];

static char * gIdl [NB_ELEMENTS];
static char * gCpp [NB_ELEMENTS];
static char * gHpp [NB_ELEMENTS];

static int lastUUID=0;




#define NEXT_ELEMENT(node) while(node&&node->type!=XML_ELEMENT_NODE){node=node->next;}if(!node)break;








/* String join */
void trace (char *cs, ...)
{
  //  printf(">>%s\n",cs);
  /*  if (!gVerbose) return;*/
  
  char * msg="* ";
  va_list va;
  va_start (va, cs);
  while (cs != NULL) {
    str_cat(&msg, cs);
    cs = va_arg(va, char *);
  }
  va_end(va);
  str_cat(&msg,"\n");
  fprintf(stderr, msg);
  
}



char * getUUID() {
  if (lastUUID>=UUID_NB) {
    printf("Error : Not enougth UUID!");
    exit(0);
  }
  return gUUID[lastUUID++];
}

/* string to type 
 */
int stot(char * type)
{
  if (type==NULL) 
    return T_UNKNOWN;
  int i;
  for(i=1;i<TL_SIZE;i++)
    if (strcmp(type,TL_TYPE[i])==0)
      return i;
  return T_UNKNOWN;
}

/* string to direction
 */
int stod(char * dir)
{
  if (dir==NULL) 
    return D_IN;
  if (strcmp(dir,SAV_IN)==0)
    return D_IN;
  if (strcmp(dir,SAV_OUT)==0)
    return D_OUT;
  if (strcmp(dir,SAV_INOUT)==0)
    return D_INOUT;
  return D_UNKNOWN;
}

/* string to minOccurs */
unsigned long stomino(char * minOccurs)
{
  if (minOccurs==NULL) 
    return 1;
  if (!strcmp(minOccurs,SAV_UNBOUNDED)) {
    fprintf(stdout,"WARNING: minOccurs ne supporte pas la valeur 'unbounded'. La valeur par défaut est utilisée.\n");
    return 1;
  }
  char * endptr=NULL;
  unsigned long result = strtoul(minOccurs, &endptr, 10);
  if (strcmp(endptr,strdup("")))
    fprintf(stdout,"WARNING: minOccurs est probablement incorrect '%s'\n",minOccurs);
  return result;
}

/* string to maxOccurs */
unsigned long stomaxo(char * maxOccurs)
{
  if (maxOccurs==NULL) 
    return 1;
  if (!strcmp(maxOccurs,SAV_UNBOUNDED)) {
    return 0;
  }
  char * endptr=NULL;
  unsigned long result = strtoul(maxOccurs, &endptr, 10);
  if (strcmp(endptr,""))
    fprintf(stdout,"WARNING: maxOccurs est probablement incorrect '%s'\n",maxOccurs);
  return result;
}

int ston(char * use)
{
  if (use==NULL) 
    return N_REQUIRED;
  if (strcmp(use,"optional")==0)
    return N_OPTIONAL;
  if (strcmp(use,"required")==0)
    return N_REQUIRED;
  fprintf(stderr, "WARNING: use unknown : '%s'. It is replaced by 'required'.\n",use);
  return N_REQUIRED;
}


/* string to cardinality */
char * ctos(int i, int e)
{
  char * res=strdup("");
  char nb[10];
  sprintf(nb,"%lu",gElementChildrenMinOccurs[i][e]);
  str_join(&res,nb," > ",NULL);
  if (gElementChildrenMaxOccurs[i][e]==0)
    str_cat(&res,"unbounded");
  else {
    sprintf(nb,"%lu",gElementChildrenMaxOccurs[i][e]);
    str_cat(&res,nb);
  }
  return res;
}

/* string to cardinality */
char * ltoa(unsigned long val)
{
  char nb[32];
  char * res=strdup("");
  sprintf(nb,"%lu",val);
  str_cat(&res,nb);
  return res;
}




int isEmpty(char * test) {
  return (test==NULL || strcmp(test,"")==0);
}

char * getProp(xmlNode * node, const char * propname, char * defaut)
{
  char * s;
  s = (char *)xmlGetProp(node,(const xmlChar *)propname);
  if (s==NULL)
    return defaut;
  else
    return s;
}

char * cleanName(char * markup) 
{
  if (markup==NULL)
    return NULL;
  int i,j;
  char * s =str_capitalize(markup);
  for(i=0;i<strlen(s);i++) {
    switch(s[i]) {
    case '.':
    case '-': 
      s[i]='_'; 
      if (i<strlen(s)-1)
	s[i+1]=toupper(s[i+1]);
      for (j=i;j<strlen(s)-1;j++)
	s[j]=s[j+1];
      s[j]='\0';
      break;
    }
  }
  return s;
}

char * cleanConstant(char* att, char * enumeration) 
{
  int i;
  char  t[128];
  sprintf(t,"%s_%s",att,enumeration);
  char * s = str_toupper(t);
  for(i=0;i<strlen(s);i++) {
    switch(s[i]) {
    case ' ':
    case '.':
    case '-': 
      s[i]='_'; 
      break;
    }
  }
  return s;
}


int getElementIndex(char * markup)
{
  int i;
  char * name;
  name = cleanName(markup);
  for(i=0;i<gElementNb;i++)
    if (strcmp(name,gElementName[i])==0)
      return i;
  return -1;
}

long getChoiceIndex(char * markup)
{
  int i;
  char * name;
  name = cleanName(markup);
  for(i=0;i<gChoiceNb;i++)
    if (strcmp(name,gChoiceName[i])==0)
      return i;
  return -1;
}

char * getChoiceConstant(int i, int e, int c)
{
  return gChoiceConstant[gElementChildren[i][e]][c];
}

int getId(xmlNode * aNode)
{
  char * markup = getProp(aNode,SAN_NAME,NULL);
  int id;// = getElementIndex(markup);
  if (strcmp((char *)aNode->name, SEN_ELEMENT)==0)
    id = getElementIndex(markup);
  if (strcmp((char *)aNode->name, SEN_CHOICE)==0)
    id = getChoiceIndex(markup);
  if (id<0) {
    fprintf(stderr,"ERROR: Element/Choix inconnu, intru : %s\n",markup);
    exit(1);
  }
  return id;
}


char * getChildrenName(int i, int e) 
{
  int id = gElementChildren[i][e];
  if (gElementChildrenIsChoice[i][e])
    return gChoiceName[id];
  else
    return gElementName[id];
}

char * getChildrenMarkup(int i, int e) 
{
  int c, id = gElementChildren[i][e];
  char * markup = strdup("");
  if (gElementChildrenIsChoice[i][e]) {
    for (c=0;c<gChoiceElementNb[id];c++) {
      if (c>0)
	str_cat(&markup, "|");
      str_cat(&markup, gElementMarkup[gChoiceElement[id][c]]);
    }
    return markup;
  } else
    return gElementMarkup[id];
}

int getChildrenElementCount(int i , int e) {
  if (gElementChildrenIsChoice[i][e])
    return gChoiceElementNb[gElementChildren[i][e]];
  else
    return 1;
}

int getChildrenElementByIndex(int i, int e, int c) {
  if (gElementChildrenIsChoice[i][e]) 
    return gChoiceElement[gElementChildren[i][e]][c];
  else
    return gElementChildren[i][e];
}



char * startComment(int i)
{
  char * comment=strdup("");
  int a,c,e,id;
  str_join(&comment,CPP_HEADER,
	   "/* ***** BEGIN DESCRIPTION BLOCK *****\n",
	   " * Language:  ",gName," (",gShortName,")\n",
	   " * Version:   ",gVersion,"\n",
	   " * Load att.: ",gLoad,"\n",
	   " * Authors:   ",gAuthors,"\n",
	   " * License:   ",gLicense,"\n",NULL);
  if (i>=0) {
    str_join(&comment," *\n * @element ",gElementMarkup[i],"\n",NULL);
    for (a=0;a<gElementAttributeNb[i];a++) {
      str_join(&comment," *   @attribute ",gAttributeMarkup[i][a]," ",
	       IDL_TYPE[gAttributeType[i][a]],"\n",NULL);
      for(c=0;c<gAttributeEnumerationNb[i][a];c++) {
	str_join(&comment," *     @enumeration ",gEnumerationMarkup[i][a][c]," ",
		 gEnumerationValue[i][a][c], "\n",NULL);
      }
    }
    for (e=0;e<gElementChildrenNb[i];e++) {
      id = gElementChildren[i][e];
      str_join(&comment," *   @child ",getChildrenMarkup(i,e)," ",ctos(i,e),"\n",NULL);
    }
  }
  str_join(&comment,
	   " *\n",
	   " * Copyright ",gCopyright,".\n",
	   " * ***** END DESCRIPTION BLOCK ***** */\n\n",NULL);
  return comment;
} 










nsresult extendLoad(xmlDocPtr aExtend)
{
  xmlNode *rnode = NULL;
  xmlNodePtr fnode=NULL,  enode=NULL, anode=NULL;
  int i, e, p;
  char * pExtendName, *pElementMarkup, *pVersion, *pStatus;


  rnode = xmlDocGetRootElement(aExtend);

  pExtendName      = getProp(rnode, SAN_NAME, NULL);
  if (pExtendName==NULL) {
    fprintf(stderr,"Il n'y a pas de nom d'extension.\n");
    return NS_ERROR_FAILURE;
  }
  fprintf(stdout,"INFO: Loading %s\n", pExtendName);

  pVersion=getProp(rnode,SAN_VERSION,"");

  fnode = rnode->children;

  for (enode = fnode; enode; enode = enode->next) {
    if (enode->type == XML_ELEMENT_NODE) {
      if (strcmp((char *)enode->name, SEN_METHOD)==0) {
	if (gElementNb>=NB_METHODS) {
	  fprintf(stderr, "ERROR: Il y a trop de méthodes pour le programme (maximum %d éléments).\n",NB_METHODS);
	  return NS_ERROR_FAILURE;
	}
	i = gMethodNb;
	gMethodName[i] = strdup(getProp(enode,SAN_NAME,NULL));
	if (isEmpty(gMethodName[i])) {
	  fprintf(stderr, "ERROR: une balise méthode ne possède pas de nom.");
	  return NS_ERROR_FAILURE;
	}
	pElementMarkup = getProp(enode,SAN_ELEMENT,NULL);
	if (isEmpty(pElementMarkup)) {
	  fprintf(stderr, "ERROR: une balise méthode ne possède pas de référence vers un élément.");
	  return NS_ERROR_FAILURE;
	}
	gMethodElement[i]  = getElementIndex(pElementMarkup);
	if (gMethodElement[i]<0) {
	  fprintf(stderr, "ERROR: une balise méthode '%s' possède une référence vers un élément inconnu (%s).", gMethodName[i], pElementMarkup);
	  return NS_ERROR_FAILURE;
	}
	pStatus = getProp(enode,SAN_STATUS,NULL);
	if (pStatus==NULL || strcmp(pStatus, SAV_FROZEN))
	  gElementToWrite[gMethodElement[i]]=1;

	gMethodExtend[i] = strdup(pExtendName);
	
	// Verification de l'unicité des méthodes
	for (e=0;e<i;e++) {
	  if (strcmp(gMethodName[i], gMethodName[e])==0 && gMethodElement[i]==gMethodElement[e]) {
	    fprintf(stderr, "ERROR: la méthode '%s' (pour l'élément '%s') existe déjà.\n",gMethodName[e], 
		    gElementMarkup[gMethodElement[e]]);
	    return NS_ERROR_FAILURE;
	  }
	}
	gMethodIdlPrototype[i] = strdup("  void ");
	gMethodCppFunction[i]  = strdup("/**\n");
	str_join(&gMethodCppFunction[i]," * ",gMethodExtend[i],": ",gMethodName[i],"\n",
		 " * @version ",pVersion,"\n",
		 " */\n",
		 "NS_IMETHODIMP ",NULL);
	str_join(&gMethodIdlPrototype[i],gMethodName[i],"(",NULL);
	str_join(&gMethodCppFunction[i],gCppClassname[gMethodElement[i]],"::",
		 str_firstcap(gMethodName[i]),"(",NULL);

	// Recensement des paramètres et recherche du code
	anode = enode->children;
	gMethodParameterNb[i]  = 0;
	gMethodCode[i] = strdup("");
	if (anode) {
	  for (;anode;anode=anode->next) {
	    if (anode->type == XML_ELEMENT_NODE) {

 	      if (strcmp((char *)anode->name, SEN_PARAMETER)==0) {
		p = gMethodParameterNb[i];
		gParameterName[i][p]=getProp(anode,SAN_NAME,NULL);
		if (isEmpty(gParameterName[i][p])) {
		  fprintf(stderr, "ERROR: Dans la méthode '%s', il manque le nom d'un paramètre.\n",gMethodName[i]);
		  return NS_ERROR_FAILURE;
		}
		gParameterType[i][p]=stot(getProp(anode,SAN_TYPE,NULL));
		if (gParameterType[i][p]==T_UNKNOWN) {
		  fprintf(stderr, "ERROR: Dans la méthode '%s', le type du paramètre '%s' n'est pas correct.\n",gMethodName[i], gParameterName[i][p]);
		  return NS_ERROR_FAILURE;
		}
		gParameterDir[i][p]=stod(getProp(anode,SAN_DIRECTION,NULL));
		if (gParameterDir[i][p]==D_UNKNOWN) {
		  fprintf(stderr, "ERROR: Dans la méthode '%s', la direction du paramètre '%s' n'est pas correcte.\n",gMethodName[i], gParameterName[i][p]);
		  return NS_ERROR_FAILURE;
		}
		if (p>0) {
		  str_cat(&gMethodIdlPrototype[i],", ");
		  str_cat(&gMethodCppFunction[i],", ");
		}
		str_join(&gMethodIdlPrototype[i],IDL_DIR[gParameterDir[i][p]]," ",
			 IDL_TYPE[gParameterType[i][p]]," ",gParameterName[i][p],NULL);
		switch(gParameterDir[i][p]) {
		case D_IN :
		  str_join(&gMethodCppFunction[i],CPPIN_TYPE[gParameterType[i][p]]," a",
			   str_firstcap(gParameterName[i][p]),NULL);
		  break;
		default:
		  str_join(&gMethodCppFunction[i],CPPOUT_TYPE[gParameterType[i][p]]," a",
			   str_firstcap(gParameterName[i][p]),NULL);
		}
		
	      }
	      
 	      if (strcmp((char *)anode->name, SEN_CODE)==0) {
		if (anode->children->type==XML_TEXT_NODE)
		  str_cat(&gMethodCode[i],strdup((char *)anode->children->content));
	      }


	    } 
	  } 
	} 
	// Traitement du code
	str_join(&gMethodIdlPrototype[i],")",NULL);
	str_join(&gMethodCppFunction[i],")\n{",gMethodCode[i],"}\n",NULL);
	gMethodNb++;
      }
    } 
  }


  fprintf(stdout,"INFO: %d methodes\n",gMethodNb);
  return NS_OK;
}







/**
 * Charge une balise <code>element</code>
 * @param aSchema 
 * @return State of the procedure
 */
nsresult elementLoad(xmlNodePtr aElementNode)
{
  xmlNodePtr anode=NULL, cnode=NULL;
  int i, e, a, c, type;
  unsigned long minOccurs, maxOccurs;
  char *name, aName[128], *cname, *cvalue;
  char phrase[256];
  
  if (gElementNb>=NB_ELEMENTS) {
    fprintf(stderr, "ERROR: Il y a trop d'éléments pour le programme (maximum %d éléments).\n",NB_ELEMENTS);
    return NS_ERROR_FAILURE;
  }

  i = gElementNb;
  gElementMarkup[i]  = getProp(aElementNode,SAN_NAME,NULL);
  gElementName[i]    = cleanName(gElementMarkup[i]);
  gElementToWrite[i] = 0;

  // Verification de l'unicité des éléments
  for (e=0;e<i;e++)
    if (strcmp(gElementName[i], gElementName[e])==0) {
      fprintf(stderr, "ERROR: l'élément '%s' existe déjà (cf '%s').\n",gElementMarkup[e],gElementMarkup[i]);
      return NS_ERROR_FAILURE;
    }
  
  if (isEmpty(gElementName[i])) {
    fprintf(stderr, "ERROR: une balise element ne possède pas de nom.");
    return NS_ERROR_FAILURE;
  }
  gElementType[i] = stot(getProp(aElementNode,SAN_TYPE,NULL));
  
  gIdl[i] = strdup("");
  gCpp[i] = strdup("");
  gHpp[i] = strdup("");
  
  sprintf(phrase, "%sI%s%s", gPrefix, gShortName, gElementName[i]);
  gIdlClassname[i] = strdup(phrase);
  sprintf(phrase, "%s%s%s" , gPrefix, gShortName, gElementName[i]);
  gCppClassname[i] = strdup(phrase);
      
  
  // Recensement des attributs
  // Recensement des enfants
  anode = aElementNode->children;
  gElementChildrenNb[i]  = 0;
  gElementAttributeNb[i] = 0;
  //  gElementChoiceNb[i]    = 0;
  for (;anode;anode=anode->next) {
    NEXT_ELEMENT(anode);
    
    name=getProp(anode,SAN_NAME,NULL);
    if (isEmpty(name)) {
      fprintf(stderr, "ERROR: Dans '%s', il manque un nom un attribut ou un élément.\n",gElementMarkup[i]);
      return NS_ERROR_FAILURE;
    }
    
    // Recensement des éléments fils
    if (strcmp((char *)anode->name, SEN_ELEMENT)==0 || strcmp((char *)anode->name, SEN_CHOICE)==0) {
      minOccurs = stomino(getProp(anode,SAN_MINOCCURS,NULL));
      maxOccurs = stomaxo(getProp(anode,SAN_MAXOCCURS,NULL));
      if (minOccurs>maxOccurs && maxOccurs>0) {
	fprintf(stderr, "ERROR: minOccurs est supérieur à maxOccurs dans l'élément '%s'.\n", gElementMarkup[i]);
	return NS_ERROR_FAILURE;
      }
      gElementChildrenMinOccurs[i][gElementChildrenNb[i]] = minOccurs;
      gElementChildrenMaxOccurs[i][gElementChildrenNb[i]] = maxOccurs;
      if (strcmp((char *)anode->name, SEN_CHOICE)==0) {
	//	fprintf(stdout,"(%s, %d %d)",anode->name,i,gElementChildrenNb[i]);
	gElementChildrenIsChoice [i][gElementChildrenNb[i]] = 1;
      } else
	gElementChildrenIsChoice [i][gElementChildrenNb[i]] = 0;

      gElementChildrenNb[i]++;
    }
    

    // Récupération des attributs
    if (strcmp((char *)anode->name, SEN_ATTRIBUTE)==0) {
      if (gElementAttributeNb[i]>=NB_ATTRIBUTES) {
	fprintf(stderr, "ERROR: L'élément '%s' possède trop d'attributs (maximum %d attributs).\n", gElementMarkup[i], NB_ATTRIBUTES);
	return NS_ERROR_FAILURE;
      }
      type = stot(getProp(anode,SAN_TYPE,NULL));
      if (type==T_UNKNOWN) {
	fprintf(stderr, "ERROR: Dans '%s' le type de l'attribut '%s' n'est pas spécifié correctement.\n", gElementMarkup[i],name);
	return NS_ERROR_FAILURE;
      }
      a = gElementAttributeNb[i]++;
      sprintf(aName,"_%s",cleanName(name));
      //fprintf(stderr,"%s %s\n",gElementName[i],aName);
      gAttributeName[i][a]     = cleanName(name);
      gAttributeIdlName[i][a]  = strdup(aName);
      gAttributeMarkup[i][a]   = name;
      gAttributeType[i][a]     = type;
      gAttributeEnumerationNb[i][a] = 0;
      if (strcmp(str_tolower(gAttributeName[i][a]),str_tolower(gElementName[i]))==0) {
	fprintf(stderr, "ERROR: Dans '%s', l'attribut '%s' ne doit pas porter le même nom que l'élément auquel il appartient.\n", gElementMarkup[i],name);
	return NS_ERROR_FAILURE;
      }
      int a_;
      for (a_=0;a_<gElementAttributeNb[i]-1;a_++)
	if (strcmp(gAttributeName[i][a], gAttributeName[i][a_])==0) {
	  fprintf(stderr, "ERROR: l'attribut '%s' est spécifié plusieurs fois pour l'élément '%s'.\n",gAttributeMarkup[i][a], gElementMarkup[e]);
	  return NS_ERROR_FAILURE;
	}
      
      
      /* Gestion des choix */
      c = 0;
      cnode = anode->children;
      for (;cnode;cnode=cnode->next) {
	NEXT_ELEMENT(cnode);
	
	if (strcmp((char *)cnode->name, SEN_ENUMERATION)==0) {
	  
	  cname=getProp(cnode,SAN_NAME,NULL);
	  if (isEmpty(cname)) {
	    fprintf(stderr, "ERROR: Dans '%s', il manque le nom d'un choix dans la liste de '%s'.\n",gElementMarkup[i],gAttributeMarkup[i][a]);
	    return NS_ERROR_FAILURE;
	  }
	  
	  c = gAttributeEnumerationNb[i][a]++;
	  gEnumerationMarkup[i][a][c] = strdup(cname);
	  gEnumerationName[i][a][c] = cleanConstant(gAttributeMarkup[i][a],cname);
	  cvalue = getProp(cnode,SAN_VALUE,NULL);
	  if (isEmpty(cvalue)) {
	    fprintf(stderr, "WARNING : Dans '%s', il manque la valeur du choix '%s' dans la liste de '%s'.\n",gElementMarkup[i],cname,gAttributeMarkup[i][a]);
	    cvalue = strdup(cname);
	  }
	  gEnumerationValue[i][a][c] = strdup(cvalue);
	}
      }
      /* Fin Gestion des choix */
      
      /// Need
      gAttributeNeed[i][a] = ston(getProp(anode,SAN_USE,NULL));
      
    } /* Fin Gestion des attributs */
  }
  
  if (gElementChildrenNb[i]==0 && gElementType[i]==T_UNKNOWN) {
    fprintf(stderr, "ERROR: Un type doit être spécifié pour l'élément '%s'.\n",gElementMarkup[i]);
    return NS_ERROR_FAILURE;
  }
  
  gElementNb++;
  return NS_OK;
}



/**
 * Charge une balise <code>schemax</code>
 * @param aSchema 
 * @return State of the procedure
 */
nsresult schemaLoad(xmlDocPtr aSchema) 
{
  nsresult rv;
  xmlNodePtr rnode = NULL;
  xmlNodePtr fnode=NULL,  enode=NULL, anode=NULL;
  int i, e;
  char phrase[512];

  rnode = xmlDocGetRootElement(aSchema);

  gName      = getProp(rnode, SAN_NAME, gName);
  if (gName==NULL) {
    fprintf(stderr,"Il n'y a pas de nom de schema.\n");
    return NS_ERROR_FAILURE;
  }
  fprintf(stdout,"INFO: Loading %s\n",gName);

  gVersion   = getProp(rnode,SAN_VERSION,gVersion);
  gPrefix    = getProp(rnode,"prefix",gPrefix);
  gShortName = str_firstcap(getProp(rnode,"shortname",gShortName));
  gFamily    = getProp(rnode,"family",gFamily);
  gLoad      = getProp(rnode,"load",gLoad);
  gFile      = getProp(rnode,"file",gFile);
  gAuthors   = getProp(rnode,"authors",gAuthors);
  gCopyright = getProp(rnode,"copyright",gCopyright);
  gLicense   = getProp(rnode,"license",gLicense);

  gParentName    = cleanName(getProp(rnode,"parent",gParentName));
  sprintf(phrase, "%sI%s%s", gPrefix, gShortName, gParentName);
  gParentIdlClassname = strdup(phrase);
  sprintf(phrase, "%s%s%s", gPrefix, gShortName, gParentName);
  gParentCppClassname = strdup(phrase);

  fnode = rnode->children;
  gElementNb = 0;
  gChoiceNb = 0;


  for (enode = fnode; enode; enode = enode->next) {
    NEXT_ELEMENT(enode);

    // Recuperation des elements
    if (strcmp((char *)enode->name, SEN_ELEMENT)==0) {
      rv = elementLoad(enode);
      NS_ENSURE_SUCCESS(rv, rv);
    }

    // Recuperation des choix
    if (strcmp((char *)enode->name, SEN_CHOICE)==0) {
      if (gChoiceNb>=NB_CHOICES) {
	fprintf(stderr, "ERROR: Il y a trop de méthodes pour le programme (maximum %d éléments).\n",NB_METHODS);
	return NS_ERROR_FAILURE;
      }
      i = gChoiceNb;
      gChoiceMarkup[i] = getProp(enode, SAN_NAME, NULL);
      if (isEmpty(gChoiceMarkup[i])) {
	fprintf(stderr, "ERROR: une balise choix ne possède pas de nom.\n");
	return NS_ERROR_FAILURE;
      }
      gChoiceName[i] = cleanName(gChoiceMarkup[i]);
      if (isEmpty(gChoiceName[i])) {
	fprintf(stderr, "ERROR: une balise choix ne possède pas de nom valide.\n");
	return NS_ERROR_FAILURE;
      }
      gChoiceNb++;
    }

  }

  // Identification des enfants par leur id
  // Enregistrement des choices(...)
  for (enode = fnode; enode; enode = enode->next) {
    NEXT_ELEMENT(enode);

    // Mise à jour des fils des éléments
    if (strcmp((char *)enode->name, SEN_ELEMENT)==0) {
      e = getId(enode);
      i = 0;
      anode = enode->children;
      for (;anode;anode=anode->next) {
	NEXT_ELEMENT(anode);
	if (strcmp((char *)anode->name, SEN_ELEMENT)==0 || strcmp((char *)anode->name, SEN_CHOICE)==0) {
	  gElementChildren[e][i]     = getId(anode);
	  i++;
	}
	/*
	if (strcmp((char *)anode->name, SEN_CHOICE)==0) {
	  gElementChildrenChoice[e][i] = getId(anode);
	  i++;
	}
	*/
      }
      if (i!=gElementChildrenNb[e]){
	fprintf(stderr,"ERROR: Bizarre! Le nombre de fils a changé durant le chargement!\n");
	return NS_ERROR_FAILURE;
      }
    }


    // Récupération des id des éléments de la structure
    if (strcmp((char *)enode->name, SEN_CHOICE)==0) {
      e = getId(enode);
      gChoiceElementNb[e] = 0;
      anode = enode->children;
      for (;anode;anode=anode->next) {
	NEXT_ELEMENT(anode);
	if (strcmp((char *)anode->name, SEN_ELEMENT)==0) {
	  gChoiceElement[e][gChoiceElementNb[e]]=getId(anode);
	  gChoiceConstant[e][gChoiceElementNb[e]]=cleanConstant(gChoiceMarkup[e], getProp(anode, SAN_NAME, NULL));
	  str_cat(&gChoiceConstant[e][gChoiceElementNb[e]],"_LID");
	  gChoiceElementNb[e]++;
	}
      }
      // Fin
    }


  }


  fprintf(stdout,"INFO: %d elements & %d choices, %d classes (%d UUID)\n",gElementNb, gChoiceNb, gElementNb+1, (gElementNb+1)*2);
  return NS_OK;  
}













nsresult build(void) 
{
  int i, a, e, c, m;
  char tmp[128], *uuid, *class;
  int id;
  int type;
  char * pLoadCode="";

  
  
  /* Build Idl/C++/H Files */
  for(i=0; i<gElementNb;i++) {
    trace("Building element '",gElementName[i],"'",NULL);
    // Débuts
    str_cat(&gIdl[i],startComment(i));
    //str_cat(&gIdl[i],  "#include \"nsISupports.idl\"\n");
    str_join(&gIdl[i], "#include \"",gParentIdlClassname,".idl\"\n\n",NULL);

    str_cat(&gIdl[i], "#include \"nsIDOMNode.idl\"\n");
    str_cat(&gIdl[i], "#include \"nsILocalFile.idl\"\n\n");
    
    str_cat(&gHpp[i],startComment(i));
    str_cat(&gHpp[i],"#ifndef __");
    str_cat(&gHpp[i],gCppClassname[i]);
    str_cat(&gHpp[i],"_h__\n#define __");
    str_cat(&gHpp[i],gCppClassname[i]);
    str_cat(&gHpp[i],"_h__\n");
    str_cat(&gHpp[i],"#include \"nspr.h\"\n");
    str_cat(&gHpp[i],"#include \"nsCOMPtr.h\"\n");
    str_cat(&gHpp[i],"#include \"nsCOMArray.h\"\n");
    str_cat(&gHpp[i],"#include \"nsString.h\"\n");
    //    str_cat(&gHpp[i],"#include \"nsILocalFile.h\"\n");
    //    str_cat(&gHpp[i],"#include \"nsIDOMNode.h\"\n");
    str_cat(&gHpp[i],"#include \"nsIDOMParser.h\"\n");
    str_cat(&gHpp[i],"#include \"nsIDOMSerializer.h\"\n");
    str_cat(&gHpp[i],"#include \"nsIDOMDocument.h\"\n");
    str_cat(&gHpp[i],"#include \"nsIDOMElement.h\"\n");
    str_cat(&gHpp[i],"#include \"nsIDOMNodeList.h\"\n");
    str_cat(&gHpp[i],"#include \"nsIDOMNamedNodeMap.h\"\n");
    str_cat(&gHpp[i],"#include \"nsIPromptService.h\"\n");
    str_cat(&gHpp[i],"#include \"nsIFileStreams.h\"\n");
    str_cat(&gHpp[i],"#include \"nsIVariant.h\"\n");
    str_cat(&gHpp[i],"#include \"nsEmbedCID.h\"\n");
    str_cat(&gHpp[i],"#include \"nsNetCID.h\"\n");
    str_cat(&gHpp[i],"#include \"nsUnicharUtils.h\"\n");
    str_cat(&gHpp[i],"#include \"nsScriptableInputStream.h\"\n");
    str_join(&gHpp[i],"#include \"",gIdlClassname[i],".h\"\n",NULL);
    str_cat(&gHpp[i],"#define PM_TESTOUILLE(a,b) if(NS_FAILED(a)){printf(\"[%%s, %%d]\",__FILE__,__LINE__);return(b);} \n");

    trace("  Includes",NULL);
    for (e=0;e<gElementNb;e++)
      gAlreadyDefined[e]=0;

    //Includes des enfants
    for (e=0;e<gElementChildrenNb[i];e++) {
      id = gElementChildren[i][e];
      for (c=0;c<getChildrenElementCount(i,e);c++) {
	id = getChildrenElementByIndex(i,e,c);
	if (!gAlreadyDefined[id]) {
	  str_cat(&gIdl[i], "interface ");
	  str_cat(&gIdl[i], gIdlClassname[id]);
	  str_cat(&gIdl[i], ";\n");
	  
	  str_cat(&gHpp[i], "#include \"");
	  str_cat(&gHpp[i], gIdlClassname[id]);
	  str_cat(&gHpp[i], ".h\"\n");
	  gAlreadyDefined[id] = 1;
	}
      }
    }

    
    trace("  Middle",NULL);
    // Debut du milieu
    // ",gParentIdlClassname,"
    str_join(&gIdl[i], "\n[scriptable, uuid(",getUUID(),")]\ninterface ",gIdlClassname[i],
	     " : ",gParentIdlClassname,"\n{\n", NULL);


    // Constantes de choix
    
    for (e=0;e<gElementChildrenNb[i];e++) {
      if (gElementChildrenIsChoice[i][e]) {
	for(c=0;c<getChildrenElementCount(i,e);c++) {
	  //	  sprintf(tmpb,"%s_%s_LID",str_toupper(getChildrenName(i,e)),
	  //		  str_toupper(gElementName[getChildrenElementByIndex(i,e,c)]));
	  //	  gElementChildrenConstant[i][e][c] = cleanConstant(getChildrenName(i,e), gElementMarkup[getChildrenElementByIndex(i,e,c)]);
	  //	  str_cat(&gElementChildrenConstant[i][e][c],"_LID");
	  str_join(&gIdl[i], "  const ", IDL_TYPE[T_UINT32], " ", getChoiceConstant(i,e,c),
		   " = ",ltoa(16384*(i+1)+128*(e+1)+c),";\n",NULL);
	}
      }
    }
    if (e>0)
      str_cat(&gIdl[i],"\n");

    // Constantes d'énumerations
    e=0;
    for (a=0;a<gElementAttributeNb[i];a++) {
      for(c=0;c<gAttributeEnumerationNb[i][a];c++) {
	str_join(&gIdl[i],"  const ",IDL_TYPE[gAttributeType[i][a]]," ",gEnumerationName[i][a][c],
		 " = ", IDL_PREFIX[gAttributeType[i][a]],gEnumerationValue[i][a][c],
		 IDL_SUFFIX[gAttributeType[i][a]],";\n",NULL);
	e++;
      }
    }
    if (e>0)
      str_cat(&gIdl[i],"\n");
    // Fonctions de base
    str_join(&gIdl[i],"  void ",str_tolower(F_LOAD),"(in nsILocalFile file);\n",NULL);
    str_join(&gIdl[i],"  void ", str_tolower(F_ANALYZE), "(in nsILocalFile currentFile,",
	     " in nsIDOMNode node);\n",NULL);

    // Ajout des prototypes des méthodes d'extension
    for (m=0;m<gMethodNb;m++)
      if (i==gMethodElement[m])
	str_join(&gIdl[i], gMethodIdlPrototype[m],";\n",NULL);
    str_cat(&gIdl[i],"\n");


    str_cat(&gHpp[i], "\nclass ");
    str_cat(&gHpp[i], gCppClassname[i]);
    str_cat(&gHpp[i], " : public ");
    str_cat(&gHpp[i], gIdlClassname[i]);
    str_cat(&gHpp[i], "\n{\n public:\n  NS_DECL_ISUPPORTS\n  NS_DECL_");
    str_join(&gHpp[i],str_toupper(gIdlClassname[i]),"\n",NULL);
    str_join(&gHpp[i],"  ",gCppClassname[i],"();\n",NULL);
    str_cat(&gHpp[i], " private:\n");
    str_join(&gHpp[i],"  ~",gCppClassname[i],"();\n",NULL);
    str_cat(&gHpp[i], "  NS_IMETHODIMP GetFullPath(const nsAString &, nsILocalFile **);\n");
    str_cat(&gHpp[i], " protected:\n");
    str_cat(&gHpp[i], "  nsCOMPtr<nsILocalFile> mCurrentFile;\n");


    str_cat(&gCpp[i], startComment(i));
    str_cat(&gCpp[i],"#include \"");
    str_cat(&gCpp[i],gCppClassname[i]);
    str_cat(&gCpp[i],".h\"\n\n");
    str_cat(&gCpp[i],"NS_IMPL_ISUPPORTS1(");
    str_cat(&gCpp[i],gCppClassname[i]);
    str_cat(&gCpp[i],", ");
    str_cat(&gCpp[i],gIdlClassname[i]);
    str_cat(&gCpp[i],")\n\n");

    // Constructor
    str_join(&gCpp[i],gCppClassname[i],"::",gCppClassname[i],"()\n{\n",NULL);
#ifdef TRACE
    str_join(&gCpp[i],"  printf(\"Constructor ",gCppClassname[i],"\\n\");\n",NULL);
#endif
    for (a=0;a<gElementAttributeNb[i];a++) {
      switch(gAttributeType[i][a]) {
      case T_PATH : 
	str_join(&gCpp[i],"  m",gAttributeName[i][a]," = nsnull;\n",NULL);
	break;
      case T_BOOLEAN : 
	str_join(&gCpp[i],"  m",gAttributeName[i][a]," = PR_FALSE;\n",NULL);
	break;
      case T_UINT32 : 
	str_join(&gCpp[i],"  m",gAttributeName[i][a]," = 0;\n",NULL);
	break;
      case T_STRING : 
	str_join(&gCpp[i],"  m",gAttributeName[i][a]," = NS_LITERAL_STRING(\"\");\n",NULL);
	break;
      }
    }

    str_cat(&gCpp[i],"}\n");
   

    // Destructor
    str_join(&gCpp[i],gCppClassname[i],"::~",gCppClassname[i],"()\n{\n",NULL);
#ifdef TRACE
    str_join(&gCpp[i],"  printf(\"Destructor ",gCppClassname[i],"\\n\");\n",NULL);
#endif
    str_cat(&gCpp[i],"}\n\n");



    // Ajout des corps des méthodes d'extension
    for (m=0;m<gMethodNb;m++)
      if (i==gMethodElement[m])
	str_cat(&gCpp[i], gMethodCppFunction[m]);
    str_cat(&gCpp[i],"\n");






    trace("  GetFullPath",NULL);
    // GetFullPath
    str_join(&gCpp[i],"NS_IMETHODIMP ",gCppClassname[i],
	     "::GetFullPath(const nsAString & aRelativePath ,nsILocalFile ** aReturn)\n{\n",NULL);
    str_cat(&gCpp[i],"  nsresult rv;\n");
    str_cat(&gCpp[i],"  PRUint32 pIndex, pLength;\n");
    str_cat(&gCpp[i],"  nsAutoString pPath, pStep, pChar;\n");
    str_cat(&gCpp[i],"  nsCOMPtr<nsIFile> pParentFile;\n\n");
    str_cat(&gCpp[i],"  pPath   = aRelativePath+NS_LITERAL_STRING(\"/\");\n");
    str_cat(&gCpp[i],"  pLength = pPath.Length();\n");
    str_cat(&gCpp[i],"  rv = ((nsIFile *)mCurrentFile)->GetParent(getter_AddRefs(pParentFile));\n");
    str_cat(&gCpp[i],"  PM_TESTOUILLE(rv, rv);\n");
    str_cat(&gCpp[i],"  pStep = NS_LITERAL_STRING(\"\");\n");
    str_cat(&gCpp[i],"  for (pIndex=0;pIndex<pLength;pIndex++) {\n");
    str_cat(&gCpp[i],"    pPath.Mid(pChar,pIndex,1);\n");
    str_cat(&gCpp[i],"    if (pChar==NS_LITERAL_STRING(\"/\") || pChar==NS_LITERAL_STRING(\"\\\\\")) {\n");
    str_cat(&gCpp[i],"      rv = pParentFile->Append(pStep);\n");
    str_cat(&gCpp[i],"      PM_TESTOUILLE(rv, rv);\n");
    str_cat(&gCpp[i],"      pStep = NS_LITERAL_STRING(\"\");\n");
    str_cat(&gCpp[i],"    } else\n");
    str_cat(&gCpp[i],"      pStep += pChar;\n");
    str_cat(&gCpp[i],"  }\n");
    str_cat(&gCpp[i],"  rv = pParentFile->Clone((nsIFile **)aReturn);\n");
    str_cat(&gCpp[i],"  return rv;\n");
    str_cat(&gCpp[i],"}\n\n");

    /* Load File
     *
     *  Open and parse XML file, and execute 'LoadNode'
     *  Finally, free the DOM document
     *
     */
    trace("  Load",NULL);
    str_join(&gCpp[i],"NS_IMETHODIMP ",gCppClassname[i],"::",F_LOAD,"(nsILocalFile * aLocalFile)\n{\n",NULL);
#ifdef TRACE
    str_join(&gCpp[i],"  printf(\"Load ",gCppClassname[i],"\\n\");\n",NULL);
#endif
    str_cat(&gCpp[i],"  nsresult rv;\n");
    str_cat(&gCpp[i],"  nsCOMPtr<nsIDOMDocument> pDocument;\n");
    str_cat(&gCpp[i],"  PRBool   pExists;\n");
    str_cat(&gCpp[i],"  PRUint32 pAvailable;\n");
    str_cat(&gCpp[i],"  char *   pText;\n");
    str_cat(&gCpp[i],"  nsString pFileContent;\n\n");

    str_cat(&gCpp[i],"  rv = aLocalFile->Exists(&pExists);\n");
    str_cat(&gCpp[i],"  PM_TESTOUILLE(rv, rv);\n");
    str_cat(&gCpp[i],"  if(!pExists)\n");
    str_cat(&gCpp[i],"    return NS_ERROR_FILE_NOT_FOUND;\n");
    str_cat(&gCpp[i],"  nsCOMPtr<nsIFileInputStream> pFileInputStream = do_CreateInstance(NS_LOCALFILEINPUTSTREAM_CONTRACTID, &rv);\n");
    str_cat(&gCpp[i],"  PM_TESTOUILLE(rv, rv);\n");
    str_cat(&gCpp[i],"  rv = pFileInputStream->Init(aLocalFile, PR_RDONLY, PR_IROTH, nsnull);\n");
    str_cat(&gCpp[i],"  PM_TESTOUILLE(rv, rv);\n");
    str_cat(&gCpp[i],"  nsCOMPtr<nsIScriptableInputStream> pProjectScriptableInputStream = do_CreateInstance(NS_SCRIPTABLEINPUTSTREAM_CONTRACTID, &rv);\n");
    str_cat(&gCpp[i],"  PM_TESTOUILLE(rv, rv);\n");
    str_cat(&gCpp[i],"  rv = pProjectScriptableInputStream->Init(pFileInputStream);\n");
    str_cat(&gCpp[i],"  PM_TESTOUILLE(rv, rv);\n");
    str_cat(&gCpp[i],"  rv = pProjectScriptableInputStream->Available(&pAvailable);\n");
    str_cat(&gCpp[i],"  PM_TESTOUILLE(rv, rv);\n");
    str_cat(&gCpp[i],"  rv = pProjectScriptableInputStream->Read(pAvailable, &pText);\n");
    str_cat(&gCpp[i],"  PM_TESTOUILLE(rv, rv);\n");
    str_cat(&gCpp[i],"  pFileContent.AssignWithConversion(pText);\n");
    str_cat(&gCpp[i],"  nsCOMPtr<nsIDOMParser> pDOMParser = do_CreateInstance(NS_DOMPARSER_CONTRACTID, &rv);\n");
    str_cat(&gCpp[i],"  PM_TESTOUILLE(rv, rv);\n");
    str_cat(&gCpp[i],"  rv = pDOMParser->ParseFromString(pFileContent.get(), \"application/xml\",  getter_AddRefs(pDocument));\n");
    str_cat(&gCpp[i],"  PM_TESTOUILLE(rv, rv);\n");
    str_cat(&gCpp[i],"  nsCOMPtr<nsIDOMElement> pRootElement;\n");
    str_cat(&gCpp[i],"  nsAutoString pTagName, pNamespaceURI, pContent;\n");
    str_cat(&gCpp[i],"  rv = pDocument->GetDocumentElement(getter_AddRefs(pRootElement));\n");
    str_cat(&gCpp[i],"  PM_TESTOUILLE(rv, rv);\n");
    str_cat(&gCpp[i],"  rv = pRootElement->GetTagName(pTagName);\n");
    str_cat(&gCpp[i],"  PM_TESTOUILLE(rv, rv);\n");
    str_cat(&gCpp[i],"  rv = pRootElement->GetNamespaceURI(pNamespaceURI);\n");
    str_cat(&gCpp[i],"  PM_TESTOUILLE(rv, rv);\n");
    str_cat(&gCpp[i],"  if(pTagName==NS_LITERAL_STRING(\"parserError\") || pNamespaceURI == NS_LITERAL_STRING(\"http://www.mozilla.org/newlayout/xml/parsererror.xml\"))\n");
    str_cat(&gCpp[i],"    {\n");
    str_cat(&gCpp[i],"      nsCOMPtr<nsIDOMSerializer> pSerializer = do_CreateInstance(NS_XMLSERIALIZER_CONTRACTID, &rv);\n");
    str_cat(&gCpp[i],"      PM_TESTOUILLE(rv, rv);\n");
    str_cat(&gCpp[i],"      pSerializer->SerializeToString(pRootElement, pContent);\n");
    str_cat(&gCpp[i],"      nsCOMPtr<nsIPromptService> pPrompt = do_CreateInstance(NS_PROMPTSERVICE_CONTRACTID, &rv);\n");
    str_cat(&gCpp[i],"      PM_TESTOUILLE(rv, rv);\n");
    str_cat(&gCpp[i],"      pPrompt->Alert(nsnull, ToNewUnicode(NS_LITERAL_STRING(\"Erreur de syntaxe XML\")), ToNewUnicode(pContent));\n");
    str_cat(&gCpp[i],"      return NS_ERROR_FAILURE;\n");
    str_cat(&gCpp[i], "    }\n");
    str_join(&gCpp[i],"  rv = ", F_ANALYZE,"(aLocalFile, pRootElement);\n", NULL);
    str_cat(&gCpp[i], "  return rv;\n}\n\n");

    /* Analyze
     * 
     * Read the the First generation of the DOM tree
     * and execute 'Load' functions on the children 
     *
     */
    trace("  Analyze",NULL);
    str_join(&gCpp[i],"NS_IMETHODIMP ",gCppClassname[i],"::", F_ANALYZE, 
      "(nsILocalFile * aCurrentFile, nsIDOMNode * aNode)\n{\n", NULL);
#ifdef TRACE
    str_join(&gCpp[i],"  printf(\"Analyze (",gCppClassname[i],"\\n\");\n",NULL);
#endif
    str_cat(&gCpp[i],"  nsresult rv;\n");
    str_cat(&gCpp[i],"  nsAutoString pName, pValue;\n");
    str_cat(&gCpp[i],"  nsCOMPtr<nsIDOMNamedNodeMap> pAttributes;\n");
    str_cat(&gCpp[i],"  nsCOMPtr<nsIDOMNode> pAttribute;\n");
    str_cat(&gCpp[i],"  PRUint32 pLength;\n\n");
    str_cat(&gCpp[i],"  nsCOMPtr<nsIWritableVariant> pVariant = do_CreateInstance(NS_VARIANT_CONTRACTID, &rv);\n");
    str_cat(&gCpp[i],"  PM_TESTOUILLE(rv, rv);\n\n");

    str_cat(&gCpp[i],"  rv = ((nsIFile*)aCurrentFile)->Clone((nsIFile**)&mCurrentFile);\n");
    str_cat(&gCpp[i],"  PM_TESTOUILLE(rv, rv);\n\n");

    str_cat(&gCpp[i],"  rv = aNode->GetNodeName(pName);\n");
    str_cat(&gCpp[i],"  PM_TESTOUILLE(rv, rv);\n");
    str_cat(&gCpp[i],"  if (pName!=NS_LITERAL_STRING(\"");
    str_cat(&gCpp[i],gElementMarkup[i]);
    str_cat(&gCpp[i],"\")) {\n");
    str_cat(&gCpp[i],"    nsCOMPtr<nsIPromptService> pPrompt = do_CreateInstance(NS_PROMPTSERVICE_CONTRACTID, &rv);\n");
    str_cat(&gCpp[i],"    PM_TESTOUILLE(rv, rv);\n");
    str_cat(&gCpp[i],"    pPrompt->Alert(nsnull, ToNewUnicode(NS_LITERAL_STRING(\"Erreur de correspondance de balises\")), \n");
    str_cat(&gCpp[i],"		     ToNewUnicode(NS_LITERAL_STRING(\"La balise '");
    str_cat(&gCpp[i],gElementMarkup[i]);
    str_cat(&gCpp[i],"' était attendue au lieu de : \")+pName));\n");
    str_cat(&gCpp[i],"    return NS_ERROR_FAILURE;\n");
    str_cat(&gCpp[i],"  }\n");
    // Vérification que la balise racine corresponde à la classe
    str_cat(&gCpp[i],"  rv = aNode->GetAttributes(getter_AddRefs(pAttributes));\n");
    str_cat(&gCpp[i],"  PM_TESTOUILLE(rv, rv);\n");
    str_cat(&gCpp[i],"  pAttributes->GetLength(&pLength);\n");
    str_cat(&gCpp[i],"  rv = pAttributes->GetNamedItem(NS_LITERAL_STRING(\"");
    str_cat(&gCpp[i],gLoad);
    str_cat(&gCpp[i],"\"), getter_AddRefs(pAttribute));\n");
    str_cat(&gCpp[i],"  PM_TESTOUILLE(rv, rv);\n");
#ifdef TRACE
    str_join(&gCpp[i],"  printf(\"[Analyze(",gCppClassname[i],") 1]\\n\");\n",NULL);
#endif
    // Si y a l'attribut '_load' alors chargement du fichier
    // Sinon chargement des attributs
    str_cat(&gCpp[i], "  if (pLength==1 && pAttribute) {\n");
    str_cat(&gCpp[i], "    pAttribute->GetNodeValue(pValue);\n");
#ifdef TRACE
    str_cat(&gCpp[i], "    nsAutoString pPath;\n");
    str_join(&gCpp[i],"    printf(\"[Analyze(",gCppClassname[i],") 1.1]\\n\");\n",NULL);
    str_cat(&gCpp[i], "    aCurrentFile->GetPath(pPath);\n");
    str_cat(&gCpp[i], "    printf(\"::%%s\\n\",ToNewCString(pPath));\n");
#endif
    str_cat(&gCpp[i], "    nsCOMPtr<nsILocalFile> pFile;\n");
    str_cat(&gCpp[i], "    rv = GetFullPath(pValue,getter_AddRefs(pFile));\n");
    str_cat(&gCpp[i], "    PM_TESTOUILLE(rv, rv);\n");

    str_cat(&gCpp[i], "    rv = Load(pFile);\n");
    str_cat(&gCpp[i], "    return rv; \n");
    str_cat(&gCpp[i], "  }");
    if (gElementAttributeNb[i]==0)
      str_cat(&gCpp[i],"\n");
    else {
      str_cat(&gCpp[i]," else {\n");
#ifdef TRACE
      str_join(&gCpp[i],"  printf(\"[Analyze(",gCppClassname[i],") 2]\\n\");\n",NULL);
#endif
      //Chargement des attributs par appels successifs
      
      int localType;
      trace("    Attribute",NULL);
      for (a=0;a<gElementAttributeNb[i];a++) {

	if (gAttributeEnumerationNb[i][a]>0)
	  str_join(&gCpp[i],"    m",gAttributeName[i][a]," = ",
		   gEnumerationName[i][a][0],";\n",NULL);
	  
	str_join(&gCpp[i],"    rv = pAttributes->GetNamedItem(NS_LITERAL_STRING(\"",
		 gAttributeMarkup[i][a],"\"), getter_AddRefs(pAttribute));\n",NULL);
	str_cat(&gCpp[i], "    PM_TESTOUILLE(rv, rv);\n");
	if (gAttributeNeed[i][a]==N_REQUIRED) {
	  str_cat(&gCpp[i], "    if (!pAttribute) {\n");
	  str_cat(&gCpp[i], "      nsCOMPtr<nsIPromptService> pPrompt = do_CreateInstance(NS_PROMPTSERVICE_CONTRACTID, &rv);\n");
	  str_cat(&gCpp[i], "      PM_TESTOUILLE(rv, rv);\n");
	  str_join(&gCpp[i],"      pPrompt->Alert(nsnull, ToNewUnicode(NS_LITERAL_STRING(\"Valeur d'attribut manquante\")), ",
		   "ToNewUnicode(NS_LITERAL_STRING(\"La balise '",gElementMarkup[i],
		   "' attend une valeur pour l'attribut '",gAttributeMarkup[i][a],"'.\")));\n",NULL);	  
	  str_cat(&gCpp[i], "      return NS_ERROR_FAILURE;\n");
	  str_cat(&gCpp[i], "    } else {\n");
	} else {
	  str_cat(&gCpp[i], "    if (pAttribute) {\n");
	}
	str_cat(&gCpp[i], "      rv = pAttribute->GetNodeValue(pValue);\n");
	str_cat(&gCpp[i], "      PM_TESTOUILLE(rv, rv);\n");
	str_cat(&gCpp[i], "      rv = pVariant->SetAsDOMString(pValue);\n");
	str_cat(&gCpp[i], "      PM_TESTOUILLE(rv, rv);\n");
	str_join(&gCpp[i],"      ",VARCPP_TYPE[gAttributeType[i][a]]," p",
		 gAttributeName[i][a], "Value;\n",NULL);

	if (gAttributeEnumerationNb[i][a]>0) {
	  localType = T_STRING;
	  str_join(&gCpp[i],"      p",gAttributeName[i][a],"Value=",
		   gEnumerationName[i][a][0],";\n",NULL);	    
	  str_join(&gCpp[i],"      ",VARCPP_TYPE[localType]," p",
		   gAttributeName[i][a],"NewValue;\n",NULL);
	  str_join(&gCpp[i],"      rv = pVariant->GetAs",VARIANT_TYPE[localType],
		   "(", CPPIN_PREFIX[localType],"p",gAttributeName[i][a],
		   "NewValue);\n",NULL);
	  str_cat(&gCpp[i], "      PM_TESTOUILLE(rv, rv);\n");
	  str_join(&gCpp[i],"      PRBool p",gAttributeName[i][a],"Found=PR_FALSE;\n",NULL);
	  for (c=0;c<gAttributeEnumerationNb[i][a];c++) {
	    str_join(&gCpp[i],"      if (p",gAttributeName[i][a],"NewValue==",
		     "NS_LITERAL_STRING(\"",gEnumerationMarkup[i][a][c],
		     "\") && !p",gAttributeName[i][a],"Found) {\n",NULL);
	    str_join(&gCpp[i],"        p",gAttributeName[i][a],"Value=",
		     gEnumerationName[i][a][c],";\n",NULL);
		     //		     CPP_PREFIX[gAttributeType[i][a]],gEnumerationValue[i][a][c],
		     //		     CPP_SUFFIX[gAttributeType[i][a]],";\n",NULL);
	    str_join(&gCpp[i],"        p",gAttributeName[i][a],"Found=PR_TRUE;\n",NULL);
	    str_cat(&gCpp[i], "      }\n");
	  }
	  
	  if (gAttributeNeed[i][a]>=N_REQUIRED)
	    str_join(&gCpp[i],"      if (!p",gAttributeName[i][a],"Found) {\n",NULL);
	  else
	    str_join(&gCpp[i],"      if (!p",gAttributeName[i][a],"Found && pValue.Length()>0) {\n",NULL);	    
	  str_cat(&gCpp[i], "        nsCOMPtr<nsIPromptService> pPrompt = do_CreateInstance(NS_PROMPTSERVICE_CONTRACTID, &rv);\n");
	  str_cat(&gCpp[i], "        PM_TESTOUILLE(rv, rv);\n");
	  str_join(&gCpp[i],"        pPrompt->Alert(nsnull, ToNewUnicode(NS_LITERAL_STRING(\"Valeur invalide\")), ",
		   "ToNewUnicode(NS_LITERAL_STRING(\"La balise '",gElementMarkup[i],
		   "' a l'attribut '",gAttributeMarkup[i][a],"' renseigné avec une valeur incorrecte '\")+pValue+NS_LITERAL_STRING(\"'\")));\n",NULL);
	  str_cat(&gCpp[i], "        return NS_ERROR_FAILURE;\n");      
	  str_cat(&gCpp[i], "      }\n");
	  
	  
	  str_join(&gCpp[i],"      m",gAttributeName[i][a]," = p",
		   gAttributeName[i][a],"Value;\n",NULL);
	  

	} else {
	  localType = gAttributeType[i][a];
	  str_join(&gCpp[i],"      rv = pVariant->GetAs",VARIANT_TYPE[localType],
		   "(", VARCPPIN_PREFIX[localType],"p",gAttributeName[i][a],
		   "Value);\n",NULL);
	  str_cat(&gCpp[i],"      PM_TESTOUILLE(rv, rv);\n");
	}

	switch(gAttributeType[i][a]) {
	case T_PATH : 
	  str_join(&gCpp[i],"      rv = GetFullPath(p",gAttributeName[i][a],
		   "Value, getter_AddRefs(m",gAttributeName[i][a],"));\n",
		   NULL);
	  str_cat(&gCpp[i], "      PM_TESTOUILLE(rv, rv);\n");
	  break;
	case T_BOOLEAN :
	  str_join(&gCpp[i],"      m",gAttributeName[i][a]," = PR_FALSE;\n",NULL);
	  str_join(&gCpp[i],"      if (p",gAttributeName[i][a],"Value==NS_LITERAL_STRING(\"true\"))\n",NULL);
	  str_join(&gCpp[i],"        m",gAttributeName[i][a]," = PR_TRUE;\n",NULL);
	  break;
	default : 
	  if (gAttributeEnumerationNb[i][a]>0) {
	  } else {
	  str_join(&gCpp[i],"      m",gAttributeName[i][a]," = p",gAttributeName[i][a],
		   "Value;\n",NULL);
	  }
	}
	str_cat(&gCpp[i],"    }\n\n");
      }
      str_cat(&gCpp[i],"  }\n");
    } // Fin du chargement des attributs

#ifdef TRACE
    str_join(&gCpp[i],"  printf(\"[Analyze(",gCppClassname[i],") 3]\\n\");\n",NULL);
#endif

    /*
     * Chargement des éléments fils 
     *
     */


    // S'il n'y a pas de 'load' alors parcours de la première génération avec chargement à la volée
    str_cat(&gCpp[i],"  nsAutoString pNodeName;\n");
    str_cat(&gCpp[i],"  nsCOMPtr<nsIDOMNode> pTextNode;\n");
    str_cat(&gCpp[i],"  nsCOMPtr<nsIDOMNodeList> pChildNodes;\n");
    str_cat(&gCpp[i],"  rv = aNode->GetChildNodes(getter_AddRefs(pChildNodes));\n");
    str_cat(&gCpp[i],"  PM_TESTOUILLE(rv, rv);\n");
    str_cat(&gCpp[i],"  pChildNodes->GetLength(&pLength);\n");
    if (gElementChildrenNb[i]==0) {
      trace("    No Children",NULL);
      // Recupération de valeur en cas de non-fils
      /*  ENFANTS NON VOULUS
      str_cat(&gCpp[i], "  if (pLength>1){\n");
      str_cat(&gCpp[i], "    nsCOMPtr<nsIPromptService> pPrompt = do_CreateInstance(NS_PROMPTSERVICE_CONTRACTID, &rv);\n");
      str_cat(&gCpp[i], "    PM_TESTOUILLE(rv, rv);\n");
      str_join(&gCpp[i],"    pPrompt->Alert(nsnull, ToNewUnicode(NS_LITERAL_STRING(\"Balises en trop\")), ",
	       "ToNewUnicode(NS_LITERAL_STRING(\"La balise '",gElementMarkup[i],
	       "' possède des balises filles alors qu'elle ne le devrait pas.\")));\n",NULL);
      str_cat(&gCpp[i], "  }\n");
      */
      str_cat(&gCpp[i], "  PRUint16 pTextNodeType;\n");
      str_cat(&gCpp[i], "  rv = aNode->GetFirstChild(getter_AddRefs(pTextNode));\n");
      str_cat(&gCpp[i], "  PM_TESTOUILLE(rv, rv);\n");
      str_cat(&gCpp[i], "  if (pTextNode) {\n");
      str_cat(&gCpp[i], "    rv = pTextNode->GetNodeType(&pTextNodeType);\n");
      str_cat(&gCpp[i], "    PM_TESTOUILLE(rv, rv);\n");
#ifdef TRACE
      str_cat(&gCpp[i], "    nsAutoString pTutu,pTiti;\n");
      str_cat(&gCpp[i], "    rv = pTextNode->GetNodeName(pTutu);\n");
      str_cat(&gCpp[i], "    rv = pTextNode->GetNodeValue(pTiti);\n");
      str_cat(&gCpp[i], "    PM_TESTOUILLE(rv, rv);\n");
      str_cat(&gCpp[i], "    printf(\"%%s %%d %%s\",ToNewCString(pTutu),pTextNodeType, ToNewCString(pTiti));\n");
#endif
      str_cat(&gCpp[i], "    pTextNode->GetNodeValue(pValue);\n");
      str_cat(&gCpp[i], "    PM_TESTOUILLE(rv, rv);\n");
      str_cat(&gCpp[i], "    rv = pVariant->SetAsDOMString(pValue);\n");
      str_cat(&gCpp[i], "    PM_TESTOUILLE(rv, rv);\n");
      str_join(&gCpp[i],"    ",VARCPP_TYPE[gElementType[i]]," p",gElementName[i],
	       "Value;\n",NULL);
      str_join(&gCpp[i],"    rv = pVariant->GetAs",VARIANT_TYPE[gElementType[i]],"(",
	       CPPIN_PREFIX[gElementType[i]],"p",gElementName[i],"Value);\n",NULL);
      str_cat(&gCpp[i], "    PM_TESTOUILLE(rv, rv);\n");
      switch(gElementType[i]) {
      case T_PATH : 
	str_join(&gCpp[i],"    rv = GetFullPath(pValue, getter_AddRefs(m", gElementName[i],
		 "));\n", NULL);
	str_cat(&gCpp[i], "    PM_TESTOUILLE(rv, rv);\n");
	break;
      case T_BOOLEAN :
	str_join(&gCpp[i],"    m",gElementName[i]," = PR_FALSE;\n",NULL);
	str_join(&gCpp[i],"    if (p",gElementName[i],"Value==NS_LITERAL_STRING(\"true\"))\n",NULL);
	str_join(&gCpp[i],"      m",gElementName[i]," = PR_TRUE;\n",NULL);
	break;
      default : 
	str_join(&gCpp[i],"    m",gElementName[i]," = p",gElementName[i],
		 "Value;\n",NULL);
      }
      str_cat(&gCpp[i], "  }\n");


    } else {


      trace("    Children",NULL);
      /*
       * Recherche des fils attendus
       *
       */

      // Si il y a des fils
      str_cat(&gCpp[i],"  PRBool pFound=PR_FALSE;\n");
      str_cat(&gCpp[i],"  PRUint32 pIndex;\n");
      str_cat(&gCpp[i],"  PRUint16 pNodeType;\n");
      str_cat(&gCpp[i],"  nsCOMPtr<nsIDOMNode> pNode;\n");
      str_cat(&gCpp[i],"  \n");
      for (e=0;e<gElementChildrenNb[i];e++)
	str_join(&gCpp[i],"  PRUint32 p",getChildrenName(i,e),"Count=0;\n",NULL);

      str_cat(&gCpp[i],"  for (pIndex=0; pIndex<pLength; pIndex++) {\n");
      str_cat(&gCpp[i],"    rv = pChildNodes->Item(pIndex, getter_AddRefs(pNode));\n");
      str_cat(&gCpp[i],"    PM_TESTOUILLE(rv, rv);\n");
      str_cat(&gCpp[i],"    pNode->GetNodeType(&pNodeType);\n");
      str_cat(&gCpp[i],"    if (pNodeType==nsIDOMNode::ELEMENT_NODE) {\n");
      str_cat(&gCpp[i],"      pFound=PR_FALSE;\n");
      str_cat(&gCpp[i],"      pNode->GetNodeName(pNodeName);\n");

      // chargement de la balise <_load>
      str_cat(&gCpp[i], "      /* _LOAD MARKUP */\n");
      str_join(&gCpp[i],"      if (pNodeName==NS_LITERAL_STRING(\"",gLoad,"\")) {\n",NULL);
      str_cat(&gCpp[i], "        PRUint32 pIndex2, pLength2;\n");
      str_cat(&gCpp[i], "        rv = pNode->GetAttributes(getter_AddRefs(pAttributes));\n");
      str_cat(&gCpp[i], "        PM_TESTOUILLE(rv, rv);\n");
      str_cat(&gCpp[i], "        pAttributes->GetLength(&pLength2);\n");
      str_join(&gCpp[i],"        rv = pAttributes->GetNamedItem(NS_LITERAL_STRING(\"", gFile, 
	       "\"), getter_AddRefs(pAttribute));\n",NULL);
      str_cat(&gCpp[i], "        PM_TESTOUILLE(rv, rv);\n");
      str_cat(&gCpp[i], "        if (pLength2==1 && pAttribute) {\n");
      str_cat(&gCpp[i], "          nsCOMPtr<nsIDOMDocument> pDocument;\n");
      str_cat(&gCpp[i], "          nsCOMPtr<nsIDOMNodeList> pLoadChilds;\n");
      str_cat(&gCpp[i], "          PRBool   pExists;\n");
      str_cat(&gCpp[i], "          PRUint32 pAvailable;\n");
      str_cat(&gCpp[i], "          char *   pText;\n");
      str_cat(&gCpp[i], "          nsString pFileContent;\n\n");
      
      str_cat(&gCpp[i], "          pAttribute->GetNodeValue(pValue);\n");
      str_cat(&gCpp[i], "          nsCOMPtr<nsILocalFile> pFile;\n");
      str_cat(&gCpp[i], "          rv = GetFullPath(pValue,getter_AddRefs(pFile));\n");
      str_cat(&gCpp[i], "          PM_TESTOUILLE(rv, rv);\n");
      str_cat(&gCpp[i], "          rv = pFile->Exists(&pExists);\n");
      str_cat(&gCpp[i], "          PM_TESTOUILLE(rv, rv);\n");
      str_cat(&gCpp[i], "          if(!pExists)\n");
      str_cat(&gCpp[i], "            return NS_ERROR_FILE_NOT_FOUND;\n");
      str_cat(&gCpp[i], "          nsCOMPtr<nsIFileInputStream> pFileInputStream = do_CreateInstance(NS_LOCALFILEINPUTSTREAM_CONTRACTID, &rv);\n");
      str_cat(&gCpp[i], "          PM_TESTOUILLE(rv, rv);\n");
      str_cat(&gCpp[i], "          rv = pFileInputStream->Init(pFile, PR_RDONLY, PR_IROTH, nsnull);\n");
      str_cat(&gCpp[i], "          PM_TESTOUILLE(rv, rv);\n");
      str_cat(&gCpp[i], "          nsCOMPtr<nsIScriptableInputStream> pProjectScriptableInputStream = do_CreateInstance(NS_SCRIPTABLEINPUTSTREAM_CONTRACTID, &rv);\n");
      str_cat(&gCpp[i], "          PM_TESTOUILLE(rv, rv);\n");
      str_cat(&gCpp[i], "          rv = pProjectScriptableInputStream->Init(pFileInputStream);\n");
      str_cat(&gCpp[i], "          PM_TESTOUILLE(rv, rv);\n");
      str_cat(&gCpp[i], "          rv = pProjectScriptableInputStream->Available(&pAvailable);\n");
      str_cat(&gCpp[i], "          PM_TESTOUILLE(rv, rv);\n");
      str_cat(&gCpp[i], "          rv = pProjectScriptableInputStream->Read(pAvailable, &pText);\n");
      str_cat(&gCpp[i], "          PM_TESTOUILLE(rv, rv);\n");
      str_cat(&gCpp[i], "          pFileContent.AssignWithConversion(pText);\n");
      str_cat(&gCpp[i], "          nsCOMPtr<nsIDOMParser> pDOMParser = do_CreateInstance(NS_DOMPARSER_CONTRACTID, &rv);\n");
      str_cat(&gCpp[i], "          PM_TESTOUILLE(rv, rv);\n");
      str_cat(&gCpp[i], "          rv = pDOMParser->ParseFromString(pFileContent.get(), \"application/xml\",  getter_AddRefs(pDocument));\n");
      str_cat(&gCpp[i], "          PM_TESTOUILLE(rv, rv);\n");
      str_cat(&gCpp[i], "          nsCOMPtr<nsIDOMElement> pRootElement;\n");
      str_cat(&gCpp[i], "          nsAutoString pTagName, pNamespaceURI, pContent;\n");
      str_cat(&gCpp[i], "          rv = pDocument->GetDocumentElement(getter_AddRefs(pRootElement));\n");
      str_cat(&gCpp[i], "          PM_TESTOUILLE(rv, rv);\n");
      str_cat(&gCpp[i], "          rv = pRootElement->GetTagName(pTagName);\n");
      str_cat(&gCpp[i], "          PM_TESTOUILLE(rv, rv);\n");
      str_cat(&gCpp[i], "          rv = pRootElement->GetNamespaceURI(pNamespaceURI);\n");
      str_cat(&gCpp[i], "          PM_TESTOUILLE(rv, rv);\n");
      str_cat(&gCpp[i], "          if(pTagName==NS_LITERAL_STRING(\"parserError\") || pNamespaceURI == NS_LITERAL_STRING(\"http://www.mozilla.org/newlayout/xml/parsererror.xml\"))\n");
      str_cat(&gCpp[i], "            {\n");
      str_cat(&gCpp[i], "              nsCOMPtr<nsIDOMSerializer> pSerializer = do_CreateInstance(NS_XMLSERIALIZER_CONTRACTID, &rv);\n");
      str_cat(&gCpp[i], "              PM_TESTOUILLE(rv, rv);\n");
      str_cat(&gCpp[i], "              pSerializer->SerializeToString(pRootElement, pContent);\n");
      str_cat(&gCpp[i], "              nsCOMPtr<nsIPromptService> pPrompt = do_CreateInstance(NS_PROMPTSERVICE_CONTRACTID, &rv);\n");
      str_cat(&gCpp[i], "              PM_TESTOUILLE(rv, rv);\n");
      str_cat(&gCpp[i], "              pPrompt->Alert(nsnull, ToNewUnicode(NS_LITERAL_STRING(\"Erreur de syntaxe XML\")), ToNewUnicode(pContent));\n");
      str_cat(&gCpp[i], "              return NS_ERROR_FAILURE;\n");
      str_cat(&gCpp[i], "             }\n");
      str_cat(&gCpp[i], "          rv = pRootElement->GetChildNodes(getter_AddRefs(pLoadChilds));\n");
      str_cat(&gCpp[i], "          PM_TESTOUILLE(rv, rv);\n");
      str_cat(&gCpp[i], "          pLoadChilds->GetLength(&pLength2);\n");
      str_cat(&gCpp[i], "          for (pIndex2=0; pIndex2<pLength2; pIndex2++) {\n");
      str_cat(&gCpp[i], "            rv = pLoadChilds->Item(pIndex2, getter_AddRefs(pNode));\n");
      str_cat(&gCpp[i], "            PM_TESTOUILLE(rv, rv);\n");
      str_cat(&gCpp[i], "            pNode->GetNodeType(&pNodeType);\n");
      str_cat(&gCpp[i], "            if (pNodeType==nsIDOMNode::ELEMENT_NODE) {\n");
      str_cat(&gCpp[i], "            pFound=PR_FALSE;\n");
      str_cat(&gCpp[i], "            pNode->GetNodeName(pNodeName);\n");



      pLoadCode = strdup("");

      // Instanciation des éléments fils s'il en faut
      for (e=0;e<gElementChildrenNb[i];e++) {
	//	id = gElementChildren[i][e];
	for(c=0;c<getChildrenElementCount(i,e);c++) {
	  // Condition d'instanciation
	  str_join(&pLoadCode,"      if (!pFound && pNodeName==NS_LITERAL_STRING(\"",
		   gElementMarkup[getChildrenElementByIndex(i,e,c)],"\")) {\n",NULL);
	
	  // Verification que le max est respecté
	  str_join(&pLoadCode,"        p",getChildrenName(i,e),"Count++;\n",NULL);
	  if (gElementChildrenMaxOccurs[i][e]>0) {
	    str_join(&pLoadCode,"        if (p",getChildrenName(i,e),"Count>",ltoa(gElementChildrenMaxOccurs[i][e]),") {\n",NULL);	  
	    str_cat(&pLoadCode, "          nsCOMPtr<nsIPromptService> pPrompt = do_CreateInstance(NS_PROMPTSERVICE_CONTRACTID, &rv);\n");
	    str_cat(&pLoadCode, "          PM_TESTOUILLE(rv, rv);\n");
	    str_join(&pLoadCode,"          pPrompt->Alert(nsnull, ToNewUnicode(NS_LITERAL_STRING(\"Elément en trop\")), ToNewUnicode(NS_LITERAL_STRING(\"L'élément '",
		     gElementMarkup[i],"' attend au plus ",ltoa(gElementChildrenMaxOccurs[i][e])," élément",
		     (gElementChildrenMaxOccurs[i][e]>1)?"s":""," fils '",
		     getChildrenMarkup(i,e),"'.\")));\n",NULL);
	    str_cat(&pLoadCode, "          return NS_ERROR_FAILURE;\n");
	    str_cat(&pLoadCode, "        }\n");
	  }


	  if (gElementChildrenIsChoice[i][e])
	    class = gParentName;
	  else
	    class = gElementName[gElementChildren[i][e]];
	      
	  trace("      Child '",getChildrenName(i,e),"' ",ctos(i,e),NULL);
	  str_join(&pLoadCode,"        nsCOMPtr<",gIdlClassname[getChildrenElementByIndex(i,e,c)],
		   "> p",getChildrenName(i,e),"Object = do_CreateInstance(",
		   str_toupper(gPrefix),"_", str_toupper(gShortName),
		   str_toupper(gElementName[getChildrenElementByIndex(i,e,c)]),
		   "_CONTRACTID, &rv);\n",NULL);
	  str_cat(&pLoadCode, "        PM_TESTOUILLE(rv, rv);\n");
	  str_join(&pLoadCode,"        rv = p",getChildrenName(i,e),"Object->Analyze(aCurrentFile, pNode);\n",NULL);
	  str_cat(&pLoadCode, "        PM_TESTOUILLE(rv, rv);\n");	  
	  if (gElementChildrenMaxOccurs[i][e]==1) {
	    // One child
	    // getTheXXX
	    str_join(&pLoadCode,"        mThe",getChildrenName(i,e)," = p",getChildrenName(i,e),
		     "Object;\n",NULL);
	    if (gElementChildrenIsChoice[i][e])
	       str_join(&pLoadCode,"        mThe",getChildrenName(i,e),"_LID = ",
			getChoiceConstant(i,e,c),";\n",NULL);
	  } else {
	    // Infinite child
	    // getXXXNumber & getXXXByIndex
	    
	    str_join(&pLoadCode,"        rv = m",getChildrenName(i,e),"Array.AppendObject(p",getChildrenName(i,e),"Object);\n",NULL);
	    str_cat(&pLoadCode, "        PM_TESTOUILLE(rv, rv);\n");	  
	    if (gElementChildrenIsChoice[i][e]) {
	      str_join(&pLoadCode,"        PRUint32 pLocalCount = m",getChildrenName(i,e),
		       "Array.Count();\n",NULL);
	      str_join(&pLoadCode,"        if (pLocalCount<=1) m", getChildrenName(i,e),
		       "Array_LID = nsnull;\n",NULL);
	      str_join(&pLoadCode,"        m",getChildrenName(i,e),"Array_LID = (PRUint32*)",
		       "PR_Realloc((PRUint32*)m", getChildrenName(i,e),"Array_LID, pLocalCount*sizeof(PRUint32));\n",NULL);
	      str_join(&pLoadCode,"        m",getChildrenName(i,e),"Array_LID[pLocalCount-1] = ",
		       getChoiceConstant(i,e,c),//ElementChildrenConstant[i][e][c],
		       ";\n",NULL);
	    }
	    //	    str_cat(&pLoadCode, "        PM_TESTOUILLE(rv, rv);\n");	  
	  }
	  str_cat(&pLoadCode,"        pFound=PR_TRUE;\n");
	  str_cat(&pLoadCode,"      }\n");
	}
      }
      str_cat(&pLoadCode, "      if(!pFound) {\n");
      str_cat(&pLoadCode, "        nsCOMPtr<nsIPromptService> pPrompt = do_CreateInstance(NS_PROMPTSERVICE_CONTRACTID, &rv);\n");
      str_cat(&pLoadCode, "        PM_TESTOUILLE(rv, rv);\n");
      str_join(&pLoadCode,"        pPrompt->Alert(nsnull, ToNewUnicode(NS_LITERAL_STRING(\"Balise inconnue\")), ",
	       "ToNewUnicode(NS_LITERAL_STRING(\"La balise '\")+pNodeName",
	       "+NS_LITERAL_STRING(\"' est inattendue.\")));\n",NULL);
      str_cat(&pLoadCode, "        return NS_ERROR_FAILURE;\n");
      str_cat(&pLoadCode, "      }\n");

      str_cat(&gCpp[i], pLoadCode);
      str_cat(&gCpp[i], "            }\n");
      str_cat(&gCpp[i], "          }\n");
      str_cat(&gCpp[i], "        }\n");
      str_cat(&gCpp[i], "        pFound = PR_TRUE;\n");
      str_cat(&gCpp[i], "      }\n\n");
      str_cat(&gCpp[i], "      /* _LOAD MARKUP */\n\n");
      str_cat(&gCpp[i], pLoadCode);
      
      str_cat(&gCpp[i], "    }\n");
      str_cat(&gCpp[i], "  }\n");
#ifdef TRACE
      str_join(&gCpp[i],"  printf(\" )\\n\");\n",NULL);
#endif
      // Vérification de la présence du nombre minimum d'éléments
      for (e=0;e<gElementChildrenNb[i];e++) {
	id = gElementChildren[i][e];
        if (gElementChildrenMinOccurs[i][e]>0) {
	  str_join(&gCpp[i],"  if (p",getChildrenName(i,e),"Count<",ltoa(gElementChildrenMinOccurs[i][e]),") {\n",NULL);	  
	  str_cat(&gCpp[i], "    nsCOMPtr<nsIPromptService> pPrompt = do_CreateInstance(NS_PROMPTSERVICE_CONTRACTID, &rv);\n");
	  str_cat(&gCpp[i], "    PM_TESTOUILLE(rv, rv);\n");
	  str_join(&gCpp[i],"    pPrompt->Alert(nsnull, ToNewUnicode(NS_LITERAL_STRING(\"Elément(s) nécessaire(s)\")), ToNewUnicode(NS_LITERAL_STRING(\"L'élément '",
		   gElementMarkup[i],"' attend au moins ",ltoa(gElementChildrenMinOccurs[i][e])," élément",
		   (gElementChildrenMinOccurs[i][e]>1)?"s":""," fils '",getChildrenMarkup(i,e),"'.\")));\n",NULL);
	  str_cat(&gCpp[i], "    return NS_ERROR_FAILURE;\n");
	  str_cat(&gCpp[i], "  }\n");
	}
      }



    }
    str_cat(&gCpp[i],"  return NS_OK;\n}\n\n");


    /*
     * Gestion des Lectures(/écritures) sur les membres
     *
     */


    // Attributs (gestion des données)
    for (a=0;a<gElementAttributeNb[i];a++) {
      str_cat(&gIdl[i],"  attribute ");
      str_cat(&gIdl[i], IDL_TYPE[gAttributeType[i][a]]);
      str_cat(&gIdl[i]," ");
      str_cat(&gIdl[i], gAttributeIdlName[i][a]);
      str_cat(&gIdl[i],";\n");
      //get
      str_cat(&gCpp[i], "/*------------======================-------------*/\n");
      str_join(&gCpp[i],"NS_IMETHODIMP ",gCppClassname[i],"::Get",gAttributeName[i][a],
	       "(",CPPOUT_TYPE[gAttributeType[i][a]]," a",gAttributeName[i][a],")\n{\n",NULL);
      str_join(&gCpp[i],"  ",CPPOUT_PREFIX[gAttributeType[i][a]],"a",gAttributeName[i][a]," = m",
	       gAttributeName[i][a],";\n",NULL);
      if (GET_ADDREF[gAttributeType[i][a]]) 
	str_join(&gCpp[i],"  NS_IF_ADDREF(",CPPOUT_PREFIX[gAttributeType[i][a]],"a",
		 gAttributeName[i][a],");\n",NULL);
	
      str_join(&gCpp[i],"  return NS_OK;\n","}\n",NULL);
      //set
      str_join(&gCpp[i],"NS_IMETHODIMP ",gCppClassname[i],"::Set",gAttributeName[i][a],
	       "(",CPPIN_TYPE[gAttributeType[i][a]], " a",gAttributeName[i][a], ")\n{\n",NULL);
      str_join(&gCpp[i],"  ","m",gAttributeName[i][a]," = a",gAttributeName[i][a],";\n",NULL);
      str_cat(&gCpp[i],"  return NS_OK;\n");
      str_cat(&gCpp[i],"}\n");
      
      str_join(&gHpp[i],"  ",CPPDECL_TYPE[gAttributeType[i][a]]," m",gAttributeName[i][a],";\n",NULL);
      
      str_cat(&gCpp[i],"\n");
    }

    // Elements
    if (a>0)
      str_cat(&gCpp[i],"\n\n\n/*------------======================-------------*/\n\n\n");
          
    if (gElementChildrenNb[i]>0) {
      if (a>0)
	str_cat(&gIdl[i],"\n");
      for (e=0;e<gElementChildrenNb[i];e++) {
	id = gElementChildren[i][e];
	// Remplace gIdlClassname[id] 
	if (gElementChildrenIsChoice[i][e])
	  class = gParentIdlClassname;
	else
	  class = gIdlClassname[id];

	if (gElementChildrenMaxOccurs[i][e]==1) {
	  //str_cat(&gIdl[i], );
	  //	  str_join(&gIdl[i], "  ",gIdlClassname[id]," getThe",getChildrenName(i,e),"();\n",NULL);
	  str_join(&gIdl[i], "  ",class," getThe",getChildrenName(i,e),"();\n",NULL);

	  //	  str_join(&gHpp[i],"  nsCOMPtr<",gIdlClassname[id],"> mThe", getChildrenName(i,e),";\n",NULL);
	  str_join(&gHpp[i],"  nsCOMPtr<",class,"> mThe", getChildrenName(i,e),";\n",NULL);
	  if (gElementChildrenIsChoice[i][e])
	    str_join(&gHpp[i],"  PRUint32 mThe", getChildrenName(i,e),"_LID;\n",NULL);
	    
	  
	  str_join(&gCpp[i],"NS_IMETHODIMP ", gCppClassname[i], "::GetThe", 
		   getChildrenName(i,e), "(",  class, " ** aReturn)\n{\n",NULL);
	  //		   getChildrenName(i,e), "(",  gIdlClassname[id], " ** aReturn)\n{\n",NULL);

	  str_join(&gCpp[i],"  if (mThe", getChildrenName(i,e),") {\n",NULL);
	  str_join(&gCpp[i],"    *aReturn = mThe", getChildrenName(i,e),";\n",NULL);
	  str_cat(&gCpp[i], "    NS_ADDREF(*aReturn);\n");
	  str_cat(&gCpp[i], "  } else {\n    *aReturn = nsnull;\n  }\n");
	  str_cat(&gCpp[i], "  return NS_OK;\n}\n\n");
	} else {
	  // GetXxxxxNumber()
	  str_join(&gIdl[i],"  ",IDL_TYPE[T_UINT32]," get",getChildrenName(i,e),"Number();\n",NULL);
	  str_join(&gIdl[i],"  ",class," get",getChildrenName(i,e),"ByIndex(in ",IDL_TYPE[T_UINT32]," index);\n",NULL);
	  //	  str_join(&gIdl[i],"  ",gIdlClassname[id]," get",getChildrenName(i,e),"ByIndex(in ",IDL_TYPE[T_UINT32]," index);\n",NULL);

	  //	  str_join(&gHpp[i],"  nsCOMArray<",gIdlClassname[id],"> m",getChildrenName(i,e),"Array;\n",NULL);
	  str_join(&gHpp[i],"  nsCOMArray<",class,"> m",getChildrenName(i,e),"Array;\n",NULL);
	  if (gElementChildrenIsChoice[i][e])
	    str_join(&gHpp[i],"  PRUint32 * m",getChildrenName(i,e),"Array_LID;\n",NULL);
	  
	  str_join(&gCpp[i],"NS_IMETHODIMP ",gCppClassname[i],"::Get",
		   getChildrenName(i,e),"Number(",CPPOUT_TYPE[T_UINT32],
		   " aReturn)\n{\n  ",NULL);
	  str_join(&gCpp[i],CPPOUT_PREFIX[T_UINT32],"aReturn = m",
		   getChildrenName(i,e),"Array.Count();\n",NULL);
	  str_cat(&gCpp[i],"  return NS_OK;\n}\n\n");
	  // GetXxxxxByIndex()
	  str_join(&gCpp[i],"NS_IMETHODIMP ",gCppClassname[i],"::Get",
		   getChildrenName(i,e),"ByIndex(",CPPIN_TYPE[T_UINT32],
		   " aIndex, ",class," ** aReturn)\n{\n",NULL);
	  //		   " aIndex, ",gIdlClassname[id]," ** aReturn)\n{\n",NULL);
	  str_join(&gCpp[i],"  PRInt64 pIndex = aIndex;\n",NULL);
	  str_join(&gCpp[i],"  NS_ENSURE_TRUE(pIndex<m",getChildrenName(i,e),
		   "Array.Count(), NS_ERROR_FAILURE);\n",NULL);
	  str_join(&gCpp[i],"  *aReturn = m",getChildrenName(i,e),"Array[aIndex];\n",NULL);
	  str_cat(&gCpp[i], "  NS_ADDREF(*aReturn);\n");
	  str_cat(&gCpp[i], "  return NS_OK;\n}\n\n");
	}
      }
    } else { // Si pas d'enfants alors getTheXXXXValue()
      type = gElementType[i];
      str_join(&gIdl[i],"  attribute ",IDL_TYPE[type]," _",gElementName[i],";\n",NULL);
      //get
      str_join(&gCpp[i],"NS_IMETHODIMP ",gCppClassname[i],"::Get",
	       gElementName[i],"(",CPPOUT_TYPE[type]," a",
	       gElementName[i],")\n{\n",NULL);
      str_join(&gCpp[i],"  ",CPPOUT_PREFIX[type],"a",
	       gElementName[i]," = m",
	       gElementName[i],"",NULL);
      str_cat(&gCpp[i],";\n  return NS_OK;\n");
      str_cat(&gCpp[i],"}\n");
      //set
      str_join(&gCpp[i],"NS_IMETHODIMP ",gCppClassname[i],"::Set",
	       gElementName[i],"(",CPPIN_TYPE[type]," a",
	       gElementName[i],")\n{\n",NULL);
      str_join(&gCpp[i],"  m",gElementName[i]," = a",gElementName[i],";\n",NULL);
      str_cat(&gCpp[i],"  return NS_OK;\n");
      str_cat(&gCpp[i],"}\n");
      
      str_join(&gHpp[i],"  ",CPPDECL_TYPE[type]," m",gElementName[i],";\n",NULL);
    }


    // Fins
    str_cat(&gIdl[i],"};\n\n");
    uuid = strdup(getUUID());
    sprintf(tmp,"%s_%s%s",gPrefix,gShortName,gElementName[i]);

    str_join(&gIdl[i],"%{C++\n// {",uuid,"}\n",NULL);
    str_join(&gIdl[i],"#define ",str_toupper(tmp),"_CID ",toCppUUID(uuid),"\n",NULL);
    str_join(&gIdl[i],"#define ",str_toupper(tmp),"_CONTRACTID \"@",gFamily,"/",str_tolower(gShortName),"/",str_tolower(gElementName[i]),";1\"\n",NULL);
    str_join(&gIdl[i],"#define ",str_toupper(tmp),"_CLASSNAME \"",gElementName[i]," markup\"\n%}\n\n",NULL);

    str_cat(&gHpp[i],"};\n\n#endif\n\n");


  }
  /* Build Component Files */
  
  return NS_OK;
}














nsresult write(char * path) 
{
  int i,w;
  char filename[256], *file=strdup("");
  FILE * fileout;

  char *requires = strdup("");
  str_cat(&requires,"REQUIRES =  xpcom string dom nspr view webshell appcomps embed_base necko windowwatcher content unicharutil $(NULL)\n");
  // /
  sprintf(filename,"%s",path);
  if (!gBuildOnlyMethods) {
    mkdir(filename,0755);
  }

  // /Makefile.in
  str_cat(&file,"");
  str_cat(&file,"DEPTH=../..\n");
  str_cat(&file,"topsrcdir=@top_srcdir@\n");
  str_cat(&file,"srcdir=@srcdir@\n");
  str_cat(&file,"VPATH=@srcdir@\n");
  str_cat(&file,"include $(DEPTH)/config/autoconf.mk\n");
  str_cat(&file,"MODULE	= ");
  str_cat(&file, str_tolower(gShortName));
  str_cat(&file,"\nVERSION = ");
  str_cat(&file, gVersion);
  str_cat(&file,"\nDIRS    = base build\n");
  str_cat(&file,"include $(topsrcdir)/config/rules.mk\n");
  
  sprintf(filename,"%s/%s",path, D_MAKEFILE_IN);
  if (!gBuildOnlyMethods) {
    fileout=(FILE *)fopen(filename,"w");
    if (fileout == NULL) {
      fprintf(stderr,"Cannot write '%s'.\n",filename);
      return NS_ERROR_FAILURE;
    }
    fprintf(fileout,file);
    fclose(fileout);
  }

  // /base
  sprintf(filename,"%s/%s",path, D_BASE);
  if (!gBuildOnlyMethods) {
    mkdir(filename,0755);
  }

  // /base/Makefile.in
  free(file);
  file=(char *)malloc(sizeof(char));
  file[0] = '\0';
  str_cat(&file,"DEPTH=../../..\n");
  str_cat(&file,"topsrcdir=@top_srcdir@\n");
  str_cat(&file,"srcdir=@srcdir@\n");
  str_cat(&file,"VPATH=@srcdir@\n");
  str_cat(&file,"include $(DEPTH)/config/autoconf.mk\n");
  str_cat(&file,"DIRS=public src\n");
  str_cat(&file,"include $(topsrcdir)/config/rules.mk\n");

  sprintf(filename,"%s/%s/%s",path, D_BASE, D_MAKEFILE_IN);
  if (!gBuildOnlyMethods) {
    fileout=(FILE *)fopen(filename,"w");
    if (fileout == NULL) {
      printf("Cannot write '%s'",filename);
      return NS_ERROR_FAILURE;
    }
    fprintf(fileout,file);
    fclose(fileout);
  }  

  // /base/public
  sprintf(filename,"%s/%s/%s",path, D_BASE, D_PUBLIC);
  if (!gBuildOnlyMethods) {
    mkdir(filename,0755);
  }

  // /base/public/xxIYYYElement.idl
  free(file);
  file=(char *)malloc(sizeof(char));
  file[0] = '\0';
  str_cat( &file, startComment(-1));
  str_cat( &file, "#include \"nsISupports.idl\"\n\n");
  str_cat( &file, "interface nsIDOMNode;\n");
  str_cat( &file, "interface nsILocalFile;\n\n");
  str_join(&file, "[scriptable, uuid(",getUUID(),")]\ninterface ",
	   gParentIdlClassname," : nsISupports\n{\n", NULL);
  //  str_join(&file,"  void ", str_tolower(F_LOAD),"(in nsILocalFile file);\n",NULL);
  //  str_join(&file,"  void ", str_tolower(F_ANALYZE), "(in nsILocalFile currentFile,"," in nsIDOMNode node);\n",NULL);

  str_cat(&file, "};\n\n");
  char tmp[128],*uuid;
  uuid = strdup(getUUID());
  sprintf(tmp,"%s_%s%s",gPrefix,gShortName,gParentName);
  str_join(&file,"%{C++\n// {",uuid,"}\n",NULL);
  str_join(&file,"#define ",str_toupper(tmp),"_CID ",toCppUUID(uuid),"\n",NULL);
  str_join(&file,"#define ",str_toupper(tmp),"_CONTRACTID \"@",gFamily,"/",str_tolower(gShortName),"/",str_tolower(gParentName),";1\"\n",NULL);
  str_join(&file,"#define ",str_toupper(tmp),"_CLASSNAME \"",gParentName," parent class\"\n%}\n\n",NULL);


  sprintf(filename,"%s/%s/%s/%s.idl",path, D_BASE, D_PUBLIC, gParentIdlClassname);
  if (!gBuildOnlyMethods) {
    fileout=(FILE *)fopen(filename,"w");
    if (fileout == NULL) {
      printf("Cannot write '%s'",filename);
      return NS_ERROR_FAILURE;
    }
    fprintf(fileout,file);
    fclose(fileout);
  }  

  // /base/public/Makefile.in
  free(file);
  file=(char *)malloc(sizeof(char));
  file[0] = '\0';
  str_cat(&file,"DEPTH=../../../..\n");
  str_cat(&file,"topsrcdir=@top_srcdir@\n");
  str_cat(&file,"srcdir=@srcdir@\n");
  str_cat(&file,"VPATH=@srcdir@\n");
  str_cat(&file,"include $(DEPTH)/config/autoconf.mk\n");
  str_cat(&file,"MODULE = ");
  str_cat(&file, str_tolower(gShortName));
  str_cat(&file,"\nXPIDL_MODULE = ");
  str_cat(&file, str_tolower(gShortName));
  str_cat(&file,"\nifdef MOZ_XUL_APP\n");
  str_cat(&file,"XPI_NAME = ");
  str_cat(&file, str_tolower(gShortName));
  str_cat(&file,"\nendif\n");
  str_join(&file,"XPIDLSRCS = ",gParentIdlClassname,".idl ",NULL);
  for(i=0; i<gElementNb;i++) {
    str_cat(&file,gIdlClassname[i]);
    str_cat(&file,".idl ");   
  }
  str_cat(&file,"$(NULL)\n");

  str_cat(&file,"include $(topsrcdir)/config/rules.mk\n");

  sprintf(filename,"%s/%s/%s/%s",path, D_BASE, D_PUBLIC, D_MAKEFILE_IN);
  if (!gBuildOnlyMethods) {

    fileout=(FILE *)fopen(filename,"w");
    if (fileout == NULL) {
      printf("Cannot write '%s'",filename);
      return NS_ERROR_FAILURE;
    }
    fprintf(fileout,file);
    fclose(fileout);
  }

  // /base/src
  sprintf(filename,"%s/%s/%s",path, D_BASE, D_SRC);
  if (!gBuildOnlyMethods) {
    mkdir(filename,0755);
  }

  // /base/src/Makefile.in
  free(file);
  file=(char *)malloc(sizeof(char));
  file[0] = '\0';
  str_cat(&file,"DEPTH=../../../..\n");
  str_cat(&file,"topsrcdir=@top_srcdir@\n");
  str_cat(&file,"srcdir=@srcdir@\n");
  str_cat(&file,"VPATH=@srcdir@\n");
  str_cat(&file,"include $(DEPTH)/config/autoconf.mk\n");
  str_join(&file,"MODULE=",str_tolower(gShortName),"\n",NULL);
  str_join(&file,"LIBRARY_NAME=",str_tolower(gShortName),"_s\n",NULL);
  str_cat(&file,"MOZILLA_INTERNAL_API = 1\n");
  str_cat(&file,"ifdef MOZ_XUL_APP\n");
  str_cat(&file,"XPI_NAME = ");
  str_cat(&file, str_tolower(gShortName));
  str_cat(&file,"\nendif\n");
  str_cat(&file,requires);
  str_join(&file,"CPPSRCS = ",NULL);//,gParentCppClassname,".cpp ",NULL);
  for(i=0; i<gElementNb;i++) {
    str_cat(&file,gCppClassname[i]);
    str_cat(&file,".cpp ");   
  }
  str_cat(&file,"	$(NULL)\n");
  str_cat(&file,"FORCE_STATIC_LIB = 1\n");
  str_cat(&file,"FORCE_USE_PIC = 1\n");
  str_cat(&file,"include $(topsrcdir)/config/rules.mk\n");

  sprintf(filename,"%s/%s/%s/%s",path, D_BASE, D_SRC, D_MAKEFILE_IN);
  if (!gBuildOnlyMethods) {
    fileout=(FILE *)fopen(filename,"w");
    if (fileout == NULL) {
      printf("Cannot write '%s'",filename);
      return NS_ERROR_FAILURE;
    }
    fprintf(fileout,file);
    fclose(fileout);
  }

  // /build
  sprintf(filename,"%s/%s",path, D_BUILD);
  if (!gBuildOnlyMethods) {
    mkdir(filename,0755);
  }

  // /build/Makefile.in
  free(file);
  file=(char *)malloc(sizeof(char));
  file[0] = '\0';
  str_cat(&file,"DEPTH=../../..\n");
  str_cat(&file,"topsrcdir=@top_srcdir@\n");
  str_cat(&file,"srcdir=@srcdir@\n");
  str_cat(&file,"VPATH=@srcdir@\n");
  str_cat(&file,"include $(DEPTH)/config/autoconf.mk\n");
  str_cat(&file,"DIRS=src\n");
  str_cat(&file,"include $(topsrcdir)/config/rules.mk\n");

  sprintf(filename,"%s/%s/%s",path, D_BUILD, D_MAKEFILE_IN);
  if (!gBuildOnlyMethods) {
    fileout=(FILE *)fopen(filename,"w");
    if (fileout == NULL) {
      printf("Cannot write '%s'",filename);
      return NS_ERROR_FAILURE;
    }
    fprintf(fileout,file);
    fclose(fileout);
  }

  // /build/src
  sprintf(filename,"%s/%s/%s",path, D_BUILD,D_SRC);
  mkdir(filename,0755);


  // /build/src/Makefile.in
  free(file);
  file=(char *)malloc(sizeof(char));
  file[0] = '\0';
  str_cat(&file,"DEPTH=../../../..\n");
  str_cat(&file,"topsrcdir=@top_srcdir@\n");
  str_cat(&file,"srcdir=@srcdir@\n");
  str_cat(&file,"VPATH=@srcdir@\n");
  str_cat(&file,"include $(DEPTH)/config/autoconf.mk\n");
  str_join(&file,"MODULE          = ",str_tolower(gShortName),"\n",NULL);
  str_join(&file,"LIBRARY_NAME    = ",str_tolower(gShortName),"\n",NULL);
  str_cat(&file, "EXPORT_LIBRARY  = 1\n");
  str_cat(&file, "IS_COMPONENT    = 1\n");
  str_join(&file,"MODULE_NAME     = ",str_tolower(gPrefix),gShortName,"Module\n",NULL);
  str_cat(&file, "MOZILLA_INTERNAL_API = 1\n");

  //  str_cat(&file,"FORCE_SHARED_LIB = 1\n");
  str_cat(&file,requires);
  str_join(&file,"EXPORTS 	= ", str_tolower(gPrefix), gShortName,"CID.h\n",NULL);
  str_join(&file,"CPPSRCS 	= ", str_tolower(gPrefix), gShortName,"Module.cpp $(NULL)\n",NULL);
  str_cat(&file,"LOCAL_INCLUDES = -I$(srcdir)/../../base/src\n\n");
  str_cat(&file,"SHARED_LIBRARY_LIBS = \\\n");
  str_cat(&file,"		$(DIST)/lib/$(LIB_PREFIX)");
  str_cat(&file, str_tolower(gShortName));
  str_cat(&file, "_s.$(LIB_SUFFIX) \\\n");
  str_cat(&file,"		$(NULL)\n\n");
  str_cat(&file,"EXTRA_DSO_LDOPTS +=\\\n");
  str_cat(&file,"	$(LIBS_DIR) \\\n");
  str_cat(&file,"	$(EXTRA_DSO_LIBS) \\\n");
  str_cat(&file,"	$(MOZ_UNICHARUTIL_LIBS) \\\n");
  str_cat(&file,"	$(MOZ_COMPONENT_LIBS) \\\n");
  str_cat(&file,"	$(NULL)\n");
  str_cat(&file,"include $(topsrcdir)/config/rules.mk\n");

  sprintf(filename,"%s/%s/%s/%s",path, D_BUILD, D_SRC, D_MAKEFILE_IN);
  if (!gBuildOnlyMethods) {
    fileout=(FILE *)fopen(filename,"w");
    if (fileout == NULL) {
      printf("Cannot write '%s'",filename);
      return NS_ERROR_FAILURE;
    }
    fprintf(fileout,file);
    fclose(fileout);
  }


  // /build/src/zzXXXModule.cpp
  free(file);
  file=(char *)malloc(sizeof(char));
  file[0] = '\0';
  char * factory=strdup(""), *include=strdup(""), *component=strdup(""), root[64], *cid=strdup("");
  str_cat(&cid,  CPP_HEADER);
  str_join(&cid, "#ifndef __",str_tolower(gPrefix),gShortName,"CID_h__\n",NULL);
  str_join(&cid, "#define __",str_tolower(gPrefix),gShortName,"CID_h__\n",NULL);
  /*
    str_join(&cid, "#include \"",gParentIdlClassname,".h\"\n",NULL);
    str_join(&include, "#include \"",gParentCppClassname,".h\"\n",NULL);
    str_cat(&factory, "NS_GENERIC_FACTORY_CONSTRUCTOR(");
    str_cat(&factory, gParentCppClassname);
    str_cat(&factory, ")\n");
  
    sprintf(root,"%s_%s%s_",str_toupper(gPrefix), 
    str_toupper(gShortName),str_toupper(gParentName));
    str_cat(&component,"  { ");
    str_cat(&component,root);
    str_cat(&component,"CLASSNAME,\n    ");
    str_cat(&component,root);
    str_cat(&component,"CID,\n    ");
    str_cat(&component,root);
    str_cat(&component,"CONTRACTID,\n    ");
    str_cat(&component,gParentCppClassname);
    str_cat(&component,"Constructor }");
 
  */

  for(i=0; i<gElementNb;i++) {
    str_cat(&cid, "#include \"");
    str_cat(&cid, gIdlClassname[i]);
    str_cat(&cid, ".h\"\n");
    str_cat(&include, "#include \"");
    str_cat(&include, gCppClassname[i]);
    str_cat(&include, ".h\"\n");
    str_cat(&factory, "NS_GENERIC_FACTORY_CONSTRUCTOR(");
    str_cat(&factory, gCppClassname[i]);
    str_cat(&factory, ")\n");

    if (i>0)
      str_cat(&component,",\n");
    sprintf(root,"%s_%s%s_",str_toupper(gPrefix), 
	    str_toupper(gShortName),str_toupper(gElementName[i]));
    str_cat(&component,"  { ");
    str_cat(&component,root);
    str_cat(&component,"CLASSNAME,\n    ");
    str_cat(&component,root);
    str_cat(&component,"CID,\n    ");
    str_cat(&component,root);
    str_cat(&component,"CONTRACTID,\n    ");
    str_cat(&component,gCppClassname[i]);
    str_cat(&component,"Constructor }");
  }
  str_cat(&cid, "#endif\n\n");

  str_cat(&file, CPP_HEADER);
  str_cat(&file, "#include \"nsIGenericFactory.h\"\n");
  str_cat(&file, include);
  str_cat(&file, factory);
  str_cat(&file, "\nstatic const nsModuleComponentInfo components[] =\n{\n");
  str_cat(&file, component);
  str_cat(&file, "\n};\n\nNS_IMPL_NSGETMODULE(\"");
  str_cat(&file, str_tolower(gPrefix));
  str_cat(&file, gShortName);
  str_cat(&file, "Module\", components)\n\n");
  sprintf(filename,"%s/%s/%s/%s%sModule.cpp",path, D_BUILD, D_SRC, str_tolower(gPrefix),gShortName);
  if (!gBuildOnlyMethods) {
    fileout=(FILE *)fopen(filename,"w");
    if (fileout == NULL) {
      printf("Cannot write '%s'.\n",filename);
      return NS_ERROR_FAILURE;
    }
    fprintf(fileout,file);
    fclose(fileout);
  }

  sprintf(filename,"%s/%s/%s/%s%sCID.h",path, D_BUILD, D_SRC, str_tolower(gPrefix),gShortName);
  if (!gBuildOnlyMethods) {
    fileout=(FILE *)fopen(filename,"w");
    if (fileout == NULL) {
      printf("Cannot write '%s'.\n",filename);
      return NS_ERROR_FAILURE;
    }
    fprintf(fileout,cid);
    fclose(fileout);
    free(cid);
  }
 
  // Sources
  w=0;
  for(i=0; i<gElementNb;i++) {
    if (!gBuildOnlyMethods || (gBuildOnlyMethods && gElementToWrite[i])) {
      sprintf(filename,"%s/%s/%s/%s.idl",path, D_BASE, D_PUBLIC, gIdlClassname[i]);
      fileout=(FILE *)fopen(filename,"w");
      if (fileout == NULL) {
	printf("Cannot write '%s.idl'",gIdlClassname[i]);
      }
      fprintf(fileout,gIdl[i]);
      fclose(fileout);
      
      sprintf(filename,"%s/%s/%s/%s.cpp",path, D_BASE, D_SRC, gCppClassname[i]);
      fileout=(FILE *)fopen(filename,"w");
      if (fileout == NULL) {
	printf("Cannot write '%s.cpp'",gCppClassname[i]);
      }
      fprintf(fileout,gCpp[i]);
      fclose(fileout);
      
      sprintf(filename,"%s/%s/%s/%s.h",path, D_BASE, D_SRC, gCppClassname[i]);
      fileout=(FILE *)fopen(filename,"w");
      if (fileout == NULL) {
	printf("Cannot write '%s.h'",gCppClassname[i]);
      }
      fprintf(fileout,gHpp[i]);
      fclose(fileout);
      w++;
    }
  }
  
  fprintf(stdout, "INFO: %d written classes.\n",w);
  return NS_OK;
}

















/**
 * Simple example to parse a file called "file.xml", 
 * walk down the DOM, and print the name of the 
 * xml elements nodes.
 */
int main(int argc, char **argv)
{
  nsresult rv;
  xmlDocPtr schema=NULL, extend=NULL;
  
  if (argc < 3 && argc>5) {
    printf("Usage: format schema.xml répertoire\n");
    printf("       format schema.xml methods.xml répertoire\n");
    printf("       format schema.xml methods.xml -m répertoire\n");
    return 1;
  }

  /* Initialize libxml2 */
  LIBXML_TEST_VERSION
  


  /* Schema file */
  schema = xmlReadFile(argv[1], NULL, 0);
  if (schema == NULL) {
    printf("ERROR: could not parse file %s\n", argv[1]);
    return 2;
  }

  /* Load */
  rv = schemaLoad(schema);
  if (NS_FAILED(rv)) {
    printf("ERROR: could not load file %s\n", argv[1]);
    return 2;
  }

  /* Free XML documents */
  xmlFreeDoc(schema);

  /* Extension file */
  if (argc>=4) {
    extend = xmlReadFile(argv[2], NULL, XML_PARSE_NOCDATA);
    if (extend == NULL) {
      printf("ERROR: could not parse file %s\n", argv[2]);
      return 2;
    }
    rv = extendLoad(extend);
    if (NS_FAILED(rv)) {
      printf("ERROR: could not load file %s\n", argv[2]);
      return 2;
    }
    xmlFreeDoc(extend);
  }

  if (argc==5)
    gBuildOnlyMethods = 1;
  else
    gBuildOnlyMethods = 0;


  /* Build */
  fprintf(stdout,"INFO: Building...\n");
  rv = build();
  if (NS_FAILED(rv)) {
    printf("ERROR: could not build extension files.\n");
    return 2;
  }

  /* Write */
  fprintf(stdout,"INFO: Writing...\n");
  rv = write(argv[argc-1]);
  if (NS_FAILED(rv)) {
    printf("ERROR: could not write files in '%s'.\n", argv[argc-1]);
    return 2;
  }

  /* Free */
  xmlCleanupParser();
  return 0;
}

