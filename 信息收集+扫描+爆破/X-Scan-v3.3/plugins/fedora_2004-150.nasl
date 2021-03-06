#
# (C) Tenable Network Security
#
# This plugin text is was extracted from the Fedora Security Advisory
#


if ( ! defined_func("bn_random") ) exit(0);

include("compat.inc");

if(description)
{
 script_id(13711);
 if(defined_func("script_xref"))script_xref(name:"IAVA", value:"2004-t-0017");
 script_bugtraq_id(10448);
 script_version ("$Revision: 1.8 $");
 script_cve_id("CVE-2004-0523");
 
 name["english"] = "Fedora Core 2 2004-150: krb5";
 
 script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host is missing a vendor-supplied security patch" );
 script_set_attribute(attribute:"description", value:
"The remote host is missing the patch for the advisory FEDORA-2004-150 (krb5).

Kerberos V5 is a trusted-third-party network authentication system,
which can improve your network's security by eliminating the insecure
practice of cleartext passwords.

Update Information:

Bugs have been fixed in the krb5_aname_to_localname library function.
Specifically, buffer overflows were possible for all Kerberos
versions up to and including 1.3.3. The krb5_aname_to_localname
function translates a Kerberos principal name to a local account
name, typically a UNIX username.  This function is frequently used
when performing authorization checks.

If configured with mappings from particular Kerberos principals to
particular UNIX user names, certain functions called by
krb5_aname_to_localname will not properly check the lengths of
buffers used to store portions of the principal name. If configured
to map principals to user names using rules, krb5_aname_to_localname
would consistently write one byte past the end of a buffer allocated
from the heap. The Common Vulnerabilities and Exposures project
(cve.mitre.org) has assigned the name CVE-2004-0523 to this issue.

Only configurations which enable the explicit mapping or rules-based
mapping functionality of krb5_aname_to_localname() are vulnerable.
These configurations are not the default." );
 script_set_attribute(attribute:"solution", value:
"http://www.fedoranews.org/updates/FEDORA-2004-150.shtml" );
 script_set_attribute(attribute:"risk_factor", value:"High" );



 script_end_attributes();

 
 summary["english"] = "Check for the version of the krb5 package";
 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2004 Tenable Network Security");
 family["english"] = "Fedora Local Security Checks";
 script_family(english:family["english"]);
 
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");
if ( rpm_check( reference:"krb5-devel-1.3.3-7", release:"FC2") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"krb5-libs-1.3.3-7", release:"FC2") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"krb5-server-1.3.3-7", release:"FC2") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"krb5-workstation-1.3.3-7", release:"FC2") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"krb5-debuginfo-1.3.3-7", release:"FC2") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_exists(rpm:"krb5-", release:"FC2") )
{
 set_kb_item(name:"CVE-2004-0523", value:TRUE);
}
