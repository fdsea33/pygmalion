/* pmServer.c
   Generated by gSOAP 2.7.6e from pygmalion.h
   Copyright (C) 2000-2005, Robert van Engelen, Genivia Inc. All Rights Reserved.
   This part of the software is released under one of the following licenses:
   GPL, the gSOAP public license, or Genivia's license for commercial use.
*/
#include "pmH.h"
#ifdef __cplusplus
extern "C" {
#endif

SOAP_SOURCE_STAMP("@(#) pmServer.c ver 2.7.6e 2006-08-22 07:43:14 GMT")


SOAP_FMAC5 int SOAP_FMAC6 soap_serve(struct soap *soap)
{
#ifndef WITH_FASTCGI
	unsigned int k = soap->max_keep_alive;
#endif

	do
	{
#ifdef WITH_FASTCGI
		if (FCGI_Accept() < 0)
		{
			soap->error = SOAP_EOF;
			return soap_send_fault(soap);
		}
#endif

		soap_begin(soap);

#ifndef WITH_FASTCGI
		if (!--k)
			soap->keep_alive = 0;
#endif

		if (soap_begin_recv(soap))
		{	if (soap->error < SOAP_STOP)
			{
#ifdef WITH_FASTCGI
				soap_send_fault(soap);
#else 
				return soap_send_fault(soap);
#endif
			}
			soap_closesock(soap);

			continue;
		}

		if (soap_envelope_begin_in(soap)
		 || soap_recv_header(soap)
		 || soap_body_begin_in(soap)
		 || soap_serve_request(soap)
		 || (soap->fserveloop && soap->fserveloop(soap)))
		{
#ifdef WITH_FASTCGI
			soap_send_fault(soap);
#else
			return soap_send_fault(soap);
#endif
		}

#ifdef WITH_FASTCGI
	} while (1);
#else
	} while (soap->keep_alive);
#endif
	return SOAP_OK;
}

#ifndef WITH_NOSERVEREQUEST
SOAP_FMAC5 int SOAP_FMAC6 soap_serve_request(struct soap *soap)
{
	soap_peek_element(soap);
	if (!soap_match_tag(soap, soap->tag, "pmns1:pmConnexion"))
		return soap_serve_pmns1__pmConnexion(soap);
	if (!soap_match_tag(soap, soap->tag, "pmns1:pmDeconnexion"))
		return soap_serve_pmns1__pmDeconnexion(soap);
	if (!soap_match_tag(soap, soap->tag, "pmns1:pmSelect"))
		return soap_serve_pmns1__pmSelect(soap);
	if (!soap_match_tag(soap, soap->tag, "pmns1:pmUpdate"))
		return soap_serve_pmns1__pmUpdate(soap);
	if (!soap_match_tag(soap, soap->tag, "pmns1:pmCalcul"))
		return soap_serve_pmns1__pmCalcul(soap);
	return soap->error = SOAP_NO_METHOD;
}
#endif

SOAP_FMAC5 int SOAP_FMAC6 soap_serve_pmns1__pmConnexion(struct soap *soap)
{	struct pmns1__pmConnexion soap_tmp_pmns1__pmConnexion;
	struct pmns1__pmConnexionResponse _param_1;
	soap_default_pmns1__pmConnexionResponse(soap, &_param_1);
	soap_default_pmns1__pmConnexion(soap, &soap_tmp_pmns1__pmConnexion);
	soap->encodingStyle = "http://schemas.xmlsoap.org/soap/encoding/";
	if (!soap_get_pmns1__pmConnexion(soap, &soap_tmp_pmns1__pmConnexion, "pmns1:pmConnexion", NULL))
		return soap->error;
	if (soap_body_end_in(soap)
	 || soap_envelope_end_in(soap)
	 || soap_end_recv(soap))
		return soap->error;
	soap->error = pmns1__pmConnexion(soap, soap_tmp_pmns1__pmConnexion.login, soap_tmp_pmns1__pmConnexion.password, soap_tmp_pmns1__pmConnexion.database, &_param_1);
	if (soap->error)
		return soap->error;
	soap_serializeheader(soap);
	soap_serialize_pmns1__pmConnexionResponse(soap, &_param_1);
	if (soap_begin_count(soap))
		return soap->error;
	if (soap->mode & SOAP_IO_LENGTH)
	{	if (soap_envelope_begin_out(soap)
		 || soap_putheader(soap)
		 || soap_body_begin_out(soap)
		 || soap_put_pmns1__pmConnexionResponse(soap, &_param_1, "pmns1:pmConnexionResponse", "")
		 || soap_body_end_out(soap)
		 || soap_envelope_end_out(soap))
			 return soap->error;
	};
	if (soap_end_count(soap)
	 || soap_response(soap, SOAP_OK)
	 || soap_envelope_begin_out(soap)
	 || soap_putheader(soap)
	 || soap_body_begin_out(soap)
	 || soap_put_pmns1__pmConnexionResponse(soap, &_param_1, "pmns1:pmConnexionResponse", "")
	 || soap_body_end_out(soap)
	 || soap_envelope_end_out(soap)
	 || soap_end_send(soap))
		return soap->error;
	return soap_closesock(soap);
}

SOAP_FMAC5 int SOAP_FMAC6 soap_serve_pmns1__pmDeconnexion(struct soap *soap)
{	struct pmns1__pmDeconnexion soap_tmp_pmns1__pmDeconnexion;
	struct pmns1__pmDeconnexionResponse soap_tmp_pmns1__pmDeconnexionResponse;
	int soap_tmp_int;
	soap_default_pmns1__pmDeconnexionResponse(soap, &soap_tmp_pmns1__pmDeconnexionResponse);
	soap_default_int(soap, &soap_tmp_int);
	soap_tmp_pmns1__pmDeconnexionResponse.resultat = &soap_tmp_int;
	soap_default_pmns1__pmDeconnexion(soap, &soap_tmp_pmns1__pmDeconnexion);
	soap->encodingStyle = "http://schemas.xmlsoap.org/soap/encoding/";
	if (!soap_get_pmns1__pmDeconnexion(soap, &soap_tmp_pmns1__pmDeconnexion, "pmns1:pmDeconnexion", NULL))
		return soap->error;
	if (soap_body_end_in(soap)
	 || soap_envelope_end_in(soap)
	 || soap_end_recv(soap))
		return soap->error;
	soap->error = pmns1__pmDeconnexion(soap, soap_tmp_pmns1__pmDeconnexion.id, &soap_tmp_int);
	if (soap->error)
		return soap->error;
	soap_serializeheader(soap);
	soap_serialize_pmns1__pmDeconnexionResponse(soap, &soap_tmp_pmns1__pmDeconnexionResponse);
	if (soap_begin_count(soap))
		return soap->error;
	if (soap->mode & SOAP_IO_LENGTH)
	{	if (soap_envelope_begin_out(soap)
		 || soap_putheader(soap)
		 || soap_body_begin_out(soap)
		 || soap_put_pmns1__pmDeconnexionResponse(soap, &soap_tmp_pmns1__pmDeconnexionResponse, "pmns1:pmDeconnexionResponse", "")
		 || soap_body_end_out(soap)
		 || soap_envelope_end_out(soap))
			 return soap->error;
	};
	if (soap_end_count(soap)
	 || soap_response(soap, SOAP_OK)
	 || soap_envelope_begin_out(soap)
	 || soap_putheader(soap)
	 || soap_body_begin_out(soap)
	 || soap_put_pmns1__pmDeconnexionResponse(soap, &soap_tmp_pmns1__pmDeconnexionResponse, "pmns1:pmDeconnexionResponse", "")
	 || soap_body_end_out(soap)
	 || soap_envelope_end_out(soap)
	 || soap_end_send(soap))
		return soap->error;
	return soap_closesock(soap);
}

SOAP_FMAC5 int SOAP_FMAC6 soap_serve_pmns1__pmSelect(struct soap *soap)
{	struct pmns1__pmSelect soap_tmp_pmns1__pmSelect;
	struct pmns1__pmSelectResponse _param_2;
	soap_default_pmns1__pmSelectResponse(soap, &_param_2);
	soap_default_pmns1__pmSelect(soap, &soap_tmp_pmns1__pmSelect);
	soap->encodingStyle = "http://schemas.xmlsoap.org/soap/encoding/";
	if (!soap_get_pmns1__pmSelect(soap, &soap_tmp_pmns1__pmSelect, "pmns1:pmSelect", NULL))
		return soap->error;
	if (soap_body_end_in(soap)
	 || soap_envelope_end_in(soap)
	 || soap_end_recv(soap))
		return soap->error;
	soap->error = pmns1__pmSelect(soap, soap_tmp_pmns1__pmSelect.id, soap_tmp_pmns1__pmSelect.query, &_param_2);
	if (soap->error)
		return soap->error;
	soap_serializeheader(soap);
	soap_serialize_pmns1__pmSelectResponse(soap, &_param_2);
	if (soap_begin_count(soap))
		return soap->error;
	if (soap->mode & SOAP_IO_LENGTH)
	{	if (soap_envelope_begin_out(soap)
		 || soap_putheader(soap)
		 || soap_body_begin_out(soap)
		 || soap_put_pmns1__pmSelectResponse(soap, &_param_2, "pmns1:pmSelectResponse", "")
		 || soap_body_end_out(soap)
		 || soap_envelope_end_out(soap))
			 return soap->error;
	};
	if (soap_end_count(soap)
	 || soap_response(soap, SOAP_OK)
	 || soap_envelope_begin_out(soap)
	 || soap_putheader(soap)
	 || soap_body_begin_out(soap)
	 || soap_put_pmns1__pmSelectResponse(soap, &_param_2, "pmns1:pmSelectResponse", "")
	 || soap_body_end_out(soap)
	 || soap_envelope_end_out(soap)
	 || soap_end_send(soap))
		return soap->error;
	return soap_closesock(soap);
}

SOAP_FMAC5 int SOAP_FMAC6 soap_serve_pmns1__pmUpdate(struct soap *soap)
{	struct pmns1__pmUpdate soap_tmp_pmns1__pmUpdate;
	struct pmns1__pmUpdateResponse soap_tmp_pmns1__pmUpdateResponse;
	int soap_tmp_int;
	soap_default_pmns1__pmUpdateResponse(soap, &soap_tmp_pmns1__pmUpdateResponse);
	soap_default_int(soap, &soap_tmp_int);
	soap_tmp_pmns1__pmUpdateResponse.resultat = &soap_tmp_int;
	soap_default_pmns1__pmUpdate(soap, &soap_tmp_pmns1__pmUpdate);
	soap->encodingStyle = "http://schemas.xmlsoap.org/soap/encoding/";
	if (!soap_get_pmns1__pmUpdate(soap, &soap_tmp_pmns1__pmUpdate, "pmns1:pmUpdate", NULL))
		return soap->error;
	if (soap_body_end_in(soap)
	 || soap_envelope_end_in(soap)
	 || soap_end_recv(soap))
		return soap->error;
	soap->error = pmns1__pmUpdate(soap, soap_tmp_pmns1__pmUpdate.id, soap_tmp_pmns1__pmUpdate.query, &soap_tmp_int);
	if (soap->error)
		return soap->error;
	soap_serializeheader(soap);
	soap_serialize_pmns1__pmUpdateResponse(soap, &soap_tmp_pmns1__pmUpdateResponse);
	if (soap_begin_count(soap))
		return soap->error;
	if (soap->mode & SOAP_IO_LENGTH)
	{	if (soap_envelope_begin_out(soap)
		 || soap_putheader(soap)
		 || soap_body_begin_out(soap)
		 || soap_put_pmns1__pmUpdateResponse(soap, &soap_tmp_pmns1__pmUpdateResponse, "pmns1:pmUpdateResponse", "")
		 || soap_body_end_out(soap)
		 || soap_envelope_end_out(soap))
			 return soap->error;
	};
	if (soap_end_count(soap)
	 || soap_response(soap, SOAP_OK)
	 || soap_envelope_begin_out(soap)
	 || soap_putheader(soap)
	 || soap_body_begin_out(soap)
	 || soap_put_pmns1__pmUpdateResponse(soap, &soap_tmp_pmns1__pmUpdateResponse, "pmns1:pmUpdateResponse", "")
	 || soap_body_end_out(soap)
	 || soap_envelope_end_out(soap)
	 || soap_end_send(soap))
		return soap->error;
	return soap_closesock(soap);
}

SOAP_FMAC5 int SOAP_FMAC6 soap_serve_pmns1__pmCalcul(struct soap *soap)
{	struct pmns1__pmCalcul soap_tmp_pmns1__pmCalcul;
	struct pmns1__pmCalculResponse soap_tmp_pmns1__pmCalculResponse;
	double soap_tmp_double;
	soap_default_pmns1__pmCalculResponse(soap, &soap_tmp_pmns1__pmCalculResponse);
	soap_default_double(soap, &soap_tmp_double);
	soap_tmp_pmns1__pmCalculResponse.return_ = &soap_tmp_double;
	soap_default_pmns1__pmCalcul(soap, &soap_tmp_pmns1__pmCalcul);
	soap->encodingStyle = "http://schemas.xmlsoap.org/soap/encoding/";
	if (!soap_get_pmns1__pmCalcul(soap, &soap_tmp_pmns1__pmCalcul, "pmns1:pmCalcul", NULL))
		return soap->error;
	if (soap_body_end_in(soap)
	 || soap_envelope_end_in(soap)
	 || soap_end_recv(soap))
		return soap->error;
	soap->error = pmns1__pmCalcul(soap, soap_tmp_pmns1__pmCalcul.taux, soap_tmp_pmns1__pmCalcul.nb, &soap_tmp_double);
	if (soap->error)
		return soap->error;
	soap_serializeheader(soap);
	soap_serialize_pmns1__pmCalculResponse(soap, &soap_tmp_pmns1__pmCalculResponse);
	if (soap_begin_count(soap))
		return soap->error;
	if (soap->mode & SOAP_IO_LENGTH)
	{	if (soap_envelope_begin_out(soap)
		 || soap_putheader(soap)
		 || soap_body_begin_out(soap)
		 || soap_put_pmns1__pmCalculResponse(soap, &soap_tmp_pmns1__pmCalculResponse, "pmns1:pmCalculResponse", "")
		 || soap_body_end_out(soap)
		 || soap_envelope_end_out(soap))
			 return soap->error;
	};
	if (soap_end_count(soap)
	 || soap_response(soap, SOAP_OK)
	 || soap_envelope_begin_out(soap)
	 || soap_putheader(soap)
	 || soap_body_begin_out(soap)
	 || soap_put_pmns1__pmCalculResponse(soap, &soap_tmp_pmns1__pmCalculResponse, "pmns1:pmCalculResponse", "")
	 || soap_body_end_out(soap)
	 || soap_envelope_end_out(soap)
	 || soap_end_send(soap))
		return soap->error;
	return soap_closesock(soap);
}

#ifdef __cplusplus
}
#endif

/* End of pmServer.c */