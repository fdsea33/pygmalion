/* mozStub.h
   Generated by gSOAP 2.7.6e from comptax.h
   Copyright (C) 2000-2005, Robert van Engelen, Genivia Inc. All Rights Reserved.
   This part of the software is released under one of the following licenses:
   GPL, the gSOAP public license, or Genivia's license for commercial use.
*/

#ifndef mozStub_H
#define mozStub_H
#include "stdsoap2.h"
#ifdef __cplusplus
extern "C" {
#endif

/******************************************************************************\
 *                                                                            *
 * Enumerations                                                               *
 *                                                                            *
\******************************************************************************/


#ifndef SOAP_TYPE_xsd__boolean
#define SOAP_TYPE_xsd__boolean (6)
/* xsd:boolean */
enum xsd__boolean {xsd__boolean__false_ = 0, xsd__boolean__true_ = 1};
#endif

/******************************************************************************\
 *                                                                            *
 * Classes and Structs                                                        *
 *                                                                            *
\******************************************************************************/


#ifndef SOAP_TYPE_moz1__sqlLine
#define SOAP_TYPE_moz1__sqlLine (7)
/* moz1:sqlLine */
struct moz1__sqlLine
{
	int __sizev;	/* sequence of elements <v> */
	char **v;	/* optional element of type xsd:string */
};
#endif

#ifndef SOAP_TYPE_moz1__sqlTable
#define SOAP_TYPE_moz1__sqlTable (9)
/* moz1:sqlTable */
struct moz1__sqlTable
{
	int __sizel;	/* sequence of elements <l> */
	struct moz1__sqlLine *l;	/* optional element of type moz1:sqlLine */
};
#endif

#ifndef SOAP_TYPE__moz1__sqlQueryList_def
#define SOAP_TYPE__moz1__sqlQueryList_def (12)
/* moz1:sqlQueryList-def */
struct _moz1__sqlQueryList_def
{
	char *query;	/* required element of type xsd:string */
	char *name;	/* required element of type xsd:string */
	unsigned int arity;	/* required element of type xsd:unsignedInt */
};
#endif

#ifndef SOAP_TYPE_moz1__sqlQueryList
#define SOAP_TYPE_moz1__sqlQueryList (11)
/* moz1:sqlQueryList */
struct moz1__sqlQueryList
{
	int __sizedef;	/* sequence of elements <def> */
	struct _moz1__sqlQueryList_def *def;	/* optional element of type moz1:sqlQueryList-def */
};
#endif

#ifndef SOAP_TYPE_moz1__pmConnectResponse
#define SOAP_TYPE_moz1__pmConnectResponse (16)
/* moz1:pmConnectResponse */
struct moz1__pmConnectResponse
{
	char **key;	/* RPC return element */	/* optional element of type xsd:string */
};
#endif

#ifndef SOAP_TYPE_moz1__pmConnect
#define SOAP_TYPE_moz1__pmConnect (17)
/* moz1:pmConnect */
struct moz1__pmConnect
{
	char *login;	/* optional element of type xsd:string */
	char *password;	/* optional element of type xsd:string */
	char *database;	/* optional element of type xsd:string */
};
#endif

#ifndef SOAP_TYPE_moz1__pmFinishResponse
#define SOAP_TYPE_moz1__pmFinishResponse (20)
/* moz1:pmFinishResponse */
struct moz1__pmFinishResponse
{
	unsigned int *result;	/* RPC return element */	/* optional element of type xsd:unsignedInt */
};
#endif

#ifndef SOAP_TYPE_moz1__pmFinish
#define SOAP_TYPE_moz1__pmFinish (21)
/* moz1:pmFinish */
struct moz1__pmFinish
{
	char *key;	/* optional element of type xsd:string */
};
#endif

#ifndef SOAP_TYPE_moz1__SetupResponse
#define SOAP_TYPE_moz1__SetupResponse (22)
/* moz1:SetupResponse */
struct moz1__SetupResponse
{
	char *name;	/* RPC return element */	/* optional element of type xsd:string */
	char *uuid;	/* optional element of type xsd:string */
	char *version;	/* optional element of type xsd:string */
	char *state;	/* optional element of type xsd:string */
	char *userType;	/* optional element of type xsd:string */
};
#endif

#ifndef SOAP_TYPE_moz1__Setup
#define SOAP_TYPE_moz1__Setup (25)
/* moz1:Setup */
struct moz1__Setup
{
	char *key;	/* optional element of type xsd:string */
};
#endif

#ifndef SOAP_TYPE_moz1__PrepareResponse
#define SOAP_TYPE_moz1__PrepareResponse (27)
/* moz1:PrepareResponse */
struct moz1__PrepareResponse
{
	unsigned int *result;	/* RPC return element */	/* optional element of type xsd:unsignedInt */
};
#endif

#ifndef SOAP_TYPE_moz1__Prepare
#define SOAP_TYPE_moz1__Prepare (28)
/* moz1:Prepare */
struct moz1__Prepare
{
	char *key;	/* optional element of type xsd:string */
	char *query;	/* optional element of type xsd:string */
	char *name;	/* optional element of type xsd:string */
	unsigned int arity;	/* required element of type xsd:unsignedInt */
};
#endif

#ifndef SOAP_TYPE_moz1__PrepareListResponse
#define SOAP_TYPE_moz1__PrepareListResponse (31)
/* moz1:PrepareListResponse */
struct moz1__PrepareListResponse
{
	unsigned int *result;	/* RPC return element */	/* optional element of type xsd:unsignedInt */
};
#endif

#ifndef SOAP_TYPE_moz1__PrepareList
#define SOAP_TYPE_moz1__PrepareList (32)
/* moz1:PrepareList */
struct moz1__PrepareList
{
	char *key;	/* optional element of type xsd:string */
	struct moz1__sqlQueryList *queries;	/* optional element of type moz1:sqlQueryList */
};
#endif

#ifndef SOAP_TYPE_moz1__ExecPreparedSelectResponse
#define SOAP_TYPE_moz1__ExecPreparedSelectResponse (33)
/* moz1:ExecPreparedSelectResponse */
struct moz1__ExecPreparedSelectResponse
{
	struct moz1__sqlTable *result;	/* RPC return element */	/* optional element of type moz1:sqlTable */
};
#endif

#ifndef SOAP_TYPE_moz1__ExecPreparedSelect
#define SOAP_TYPE_moz1__ExecPreparedSelect (37)
/* moz1:ExecPreparedSelect */
struct moz1__ExecPreparedSelect
{
	char *key;	/* optional element of type xsd:string */
	char *name;	/* optional element of type xsd:string */
	struct moz1__sqlLine *params;	/* optional element of type moz1:sqlLine */
};
#endif

#ifndef SOAP_TYPE_moz1__ExecPreparedUpdateResponse
#define SOAP_TYPE_moz1__ExecPreparedUpdateResponse (39)
/* moz1:ExecPreparedUpdateResponse */
struct moz1__ExecPreparedUpdateResponse
{
	char **result;	/* RPC return element */	/* optional element of type xsd:string */
};
#endif

#ifndef SOAP_TYPE_moz1__ExecPreparedUpdate
#define SOAP_TYPE_moz1__ExecPreparedUpdate (40)
/* moz1:ExecPreparedUpdate */
struct moz1__ExecPreparedUpdate
{
	char *key;	/* optional element of type xsd:string */
	char *name;	/* optional element of type xsd:string */
	struct moz1__sqlLine *params;	/* optional element of type moz1:sqlLine */
};
#endif

#ifndef SOAP_TYPE_moz1__ExecSelectResponse
#define SOAP_TYPE_moz1__ExecSelectResponse (41)
/* moz1:ExecSelectResponse */
struct moz1__ExecSelectResponse
{
	struct moz1__sqlTable *result;	/* RPC return element */	/* optional element of type moz1:sqlTable */
};
#endif

#ifndef SOAP_TYPE_moz1__ExecSelect
#define SOAP_TYPE_moz1__ExecSelect (44)
/* moz1:ExecSelect */
struct moz1__ExecSelect
{
	char *key;	/* optional element of type xsd:string */
	char *query;	/* optional element of type xsd:string */
	struct moz1__sqlLine *params;	/* optional element of type moz1:sqlLine */
};
#endif

#ifndef SOAP_TYPE_moz1__ExecUpdateResponse
#define SOAP_TYPE_moz1__ExecUpdateResponse (46)
/* moz1:ExecUpdateResponse */
struct moz1__ExecUpdateResponse
{
	char **result;	/* RPC return element */	/* optional element of type xsd:string */
};
#endif

#ifndef SOAP_TYPE_moz1__ExecUpdate
#define SOAP_TYPE_moz1__ExecUpdate (47)
/* moz1:ExecUpdate */
struct moz1__ExecUpdate
{
	char *key;	/* optional element of type xsd:string */
	char *query;	/* optional element of type xsd:string */
	struct moz1__sqlLine *params;	/* optional element of type moz1:sqlLine */
};
#endif

#ifndef SOAP_TYPE_moz1__pmInitResponse
#define SOAP_TYPE_moz1__pmInitResponse (49)
/* moz1:pmInitResponse */
struct moz1__pmInitResponse
{
	unsigned int *result;	/* RPC return element */	/* optional element of type xsd:unsignedInt */
};
#endif

#ifndef SOAP_TYPE_moz1__pmInit
#define SOAP_TYPE_moz1__pmInit (50)
/* moz1:pmInit */
struct moz1__pmInit
{
	char *key;	/* optional element of type xsd:string */
	char *database;	/* optional element of type xsd:string */
	enum xsd__boolean force;	/* required element of type xsd:boolean */
};
#endif

#ifndef SOAP_TYPE_SOAP_ENV__Header
#define SOAP_TYPE_SOAP_ENV__Header (53)
/* SOAP Header: */
struct SOAP_ENV__Header
{
	void *dummy;	/* transient */
};
#endif

#ifndef SOAP_TYPE_SOAP_ENV__Code
#define SOAP_TYPE_SOAP_ENV__Code (54)
/* SOAP Fault Code: */
struct SOAP_ENV__Code
{
	char *SOAP_ENV__Value;	/* optional element of type QName */
	struct SOAP_ENV__Code *SOAP_ENV__Subcode;	/* optional element of type SOAP-ENV:Code */
};
#endif

#ifndef SOAP_TYPE_SOAP_ENV__Detail
#define SOAP_TYPE_SOAP_ENV__Detail (56)
/* SOAP-ENV:Detail */
struct SOAP_ENV__Detail
{
	int __type;	/* any type of element <fault> (defined below) */
	void *fault;	/* transient */
	char *__any;
};
#endif

#ifndef SOAP_TYPE_SOAP_ENV__Reason
#define SOAP_TYPE_SOAP_ENV__Reason (57)
/* SOAP-ENV:Reason */
struct SOAP_ENV__Reason
{
	char *SOAP_ENV__Text;	/* optional element of type xsd:string */
};
#endif

#ifndef SOAP_TYPE_SOAP_ENV__Fault
#define SOAP_TYPE_SOAP_ENV__Fault (58)
/* SOAP Fault: */
struct SOAP_ENV__Fault
{
	char *faultcode;	/* optional element of type QName */
	char *faultstring;	/* optional element of type xsd:string */
	char *faultactor;	/* optional element of type xsd:string */
	struct SOAP_ENV__Detail *detail;	/* optional element of type SOAP-ENV:Detail */
	struct SOAP_ENV__Code *SOAP_ENV__Code;	/* optional element of type SOAP-ENV:Code */
	struct SOAP_ENV__Reason *SOAP_ENV__Reason;	/* optional element of type SOAP-ENV:Reason */
	char *SOAP_ENV__Node;	/* optional element of type xsd:string */
	char *SOAP_ENV__Role;	/* optional element of type xsd:string */
	struct SOAP_ENV__Detail *SOAP_ENV__Detail;	/* optional element of type SOAP-ENV:Detail */
};
#endif

/******************************************************************************\
 *                                                                            *
 * Types with Custom Serializers                                              *
 *                                                                            *
\******************************************************************************/


/******************************************************************************\
 *                                                                            *
 * Typedefs                                                                   *
 *                                                                            *
\******************************************************************************/

#ifndef SOAP_TYPE__XML
#define SOAP_TYPE__XML (4)
typedef char *_XML;
#endif

#ifndef SOAP_TYPE__QName
#define SOAP_TYPE__QName (5)
typedef char *_QName;
#endif


/******************************************************************************\
 *                                                                            *
 * Typedef Synonyms                                                           *
 *                                                                            *
\******************************************************************************/


/******************************************************************************\
 *                                                                            *
 * Externals                                                                  *
 *                                                                            *
\******************************************************************************/


/******************************************************************************\
 *                                                                            *
 * Service Operations                                                         *
 *                                                                            *
\******************************************************************************/


SOAP_FMAC5 int SOAP_FMAC6 moz1__pmConnect(struct soap*, char *login, char *password, char *database, char **key);

SOAP_FMAC5 int SOAP_FMAC6 moz1__pmFinish(struct soap*, char *key, unsigned int *result);

SOAP_FMAC5 int SOAP_FMAC6 moz1__Setup(struct soap*, char *key, struct moz1__SetupResponse *_param_1);

SOAP_FMAC5 int SOAP_FMAC6 moz1__Prepare(struct soap*, char *key, char *query, char *name, unsigned int arity, unsigned int *result);

SOAP_FMAC5 int SOAP_FMAC6 moz1__PrepareList(struct soap*, char *key, struct moz1__sqlQueryList *queries, unsigned int *result);

SOAP_FMAC5 int SOAP_FMAC6 moz1__ExecPreparedSelect(struct soap*, char *key, char *name, struct moz1__sqlLine *params, struct moz1__ExecPreparedSelectResponse *_param_2);

SOAP_FMAC5 int SOAP_FMAC6 moz1__ExecPreparedUpdate(struct soap*, char *key, char *name, struct moz1__sqlLine *params, char **result);

SOAP_FMAC5 int SOAP_FMAC6 moz1__ExecSelect(struct soap*, char *key, char *query, struct moz1__sqlLine *params, struct moz1__ExecSelectResponse *_param_3);

SOAP_FMAC5 int SOAP_FMAC6 moz1__ExecUpdate(struct soap*, char *key, char *query, struct moz1__sqlLine *params, char **result);

SOAP_FMAC5 int SOAP_FMAC6 moz1__pmInit(struct soap*, char *key, char *database, enum xsd__boolean force, unsigned int *result);

/******************************************************************************\
 *                                                                            *
 * Stubs                                                                      *
 *                                                                            *
\******************************************************************************/


SOAP_FMAC5 int SOAP_FMAC6 soap_call_moz1__pmConnect(struct soap *soap, const char *soap_endpoint, const char *soap_action, char *login, char *password, char *database, char **key);

SOAP_FMAC5 int SOAP_FMAC6 soap_call_moz1__pmFinish(struct soap *soap, const char *soap_endpoint, const char *soap_action, char *key, unsigned int *result);

SOAP_FMAC5 int SOAP_FMAC6 soap_call_moz1__Setup(struct soap *soap, const char *soap_endpoint, const char *soap_action, char *key, struct moz1__SetupResponse *_param_1);

SOAP_FMAC5 int SOAP_FMAC6 soap_call_moz1__Prepare(struct soap *soap, const char *soap_endpoint, const char *soap_action, char *key, char *query, char *name, unsigned int arity, unsigned int *result);

SOAP_FMAC5 int SOAP_FMAC6 soap_call_moz1__PrepareList(struct soap *soap, const char *soap_endpoint, const char *soap_action, char *key, struct moz1__sqlQueryList *queries, unsigned int *result);

SOAP_FMAC5 int SOAP_FMAC6 soap_call_moz1__ExecPreparedSelect(struct soap *soap, const char *soap_endpoint, const char *soap_action, char *key, char *name, struct moz1__sqlLine *params, struct moz1__ExecPreparedSelectResponse *_param_2);

SOAP_FMAC5 int SOAP_FMAC6 soap_call_moz1__ExecPreparedUpdate(struct soap *soap, const char *soap_endpoint, const char *soap_action, char *key, char *name, struct moz1__sqlLine *params, char **result);

SOAP_FMAC5 int SOAP_FMAC6 soap_call_moz1__ExecSelect(struct soap *soap, const char *soap_endpoint, const char *soap_action, char *key, char *query, struct moz1__sqlLine *params, struct moz1__ExecSelectResponse *_param_3);

SOAP_FMAC5 int SOAP_FMAC6 soap_call_moz1__ExecUpdate(struct soap *soap, const char *soap_endpoint, const char *soap_action, char *key, char *query, struct moz1__sqlLine *params, char **result);

SOAP_FMAC5 int SOAP_FMAC6 soap_call_moz1__pmInit(struct soap *soap, const char *soap_endpoint, const char *soap_action, char *key, char *database, enum xsd__boolean force, unsigned int *result);

/******************************************************************************\
 *                                                                            *
 * Skeletons                                                                  *
 *                                                                            *
\******************************************************************************/

SOAP_FMAC5 int SOAP_FMAC6 soap_serve(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve_request(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve_moz1__pmConnect(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve_moz1__pmFinish(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve_moz1__Setup(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve_moz1__Prepare(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve_moz1__PrepareList(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve_moz1__ExecPreparedSelect(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve_moz1__ExecPreparedUpdate(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve_moz1__ExecSelect(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve_moz1__ExecUpdate(struct soap*);

SOAP_FMAC5 int SOAP_FMAC6 soap_serve_moz1__pmInit(struct soap*);

#ifdef __cplusplus
}
#endif

#endif

/* End of mozStub.h */
