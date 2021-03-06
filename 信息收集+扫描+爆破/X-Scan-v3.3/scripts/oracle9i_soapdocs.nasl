#
# This script was written by Javier Fernandez-Sanguino <jfs@computer.org>
# 
# This software is distributed under the GPL license, please
# read the license at http://www.gnu.org/licenses/licenses.html#TOCGPL
#

if(description)
{
 script_id(11223);
 script_version("$Revision: 1.5 $");

 name["english"] = "Oracle 9iAS access to SOAP documentation";
 script_name(english:name["english"]);
 
 desc["english"] = "
In a default installation of Oracle 9iAS, it is possible to
access SOAP documentation. These files might be useful for an attacker
to determine what application server is being used. 

Solution: 
Remove the 'soapdocs' alias from the Oracle 9iAS http.conf:
Alias /soapdocs/ $ORACLE_HOME/soap/docs/

Note that the default installation of Oracle 9iAS 1.0.2.2 does not
seem to suffer this issue.

More information:
http://otn.oracle.com/deploy/security/pdf/ias_soap_alert.pdf
http://www.cert.org/advisories/CA-2002-08.html

Also read:
Hackproofing Oracle Application Server from NGSSoftware:
available at http://www.nextgenss.com/papers/hpoas.pdf 

Risk factor : Low";

 script_description(english:desc["english"]);
 
 summary["english"] = "Tries to retrieve Oracle9iAS SOAP documentation";
 
 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2003 Javier Fernandez-Sanguino");
 family["english"] = "CGI abuses";
 family["francais"] = "Abus de CGI";
 script_family(english:family["english"], francais:family["francais"]);
 script_dependencie("find_service.nes", "http_version.nasl");
 script_require_ports("Services/www", 80);
 script_require_keys("www/OracleApache");
 exit(0);
}

# Check starts here

include("http_func.inc");
include("http_keepalive.inc");

port = get_http_port(default:80);


if(get_port_state(port))
{ 

# Somebody needs to parse the Oracle documentation and put more files in
# these are just some examples out there.
  document[0]="ReleaseNotes.html";
  document[1]="docs/apiDocs/packages.html";
  document[2]="docs/apiDocs/org.apache.soap.util.xml.XMISerializer.html";

# This one is too big to be retrieved
#  document[X]="docs/apiDocs/AllNames.html"; 

    for  ( i=0; document[i]; i = i + 1 ) {
       req = http_get(item:string("/soapdocs/", document[i]), port:port);
       r = http_keepalive_send_recv(port:port, data:req, bodyonly:1);
       if ( r == NULL ) exit(0);
       if ( "SOAP" >< r || "Index of" >< r || "Package Index" >< r || "Generated by javadoc"  >< r )	
	      security_hole(port, data:string("The documentation file /soapdocs/",document[i]," can be retrieved remotely:\n", r));
   }  # of the for loop
 
# TODO:
# this should also check for some information in the documentation and retrieve the precise version.
# Sample:
# ReleasesNotes.html has <center>iAS v1.X.X.X</center>  which indicates the Oracle iAS version

}
