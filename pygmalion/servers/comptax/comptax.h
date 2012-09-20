/* comptax.h
   Generated by wsdl2h 1.2.6e from comptax.wsdl and typemap.dat
   2007-02-01 08:00:53 GMT
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
 * urn:pygen1                                                                 *
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

moz1 = "urn:pygen1"

*/

//gsoap moz1  schema namespace:	urn:pygen1
//gsoap moz1  schema form:	unqualified

/******************************************************************************\
 *                                                                            *
 * Schema Types                                                               *
 *                                                                            *
\******************************************************************************/


/// Built-in type "xs:boolean".
enum xsd__boolean { xsd__boolean__false_, xsd__boolean__true_ };


/// "urn:pygen1":sqlLine is a complexType.
struct moz1__sqlLine
{
/// Size of array of char** is 0..unbounded
    int                                  __sizev                       ;
/// Array of length 0..unbounded
    char**                               v                              0;
};

/// "urn:pygen1":sqlTable is a complexType.
struct moz1__sqlTable
{
/// Size of array of struct moz1__sqlLine* is 0..unbounded
    int                                  __sizel                       ;
/// Array of length 0..unbounded
    struct moz1__sqlLine*                l                              0;
};

/// "urn:pygen1":sqlQueryList is a complexType.
struct moz1__sqlQueryList
{
/// Size of def array is 0..unbounded
    int                                  __sizedef                     ;
    struct _moz1__sqlQueryList_def
    {
/// Element query of type xs:string.
    char*                                query                          1;	///< Required element.
/// Element name of type xs:string.
    char*                                name                           1;	///< Required element.
/// Element arity of type xs:unsignedInt.
    unsigned int                         arity                          1;	///< Required element.
    }                                   *def                            0;
};

/******************************************************************************\
 *                                                                            *
 * Services                                                                   *
 *                                                                            *
\******************************************************************************/


//gsoap moz1 service name:	comptaxBinding 
//gsoap moz1 service type:	PMPortType 
//gsoap moz1 service port:	http://localhost 
//gsoap moz1 service namespace:	urn:pygen1 
//gsoap moz1 service transport:	http://schemas.xmlsoap.org/soap/http 

/** @mainpage comptax Definitions

@section comptax_bindings Bindings
  - @ref comptaxBinding

*/

/**

@page comptaxBinding Binding "comptaxBinding"

@section comptaxBinding_operations Operations of Binding  "comptaxBinding"
  - @ref moz1__pmConnect
  - @ref moz1__pmFinish
  - @ref moz1__Setup
  - @ref moz1__Prepare
  - @ref moz1__PrepareList
  - @ref moz1__ExecPreparedSelect
  - @ref moz1__ExecPreparedUpdate
  - @ref moz1__ExecSelect
  - @ref moz1__ExecUpdate
  - @ref moz1__pmInit

@section comptaxBinding_ports Endpoints of Binding  "comptaxBinding"
  - http://localhost

*/

/******************************************************************************\
 *                                                                            *
 * comptaxBinding                                                             *
 *                                                                            *
\******************************************************************************/


/******************************************************************************\
 *                                                                            *
 * moz1__pmConnect                                                            *
 *                                                                            *
\******************************************************************************/


/// Operation "moz1__pmConnect" of service binding "comptaxBinding"

/**

Operation details:

  - SOAP RPC encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"

C stub function (defined in soapClient.c[pp] after running soapcpp2):
@code
  int soap_call_moz1__pmConnect(struct soap *soap,
    NULL, // char *endpoint = NULL selects default endpoint for this operation
    NULL, // char *action = NULL selects default action for this operation
    // request parameters:
    char*                               login,
    char*                               password,
    char*                               database,
    // response parameters:
    char*                              *key
  );
@endcode

*/

//gsoap moz1 service method-style:	pmConnect rpc
//gsoap moz1 service method-encoding:	pmConnect http://schemas.xmlsoap.org/soap/encoding/
//gsoap moz1 service method-action:	pmConnect ""
int moz1__pmConnect(
    char*                               login,	///< Request parameter
    char*                               password,	///< Request parameter
    char*                               database,	///< Request parameter
    char*                              *key	///< Response parameter
);

/******************************************************************************\
 *                                                                            *
 * moz1__pmFinish                                                             *
 *                                                                            *
\******************************************************************************/


/// Operation "moz1__pmFinish" of service binding "comptaxBinding"

/**

Operation details:

  - SOAP RPC encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"

C stub function (defined in soapClient.c[pp] after running soapcpp2):
@code
  int soap_call_moz1__pmFinish(struct soap *soap,
    NULL, // char *endpoint = NULL selects default endpoint for this operation
    NULL, // char *action = NULL selects default action for this operation
    // request parameters:
    char*                               key,
    // response parameters:
    unsigned int                       *result
  );
@endcode

*/

//gsoap moz1 service method-style:	pmFinish rpc
//gsoap moz1 service method-encoding:	pmFinish http://schemas.xmlsoap.org/soap/encoding/
//gsoap moz1 service method-action:	pmFinish ""
int moz1__pmFinish(
    char*                               key,	///< Request parameter
    unsigned int                       *result	///< Response parameter
);

/******************************************************************************\
 *                                                                            *
 * moz1__Setup                                                                *
 *                                                                            *
\******************************************************************************/

/// Operation response struct "moz1__SetupResponse" of service binding "comptaxBinding" operation "moz1__Setup"
struct moz1__SetupResponse
{
    char*                               name;
    char*                               uuid;
    char*                               version;
    char*                               state;
    char*                               userType;
};

/// Operation "moz1__Setup" of service binding "comptaxBinding"

/**

Operation details:

  - SOAP RPC encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"

C stub function (defined in soapClient.c[pp] after running soapcpp2):
@code
  int soap_call_moz1__Setup(struct soap *soap,
    NULL, // char *endpoint = NULL selects default endpoint for this operation
    NULL, // char *action = NULL selects default action for this operation
    // request parameters:
    char*                               key,
    // response parameters:
    struct moz1__SetupResponse*
  );
@endcode

*/

//gsoap moz1 service method-style:	Setup rpc
//gsoap moz1 service method-encoding:	Setup http://schemas.xmlsoap.org/soap/encoding/
//gsoap moz1 service method-action:	Setup ""
int moz1__Setup(
    char*                               key,	///< Request parameter
    struct moz1__SetupResponse         *	///< Response struct parameter
);

/******************************************************************************\
 *                                                                            *
 * moz1__Prepare                                                              *
 *                                                                            *
\******************************************************************************/


/// Operation "moz1__Prepare" of service binding "comptaxBinding"

/**

Operation details:

  - SOAP RPC encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"

C stub function (defined in soapClient.c[pp] after running soapcpp2):
@code
  int soap_call_moz1__Prepare(struct soap *soap,
    NULL, // char *endpoint = NULL selects default endpoint for this operation
    NULL, // char *action = NULL selects default action for this operation
    // request parameters:
    char*                               key,
    char*                               query,
    char*                               name,
    unsigned int                        arity,
    // response parameters:
    unsigned int                       *result
  );
@endcode

*/

//gsoap moz1 service method-style:	Prepare rpc
//gsoap moz1 service method-encoding:	Prepare http://schemas.xmlsoap.org/soap/encoding/
//gsoap moz1 service method-action:	Prepare ""
int moz1__Prepare(
    char*                               key,	///< Request parameter
    char*                               query,	///< Request parameter
    char*                               name,	///< Request parameter
    unsigned int                        arity,	///< Request parameter
    unsigned int                       *result	///< Response parameter
);

/******************************************************************************\
 *                                                                            *
 * moz1__PrepareList                                                          *
 *                                                                            *
\******************************************************************************/


/// Operation "moz1__PrepareList" of service binding "comptaxBinding"

/**

Operation details:

  - SOAP RPC encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"

C stub function (defined in soapClient.c[pp] after running soapcpp2):
@code
  int soap_call_moz1__PrepareList(struct soap *soap,
    NULL, // char *endpoint = NULL selects default endpoint for this operation
    NULL, // char *action = NULL selects default action for this operation
    // request parameters:
    char*                               key,
    struct moz1__sqlQueryList*          queries,
    // response parameters:
    unsigned int                       *result
  );
@endcode

*/

//gsoap moz1 service method-style:	PrepareList rpc
//gsoap moz1 service method-encoding:	PrepareList http://schemas.xmlsoap.org/soap/encoding/
//gsoap moz1 service method-action:	PrepareList ""
int moz1__PrepareList(
    char*                               key,	///< Request parameter
    struct moz1__sqlQueryList*          queries,	///< Request parameter
    unsigned int                       *result	///< Response parameter
);

/******************************************************************************\
 *                                                                            *
 * moz1__ExecPreparedSelect                                                   *
 *                                                                            *
\******************************************************************************/

/// Operation response struct "moz1__ExecPreparedSelectResponse" of service binding "comptaxBinding" operation "moz1__ExecPreparedSelect"
struct moz1__ExecPreparedSelectResponse
{
    struct moz1__sqlTable*              result;
};

/// Operation "moz1__ExecPreparedSelect" of service binding "comptaxBinding"

/**

Operation details:

  - SOAP RPC encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"

C stub function (defined in soapClient.c[pp] after running soapcpp2):
@code
  int soap_call_moz1__ExecPreparedSelect(struct soap *soap,
    NULL, // char *endpoint = NULL selects default endpoint for this operation
    NULL, // char *action = NULL selects default action for this operation
    // request parameters:
    char*                               key,
    char*                               name,
    struct moz1__sqlLine*               params,
    // response parameters:
    struct moz1__ExecPreparedSelectResponse*
  );
@endcode

*/

//gsoap moz1 service method-style:	ExecPreparedSelect rpc
//gsoap moz1 service method-encoding:	ExecPreparedSelect http://schemas.xmlsoap.org/soap/encoding/
//gsoap moz1 service method-action:	ExecPreparedSelect ""
int moz1__ExecPreparedSelect(
    char*                               key,	///< Request parameter
    char*                               name,	///< Request parameter
    struct moz1__sqlLine*               params,	///< Request parameter
    struct moz1__ExecPreparedSelectResponse*	///< Response struct parameter
);

/******************************************************************************\
 *                                                                            *
 * moz1__ExecPreparedUpdate                                                   *
 *                                                                            *
\******************************************************************************/


/// Operation "moz1__ExecPreparedUpdate" of service binding "comptaxBinding"

/**

Operation details:

  - SOAP RPC encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"

C stub function (defined in soapClient.c[pp] after running soapcpp2):
@code
  int soap_call_moz1__ExecPreparedUpdate(struct soap *soap,
    NULL, // char *endpoint = NULL selects default endpoint for this operation
    NULL, // char *action = NULL selects default action for this operation
    // request parameters:
    char*                               key,
    char*                               name,
    struct moz1__sqlLine*               params,
    // response parameters:
    char*                              *result
  );
@endcode

*/

//gsoap moz1 service method-style:	ExecPreparedUpdate rpc
//gsoap moz1 service method-encoding:	ExecPreparedUpdate http://schemas.xmlsoap.org/soap/encoding/
//gsoap moz1 service method-action:	ExecPreparedUpdate ""
int moz1__ExecPreparedUpdate(
    char*                               key,	///< Request parameter
    char*                               name,	///< Request parameter
    struct moz1__sqlLine*               params,	///< Request parameter
    char*                              *result	///< Response parameter
);

/******************************************************************************\
 *                                                                            *
 * moz1__ExecSelect                                                           *
 *                                                                            *
\******************************************************************************/

/// Operation response struct "moz1__ExecSelectResponse" of service binding "comptaxBinding" operation "moz1__ExecSelect"
struct moz1__ExecSelectResponse
{
    struct moz1__sqlTable*              result;
};

/// Operation "moz1__ExecSelect" of service binding "comptaxBinding"

/**

Operation details:

  - SOAP RPC encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"

C stub function (defined in soapClient.c[pp] after running soapcpp2):
@code
  int soap_call_moz1__ExecSelect(struct soap *soap,
    NULL, // char *endpoint = NULL selects default endpoint for this operation
    NULL, // char *action = NULL selects default action for this operation
    // request parameters:
    char*                               key,
    char*                               query,
    struct moz1__sqlLine*               params,
    // response parameters:
    struct moz1__ExecSelectResponse*
  );
@endcode

*/

//gsoap moz1 service method-style:	ExecSelect rpc
//gsoap moz1 service method-encoding:	ExecSelect http://schemas.xmlsoap.org/soap/encoding/
//gsoap moz1 service method-action:	ExecSelect ""
int moz1__ExecSelect(
    char*                               key,	///< Request parameter
    char*                               query,	///< Request parameter
    struct moz1__sqlLine*               params,	///< Request parameter
    struct moz1__ExecSelectResponse    *	///< Response struct parameter
);

/******************************************************************************\
 *                                                                            *
 * moz1__ExecUpdate                                                           *
 *                                                                            *
\******************************************************************************/


/// Operation "moz1__ExecUpdate" of service binding "comptaxBinding"

/**

Operation details:

  - SOAP RPC encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"

C stub function (defined in soapClient.c[pp] after running soapcpp2):
@code
  int soap_call_moz1__ExecUpdate(struct soap *soap,
    NULL, // char *endpoint = NULL selects default endpoint for this operation
    NULL, // char *action = NULL selects default action for this operation
    // request parameters:
    char*                               key,
    char*                               query,
    struct moz1__sqlLine*               params,
    // response parameters:
    char*                              *result
  );
@endcode

*/

//gsoap moz1 service method-style:	ExecUpdate rpc
//gsoap moz1 service method-encoding:	ExecUpdate http://schemas.xmlsoap.org/soap/encoding/
//gsoap moz1 service method-action:	ExecUpdate ""
int moz1__ExecUpdate(
    char*                               key,	///< Request parameter
    char*                               query,	///< Request parameter
    struct moz1__sqlLine*               params,	///< Request parameter
    char*                              *result	///< Response parameter
);

/******************************************************************************\
 *                                                                            *
 * moz1__pmInit                                                               *
 *                                                                            *
\******************************************************************************/


/// Operation "moz1__pmInit" of service binding "comptaxBinding"

/**

Operation details:

  - SOAP RPC encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"

C stub function (defined in soapClient.c[pp] after running soapcpp2):
@code
  int soap_call_moz1__pmInit(struct soap *soap,
    NULL, // char *endpoint = NULL selects default endpoint for this operation
    NULL, // char *action = NULL selects default action for this operation
    // request parameters:
    char*                               key,
    char*                               database,
    enum xsd__boolean                   force,
    // response parameters:
    unsigned int                       *result
  );
@endcode

*/

//gsoap moz1 service method-style:	pmInit rpc
//gsoap moz1 service method-encoding:	pmInit http://schemas.xmlsoap.org/soap/encoding/
//gsoap moz1 service method-action:	pmInit ""
int moz1__pmInit(
    char*                               key,	///< Request parameter
    char*                               database,	///< Request parameter
    enum xsd__boolean                   force,	///< Request parameter
    unsigned int                       *result	///< Response parameter
);

/* End of comptax.h */
