// Reminder: Modify typemap.dat to customize the header file generated by wsdl2h
/* pygmalion.h
   Generated by wsdl2h 1.2.6e from pygmalion.wsdl and typemap.dat
   2006-08-22 07:43:14 GMT
   Copyright (C) 2001-2005 Robert van Engelen, Genivia Inc. All Rights Reserved.
   This part of the software is released under one of the following licenses:
   GPL or Genivia's license for commercial use.
*/

/* NOTE:

 - Compile this file with soapcpp2 to complete the code generation process.
 - Use soapcpp2 option -I to specify paths for #import
   To build with STL, 'stlvector.h' is imported from 'import' dir in package.
 - Use wsdl2h options -c and -s to generate pure C code or C++ code without STL.
 - Use 'typemap.dat' to control schema namespace bindings and type mappings.
   It is strongly recommended to customize the names of the namespace prefixes
   generated by wsdl2h. To do so, modify the prefix bindings in the Namespaces
   section below and add the modified lines to 'typemap.dat' to rerun wsdl2h.
 - Use Doxygen (www.doxygen.org) to browse this file.
 - Use wsdl2h option -l to view the software license terms.

*/

/******************************************************************************\
 *                                                                            *
 * urn:Pygmalion                                                              *
 *                                                                            *
\******************************************************************************/

//gsoapopt cw

/******************************************************************************\
 *                                                                            *
 * Import                                                                     *
 *                                                                            *
\******************************************************************************/


/******************************************************************************\
 *                                                                            *
 * Schema Namespaces                                                          *
 *                                                                            *
\******************************************************************************/


/* NOTE:

It is strongly recommended to customize the names of the namespace prefixes
generated by wsdl2h. To do so, modify the prefix bindings below and add the
modified lines to typemap.dat to rerun wsdl2h:

pmns1 = "urn:Pygmalion"

*/

//gsoap pmns1 schema namespace:	urn:Pygmalion
//gsoap pmns1 schema form:	unqualified

/******************************************************************************\
 *                                                                            *
 * Schema Types                                                               *
 *                                                                            *
\******************************************************************************/



/// "urn:Pygmalion":Identifiant is a simpleType restriction of xs:int.
typedef int pmns1__Identifiant;

/// "urn:Pygmalion":Ligne is a complexType.
struct pmns1__Ligne
{
/// Size of array of char** is 1..unbounded
    int                                  __sizevaleurs                 ;
/// Array of length 1..unbounded
    char**                               valeurs                        1;
};

/// "urn:Pygmalion":Resultat is a complexType.
struct pmns1__Resultat
{
/// Size of array of struct pmns1__Ligne* is 1..unbounded
    int                                  __sizelignes                  ;
/// Array of length 1..unbounded
    struct pmns1__Ligne*                 lignes                         1;
};

/******************************************************************************\
 *                                                                            *
 * Services                                                                   *
 *                                                                            *
\******************************************************************************/


//gsoap pmns1 service name:	PMBinding 
//gsoap pmns1 service type:	PMPortType 
//gsoap pmns1 service port:	https://localhost 
//gsoap pmns1 service namespace:	urn:Pygmalion 
//gsoap pmns1 service transport:	http://schemas.xmlsoap.org/soap/http 

/** @mainpage Pygmalion Definitions

@section Pygmalion_bindings Bindings
  - @ref PMBinding

*/

/**

@page PMBinding Binding "PMBinding"

@section PMBinding_operations Operations of Binding  "PMBinding"
  - @ref pmns1__pmConnexion
  - @ref pmns1__pmDeconnexion
  - @ref pmns1__pmSelect
  - @ref pmns1__pmUpdate
  - @ref pmns1__pmCalcul

@section PMBinding_ports Endpoints of Binding  "PMBinding"
  - https://localhost

*/

/******************************************************************************\
 *                                                                            *
 * PMBinding                                                                  *
 *                                                                            *
\******************************************************************************/


/******************************************************************************\
 *                                                                            *
 * pmns1__pmConnexion                                                         *
 *                                                                            *
\******************************************************************************/

/// Operation response struct "pmns1__pmConnexionResponse" of service binding "PMBinding" operation "pmns1__pmConnexion"
struct pmns1__pmConnexionResponse
{
    pmns1__Identifiant                  id;
};

/// Operation "pmns1__pmConnexion" of service binding "PMBinding"

/**

Operation details:

  - SOAP RPC encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"
  - SOAP action="urn:PygmalionAction"

C stub function (defined in soapClient.c[pp] after running soapcpp2):
@code
  int soap_call_pmns1__pmConnexion(struct soap *soap,
    NULL, // char *endpoint = NULL selects default endpoint for this operation
    NULL, // char *action = NULL selects default action for this operation
    // request parameters:
    char*                               login,
    char*                               password,
    char*                               database,
    // response parameters:
    struct pmns1__pmConnexionResponse*
  );
@endcode

*/

//gsoap pmns1 service method-style:	pmConnexion rpc
//gsoap pmns1 service method-encoding:	pmConnexion http://schemas.xmlsoap.org/soap/encoding/
//gsoap pmns1 service method-action:	pmConnexion urn:PygmalionAction
int pmns1__pmConnexion(
    char*                               login,	///< Request parameter
    char*                               password,	///< Request parameter
    char*                               database,	///< Request parameter
    struct pmns1__pmConnexionResponse  *	///< Response struct parameter
);

/******************************************************************************\
 *                                                                            *
 * pmns1__pmDeconnexion                                                       *
 *                                                                            *
\******************************************************************************/


/// Operation "pmns1__pmDeconnexion" of service binding "PMBinding"

/**

Operation details:

  - SOAP RPC encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"
  - SOAP action="urn:PygmalionAction"

C stub function (defined in soapClient.c[pp] after running soapcpp2):
@code
  int soap_call_pmns1__pmDeconnexion(struct soap *soap,
    NULL, // char *endpoint = NULL selects default endpoint for this operation
    NULL, // char *action = NULL selects default action for this operation
    // request parameters:
    pmns1__Identifiant                  id,
    // response parameters:
    int                                *resultat
  );
@endcode

*/

//gsoap pmns1 service method-style:	pmDeconnexion rpc
//gsoap pmns1 service method-encoding:	pmDeconnexion http://schemas.xmlsoap.org/soap/encoding/
//gsoap pmns1 service method-action:	pmDeconnexion urn:PygmalionAction
int pmns1__pmDeconnexion(
    pmns1__Identifiant                  id,	///< Request parameter
    int                                *resultat	///< Response parameter
);

/******************************************************************************\
 *                                                                            *
 * pmns1__pmSelect                                                            *
 *                                                                            *
\******************************************************************************/

/// Operation response struct "pmns1__pmSelectResponse" of service binding "PMBinding" operation "pmns1__pmSelect"
struct pmns1__pmSelectResponse
{
    struct pmns1__Resultat*             resultat;
};

/// Operation "pmns1__pmSelect" of service binding "PMBinding"

/**

Operation details:

  - SOAP RPC encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"
  - SOAP action="urn:PygmalionAction"

C stub function (defined in soapClient.c[pp] after running soapcpp2):
@code
  int soap_call_pmns1__pmSelect(struct soap *soap,
    NULL, // char *endpoint = NULL selects default endpoint for this operation
    NULL, // char *action = NULL selects default action for this operation
    // request parameters:
    pmns1__Identifiant                  id,
    char*                               query,
    // response parameters:
    struct pmns1__pmSelectResponse*
  );
@endcode

*/

//gsoap pmns1 service method-style:	pmSelect rpc
//gsoap pmns1 service method-encoding:	pmSelect http://schemas.xmlsoap.org/soap/encoding/
//gsoap pmns1 service method-action:	pmSelect urn:PygmalionAction
int pmns1__pmSelect(
    pmns1__Identifiant                  id,	///< Request parameter
    char*                               query,	///< Request parameter
    struct pmns1__pmSelectResponse     *	///< Response struct parameter
);

/******************************************************************************\
 *                                                                            *
 * pmns1__pmUpdate                                                            *
 *                                                                            *
\******************************************************************************/


/// Operation "pmns1__pmUpdate" of service binding "PMBinding"

/**

Operation details:

  - SOAP RPC encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"
  - SOAP action="urn:PygmalionAction"

C stub function (defined in soapClient.c[pp] after running soapcpp2):
@code
  int soap_call_pmns1__pmUpdate(struct soap *soap,
    NULL, // char *endpoint = NULL selects default endpoint for this operation
    NULL, // char *action = NULL selects default action for this operation
    // request parameters:
    pmns1__Identifiant                  id,
    char*                               query,
    // response parameters:
    int                                *resultat
  );
@endcode

*/

//gsoap pmns1 service method-style:	pmUpdate rpc
//gsoap pmns1 service method-encoding:	pmUpdate http://schemas.xmlsoap.org/soap/encoding/
//gsoap pmns1 service method-action:	pmUpdate urn:PygmalionAction
int pmns1__pmUpdate(
    pmns1__Identifiant                  id,	///< Request parameter
    char*                               query,	///< Request parameter
    int                                *resultat	///< Response parameter
);

/******************************************************************************\
 *                                                                            *
 * pmns1__pmCalcul                                                            *
 *                                                                            *
\******************************************************************************/


/// Operation "pmns1__pmCalcul" of service binding "PMBinding"

/**

Operation details:

  - SOAP RPC encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"
  - SOAP action="urn:PygmalionAction"

C stub function (defined in soapClient.c[pp] after running soapcpp2):
@code
  int soap_call_pmns1__pmCalcul(struct soap *soap,
    NULL, // char *endpoint = NULL selects default endpoint for this operation
    NULL, // char *action = NULL selects default action for this operation
    // request parameters:
    double                              taux,
    int                                 nb,
    // response parameters:
    double                             *return_
  );
@endcode

*/

//gsoap pmns1 service method-style:	pmCalcul rpc
//gsoap pmns1 service method-encoding:	pmCalcul http://schemas.xmlsoap.org/soap/encoding/
//gsoap pmns1 service method-action:	pmCalcul urn:PygmalionAction
int pmns1__pmCalcul(
    double                              taux,	///< Request parameter
    int                                 nb,	///< Request parameter
    double                             *return_	///< Response parameter
);

/* End of pygmalion.h */
