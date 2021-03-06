# This script was automatically generated from the dsa-034
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(14871);
 script_version("$Revision: 1.9 $");
 script_xref(name: "DSA", value: "034");
 script_cve_id("CVE-2001-0458");
 script_bugtraq_id(2464);

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-034 security update');
 script_set_attribute(attribute: 'description', value:
'Fumitoshi Ukai and Denis Barbier have found several
potential buffer overflow bugs in our version of ePerl as distributed in all of
our distributions.  

When eperl is installed setuid root, it can switch to the UID/GID of
the scripts owner.  Although Debian doesn\'t ship the program setuid
root, this is a useful feature which people may have activated
locally.  When the program is used as /usr/lib/cgi-bin/nph-eperl the
bugs could lead into a remote vulnerability as well.

Version 2.2.14-0.7potato2 fixes this; we recommend you upgrade your eperl
package immediately.  
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2001/dsa-034');
 script_set_attribute(attribute: 'solution', value: 
'Read http://www.debian.org/security/2001/dsa-034
and install the recommended updated packages.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA034] DSA-034-1 ePerl");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-034-1 ePerl");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'eperl', release: '2.2', reference: '2.2.14-0.7potato2');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
