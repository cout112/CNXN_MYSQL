CREATE TABLE public.aaaaccadminprofile (
accountprofile_id bigint NOT NULL,
name citext NOT NULL,
exp_after integer DEFAULT '-1' NOT NULL,
deleteon_expiry integer DEFAULT '-1' NOT NULL,
nvrlogin_explt integer DEFAULT '-1' NOT NULL,
idle_session bigint DEFAULT '-1' NOT NULL,
expew_thres integer DEFAULT '-1' NOT NULL,
forceout_onexp boolean DEFAULT true NOT NULL,
simul_login integer DEFAULT 0 NOT NULL,
allowed_badlogin integer DEFAULT '-1' NOT NULL,
lock_period integer DEFAULT '-1' NOT NULL,
login_criteria citext DEFAULT 'None' NOT NULL,
CONSTRAINT aaaaccadminprofile_1451764629_c CHECK ((length((login_criteria)::text) <= 200)),
CONSTRAINT aaaaccadminprofile_2388619_c CHECK ((length((name)::text) <= 50))
);
CREATE TABLE public.aaaaccbadloginstatus (
account_id bigint NOT NULL,
numof_badlogin integer DEFAULT 0 NOT NULL,
host citext NOT NULL,
updatedtime bigint NOT NULL,
host_name citext,
CONSTRAINT aaaaccbadloginstatus_2098693826_c CHECK ((length((host_name)::text) <= 200)),
CONSTRAINT aaaaccbadloginstatus_2223528_c CHECK ((length((host)::text) <= 100))
);
CREATE TABLE public.aaaacchttpsession (
session_id bigint NOT NULL,
sso_id bytea NOT NULL
);
CREATE TABLE public.aaaaccoldpassword (
account_id bigint NOT NULL,
oldpassword_id bigint NOT NULL
);
CREATE TABLE public.aaaaccount (
account_id bigint NOT NULL,
login_id bigint NOT NULL,
service_id bigint NOT NULL,
accountprofile_id bigint NOT NULL,
createdtime bigint NOT NULL
);
CREATE TABLE public.aaaaccountowner (
account_id bigint NOT NULL,
owneraccount_id bigint NOT NULL
);
CREATE TABLE public.aaaaccountstatus (
account_id bigint NOT NULL,
expireat bigint DEFAULT '0' NOT NULL,
afterexp_login integer DEFAULT 0 NOT NULL,
status citext DEFAULT 'NEW' NOT NULL,
updatedtime bigint NOT NULL,
CONSTRAINT aaaaccountstatus_1839152142_c CHECK ((length((status)::text) <= 20))
);
CREATE TABLE public.aaaaccownerprofile (
account_id bigint NOT NULL,
allowed_subaccount integer DEFAULT '-1' NOT NULL
);
CREATE TABLE public.aaaaccpassword (
account_id bigint NOT NULL,
password_id bigint NOT NULL
);
CREATE TABLE public.aaaaccsession (
session_id bigint NOT NULL,
account_id bigint NOT NULL,
user_host citext DEFAULT 'Unknown' NOT NULL,
application_host citext NOT NULL,
opentime bigint NOT NULL,
closetime bigint DEFAULT '0' NOT NULL,
status citext DEFAULT 'ACTIVE' NOT NULL,
user_host_name citext NOT NULL,
authenticator citext DEFAULT 'UNKNOWN' NOT NULL,
CONSTRAINT aaaaccsession_1139644004_c CHECK ((length((user_host)::text) <= 100)),
CONSTRAINT aaaaccsession_1839152142_c CHECK ((length((status)::text) <= 20)),
CONSTRAINT aaaaccsession_304434007_c CHECK ((length((application_host)::text) <= 100)),
CONSTRAINT aaaaccsession_636276051_c CHECK ((length((authenticator)::text) <= 200)),
CONSTRAINT aaaaccsession_999973710_c CHECK ((length((user_host_name)::text) <= 200))
);
CREATE TABLE public.aaaaccsessionaudit (
session_id bigint NOT NULL,
auditid bigint NOT NULL
);
CREATE TABLE public.aaaaccsessionprop (
session_id bigint NOT NULL,
prop_name citext NOT NULL,
prop_value citext NOT NULL,
CONSTRAINT aaaaccsessionprop_2087859687_c CHECK ((length((prop_name)::text) <= 50)),
CONSTRAINT aaaaccsessionprop_306528629_c CHECK ((length((prop_value)::text) <= 100))
);
CREATE TABLE public.aaaaccuserprofile (
account_id bigint NOT NULL,
session_timeout integer DEFAULT 10 NOT NULL
);
CREATE TABLE public.aaaace (
permission_id bigint NOT NULL,
role_id bigint NOT NULL,
env_criteria citext DEFAULT 'ALL',
expiry_time bigint DEFAULT '0',
exclude boolean DEFAULT false,
evaluationorder integer DEFAULT 0,
CONSTRAINT aaaace_698419857_c CHECK ((length((env_criteria)::text) <= 100))
);
CREATE TABLE public.aaaauthorizedrole (
account_id bigint NOT NULL,
role_id bigint NOT NULL
);
CREATE TABLE public.aaacontactinfo (
contactinfo_id bigint NOT NULL,
emailid citext,
landline citext,
mobile citext,
fax citext,
web_url citext,
res_phone citext,
CONSTRAINT aaacontactinfo_1256686799_c CHECK ((length((res_phone)::text) <= 30)),
CONSTRAINT aaacontactinfo_1942687172_c CHECK ((length((web_url)::text) <= 255)),
CONSTRAINT aaacontactinfo_2015525726_c CHECK ((length((mobile)::text) <= 30)),
CONSTRAINT aaacontactinfo_69373_c CHECK ((length((fax)::text) <= 30)),
CONSTRAINT aaacontactinfo_833993633_c CHECK ((length((landline)::text) <= 30)),
CONSTRAINT aaacontactinfo_920031849_c CHECK ((length((emailid)::text) <= 200))
);
CREATE TABLE public.aaadisableauth (
module_id bigint NOT NULL
);
CREATE TABLE public.aaaenvironmententry (
service_id bigint NOT NULL,
name citext NOT NULL,
value citext NOT NULL,
type citext NOT NULL,
description citext DEFAULT 'No Description',
CONSTRAINT aaaenvironmententry_2388619_c CHECK ((length((name)::text) <= 50)),
CONSTRAINT aaaenvironmententry_2590522_c CHECK ((length((type)::text) <= 50)),
CONSTRAINT aaaenvironmententry_428414940_c CHECK ((length((description)::text) <= 100)),
CONSTRAINT aaaenvironmententry_81434961_c CHECK ((length((value)::text) <= 100))
);
CREATE TABLE public.aaagenderhonorific (
gh_id bigint NOT NULL,
gender citext NOT NULL,
honorific citext NOT NULL,
CONSTRAINT aaagenderhonorific_1800846913_c CHECK ((length((honorific)::text) <= 20)),
CONSTRAINT aaagenderhonorific_2098783937_c CHECK ((length((gender)::text) <= 10))
);
CREATE TABLE public.aaaimpliedbytablecolumn (
permission_id bigint NOT NULL,
implied_table_name citext NOT NULL,
implied_by_table_name citext NOT NULL,
column_name citext NOT NULL,
column_order bigint DEFAULT '0',
CONSTRAINT aaaimpliedbytablecolumn_1040558227_c CHECK ((length((implied_table_name)::text) <= 50)),
CONSTRAINT aaaimpliedbytablecolumn_1347586516_c CHECK ((length((column_name)::text) <= 50)),
CONSTRAINT aaaimpliedbytablecolumn_1869163027_c CHECK ((length((implied_by_table_name)::text) <= 50))
);
CREATE TABLE public.aaaimpliedpermission (
permission_id bigint NOT NULL,
implied_table_name citext NOT NULL,
implied_by_table_name citext NOT NULL,
criteria citext,
CONSTRAINT aaaimpliedpermission_1040558227_c CHECK ((length((implied_table_name)::text) <= 50)),
CONSTRAINT aaaimpliedpermission_1560293537_c CHECK ((length((criteria)::text) <= 250)),
CONSTRAINT aaaimpliedpermission_1869163027_c CHECK ((length((implied_by_table_name)::text) <= 50))
);
CREATE TABLE public.aaaimpliedrole (
role_id bigint NOT NULL,
impliedrole_id bigint NOT NULL
);
CREATE TABLE public.aaaimpliedtablecolumn (
permission_id bigint NOT NULL,
implied_table_name citext NOT NULL,
column_name citext NOT NULL,
column_order bigint DEFAULT '0',
CONSTRAINT aaaimpliedtablecolumn_1040558227_c CHECK ((length((implied_table_name)::text) <= 50)),
CONSTRAINT aaaimpliedtablecolumn_1347586516_c CHECK ((length((column_name)::text) <= 50))
);
CREATE TABLE public.aaalogin (
login_id bigint NOT NULL,
user_id bigint NOT NULL,
name citext NOT NULL,
domainname citext DEFAULT '-' NOT NULL,
CONSTRAINT aaalogin_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT aaalogin_758040241_c CHECK ((length((domainname)::text) <= 100))
);
CREATE TABLE public.aaamethodparams (
permission_id bigint NOT NULL,
param_type citext NOT NULL,
param_order bigint NOT NULL,
CONSTRAINT aaamethodparams_967859148_c CHECK ((length((param_type)::text) <= 150))
);
CREATE TABLE public.aaamethodpermission (
permission_id bigint NOT NULL,
bean_name citext NOT NULL,
method_name citext NOT NULL,
CONSTRAINT aaamethodpermission_1255361321_c CHECK ((length((method_name)::text) <= 150)),
CONSTRAINT aaamethodpermission_843312570_c CHECK ((length((bean_name)::text) <= 100))
);
CREATE TABLE public.aaamoduleservice (
id bigint NOT NULL,
module_id bigint,
service_id bigint NOT NULL
);
CREATE TABLE public.aaaorganization (
org_id bigint NOT NULL,
name citext NOT NULL,
createdtime bigint NOT NULL,
description citext DEFAULT 'No Description' NOT NULL,
CONSTRAINT aaaorganization_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT aaaorganization_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.aaaorgcontactinfo (
org_id bigint NOT NULL,
contactinfo_id bigint NOT NULL
);
CREATE TABLE public.aaaorgcontactuser (
org_id bigint NOT NULL,
user_id bigint NOT NULL
);
CREATE TABLE public.aaaorgdetail (
org_id bigint NOT NULL,
legalname citext,
alias citext,
emp_count bigint DEFAULT '1' NOT NULL,
CONSTRAINT aaaorgdetail_588966052_c CHECK ((length((legalname)::text) <= 100)),
CONSTRAINT aaaorgdetail_62365232_c CHECK ((length((alias)::text) <= 50))
);
CREATE TABLE public.aaaorgpostaladdr (
org_id bigint NOT NULL,
postaladdr_id bigint NOT NULL
);
CREATE TABLE public.aaaorgstatus (
org_id bigint NOT NULL,
status citext DEFAULT 'ACTIVE' NOT NULL,
updatedtime bigint NOT NULL,
CONSTRAINT aaaorgstatus_1839152142_c CHECK ((length((status)::text) <= 20))
);
CREATE TABLE public.aaaorguser (
org_id bigint NOT NULL,
user_id bigint NOT NULL,
type citext DEFAULT 'CONSULTANT' NOT NULL,
CONSTRAINT aaaorguser_2590522_c CHECK ((length((type)::text) <= 30))
);
CREATE TABLE public.aaapamconf (
service_id bigint NOT NULL,
pammodule_id bigint NOT NULL,
control_flag citext DEFAULT 'required' NOT NULL,
execorder integer DEFAULT 0,
CONSTRAINT aaapamconf_723451182_c CHECK ((length((control_flag)::text) <= 10))
);
CREATE TABLE public.aaapammodule (
pammodule_id bigint NOT NULL,
name citext NOT NULL,
type citext DEFAULT 'auth' NOT NULL,
classname citext NOT NULL,
description citext DEFAULT 'No Description' NOT NULL,
CONSTRAINT aaapammodule_1517307933_c CHECK ((length((classname)::text) <= 100)),
CONSTRAINT aaapammodule_2388619_c CHECK ((length((name)::text) <= 50)),
CONSTRAINT aaapammodule_2590522_c CHECK ((length((type)::text) <= 10)),
CONSTRAINT aaapammodule_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.aaapammoduleoption (
pammodule_id bigint NOT NULL,
prop_name citext NOT NULL,
prop_value citext NOT NULL,
CONSTRAINT aaapammoduleoption_2087859687_c CHECK ((length((prop_name)::text) <= 50)),
CONSTRAINT aaapammoduleoption_306528629_c CHECK ((length((prop_value)::text) <= 50))
);
CREATE TABLE public.aaapassword (
password_id bigint NOT NULL,
password citext NOT NULL,
algorithm citext DEFAULT 'bcrypt' NOT NULL,
salt bytea NOT NULL,
passwdprofile_id bigint NOT NULL,
passwdrule_id bigint NOT NULL,
createdtime bigint NOT NULL,
factor bigint,
CONSTRAINT aaapassword_1282882481_c CHECK ((length((algorithm)::text) <= 20)),
CONSTRAINT aaapassword_1999612571_c CHECK ((length((password)::text) <= 100))
);
CREATE TABLE public.aaapasswordhint (
password_id bigint NOT NULL,
question citext NOT NULL,
answer citext NOT NULL,
CONSTRAINT aaapasswordhint_1935487934_c CHECK ((length((answer)::text) <= 50)),
CONSTRAINT aaapasswordhint_383243290_c CHECK ((length((question)::text) <= 100))
);
CREATE TABLE public.aaapasswordprofile (
passwdprofile_id bigint NOT NULL,
name citext NOT NULL,
exp_after integer DEFAULT '-1' NOT NULL,
expew_thres integer DEFAULT '-1' NOT NULL,
login_afterexp integer DEFAULT 0 NOT NULL,
update_interval integer DEFAULT '-1' NOT NULL,
chpasswd_onfl boolean DEFAULT true NOT NULL,
numof_oldpasswd integer DEFAULT 1 NOT NULL,
factor bigint,
password_min_age integer DEFAULT 0 NOT NULL,
CONSTRAINT aaapasswordprofile_2388619_c CHECK ((length((name)::text) <= 50))
);
CREATE TABLE public.aaapasswordrule (
passwdrule_id bigint NOT NULL,
name citext NOT NULL,
min_length integer DEFAULT 6 NOT NULL,
max_length integer DEFAULT 10 NOT NULL,
req_mixedcase boolean DEFAULT false NOT NULL,
numof_splchar integer DEFAULT '-1' NOT NULL,
beginwith_letter boolean DEFAULT false NOT NULL,
loginname_indepndt boolean DEFAULT true NOT NULL,
CONSTRAINT aaapasswordrule_2388619_c CHECK ((length((name)::text) <= 50))
);
CREATE TABLE public.aaapasswordstatus (
password_id bigint NOT NULL,
expireat bigint DEFAULT '9223372036854775807' NOT NULL,
afterexp_login integer DEFAULT 0 NOT NULL,
status citext DEFAULT 'NEW' NOT NULL,
updatedtime bigint NOT NULL,
change_pwd_on_login boolean DEFAULT false NOT NULL,
CONSTRAINT aaapasswordstatus_1839152142_c CHECK ((length((status)::text) <= 20))
);
CREATE TABLE public.aaapermission (
permission_id bigint NOT NULL,
permission_name citext NOT NULL,
service_id bigint NOT NULL,
description citext DEFAULT 'No Description',
CONSTRAINT aaapermission_428414940_c CHECK ((length((description)::text) <= 100)),
CONSTRAINT aaapermission_474922245_c CHECK ((length((permission_name)::text) <= 100))
);
CREATE TABLE public.aaapostaladdress (
postaladdr_id bigint NOT NULL,
door_no citext,
street citext,
location citext,
landmark citext,
city citext,
postalcode citext,
state citext,
country citext,
CONSTRAINT aaapostaladdress_1611296843_c CHECK ((length((location)::text) <= 50)),
CONSTRAINT aaapostaladdress_1675813750_c CHECK ((length((country)::text) <= 50)),
CONSTRAINT aaapostaladdress_1737061390_c CHECK ((length((door_no)::text) <= 50)),
CONSTRAINT aaapostaladdress_1797768904_c CHECK ((length((postalcode)::text) <= 20)),
CONSTRAINT aaapostaladdress_1838660605_c CHECK ((length((street)::text) <= 50)),
CONSTRAINT aaapostaladdress_2068843_c CHECK ((length((city)::text) <= 50)),
CONSTRAINT aaapostaladdress_79219825_c CHECK ((length((state)::text) <= 50)),
CONSTRAINT aaapostaladdress_833971400_c CHECK ((length((landmark)::text) <= 50))
);
CREATE TABLE public.aaaradiusconfig (
server_name citext NOT NULL,
server_port integer NOT NULL,
server_protocol citext NOT NULL,
server_secret bytea NOT NULL,
retries integer NOT NULL,
timeout integer,
CONSTRAINT aaaradiusconfig_1423743495_c CHECK ((length((server_name)::text) <= 50)),
CONSTRAINT aaaradiusconfig_1490061332_c CHECK ((length((server_protocol)::text) <= 10))
);
CREATE TABLE public.aaaremembermeinfo (
id bigint NOT NULL,
user_id bigint NOT NULL,
token citext NOT NULL,
createdtime bigint NOT NULL,
updatedtime bigint NOT NULL,
expiretime bigint NOT NULL,
CONSTRAINT aaaremembermeinfo_80003545_c CHECK ((length((token)::text) <= 100))
);
CREATE TABLE public.aaarole (
role_id bigint NOT NULL,
name citext NOT NULL,
service_id bigint NOT NULL,
description citext DEFAULT 'No Description' NOT NULL,
CONSTRAINT aaarole_2388619_c CHECK ((length((name)::text) <= 250)),
CONSTRAINT aaarole_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.aaarolecategory (
category_id bigint NOT NULL,
name citext NOT NULL,
CONSTRAINT aaarolecategory_2388619_c CHECK ((length((name)::text) <= 50))
);
CREATE TABLE public.aaaroleowner (
role_id bigint NOT NULL,
ownerrole_id bigint NOT NULL
);
CREATE TABLE public.aaaroletocategory (
category_id bigint NOT NULL,
role_id bigint NOT NULL
);
CREATE TABLE public.aaaservice (
service_id bigint NOT NULL,
name citext NOT NULL,
description citext DEFAULT 'No Description' NOT NULL,
CONSTRAINT aaaservice_2388619_c CHECK ((length((name)::text) <= 50)),
CONSTRAINT aaaservice_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.aaaservicepasswordrule (
service_id bigint NOT NULL,
passwdrule_id bigint NOT NULL
);
CREATE TABLE public.aaasimplepermission (
permission_id bigint NOT NULL,
operation_name citext NOT NULL,
CONSTRAINT aaasimplepermission_710638211_c CHECK ((length((operation_name)::text) <= 50))
);
CREATE TABLE public.aaatableaccessspi (
table_name citext NOT NULL,
service_id bigint NOT NULL,
criteria_class citext NOT NULL,
CONSTRAINT aaatableaccessspi_1727487880_c CHECK ((length((criteria_class)::text) <= 150)),
CONSTRAINT aaatableaccessspi_989985668_c CHECK ((length((table_name)::text) <= 50))
);
CREATE TABLE public.aaatablepermission (
permission_id bigint NOT NULL,
table_name citext NOT NULL,
criteria citext,
access_type citext NOT NULL,
CONSTRAINT aaatablepermission_1150145845_c CHECK ((length((access_type)::text) <= 4)),
CONSTRAINT aaatablepermission_989985668_c CHECK ((length((table_name)::text) <= 50))
);
CREATE TABLE public.aaatablereadpermission (
permission_id bigint NOT NULL,
table_name citext NOT NULL,
column_name citext NOT NULL,
CONSTRAINT aaatablereadpermission_1347586516_c CHECK ((length((column_name)::text) <= 50)),
CONSTRAINT aaatablereadpermission_989985668_c CHECK ((length((table_name)::text) <= 50))
);
CREATE TABLE public.aaatableupdatepermission (
permission_id bigint NOT NULL,
table_name citext NOT NULL,
column_name citext NOT NULL,
update_criteria citext,
CONSTRAINT aaatableupdatepermission_1347586516_c CHECK ((length((column_name)::text) <= 50)),
CONSTRAINT aaatableupdatepermission_357377557_c CHECK ((length((update_criteria)::text) <= 250)),
CONSTRAINT aaatableupdatepermission_989985668_c CHECK ((length((table_name)::text) <= 50))
);
CREATE TABLE public.aaatrustedrole (
service_id bigint NOT NULL,
trusted_role_id bigint NOT NULL,
unauth_role_id bigint
);
CREATE TABLE public.aaauser (
user_id bigint NOT NULL,
first_name citext NOT NULL,
middle_name citext,
last_name citext,
createdtime bigint NOT NULL,
description citext DEFAULT 'No Description' NOT NULL,
CONSTRAINT aaauser_1691381003_c CHECK ((length((middle_name)::text) <= 200)),
CONSTRAINT aaauser_353659610_c CHECK ((length((first_name)::text) <= 200)),
CONSTRAINT aaauser_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT aaauser_534302356_c CHECK ((length((last_name)::text) <= 200))
);
CREATE TABLE public.aaauserconfigrecord (
user_id bigint NOT NULL
);
CREATE TABLE public.aaausercontactinfo (
user_id bigint NOT NULL,
contactinfo_id bigint NOT NULL
);
CREATE TABLE public.aaauserpostaladdr (
user_id bigint NOT NULL,
postaladdr_id bigint NOT NULL
);
CREATE TABLE public.aaauserprofile (
user_id bigint NOT NULL,
alias citext,
dob bigint,
gh_id bigint NOT NULL,
timezone citext DEFAULT 'GMT' NOT NULL,
language_code citext DEFAULT 'en',
country_code citext DEFAULT 'US',
CONSTRAINT aaauserprofile_1293600775_c CHECK ((length((timezone)::text) <= 50)),
CONSTRAINT aaauserprofile_1561972108_c CHECK ((length((language_code)::text) <= 2)),
CONSTRAINT aaauserprofile_467061482_c CHECK ((length((country_code)::text) <= 2)),
CONSTRAINT aaauserprofile_62365232_c CHECK ((length((alias)::text) <= 50))
);
CREATE TABLE public.aaauserproperty (
user_id bigint NOT NULL,
prop_name citext NOT NULL,
prop_value citext NOT NULL,
CONSTRAINT aaauserproperty_2087859687_c CHECK ((length((prop_name)::text) <= 50)),
CONSTRAINT aaauserproperty_306528629_c CHECK ((length((prop_value)::text) <= 1000))
);
CREATE TABLE public.aaauserstatus (
user_id bigint NOT NULL,
status citext DEFAULT 'ACTIVE' NOT NULL,
updatedtime bigint NOT NULL,
CONSTRAINT aaauserstatus_1839152142_c CHECK ((length((status)::text) <= 20))
);
CREATE TABLE public.aaausertwofactordetails (
user_id bigint NOT NULL,
enabled boolean DEFAULT false,
twofactorauthimpl citext,
twofactorpassword citext NOT NULL,
CONSTRAINT aaausertwofactordetails_1664934422_c CHECK ((length((twofactorpassword)::text) <= 50)),
CONSTRAINT aaausertwofactordetails_1880838979_c CHECK ((length((twofactorauthimpl)::text) <= 250))
);
CREATE TABLE public.acajaxform (
viewname bigint NOT NULL,
formname citext NOT NULL,
action citext,
method citext DEFAULT 'POST',
onsuccessfunc citext DEFAULT 'AjaxAPI.closeView',
validatefunc citext,
alerttype citext DEFAULT 'Custom',
viewtoforward citext,
statusfunc citext DEFAULT 'AjaxAPI.showRespMsg',
CONSTRAINT acajaxform_1257076047_c CHECK ((length((formname)::text) <= 50)),
CONSTRAINT acajaxform_1325144694_c CHECK ((length((alerttype)::text) <= 50)),
CONSTRAINT acajaxform_1925345846_c CHECK ((length((action)::text) <= 250)),
CONSTRAINT acajaxform_2024225567_c CHECK ((length((method)::text) <= 10)),
CONSTRAINT acajaxform_659726824_c CHECK ((length((onsuccessfunc)::text) <= 100)),
CONSTRAINT acajaxform_733648310_c CHECK ((length((statusfunc)::text) <= 100)),
CONSTRAINT acajaxform_799431365_c CHECK ((length((viewtoforward)::text) <= 50)),
CONSTRAINT acajaxform_895899430_c CHECK ((length((validatefunc)::text) <= 100))
);
CREATE TABLE public.acajaxformoption (
viewname bigint NOT NULL,
formname citext NOT NULL,
name citext NOT NULL,
value citext NOT NULL,
CONSTRAINT acajaxformoption_1257076047_c CHECK ((length((formname)::text) <= 50)),
CONSTRAINT acajaxformoption_2388619_c CHECK ((length((name)::text) <= 50)),
CONSTRAINT acajaxformoption_81434961_c CHECK ((length((value)::text) <= 50))
);
CREATE TABLE public.acajaxoptions (
menuitemid bigint NOT NULL,
onsuccessfunc citext DEFAULT 'AjaxAPI.refreshView',
statusfunc citext DEFAULT 'AjaxAPI.showRespMsg',
CONSTRAINT acajaxoptions_659726824_c CHECK ((length((onsuccessfunc)::text) <= 50)),
CONSTRAINT acajaxoptions_733648310_c CHECK ((length((statusfunc)::text) <= 50))
);
CREATE TABLE public.accesspoint (
ciid bigint NOT NULL
);
CREATE TABLE public.accesspoint_firewall (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.accesspoint_server (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.accesspoint_tech (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.accesspoint_workstation (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.acclientencprops (
acpropid bigint NOT NULL,
paramname citext NOT NULL,
paramvalue citext NOT NULL,
CONSTRAINT acclientencprops_446338168_c CHECK ((length((paramname)::text) <= 100)),
CONSTRAINT acclientencprops_958969092_c CHECK ((length((paramvalue)::text) <= 200))
);
CREATE TABLE public.acclientprops (
acpropid bigint NOT NULL,
paramname citext NOT NULL,
paramvalue citext NOT NULL,
CONSTRAINT acclientprops_446338168_c CHECK ((length((paramname)::text) <= 100)),
CONSTRAINT acclientprops_958969092_c CHECK ((length((paramvalue)::text) <= 200))
);
CREATE TABLE public.accolumnconfiguration (
configname bigint NOT NULL,
columnindex integer NOT NULL,
columnalias citext NOT NULL,
displayname citext,
visible boolean DEFAULT true,
sortenabled boolean DEFAULT true,
transformer citext DEFAULT 'com.adventnet.client.components.table.web.DefaultTransformer',
actionname citext,
searchenabled boolean DEFAULT false,
creatorconfig bigint,
default_text citext,
date_format citext,
trim_length integer,
trim_msg_link citext DEFAULT 'defaultTrimmedMessageDisplayer',
prefix_text citext,
suffix_text citext,
suffix_icon citext,
icon citext,
tablealias citext,
viewname citext,
static_text citext,
isnullable boolean,
cssclass citext,
menuid citext,
isheadervisible boolean DEFAULT true NOT NULL,
autolink boolean DEFAULT false NOT NULL,
replace_text citext,
replace_icon citext,
headercss citext,
actioninvokingstyle citext,
rolename citext,
column_type citext,
isdynamic boolean DEFAULT false NOT NULL,
prefix_link citext,
suffix_link citext,
width bigint,
isexportable boolean DEFAULT true NOT NULL,
ischoosable boolean DEFAULT true,
properties citext,
CONSTRAINT accolumnconfiguration_100625575_c CHECK ((length((suffix_icon)::text) <= 100)),
CONSTRAINT accolumnconfiguration_100720680_c CHECK ((length((suffix_link)::text) <= 75)),
CONSTRAINT accolumnconfiguration_100955483_c CHECK ((length((suffix_text)::text) <= 75)),
CONSTRAINT accolumnconfiguration_1017743550_c CHECK ((length((tablealias)::text) <= 50)),
CONSTRAINT accolumnconfiguration_1226864546_c CHECK ((length((static_text)::text) <= 100)),
CONSTRAINT accolumnconfiguration_1319828634_c CHECK ((length((columnalias)::text) <= 50)),
CONSTRAINT accolumnconfiguration_1347788419_c CHECK ((length((column_type)::text) <= 100)),
CONSTRAINT accolumnconfiguration_1458413992_c CHECK ((length((date_format)::text) <= 100)),
CONSTRAINT accolumnconfiguration_1487031304_c CHECK ((length((replace_text)::text) <= 100)),
CONSTRAINT accolumnconfiguration_1487361212_c CHECK ((length((replace_icon)::text) <= 100)),
CONSTRAINT accolumnconfiguration_153411833_c CHECK ((length((transformer)::text) <= 200)),
CONSTRAINT accolumnconfiguration_1696579723_c CHECK ((length((default_text)::text) <= 100)),
CONSTRAINT accolumnconfiguration_1721661386_c CHECK ((length((headercss)::text) <= 50)),
CONSTRAINT accolumnconfiguration_1837206123_c CHECK ((length((trim_msg_link)::text) <= 100)),
CONSTRAINT accolumnconfiguration_1867784454_c CHECK ((length((actioninvokingstyle)::text) <= 50)),
CONSTRAINT accolumnconfiguration_1957242431_c CHECK ((length((actionname)::text) <= 200)),
CONSTRAINT accolumnconfiguration_1979239088_c CHECK ((length((viewname)::text) <= 100)),
CONSTRAINT accolumnconfiguration_2024392006_c CHECK ((length((menuid)::text) <= 100)),
CONSTRAINT accolumnconfiguration_2241657_c CHECK ((length((icon)::text) <= 100)),
CONSTRAINT accolumnconfiguration_402005675_c CHECK ((length((cssclass)::text) <= 50)),
CONSTRAINT accolumnconfiguration_426904019_c CHECK ((length((displayname)::text) <= 250)),
CONSTRAINT accolumnconfiguration_516800513_c CHECK ((length((rolename)::text) <= 100)),
CONSTRAINT accolumnconfiguration_701130054_c CHECK ((length((prefix_text)::text) <= 75)),
CONSTRAINT accolumnconfiguration_701364857_c CHECK ((length((prefix_link)::text) <= 75))
);
CREATE TABLE public.accolumnconfigurationlist (
name_no bigint NOT NULL,
name citext NOT NULL,
CONSTRAINT accolumnconfigurationlist_2388619_c CHECK ((length((name)::text) <= 50))
);
CREATE TABLE public.accontexthelp (
target_no bigint NOT NULL,
target citext NOT NULL,
url citext NOT NULL,
CONSTRAINT accontexthelp_1827576431_c CHECK ((length((target)::text) <= 50)),
CONSTRAINT accontexthelp_84303_c CHECK ((length((url)::text) <= 100))
);
CREATE TABLE public.accountdefinition (
org_id bigint NOT NULL,
log_logo citext NOT NULL,
head_logo citext NOT NULL,
org_name citext NOT NULL,
hasattachment boolean DEFAULT false NOT NULL,
login_uri citext NOT NULL,
support_email citext,
sendername citext,
defaultsiteid bigint,
ciid bigint NOT NULL,
lastupdatedtime bigint DEFAULT '1' NOT NULL,
CONSTRAINT accountdefinition_1068606294_c CHECK ((length((login_uri)::text) <= 100)),
CONSTRAINT accountdefinition_1469307418_c CHECK ((length((log_logo)::text) <= 100)),
CONSTRAINT accountdefinition_1483431488_c CHECK ((length((sendername)::text) <= 250)),
CONSTRAINT accountdefinition_1697817430_c CHECK ((length((head_logo)::text) <= 100)),
CONSTRAINT accountdefinition_2126713638_c CHECK ((length((org_name)::text) <= 100)),
CONSTRAINT accountdefinition_910621972_c CHECK ((length((support_email)::text) <= 250))
);
CREATE TABLE public.accountsitemapping (
accountid bigint NOT NULL,
siteid bigint NOT NULL
);
CREATE TABLE public.accountsqlstring (
queryid bigint NOT NULL,
sql citext NOT NULL,
CONSTRAINT accountsqlstring_82350_c CHECK ((length((sql)::text) <= 4000))
);
CREATE TABLE public.accriteria (
criteriaid bigint NOT NULL,
logicalrepresentation citext NOT NULL,
CONSTRAINT accriteria_1243883274_c CHECK ((length((logicalrepresentation)::text) <= 100))
);
CREATE TABLE public.accvtabparentconfig (
viewname bigint NOT NULL,
parentviewname bigint NOT NULL
);
CREATE TABLE public.acdropdown (
name_no bigint NOT NULL,
name citext NOT NULL,
cvname citext,
columnforserver citext NOT NULL,
columnforclient citext NOT NULL,
tablename citext,
defaultvalue citext,
selectedkey citext,
onselectmethodname citext,
CONSTRAINT acdropdown_1094424377_c CHECK ((length((onselectmethodname)::text) <= 100)),
CONSTRAINT acdropdown_1687708624_c CHECK ((length((defaultvalue)::text) <= 50)),
CONSTRAINT acdropdown_1921485372_c CHECK ((length((selectedkey)::text) <= 20)),
CONSTRAINT acdropdown_1999964542_c CHECK ((length((cvname)::text) <= 50)),
CONSTRAINT acdropdown_2388619_c CHECK ((length((name)::text) <= 50)),
CONSTRAINT acdropdown_395220330_c CHECK ((length((columnforserver)::text) <= 50)),
CONSTRAINT acdropdown_798830393_c CHECK ((length((tablename)::text) <= 50)),
CONSTRAINT acdropdown_847106274_c CHECK ((length((columnforclient)::text) <= 50))
);
CREATE TABLE public.acdropdownparams (
name bigint NOT NULL,
paramname citext NOT NULL,
mandatory boolean DEFAULT false NOT NULL,
CONSTRAINT acdropdownparams_446338168_c CHECK ((length((paramname)::text) <= 100))
);
CREATE TABLE public.acelement (
name_no bigint NOT NULL,
name citext NOT NULL,
uicreator citext DEFAULT 'com.adventnet.client.components.web.DefaultUICreator' NOT NULL,
validationmethod citext,
alertmessage citext,
type citext,
CONSTRAINT acelement_1107866360_c CHECK ((length((uicreator)::text) <= 200)),
CONSTRAINT acelement_145727701_c CHECK ((length((alertmessage)::text) <= 250)),
CONSTRAINT acelement_1513817446_c CHECK ((length((validationmethod)::text) <= 100)),
CONSTRAINT acelement_2388619_c CHECK ((length((name)::text) <= 50)),
CONSTRAINT acelement_2590522_c CHECK ((length((type)::text) <= 15))
);
CREATE TABLE public.acelementattr (
name bigint NOT NULL,
attrname citext NOT NULL,
attrvalue citext,
CONSTRAINT acelementattr_1337385980_c CHECK ((length((attrname)::text) <= 50)),
CONSTRAINT acelementattr_1483319808_c CHECK ((length((attrvalue)::text) <= 50))
);
CREATE TABLE public.acemailaddress (
mailtoid bigint NOT NULL,
toaddress citext NOT NULL,
CONSTRAINT acemailaddress_1688965895_c CHECK ((length((toaddress)::text) <= 250))
);
CREATE TABLE public.acfeedbackproperties (
messagetime bigint NOT NULL,
property_name citext NOT NULL,
property_value citext NOT NULL,
CONSTRAINT acfeedbackproperties_1496077927_c CHECK ((length((property_value)::text) <= 250)),
CONSTRAINT acfeedbackproperties_2126232245_c CHECK ((length((property_name)::text) <= 50))
);
CREATE TABLE public.acfilter (
listid bigint NOT NULL,
groupname citext NOT NULL,
filtername citext NOT NULL,
displayname citext NOT NULL,
filterindex integer,
criteriaid bigint,
queryid bigint,
createdby bigint,
empty_message_id bigint,
CONSTRAINT acfilter_1067207165_c CHECK ((length((filtername)::text) <= 50)),
CONSTRAINT acfilter_1304373610_c CHECK ((length((groupname)::text) <= 50)),
CONSTRAINT acfilter_426904019_c CHECK ((length((displayname)::text) <= 100))
);
CREATE TABLE public.acfilterconfig (
id bigint NOT NULL,
colindex bigint NOT NULL,
tablealias citext NOT NULL,
tablename citext,
colname citext NOT NULL,
displayname citext NOT NULL,
filtertype citext NOT NULL,
alloweddispcol citext,
showallowedvalues citext DEFAULT 'none',
allowedvaltbl citext,
allowedvalcol citext,
classname citext,
CONSTRAINT acfilterconfig_1017743550_c CHECK ((length((tablealias)::text) <= 50)),
CONSTRAINT acfilterconfig_1067005262_c CHECK ((length((filtertype)::text) <= 50)),
CONSTRAINT acfilterconfig_1517307933_c CHECK ((length((classname)::text) <= 100)),
CONSTRAINT acfilterconfig_1667483627_c CHECK ((length((colname)::text) <= 50)),
CONSTRAINT acfilterconfig_1965266503_c CHECK ((length((allowedvalcol)::text) <= 50)),
CONSTRAINT acfilterconfig_1965282437_c CHECK ((length((allowedvaltbl)::text) <= 50)),
CONSTRAINT acfilterconfig_1974302515_c CHECK ((length((showallowedvalues)::text) <= 50)),
CONSTRAINT acfilterconfig_2060571146_c CHECK ((length((alloweddispcol)::text) <= 50)),
CONSTRAINT acfilterconfig_426904019_c CHECK ((length((displayname)::text) <= 250)),
CONSTRAINT acfilterconfig_798830393_c CHECK ((length((tablename)::text) <= 50))
);
CREATE TABLE public.acfilterconfiglist (
id bigint NOT NULL,
name citext NOT NULL,
viewname citext DEFAULT 'FilterCreateForm',
CONSTRAINT acfilterconfiglist_1979239088_c CHECK ((length((viewname)::text) <= 50)),
CONSTRAINT acfilterconfiglist_2388619_c CHECK ((length((name)::text) <= 50))
);
CREATE TABLE public.acfiltergroup (
listid bigint NOT NULL,
groupname citext NOT NULL,
displayname citext,
grpindex integer NOT NULL,
CONSTRAINT acfiltergroup_1304373610_c CHECK ((length((groupname)::text) <= 50)),
CONSTRAINT acfiltergroup_426904019_c CHECK ((length((displayname)::text) <= 100))
);
CREATE TABLE public.acfilterlist (
listid bigint NOT NULL,
listname citext NOT NULL,
description citext,
CONSTRAINT acfilterlist_2129042473_c CHECK ((length((listname)::text) <= 50)),
CONSTRAINT acfilterlist_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.acformconfig (
name bigint NOT NULL,
isreadmode boolean DEFAULT false,
columnconfiglist bigint,
layoutconfiglist bigint,
jsfilename citext,
actionlink citext,
target citext,
formtype citext,
cvname bigint,
successmessage citext,
failuremessage citext,
alerttype citext DEFAULT 'Default',
CONSTRAINT acformconfig_1255357635_c CHECK ((length((failuremessage)::text) <= 250)),
CONSTRAINT acformconfig_1257277950_c CHECK ((length((formtype)::text) <= 50)),
CONSTRAINT acformconfig_1304104368_c CHECK ((length((jsfilename)::text) <= 100)),
CONSTRAINT acformconfig_1325144694_c CHECK ((length((alerttype)::text) <= 50)),
CONSTRAINT acformconfig_1668688548_c CHECK ((length((successmessage)::text) <= 250)),
CONSTRAINT acformconfig_1827576431_c CHECK ((length((target)::text) <= 50)),
CONSTRAINT acformconfig_1957294288_c CHECK ((length((actionlink)::text) <= 100))
);
CREATE TABLE public.acftpdetails (
id bigint NOT NULL,
schedule_name citext,
server citext NOT NULL,
username citext,
password citext,
remote_directory citext,
CONSTRAINT acftpdetails_1092029036_c CHECK ((length((remote_directory)::text) <= 50)),
CONSTRAINT acftpdetails_1852497085_c CHECK ((length((server)::text) <= 50)),
CONSTRAINT acftpdetails_1999612571_c CHECK ((length((password)::text) <= 50)),
CONSTRAINT acftpdetails_516913366_c CHECK ((length((username)::text) <= 50)),
CONSTRAINT acftpdetails_528461619_c CHECK ((length((schedule_name)::text) <= 50))
);
CREATE TABLE public.acfunctioncolumns (
viewname bigint NOT NULL,
tablealias citext NOT NULL,
columnname citext NOT NULL,
columnalias citext NOT NULL,
functionname citext NOT NULL,
CONSTRAINT acfunctioncolumns_1017743550_c CHECK ((length((tablealias)::text) <= 50)),
CONSTRAINT acfunctioncolumns_1319828634_c CHECK ((length((columnalias)::text) <= 50)),
CONSTRAINT acfunctioncolumns_1619616031_c CHECK ((length((columnname)::text) <= 50)),
CONSTRAINT acfunctioncolumns_2106862179_c CHECK ((length((functionname)::text) <= 50))
);
CREATE TABLE public.acgridlayoutchildconfig (
viewname bigint NOT NULL,
childviewname bigint NOT NULL,
childindex integer NOT NULL,
showinbox citext,
isopen boolean DEFAULT true,
CONSTRAINT acgridlayoutchildconfig_892317065_c CHECK ((length((showinbox)::text) <= 50))
);
CREATE TABLE public.acgridlayoutconfig (
viewname bigint NOT NULL,
columncount integer NOT NULL
);
CREATE TABLE public.acgroupbycolumns (
viewname bigint NOT NULL,
tablealias citext NOT NULL,
columnname citext NOT NULL,
columnalias citext NOT NULL,
CONSTRAINT acgroupbycolumns_1017743550_c CHECK ((length((tablealias)::text) <= 50)),
CONSTRAINT acgroupbycolumns_1319828634_c CHECK ((length((columnalias)::text) <= 50)),
CONSTRAINT acgroupbycolumns_1619616031_c CHECK ((length((columnname)::text) <= 50))
);
CREATE TABLE public.acinstantfeedback (
username citext NOT NULL,
fromaddress citext NOT NULL,
toaddress citext NOT NULL,
subject citext NOT NULL,
comments citext,
stacktrace citext,
clientstate citext,
messagetime_no bigint NOT NULL,
messagetime bigint,
status boolean DEFAULT false,
replyto citext NOT NULL,
context_name citext NOT NULL,
CONSTRAINT acinstantfeedback_1149902580_c CHECK ((length((subject)::text) <= 150)),
CONSTRAINT acinstantfeedback_1688965895_c CHECK ((length((toaddress)::text) <= 50)),
CONSTRAINT acinstantfeedback_1754042435_c CHECK ((length((stacktrace)::text) <= 4000)),
CONSTRAINT acinstantfeedback_180211188_c CHECK ((length((comments)::text) <= 4000)),
CONSTRAINT acinstantfeedback_1812503237_c CHECK ((length((replyto)::text) <= 50)),
CONSTRAINT acinstantfeedback_1997736838_c CHECK ((length((clientstate)::text) <= 4000)),
CONSTRAINT acinstantfeedback_516913366_c CHECK ((length((username)::text) <= 50)),
CONSTRAINT acinstantfeedback_599063318_c CHECK ((length((fromaddress)::text) <= 50)),
CONSTRAINT acinstantfeedback_831386821_c CHECK ((length((context_name)::text) <= 50))
);
CREATE TABLE public.acjsoption (
menuitemid bigint NOT NULL,
name citext NOT NULL,
value citext NOT NULL,
CONSTRAINT acjsoption_2388619_c CHECK ((length((name)::text) <= 50)),
CONSTRAINT acjsoption_81434961_c CHECK ((length((value)::text) <= 50))
);
CREATE TABLE public.aclink (
viewname bigint NOT NULL,
menuitemid bigint NOT NULL,
menuitemindex integer NOT NULL,
createdby bigint
);
CREATE TABLE public.aclinkparams (
configname bigint NOT NULL,
columnalias citext NOT NULL,
name citext NOT NULL,
paramindex integer DEFAULT 0 NOT NULL,
value citext,
scope citext DEFAULT 'STATIC',
CONSTRAINT aclinkparams_1319828634_c CHECK ((length((columnalias)::text) <= 50)),
CONSTRAINT aclinkparams_2388619_c CHECK ((length((name)::text) <= 50)),
CONSTRAINT aclinkparams_78726708_c CHECK ((length((scope)::text) <= 100)),
CONSTRAINT aclinkparams_81434961_c CHECK ((length((value)::text) <= 80))
);
CREATE TABLE public.acmailconfig (
context_name_no bigint NOT NULL,
context_name citext,
fromaddress citext,
toaddress citext NOT NULL,
server citext NOT NULL,
username citext,
password citext,
port integer DEFAULT 25 NOT NULL,
CONSTRAINT acmailconfig_1688965895_c CHECK ((length((toaddress)::text) <= 500)),
CONSTRAINT acmailconfig_1852497085_c CHECK ((length((server)::text) <= 50)),
CONSTRAINT acmailconfig_1999612571_c CHECK ((length((password)::text) <= 50)),
CONSTRAINT acmailconfig_516913366_c CHECK ((length((username)::text) <= 50)),
CONSTRAINT acmailconfig_599063318_c CHECK ((length((fromaddress)::text) <= 50)),
CONSTRAINT acmailconfig_831386821_c CHECK ((length((context_name)::text) <= 50))
);
CREATE TABLE public.acnavigationconfiguration (
name_no bigint NOT NULL,
name citext NOT NULL,
navigationtype citext DEFAULT 'NORMAL',
nocount citext DEFAULT 'false',
orientation citext DEFAULT 'TOP',
templatename citext,
CONSTRAINT acnavigationconfiguration_1342071301_c CHECK ((length((templatename)::text) <= 250)),
CONSTRAINT acnavigationconfiguration_1463140402_c CHECK ((length((nocount)::text) <= 25)),
CONSTRAINT acnavigationconfiguration_2008657074_c CHECK ((length((navigationtype)::text) <= 100)),
CONSTRAINT acnavigationconfiguration_2388619_c CHECK ((length((name)::text) <= 50)),
CONSTRAINT acnavigationconfiguration_713460144_c CHECK ((length((orientation)::text) <= 25))
);
CREATE TABLE public.acpagelengthconfig (
name bigint NOT NULL,
pagelength integer NOT NULL
);
CREATE TABLE public.acpanelelement (
name bigint NOT NULL,
childelement bigint NOT NULL,
buttonindex integer NOT NULL
);
CREATE TABLE public.acparams (
menuitemid bigint NOT NULL,
name citext NOT NULL,
paramindex integer DEFAULT 0 NOT NULL,
value citext,
scope citext DEFAULT 'STATIC',
CONSTRAINT acparams_2388619_c CHECK ((length((name)::text) <= 50)),
CONSTRAINT acparams_78726708_c CHECK ((length((scope)::text) <= 100)),
CONSTRAINT acparams_81434961_c CHECK ((length((value)::text) <= 100))
);
CREATE TABLE public.acpsconfiglist (
name_no bigint NOT NULL,
name citext NOT NULL,
CONSTRAINT acpsconfiglist_2388619_c CHECK ((length((name)::text) <= 50))
);
CREATE TABLE public.acpsconfiguration (
configname bigint NOT NULL,
columnindex integer NOT NULL,
rowindex integer NOT NULL,
colspan integer DEFAULT 1,
rowspan integer DEFAULT 1,
datatype citext NOT NULL,
datavalue citext NOT NULL,
width integer,
height integer,
creatorconfig bigint,
CONSTRAINT acpsconfiguration_1722316316_c CHECK ((length((datatype)::text) <= 50)),
CONSTRAINT acpsconfiguration_1851069465_c CHECK ((length((datavalue)::text) <= 250))
);
CREATE TABLE public.acrelationalcriteria (
criteriaid bigint NOT NULL,
relationalcriteriaid bigint NOT NULL,
tablealias citext,
columnname citext,
comparator integer,
value citext,
casesensitive boolean DEFAULT true NOT NULL,
CONSTRAINT acrelationalcriteria_1017743550_c CHECK ((length((tablealias)::text) <= 50)),
CONSTRAINT acrelationalcriteria_1619616031_c CHECK ((length((columnname)::text) <= 50)),
CONSTRAINT acrelationalcriteria_81434961_c CHECK ((length((value)::text) <= 50))
);
CREATE TABLE public.acrendererconfiguration (
configname bigint NOT NULL,
columnalias citext NOT NULL,
propertyname citext NOT NULL,
propertyvalue citext,
CONSTRAINT acrendererconfiguration_1319828634_c CHECK ((length((columnalias)::text) <= 50)),
CONSTRAINT acrendererconfiguration_1453542880_c CHECK ((length((propertyname)::text) <= 50)),
CONSTRAINT acrendererconfiguration_2117544092_c CHECK ((length((propertyvalue)::text) <= 150))
);
CREATE TABLE public.acsqlstring (
queryid bigint NOT NULL,
sql citext NOT NULL,
groupbyused boolean DEFAULT false NOT NULL,
isunion boolean DEFAULT false NOT NULL
);
CREATE TABLE public.acsumsqlstring (
queryid bigint NOT NULL,
sql citext NOT NULL,
CONSTRAINT acsumsqlstring_82350_c CHECK ((length((sql)::text) <= 4000))
);
CREATE TABLE public.actabchildconfig (
viewname bigint NOT NULL,
childviewname bigint NOT NULL,
childindex integer NOT NULL,
dropdownview bigint,
dropdowntab bigint,
dropdownmenu bigint,
dropdownparams citext DEFAULT 'displayType=onImageMouseOver' NOT NULL,
ajaxparams citext,
displayname citext,
CONSTRAINT actabchildconfig_33783898_c CHECK ((length((ajaxparams)::text) <= 250)),
CONSTRAINT actabchildconfig_390721321_c CHECK ((length((dropdownparams)::text) <= 250)),
CONSTRAINT actabchildconfig_426904019_c CHECK ((length((displayname)::text) <= 50))
);
CREATE TABLE public.actablecolumns (
viewname bigint NOT NULL,
columnindex integer NOT NULL,
columnalias citext NOT NULL,
displayname citext,
visible boolean DEFAULT true,
width bigint,
redact_type citext,
CONSTRAINT actablecolumns_1201572264_c CHECK ((length((redact_type)::text) <= 50)),
CONSTRAINT actablecolumns_1319828634_c CHECK ((length((columnalias)::text) <= 50)),
CONSTRAINT actablecolumns_426904019_c CHECK ((length((displayname)::text) <= 250))
);
CREATE TABLE public.actablefilterlistrel (
viewname bigint NOT NULL,
filterlistid bigint NOT NULL,
defaultfiltername citext NOT NULL,
filterconfiglistname bigint,
iscustomfilter boolean DEFAULT false,
filteruitype citext DEFAULT 'NORMAL' NOT NULL,
linkedviewname citext,
CONSTRAINT actablefilterlistrel_1119120710_c CHECK ((length((filteruitype)::text) <= 20)),
CONSTRAINT actablefilterlistrel_1203291191_c CHECK ((length((linkedviewname)::text) <= 50)),
CONSTRAINT actablefilterlistrel_980132580_c CHECK ((length((defaultfiltername)::text) <= 50))
);
CREATE TABLE public.actablelayoutchildconfig (
viewname bigint NOT NULL,
childviewname bigint NOT NULL,
rowindex integer NOT NULL,
columnindex integer NOT NULL,
colspan integer DEFAULT 1,
rowspan integer DEFAULT 1,
width citext,
height citext,
showinbox citext,
isopen boolean DEFAULT true,
CONSTRAINT actablelayoutchildconfig_2127267111_c CHECK ((length((height)::text) <= 10)),
CONSTRAINT actablelayoutchildconfig_82589094_c CHECK ((length((width)::text) <= 10)),
CONSTRAINT actablelayoutchildconfig_892317065_c CHECK ((length((showinbox)::text) <= 50))
);
CREATE TABLE public.actableviewconfig (
name bigint NOT NULL,
cvname bigint,
navigationconfig bigint,
columnconfiglist bigint,
psconfiglist bigint,
empty_table_message citext,
displaytype citext DEFAULT 'Horizontal',
columnchoosermenuitem bigint,
enablerowselection citext DEFAULT 'CHECKBOX',
rendermenu boolean DEFAULT false,
datasourcename citext,
pagelength integer,
sortcolumn citext,
sortorder citext,
enablerowhover boolean DEFAULT false,
enableexport boolean DEFAULT false,
displayheader boolean DEFAULT true,
customtablemodelrenderer citext DEFAULT 'com.adventnet.client.components.table.web.DefaultCustomTableModelRenderer',
hlsearch boolean DEFAULT false,
isadvancedsearch boolean DEFAULT false,
shownavig boolean DEFAULT false,
rowtransformer citext,
isscrollenabled boolean DEFAULT false,
initialfetchedrows integer DEFAULT '-1',
templateviewname citext,
empty_message_id bigint,
CONSTRAINT actableviewconfig_1119869872_c CHECK ((length((datasourcename)::text) <= 50)),
CONSTRAINT actableviewconfig_1505594288_c CHECK ((length((sortorder)::text) <= 10)),
CONSTRAINT actableviewconfig_1610247466_c CHECK ((length((templateviewname)::text) <= 50)),
CONSTRAINT actableviewconfig_1711428865_c CHECK ((length((rowtransformer)::text) <= 200)),
CONSTRAINT actableviewconfig_178215153_c CHECK ((length((customtablemodelrenderer)::text) <= 250)),
CONSTRAINT actableviewconfig_225150580_c CHECK ((length((sortcolumn)::text) <= 50)),
CONSTRAINT actableviewconfig_426702116_c CHECK ((length((displaytype)::text) <= 20)),
CONSTRAINT actableviewconfig_588630844_c CHECK ((length((empty_table_message)::text) <= 250)),
CONSTRAINT actableviewconfig_85393909_c CHECK ((length((enablerowselection)::text) <= 20))
);
CREATE TABLE public.actemplatehandler (
id bigint NOT NULL,
handlername citext NOT NULL,
classname citext NOT NULL,
CONSTRAINT actemplatehandler_1517307933_c CHECK ((length((classname)::text) <= 250)),
CONSTRAINT actemplatehandler_631131979_c CHECK ((length((handlername)::text) <= 50))
);
CREATE TABLE public.action (
menuitemid bigint NOT NULL,
forward citext,
type citext,
name citext,
input citext,
validated citext,
CONSTRAINT action_1676810734_c CHECK ((length((validated)::text) <= 100)),
CONSTRAINT action_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT action_2590522_c CHECK ((length((type)::text) <= 100)),
CONSTRAINT action_40836773_c CHECK ((length((forward)::text) <= 100)),
CONSTRAINT action_69820330_c CHECK ((length((input)::text) <= 100))
);
CREATE TABLE public.actionablecard_notifications (
notificationid bigint NOT NULL,
serviceid bigint NOT NULL,
notify_type citext NOT NULL,
isenabled boolean DEFAULT true NOT NULL,
hide_orginal_body boolean DEFAULT true NOT NULL,
CONSTRAINT actionablecard_notifications_439900784_c CHECK ((length((notify_type)::text) <= 100))
);
CREATE TABLE public.actionname (
uid bigint NOT NULL,
actionname citext NOT NULL,
description citext NOT NULL,
module citext NOT NULL,
interestedfor integer NOT NULL,
CONSTRAINT actionname_1957242431_c CHECK ((length((actionname)::text) <= 200)),
CONSTRAINT actionname_2015454612_c CHECK ((length((module)::text) <= 200)),
CONSTRAINT actionname_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.actionsperformed (
uid bigint NOT NULL,
year integer NOT NULL,
month citext NOT NULL,
actionid bigint NOT NULL,
subactionid bigint,
techcount bigint NOT NULL,
requestercount bigint NOT NULL,
CONSTRAINT actionsperformed_73542240_c CHECK ((length((month)::text) <= 25))
);
CREATE TABLE public.activedirectoryinfo (
ad_id bigint NOT NULL,
servername citext,
defaultdomain citext,
username citext,
password citext,
secondaryservername citext,
isssl boolean DEFAULT false,
port integer,
CONSTRAINT activedirectoryinfo_1340064690_c CHECK ((length((servername)::text) <= 100)),
CONSTRAINT activedirectoryinfo_1999612571_c CHECK ((length((password)::text) <= 50)),
CONSTRAINT activedirectoryinfo_276975141_c CHECK ((length((defaultdomain)::text) <= 50)),
CONSTRAINT activedirectoryinfo_516913366_c CHECK ((length((username)::text) <= 50)),
CONSTRAINT activedirectoryinfo_999957666_c CHECK ((length((secondaryservername)::text) <= 250))
);
CREATE TABLE public.acuserclientstate (
account_id bigint NOT NULL,
selectedtheme bigint,
modtime bigint DEFAULT '-1' NOT NULL
);
CREATE TABLE public.acuserfiltergroup (
listid bigint NOT NULL,
groupname citext NOT NULL,
CONSTRAINT acuserfiltergroup_1304373610_c CHECK ((length((groupname)::text) <= 50))
);
CREATE TABLE public.acuserpreference (
account_id bigint NOT NULL,
prefname citext NOT NULL,
value citext,
CONSTRAINT acuserpreference_505789650_c CHECK ((length((prefname)::text) <= 50)),
CONSTRAINT acuserpreference_81434961_c CHECK ((length((value)::text) <= 100))
);
CREATE TABLE public.acusertabchildconfig (
viewname bigint NOT NULL,
childviewname bigint NOT NULL,
childindex integer NOT NULL,
account_id bigint NOT NULL,
displayname citext,
CONSTRAINT acusertabchildconfig_426904019_c CHECK ((length((displayname)::text) <= 50))
);
CREATE TABLE public.acviewtogroupmapping (
viewname bigint NOT NULL,
groupname citext NOT NULL,
CONSTRAINT acviewtogroupmapping_1304373610_c CHECK ((length((groupname)::text) <= 50))
);
CREATE TABLE public.adauthenticationinfo (
domain_id bigint NOT NULL
);
CREATE TABLE public.adconfig (
adconfigid bigint NOT NULL,
parameter citext NOT NULL,
paramvalue citext NOT NULL,
description citext DEFAULT '-' NOT NULL,
CONSTRAINT adconfig_428414940_c CHECK ((length((description)::text) <= 200)),
CONSTRAINT adconfig_446088073_c CHECK ((length((parameter)::text) <= 100)),
CONSTRAINT adconfig_958969092_c CHECK ((length((paramvalue)::text) <= 500))
);
CREATE TABLE public.adconfigtechdeletecount (
id bigint NOT NULL,
count bigint,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.additionalviewparams (
viewname bigint NOT NULL,
paramname citext NOT NULL,
paramindex integer DEFAULT 0 NOT NULL,
paramvalue citext,
CONSTRAINT additionalviewparams_446338168_c CHECK ((length((paramname)::text) <= 100)),
CONSTRAINT additionalviewparams_958969092_c CHECK ((length((paramvalue)::text) <= 100))
);
CREATE TABLE public.adminaudithistory (
historyid bigint NOT NULL,
entity citext NOT NULL,
module citext,
entityid bigint NOT NULL,
helpdeskid bigint,
operation citext NOT NULL,
operationownerid bigint NOT NULL,
operationtime bigint NOT NULL,
comment citext,
ipaddress citext,
useragent citext,
siteid bigint,
CONSTRAINT adminaudithistory_1538992947_c CHECK ((length((ipaddress)::text) <= 250)),
CONSTRAINT adminaudithistory_154330439_c CHECK ((length((operation)::text) <= 100)),
CONSTRAINT adminaudithistory_1668381247_c CHECK ((length((comment)::text) <= 500)),
CONSTRAINT adminaudithistory_2015454612_c CHECK ((length((module)::text) <= 250)),
CONSTRAINT adminaudithistory_2050021347_c CHECK ((length((entity)::text) <= 250))
);
CREATE TABLE public.adminaudithistorydiff (
historydiffid bigint NOT NULL,
historyid bigint NOT NULL,
columnname citext NOT NULL,
prev_value citext,
current_value citext,
prev_encrypted_value bytea,
current_encrypted_value bytea,
helpdeskid bigint
);
CREATE TABLE public.adminaudithistoryjson (
historyjsonid bigint NOT NULL,
historyid bigint NOT NULL,
jsonvalue citext,
helpdeskid bigint
);
CREATE TABLE public.adorganizationalunits (
ouid bigint NOT NULL,
ouname citext NOT NULL,
adspath citext NOT NULL,
isusersimported boolean DEFAULT false NOT NULL,
iscomputersimported boolean DEFAULT false NOT NULL,
domainid bigint NOT NULL,
distinguished_name citext,
object_guid citext,
is_deleted integer DEFAULT 0 NOT NULL,
CONSTRAINT adorganizationalunits_1952376463_c CHECK ((length((ouname)::text) <= 100)),
CONSTRAINT adorganizationalunits_700803142_c CHECK ((length((distinguished_name)::text) <= 1000)),
CONSTRAINT adorganizationalunits_904945545_c CHECK ((length((object_guid)::text) <= 250))
);
CREATE TABLE public.adousrelationinfo (
ouid bigint NOT NULL,
parentouid bigint NOT NULL
);
CREATE TABLE public.adsadcomputergeneraldetails (
unique_id bigint NOT NULL,
common_name citext NOT NULL,
full_name citext NOT NULL,
dns_name citext,
distinguished_name citext NOT NULL,
sam_account_name citext NOT NULL,
when_created bigint DEFAULT '0',
when_changed bigint DEFAULT '0',
object_class citext,
object_guid citext,
sid_string citext NOT NULL,
is_deleted integer DEFAULT 0 NOT NULL,
primary_group_id citext,
manager citext,
manager_dn citext,
domain_id bigint,
CONSTRAINT adsadcomputergeneraldetails_1138971195_c CHECK ((length((full_name)::text) <= 250)),
CONSTRAINT adsadcomputergeneraldetails_1190891714_c CHECK ((length((sid_string)::text) <= 250)),
CONSTRAINT adsadcomputergeneraldetails_1224171521_c CHECK ((length((dns_name)::text) <= 250)),
CONSTRAINT adsadcomputergeneraldetails_1314715012_c CHECK ((length((manager_dn)::text) <= 1000)),
CONSTRAINT adsadcomputergeneraldetails_1352889528_c CHECK ((length((primary_group_id)::text) <= 250)),
CONSTRAINT adsadcomputergeneraldetails_1553243021_c CHECK ((length((manager)::text) <= 250)),
CONSTRAINT adsadcomputergeneraldetails_2015428520_c CHECK ((length((object_class)::text) <= 250)),
CONSTRAINT adsadcomputergeneraldetails_257558623_c CHECK ((length((common_name)::text) <= 250)),
CONSTRAINT adsadcomputergeneraldetails_700803142_c CHECK ((length((distinguished_name)::text) <= 250)),
CONSTRAINT adsadcomputergeneraldetails_843238909_c CHECK ((length((sam_account_name)::text) <= 250)),
CONSTRAINT adsadcomputergeneraldetails_904945545_c CHECK ((length((object_guid)::text) <= 250))
);
CREATE TABLE public.adsadcontactgeneraldetails (
unique_id bigint NOT NULL,
common_name citext NOT NULL,
full_name citext NOT NULL,
display_name citext,
distinguished_name citext NOT NULL,
when_created bigint DEFAULT '0',
when_changed bigint DEFAULT '0',
object_class citext,
object_guid citext,
is_deleted integer DEFAULT 0 NOT NULL,
manager citext,
manager_dn citext,
domain_id bigint,
CONSTRAINT adsadcontactgeneraldetails_1138971195_c CHECK ((length((full_name)::text) <= 250)),
CONSTRAINT adsadcontactgeneraldetails_1314715012_c CHECK ((length((manager_dn)::text) <= 1000)),
CONSTRAINT adsadcontactgeneraldetails_1553243021_c CHECK ((length((manager)::text) <= 250)),
CONSTRAINT adsadcontactgeneraldetails_2015428520_c CHECK ((length((object_class)::text) <= 250)),
CONSTRAINT adsadcontactgeneraldetails_257558623_c CHECK ((length((common_name)::text) <= 250)),
CONSTRAINT adsadcontactgeneraldetails_333046776_c CHECK ((length((display_name)::text) <= 250)),
CONSTRAINT adsadcontactgeneraldetails_700803142_c CHECK ((length((distinguished_name)::text) <= 250)),
CONSTRAINT adsadcontactgeneraldetails_904945545_c CHECK ((length((object_guid)::text) <= 250))
);
CREATE TABLE public.adsadgroupgeneraldetails (
unique_id bigint NOT NULL,
common_name citext NOT NULL,
full_name citext NOT NULL,
distinguished_name citext NOT NULL,
sam_account_name citext NOT NULL,
when_created bigint DEFAULT '0',
when_changed bigint DEFAULT '0',
object_class citext,
object_guid citext,
sid_string citext NOT NULL,
is_deleted integer DEFAULT 0 NOT NULL,
group_type citext,
manager citext,
manager_dn citext,
domain_id bigint,
CONSTRAINT adsadgroupgeneraldetails_1138971195_c CHECK ((length((full_name)::text) <= 250)),
CONSTRAINT adsadgroupgeneraldetails_1190891714_c CHECK ((length((sid_string)::text) <= 250)),
CONSTRAINT adsadgroupgeneraldetails_1314715012_c CHECK ((length((manager_dn)::text) <= 1000)),
CONSTRAINT adsadgroupgeneraldetails_1553243021_c CHECK ((length((manager)::text) <= 250)),
CONSTRAINT adsadgroupgeneraldetails_1797154074_c CHECK ((length((group_type)::text) <= 250)),
CONSTRAINT adsadgroupgeneraldetails_2015428520_c CHECK ((length((object_class)::text) <= 250)),
CONSTRAINT adsadgroupgeneraldetails_257558623_c CHECK ((length((common_name)::text) <= 250)),
CONSTRAINT adsadgroupgeneraldetails_700803142_c CHECK ((length((distinguished_name)::text) <= 250)),
CONSTRAINT adsadgroupgeneraldetails_843238909_c CHECK ((length((sam_account_name)::text) <= 250)),
CONSTRAINT adsadgroupgeneraldetails_904945545_c CHECK ((length((object_guid)::text) <= 250))
);
CREATE TABLE public.adsadougeneraldetails (
unique_id bigint NOT NULL,
common_name citext NOT NULL,
full_name citext NOT NULL,
distinguished_name citext NOT NULL,
when_created bigint DEFAULT '0',
when_changed bigint DEFAULT '0',
object_class citext,
object_guid citext,
is_deleted integer DEFAULT 0 NOT NULL,
domain_id bigint,
CONSTRAINT adsadougeneraldetails_1138971195_c CHECK ((length((full_name)::text) <= 250)),
CONSTRAINT adsadougeneraldetails_2015428520_c CHECK ((length((object_class)::text) <= 250)),
CONSTRAINT adsadougeneraldetails_257558623_c CHECK ((length((common_name)::text) <= 250)),
CONSTRAINT adsadougeneraldetails_700803142_c CHECK ((length((distinguished_name)::text) <= 250)),
CONSTRAINT adsadougeneraldetails_904945545_c CHECK ((length((object_guid)::text) <= 250))
);
CREATE TABLE public.adsadsyncaudit (
audit_id bigint NOT NULL,
domain_id bigint,
domain_name citext NOT NULL,
sync_start_time timestamp without time zone NOT NULL,
sync_end_time timestamp without time zone NOT NULL,
last_method_used citext NOT NULL,
is_full_sync boolean DEFAULT false NOT NULL,
is_other_objs_sync boolean DEFAULT false NOT NULL,
status_message citext NOT NULL,
error_message citext,
CONSTRAINT adsadsyncaudit_1112843408_c CHECK ((length((error_message)::text) <= 250)),
CONSTRAINT adsadsyncaudit_1806529586_c CHECK ((length((last_method_used)::text) <= 10)),
CONSTRAINT adsadsyncaudit_1810162842_c CHECK ((length((status_message)::text) <= 10)),
CONSTRAINT adsadsyncaudit_2008335066_c CHECK ((length((domain_name)::text) <= 250))
);
CREATE TABLE public.adsadsynchronization (
ad_sync_id bigint NOT NULL,
object_id bigint,
domain_name citext NOT NULL,
domain_id bigint,
default_objs_refreshed_time bigint NOT NULL,
other_objs_refreshed_time bigint NOT NULL,
full_refreshed_time bigint NOT NULL,
data_sync_id integer DEFAULT 0 NOT NULL,
CONSTRAINT adsadsynchronization_2008335066_c CHECK ((length((domain_name)::text) <= 250))
);
CREATE TABLE public.adsadsyncmultidcresults (
unique_id bigint NOT NULL,
ad_sync_id bigint NOT NULL,
object_id bigint NOT NULL,
base_dn citext NOT NULL,
object_type citext NOT NULL,
last_method_used citext NOT NULL,
cookie_value citext,
cookie_dc_name citext,
usn_value bigint DEFAULT '0' NOT NULL,
usn_dc_name citext,
dc_name citext,
table_name citext,
invocation_id citext,
sync_time bigint DEFAULT '0',
full_refreshed_time bigint NOT NULL,
CONSTRAINT adsadsyncmultidcresults_1729862512_c CHECK ((length((cookie_dc_name)::text) <= 250)),
CONSTRAINT adsadsyncmultidcresults_1806529586_c CHECK ((length((last_method_used)::text) <= 10)),
CONSTRAINT adsadsyncmultidcresults_2065982901_c CHECK ((length((dc_name)::text) <= 250)),
CONSTRAINT adsadsyncmultidcresults_385396920_c CHECK ((length((base_dn)::text) <= 250)),
CONSTRAINT adsadsyncmultidcresults_503047556_c CHECK ((length((usn_dc_name)::text) <= 250)),
CONSTRAINT adsadsyncmultidcresults_844366038_c CHECK ((length((invocation_id)::text) <= 100)),
CONSTRAINT adsadsyncmultidcresults_905336890_c CHECK ((length((object_type)::text) <= 80)),
CONSTRAINT adsadsyncmultidcresults_989985668_c CHECK ((length((table_name)::text) <= 250))
);
CREATE TABLE public.adsadsyncmultidcresultsaudit (
audit_id bigint NOT NULL,
reg_id bigint NOT NULL,
dc_name citext NOT NULL,
sync_end_time timestamp without time zone NOT NULL,
is_success boolean DEFAULT false NOT NULL,
status_message citext NOT NULL,
CONSTRAINT adsadsyncmultidcresultsaudit_1810162842_c CHECK ((length((status_message)::text) <= 250)),
CONSTRAINT adsadsyncmultidcresultsaudit_2065982901_c CHECK ((length((dc_name)::text) <= 250))
);
CREATE TABLE public.adsadsyncobjattributes (
object_id bigint NOT NULL,
attrib_ldap_name citext NOT NULL,
CONSTRAINT adsadsyncobjattributes_421425390_c CHECK ((length((attrib_ldap_name)::text) <= 250))
);
CREATE TABLE public.adsadsyncobjects (
object_id bigint NOT NULL,
domain_id bigint,
object_type citext NOT NULL,
search_string citext NOT NULL,
is_enabled boolean DEFAULT true NOT NULL,
is_full_refreseh_enabled boolean DEFAULT true NOT NULL,
is_functional_level_based boolean DEFAULT false NOT NULL,
priority_id bigint NOT NULL,
base_dn citext,
search_preference bigint DEFAULT '0' NOT NULL,
exclude_subtree_search boolean DEFAULT false NOT NULL,
is_multi_dc_sync boolean DEFAULT false NOT NULL,
is_custom_sync boolean DEFAULT false NOT NULL,
sync_retrieval_method citext,
is_parallel_sync_allowed boolean DEFAULT true NOT NULL,
CONSTRAINT adsadsyncobjects_1399716464_c CHECK ((length((sync_retrieval_method)::text) <= 10)),
CONSTRAINT adsadsyncobjects_385396920_c CHECK ((length((base_dn)::text) <= 2000)),
CONSTRAINT adsadsyncobjects_905336890_c CHECK ((length((object_type)::text) <= 100))
);
CREATE TABLE public.adsadsyncobjvsmanadatorysync (
object_id bigint NOT NULL,
manadatory_parent_sync bigint NOT NULL
);
CREATE TABLE public.adsadsyncobjvsreporttypes (
object_id bigint NOT NULL,
report_type citext NOT NULL,
CONSTRAINT adsadsyncobjvsreporttypes_1935972197_c CHECK ((length((report_type)::text) <= 100))
);
CREATE TABLE public.adsadsyncresults (
ad_sync_id bigint NOT NULL,
object_id bigint,
base_dn citext NOT NULL,
object_type citext NOT NULL,
last_method_used citext NOT NULL,
cookie_value citext,
cookie_dc_name citext,
usn_value bigint DEFAULT '0' NOT NULL,
usn_dc_name citext,
invocation_id citext,
full_refreshed_time bigint NOT NULL,
CONSTRAINT adsadsyncresults_1729862512_c CHECK ((length((cookie_dc_name)::text) <= 250)),
CONSTRAINT adsadsyncresults_1806529586_c CHECK ((length((last_method_used)::text) <= 10)),
CONSTRAINT adsadsyncresults_385396920_c CHECK ((length((base_dn)::text) <= 250)),
CONSTRAINT adsadsyncresults_503047556_c CHECK ((length((usn_dc_name)::text) <= 250)),
CONSTRAINT adsadsyncresults_844366038_c CHECK ((length((invocation_id)::text) <= 100)),
CONSTRAINT adsadsyncresults_905336890_c CHECK ((length((object_type)::text) <= 80))
);
CREATE TABLE public.adsadsyncsettings (
unique_id bigint NOT NULL,
full_refresh_interval bigint NOT NULL,
full_refresh_unit_of_time citext NOT NULL,
other_obj_refresh_interval bigint NOT NULL,
other_obj_unit_of_time citext NOT NULL,
listener_impl_class_name citext NOT NULL,
enable_audit boolean DEFAULT true NOT NULL,
sync_retrieval_method citext NOT NULL,
data_sync_id integer DEFAULT 0 NOT NULL,
CONSTRAINT adsadsyncsettings_113056518_c CHECK ((length((listener_impl_class_name)::text) <= 250)),
CONSTRAINT adsadsyncsettings_1249600593_c CHECK ((length((other_obj_unit_of_time)::text) <= 20)),
CONSTRAINT adsadsyncsettings_1399716464_c CHECK ((length((sync_retrieval_method)::text) <= 10)),
CONSTRAINT adsadsyncsettings_988745518_c CHECK ((length((full_refresh_unit_of_time)::text) <= 20))
);
CREATE TABLE public.adsadsynctablecolumns (
unique_id bigint NOT NULL,
table_id bigint NOT NULL,
column_name citext NOT NULL,
ldap_name citext NOT NULL,
is_unique boolean DEFAULT false,
CONSTRAINT adsadsynctablecolumns_1347586516_c CHECK ((length((column_name)::text) <= 250)),
CONSTRAINT adsadsynctablecolumns_1736914909_c CHECK ((length((ldap_name)::text) <= 250))
);
CREATE TABLE public.adsadsynctables (
unique_id bigint NOT NULL,
table_name citext NOT NULL,
object_type citext NOT NULL,
CONSTRAINT adsadsynctables_905336890_c CHECK ((length((object_type)::text) <= 250)),
CONSTRAINT adsadsynctables_989985668_c CHECK ((length((table_name)::text) <= 250))
);
CREATE TABLE public.adsadusergeneraldetails (
unique_id bigint NOT NULL,
common_name citext,
full_name citext,
display_name citext,
distinguished_name citext,
sam_account_name citext,
when_created bigint DEFAULT '0',
when_changed bigint DEFAULT '0',
object_class citext,
object_guid citext,
sid_string citext,
is_deleted integer DEFAULT 0,
primary_group_id citext,
email_address citext,
mobile citext,
manager citext,
manager_dn citext,
domain_id bigint,
domain_name citext,
CONSTRAINT adsadusergeneraldetails_1138971195_c CHECK ((length((full_name)::text) <= 250)),
CONSTRAINT adsadusergeneraldetails_1190891714_c CHECK ((length((sid_string)::text) <= 250)),
CONSTRAINT adsadusergeneraldetails_1314715012_c CHECK ((length((manager_dn)::text) <= 1000)),
CONSTRAINT adsadusergeneraldetails_1352889528_c CHECK ((length((primary_group_id)::text) <= 250)),
CONSTRAINT adsadusergeneraldetails_1553243021_c CHECK ((length((manager)::text) <= 250)),
CONSTRAINT adsadusergeneraldetails_2008335066_c CHECK ((length((domain_name)::text) <= 250)),
CONSTRAINT adsadusergeneraldetails_2012879343_c CHECK ((length((email_address)::text) <= 300)),
CONSTRAINT adsadusergeneraldetails_2015428520_c CHECK ((length((object_class)::text) <= 250)),
CONSTRAINT adsadusergeneraldetails_2015525726_c CHECK ((length((mobile)::text) <= 100)),
CONSTRAINT adsadusergeneraldetails_257558623_c CHECK ((length((common_name)::text) <= 250)),
CONSTRAINT adsadusergeneraldetails_333046776_c CHECK ((length((display_name)::text) <= 250)),
CONSTRAINT adsadusergeneraldetails_700803142_c CHECK ((length((distinguished_name)::text) <= 1000)),
CONSTRAINT adsadusergeneraldetails_843238909_c CHECK ((length((sam_account_name)::text) <= 250)),
CONSTRAINT adsadusergeneraldetails_904945545_c CHECK ((length((object_guid)::text) <= 250))
);
CREATE TABLE public.adsagentconfiguration (
agent_id bigint NOT NULL,
agent_guid citext NOT NULL,
agent_name citext NOT NULL,
agent_display_name citext NOT NULL,
agent_location citext NOT NULL,
agent_version citext NOT NULL,
remcom_wait_time integer,
restart_wait_time integer,
CONSTRAINT adsagentconfiguration_1112873009_c CHECK ((length((agent_location)::text) <= 250)),
CONSTRAINT adsagentconfiguration_1269635746_c CHECK ((length((agent_version)::text) <= 20)),
CONSTRAINT adsagentconfiguration_14538530_c CHECK ((length((agent_display_name)::text) <= 250)),
CONSTRAINT adsagentconfiguration_668080219_c CHECK ((length((agent_name)::text) <= 50)),
CONSTRAINT adsagentconfiguration_668269661_c CHECK ((length((agent_guid)::text) <= 250))
);
CREATE TABLE public.adsagentdetails (
agent_id bigint NOT NULL,
ip_address citext NOT NULL,
machine_name citext NOT NULL,
domain_name citext,
encryption_salt bytea,
encryption_type citext,
CONSTRAINT adsagentdetails_110011485_c CHECK ((length((machine_name)::text) <= 50)),
CONSTRAINT adsagentdetails_1900462268_c CHECK ((length((ip_address)::text) <= 128)),
CONSTRAINT adsagentdetails_2008335066_c CHECK ((length((domain_name)::text) <= 50)),
CONSTRAINT adsagentdetails_714145398_c CHECK ((length((encryption_type)::text) <= 50))
);
CREATE TABLE public.adsagentremoteexecutors (
remote_executor_id bigint NOT NULL,
rem_exec_impl_class citext NOT NULL,
remote_executor_name citext NOT NULL,
CONSTRAINT adsagentremoteexecutors_1348142370_c CHECK ((length((rem_exec_impl_class)::text) <= 250)),
CONSTRAINT adsagentremoteexecutors_426730946_c CHECK ((length((remote_executor_name)::text) <= 50))
);
CREATE TABLE public.adsagentvsremoteexecutors (
remote_executors_mapping_id bigint NOT NULL,
agent_id bigint,
remote_executor_id bigint,
machine_platform citext NOT NULL,
priority bigint,
is_enabled boolean DEFAULT true NOT NULL,
CONSTRAINT adsagentvsremoteexecutors_429525621_c CHECK ((length((machine_platform)::text) <= 50))
);
CREATE TABLE public.adsagentworkstationaudit (
object_guid citext NOT NULL,
machine_name citext NOT NULL,
machine_ip citext,
machine_os citext,
dns_name citext,
domain_name citext,
distinguished_name citext,
agent_id bigint NOT NULL,
operation citext,
is_success boolean DEFAULT false NOT NULL,
completed_time timestamp without time zone,
status_message citext,
CONSTRAINT adsagentworkstationaudit_110011485_c CHECK ((length((machine_name)::text) <= 250)),
CONSTRAINT adsagentworkstationaudit_1224171521_c CHECK ((length((dns_name)::text) <= 250)),
CONSTRAINT adsagentworkstationaudit_1323017988_c CHECK ((length((machine_os)::text) <= 250)),
CONSTRAINT adsagentworkstationaudit_1323018177_c CHECK ((length((machine_ip)::text) <= 250)),
CONSTRAINT adsagentworkstationaudit_154330439_c CHECK ((length((operation)::text) <= 250)),
CONSTRAINT adsagentworkstationaudit_1810162842_c CHECK ((length((status_message)::text) <= 250)),
CONSTRAINT adsagentworkstationaudit_2008335066_c CHECK ((length((domain_name)::text) <= 250)),
CONSTRAINT adsagentworkstationaudit_700803142_c CHECK ((length((distinguished_name)::text) <= 250)),
CONSTRAINT adsagentworkstationaudit_904945545_c CHECK ((length((object_guid)::text) <= 50))
);
CREATE TABLE public.adsappspanepriority (
product_id bigint NOT NULL,
priority_id bigint NOT NULL
);
CREATE TABLE public.adsauthscopes (
scope_id bigint NOT NULL,
scope_name citext NOT NULL,
description citext,
CONSTRAINT adsauthscopes_323331510_c CHECK ((length((scope_name)::text) <= 100)),
CONSTRAINT adsauthscopes_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.adsauthscopevsapi (
scope_id bigint NOT NULL,
api_id bigint NOT NULL
);
CREATE TABLE public.adsauthscopevsproduct (
scope_id bigint NOT NULL,
product_id bigint NOT NULL
);
CREATE TABLE public.adsauthscopevsrole (
scope_id bigint NOT NULL,
role_id bigint NOT NULL
);
CREATE TABLE public.adsauthtokenaudit (
audit_id bigint NOT NULL,
accessed_time bigint NOT NULL,
ip_address citext NOT NULL,
user_agent citext,
api_id bigint NOT NULL,
auth_token_id bigint NOT NULL,
CONSTRAINT adsauthtokenaudit_1900462268_c CHECK ((length((ip_address)::text) <= 100)),
CONSTRAINT adsauthtokenaudit_975942287_c CHECK ((length((user_agent)::text) <= 250))
);
CREATE TABLE public.adsauthtokenparams (
param_id bigint NOT NULL,
product_id bigint NOT NULL,
min_threshold_duration integer,
refresh_token_expiry_duration integer,
access_token_expiry_duration integer
);
CREATE TABLE public.adsauthtokens (
auth_token_id bigint NOT NULL,
auth_token bytea NOT NULL,
creation_time bigint NOT NULL,
expiration_time bigint,
auth_token_state integer DEFAULT 0 NOT NULL,
account_id bigint,
token_type integer DEFAULT 0 NOT NULL,
product_id bigint,
is_fetched boolean DEFAULT false
);
CREATE TABLE public.adsauthtokenvsscope (
auth_token_id bigint NOT NULL,
scope_id bigint NOT NULL
);
CREATE TABLE public.adsbackupconfig (
id bigint NOT NULL,
backup_content_type citext,
backup_type citext,
max_incremental_backup bigint DEFAULT '9',
CONSTRAINT adsbackupconfig_865584451_c CHECK ((length((backup_content_type)::text) <= 100)),
CONSTRAINT adsbackupconfig_992698473_c CHECK ((length((backup_type)::text) <= 100))
);
CREATE TABLE public.adsbackupconfigaudit (
product_id bigint NOT NULL,
audit_value citext,
CONSTRAINT adsbackupconfigaudit_296114227_c CHECK ((length((audit_value)::text) <= 250))
);
CREATE TABLE public.adsbackupdb (
bdb_id bigint NOT NULL,
location citext,
logon_name citext,
password bytea,
days_to_overwrite bigint DEFAULT '-1',
overwrite citext,
configured_products citext,
enable_backup citext,
CONSTRAINT adsbackupdb_1474678203_c CHECK ((length((configured_products)::text) <= 250)),
CONSTRAINT adsbackupdb_1611296843_c CHECK ((length((location)::text) <= 260)),
CONSTRAINT adsbackupdb_203113145_c CHECK ((length((logon_name)::text) <= 128)),
CONSTRAINT adsbackupdb_2041515883_c CHECK ((length((overwrite)::text) <= 50)),
CONSTRAINT adsbackupdb_2076761090_c CHECK ((length((enable_backup)::text) <= 250))
);
CREATE TABLE public.adsbackupdbaudit (
product_id bigint NOT NULL,
build_no bigint,
version citext NOT NULL,
backup_location citext,
file_size bigint,
status integer,
backup_starttime bigint NOT NULL,
CONSTRAINT adsbackupdbaudit_1069590712_c CHECK ((length((version)::text) <= 10)),
CONSTRAINT adsbackupdbaudit_1653263982_c CHECK ((length((backup_location)::text) <= 260))
);
CREATE TABLE public.adsbdbexcludetables (
exclude_table_id bigint NOT NULL,
table_name citext NOT NULL,
CONSTRAINT adsbdbexcludetables_989985668_c CHECK ((length((table_name)::text) <= 250))
);
CREATE TABLE public.adsblockuserconfig (
unique_id bigint NOT NULL,
is_enabled boolean DEFAULT false,
max_attempts bigint,
reset_time bigint,
blocking_duration bigint
);
CREATE TABLE public.adsbrowsernotification (
notification_id bigint NOT NULL,
user_role citext,
user_id bigint,
notification_title citext NOT NULL,
notification_content citext NOT NULL,
icon_id bigint NOT NULL,
onclick_url citext,
expiry_date bigint NOT NULL,
type_id bigint NOT NULL,
extra_params citext,
notification_center_id bigint NOT NULL,
CONSTRAINT adsbrowsernotification_1139346326_c CHECK ((length((user_role)::text) <= 250)),
CONSTRAINT adsbrowsernotification_1190945252_c CHECK ((length((notification_title)::text) <= 250)),
CONSTRAINT adsbrowsernotification_1845562631_c CHECK ((length((onclick_url)::text) <= 500)),
CONSTRAINT adsbrowsernotification_1969094837_c CHECK ((length((extra_params)::text) <= 1000)),
CONSTRAINT adsbrowsernotification_900357_c CHECK ((length((notification_content)::text) <= 1000))
);
CREATE TABLE public.adsbrowsernotificationaudit (
audit_id bigint NOT NULL,
user_id bigint NOT NULL,
status bigint NOT NULL,
is_shown boolean DEFAULT false,
is_clicked boolean DEFAULT false,
shown_count bigint NOT NULL,
available_time bigint NOT NULL,
notification_id bigint NOT NULL
);
CREATE TABLE public.adsbrowsernotificationcenter (
notification_id bigint NOT NULL,
notification_name citext NOT NULL,
impl_class citext NOT NULL,
is_enabled boolean DEFAULT true NOT NULL,
CONSTRAINT adsbrowsernotificationcenter_1624337057_c CHECK ((length((notification_name)::text) <= 250)),
CONSTRAINT adsbrowsernotificationcenter_305026681_c CHECK ((length((impl_class)::text) <= 250))
);
CREATE TABLE public.adsbrowsernotificationtypes (
type_id bigint NOT NULL,
notification_type citext NOT NULL,
is_silent boolean DEFAULT true,
buffer_time bigint,
is_repeatable boolean DEFAULT false,
notification_start_time citext,
notification_end_time citext,
CONSTRAINT adsbrowsernotificationtypes_1624135154_c CHECK ((length((notification_type)::text) <= 100)),
CONSTRAINT adsbrowsernotificationtypes_1944630107_c CHECK ((length((notification_end_time)::text) <= 200)),
CONSTRAINT adsbrowsernotificationtypes_755350402_c CHECK ((length((notification_start_time)::text) <= 200))
);
CREATE TABLE public.adsbusinesshours (
user_id bigint NOT NULL,
from_time bigint NOT NULL,
to_time bigint NOT NULL,
selected_days integer DEFAULT 0 NOT NULL
);
CREATE TABLE public.adscache (
unique_id bigint NOT NULL,
cache_key citext NOT NULL,
cache_value citext,
CONSTRAINT adscache_2060679198_c CHECK ((length((cache_key)::text) <= 250))
);
CREATE TABLE public.adscaptchacolors (
unique_id bigint NOT NULL,
font_color citext,
CONSTRAINT adscaptchacolors_894166867_c CHECK ((length((font_color)::text) <= 10))
);
CREATE TABLE public.adscaptchaconfig (
unique_id bigint NOT NULL,
image_width integer,
image_height integer,
noise_level integer DEFAULT 0,
is_bg_applied boolean DEFAULT true,
captcha_length integer DEFAULT 5
);
CREATE TABLE public.adscaptchafonts (
unique_id bigint NOT NULL,
font_face citext,
font_size integer,
CONSTRAINT adscaptchafonts_1275845709_c CHECK ((length((font_face)::text) <= 20))
);
CREATE TABLE public.adscaptchaparams (
unique_id bigint NOT NULL,
param_name citext,
param_value citext,
CONSTRAINT adscaptchaparams_60008705_c CHECK ((length((param_value)::text) <= 150)),
CONSTRAINT adscaptchaparams_967657245_c CHECK ((length((param_name)::text) <= 50))
);
CREATE TABLE public.adscentralizedroboupdateaudit (
audit_id bigint NOT NULL,
product_id bigint NOT NULL,
current_build_no bigint NOT NULL,
latest_ppm_build_no bigint NOT NULL,
status_flag bigint NOT NULL
);
CREATE TABLE public.adscentralizedsettings (
unique_id bigint NOT NULL,
single_signout citext,
single_console citext,
ntlm_enabled_products citext,
tfa_enabled_products citext,
custom_sso citext,
CONSTRAINT adscentralizedsettings_1066524730_c CHECK ((length((ntlm_enabled_products)::text) <= 250)),
CONSTRAINT adscentralizedsettings_1095315423_c CHECK ((length((custom_sso)::text) <= 250)),
CONSTRAINT adscentralizedsettings_1311033408_c CHECK ((length((single_console)::text) <= 250)),
CONSTRAINT adscentralizedsettings_1612852978_c CHECK ((length((tfa_enabled_products)::text) <= 250)),
CONSTRAINT adscentralizedsettings_1847165094_c CHECK ((length((single_signout)::text) <= 250))
);
CREATE TABLE public.adschangedbaudit (
unique_id bigint NOT NULL,
product_id bigint NOT NULL,
data_migration_enabled boolean DEFAULT false,
migrated_db_server citext,
migrated_time bigint,
CONSTRAINT adschangedbaudit_1199673986_c CHECK ((length((migrated_db_server)::text) <= 250))
);
CREATE TABLE public.adschangedbproducts (
product_id bigint NOT NULL,
database_name citext NOT NULL,
is_enabled boolean DEFAULT false,
CONSTRAINT adschangedbproducts_1814879951_c CHECK ((length((database_name)::text) <= 100))
);
CREATE TABLE public.adsciphersuites (
cipher_id bigint NOT NULL,
cipher_name citext NOT NULL,
CONSTRAINT adsciphersuites_14540863_c CHECK ((length((cipher_name)::text) <= 250))
);
CREATE TABLE public.adsclassloader (
module_id bigint NOT NULL,
module_name citext NOT NULL,
impl_class citext NOT NULL,
description citext,
CONSTRAINT adsclassloader_305026681_c CHECK ((length((impl_class)::text) <= 500)),
CONSTRAINT adsclassloader_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT adsclassloader_987509886_c CHECK ((length((module_name)::text) <= 250))
);
CREATE TABLE public.adsclientmodules (
module_id bigint NOT NULL,
module_name citext NOT NULL,
CONSTRAINT adsclientmodules_987509886_c CHECK ((length((module_name)::text) <= 100))
);
CREATE TABLE public.adsconnectionsecurity (
connection_security_id bigint NOT NULL,
name citext,
description citext,
CONSTRAINT adsconnectionsecurity_2388619_c CHECK ((length((name)::text) <= 250)),
CONSTRAINT adsconnectionsecurity_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.adsconnectionsecurityversions (
version_id bigint NOT NULL,
version_name citext NOT NULL,
connection_security_id bigint NOT NULL,
CONSTRAINT adsconnectionsecurityversions_2050804302_c CHECK ((length((version_name)::text) <= 250))
);
CREATE TABLE public.adsconnectionsecurityversionvscipher (
unique_id bigint NOT NULL,
cipher_id bigint,
version_id bigint
);
CREATE TABLE public.adscountries (
country_id bigint NOT NULL,
country_code citext NOT NULL,
co citext NOT NULL,
c citext NOT NULL,
dialing_code citext DEFAULT '1' NOT NULL,
CONSTRAINT adscountries_2156_c CHECK ((length((co)::text) <= 250)),
CONSTRAINT adscountries_467061482_c CHECK ((length((country_code)::text) <= 10)),
CONSTRAINT adscountries_67_c CHECK ((length((c)::text) <= 10)),
CONSTRAINT adscountries_952377414_c CHECK ((length((dialing_code)::text) <= 10))
);
CREATE TABLE public.adscountrystates (
state_id bigint NOT NULL,
country_id bigint NOT NULL,
state_name citext NOT NULL,
state_code citext NOT NULL,
CONSTRAINT adscountrystates_286568699_c CHECK ((length((state_code)::text) <= 10)),
CONSTRAINT adscountrystates_286883225_c CHECK ((length((state_name)::text) <= 250))
);
CREATE TABLE public.adscreatordetails (
product_id bigint NOT NULL,
module_name citext NOT NULL,
owner_name citext NOT NULL,
auth_token citext NOT NULL,
app_link_name citext NOT NULL,
CONSTRAINT adscreatordetails_1071764663_c CHECK ((length((owner_name)::text) <= 150)),
CONSTRAINT adscreatordetails_1820891890_c CHECK ((length((app_link_name)::text) <= 150)),
CONSTRAINT adscreatordetails_555541374_c CHECK ((length((auth_token)::text) <= 150)),
CONSTRAINT adscreatordetails_987509886_c CHECK ((length((module_name)::text) <= 150))
);
CREATE TABLE public.adscreatornotification (
creator_notification_id bigint NOT NULL,
user_role citext NOT NULL,
notification_title citext NOT NULL,
notification_content citext NOT NULL,
icon_id bigint NOT NULL,
onclick_url citext,
expiry_date bigint NOT NULL,
CONSTRAINT adscreatornotification_1139346326_c CHECK ((length((user_role)::text) <= 250)),
CONSTRAINT adscreatornotification_1190945252_c CHECK ((length((notification_title)::text) <= 250)),
CONSTRAINT adscreatornotification_1845562631_c CHECK ((length((onclick_url)::text) <= 500)),
CONSTRAINT adscreatornotification_900357_c CHECK ((length((notification_content)::text) <= 1000))
);
CREATE TABLE public.adscredentials (
credential_id bigint NOT NULL,
user_name citext NOT NULL,
password bytea,
domain_name citext NOT NULL,
CONSTRAINT adscredentials_1139478913_c CHECK ((length((user_name)::text) <= 255)),
CONSTRAINT adscredentials_2008335066_c CHECK ((length((domain_name)::text) <= 255))
);
CREATE TABLE public.adscustomcomponentsmapping (
map_id bigint NOT NULL,
render_to_id bigint NOT NULL,
component_name citext NOT NULL,
CONSTRAINT adscustomcomponentsmapping_781025107_c CHECK ((length((component_name)::text) <= 100))
);
CREATE TABLE public.adscustomcomponentsrenderto (
id bigint NOT NULL,
module_id bigint,
render_to citext NOT NULL,
CONSTRAINT adscustomcomponentsrenderto_331303364_c CHECK ((length((render_to)::text) <= 100))
);
CREATE TABLE public.adsdatetimeformat (
unique_id bigint NOT NULL,
server_value citext,
CONSTRAINT adsdatetimeformat_1193763157_c CHECK ((length((server_value)::text) <= 250))
);
CREATE TABLE public.adsdbscolumnfilter (
dbs_module_column_id bigint NOT NULL,
column_name citext NOT NULL,
CONSTRAINT adsdbscolumnfilter_1347586516_c CHECK ((length((column_name)::text) <= 50))
);
CREATE TABLE public.adsdbsreferencecolumns (
reference_table_id bigint NOT NULL,
column_name citext NOT NULL,
CONSTRAINT adsdbsreferencecolumns_1347586516_c CHECK ((length((column_name)::text) <= 50))
);
CREATE TABLE public.adsdbsreferencetables (
reference_table_id bigint NOT NULL,
dbs_module_column_id bigint NOT NULL,
table_name citext NOT NULL,
CONSTRAINT adsdbsreferencetables_989985668_c CHECK ((length((table_name)::text) <= 50))
);
CREATE TABLE public.adsdbstablefilter (
dbs_module_id bigint NOT NULL,
table_name citext NOT NULL,
allowed_operations bigint NOT NULL,
CONSTRAINT adsdbstablefilter_989985668_c CHECK ((length((table_name)::text) <= 50))
);
CREATE TABLE public.adsdbsyncdistribution (
distribution_id bigint NOT NULL,
product_id bigint NOT NULL,
last_event_id citext NOT NULL,
CONSTRAINT adsdbsyncdistribution_1977571465_c CHECK ((length((last_event_id)::text) <= 50))
);
CREATE TABLE public.adsdbsynchronization (
synchronization_id bigint NOT NULL,
publisher_class citext NOT NULL,
subscriber_class citext NOT NULL,
distributor_class citext NOT NULL,
executor_class citext NOT NULL,
log_file_path citext NOT NULL,
log_file_name citext NOT NULL,
log_file_size bigint NOT NULL,
republish boolean,
CONSTRAINT adsdbsynchronization_1232871743_c CHECK ((length((subscriber_class)::text) <= 100)),
CONSTRAINT adsdbsynchronization_1368445676_c CHECK ((length((executor_class)::text) <= 100)),
CONSTRAINT adsdbsynchronization_1647972064_c CHECK ((length((distributor_class)::text) <= 100)),
CONSTRAINT adsdbsynchronization_2060046355_c CHECK ((length((log_file_name)::text) <= 100)),
CONSTRAINT adsdbsynchronization_2060106157_c CHECK ((length((log_file_path)::text) <= 100)),
CONSTRAINT adsdbsynchronization_849350347_c CHECK ((length((publisher_class)::text) <= 100))
);
CREATE TABLE public.adsdbsyncmodulecolumns (
dbs_module_column_id bigint NOT NULL,
dbs_module_id bigint NOT NULL,
column_name citext NOT NULL,
is_unique boolean DEFAULT false,
CONSTRAINT adsdbsyncmodulecolumns_1347586516_c CHECK ((length((column_name)::text) <= 50))
);
CREATE TABLE public.adsdbsyncmodules (
dbs_module_id bigint NOT NULL,
module_name citext NOT NULL,
force_publish boolean DEFAULT false,
republish boolean DEFAULT true,
CONSTRAINT adsdbsyncmodules_987509886_c CHECK ((length((module_name)::text) <= 50))
);
CREATE TABLE public.adsdbsyncsubscription (
subscription_id bigint NOT NULL,
product_id bigint NOT NULL,
last_event_id citext NOT NULL,
CONSTRAINT adsdbsyncsubscription_1977571465_c CHECK ((length((last_event_id)::text) <= 50))
);
CREATE TABLE public.adsdcconfiguration (
domain_controller_id bigint NOT NULL,
domain_controller_name citext NOT NULL,
domain_id bigint NOT NULL,
priority_id bigint,
message citext,
CONSTRAINT adsdcconfiguration_1672907751_c CHECK ((length((message)::text) <= 256)),
CONSTRAINT adsdcconfiguration_95048659_c CHECK ((length((domain_controller_name)::text) <= 250))
);
CREATE TABLE public.adsdiskspacealertsettings (
disk_space_alert_id bigint NOT NULL,
free_space_limit bigint NOT NULL,
is_alert_enabled boolean DEFAULT false,
is_email_alert_enabled boolean DEFAULT false,
email_ids citext,
mail_subject citext,
mail_content citext,
mail_priority bigint DEFAULT '1',
CONSTRAINT adsdiskspacealertsettings_331865732_c CHECK ((length((mail_subject)::text) <= 100)),
CONSTRAINT adsdiskspacealertsettings_613318485_c CHECK ((length((email_ids)::text) <= 300))
);
CREATE TABLE public.adsdiskspacedailyusage (
unique_id bigint NOT NULL,
monitor_date date NOT NULL,
root_folder_size bigint NOT NULL,
db_size bigint NOT NULL,
es_size bigint
);
CREATE TABLE public.adsdomainconfiguration (
domain_id bigint NOT NULL,
domain_name citext NOT NULL,
domain_dns_name citext,
domain_flat_name citext,
default_naming_context citext,
domain_dns_zones citext,
is_authentication_required citext,
is_default_domain citext,
domain_functional_level citext,
admin_status integer DEFAULT 1,
status_message citext,
credential_id bigint,
forest_id bigint,
is_ldap_ssl_enabled boolean DEFAULT false,
CONSTRAINT adsdomainconfiguration_1077832234_c CHECK ((length((domain_flat_name)::text) <= 250)),
CONSTRAINT adsdomainconfiguration_1395574851_c CHECK ((length((domain_functional_level)::text) <= 256)),
CONSTRAINT adsdomainconfiguration_1651442319_c CHECK ((length((is_authentication_required)::text) <= 256)),
CONSTRAINT adsdomainconfiguration_1810162842_c CHECK ((length((status_message)::text) <= 256)),
CONSTRAINT adsdomainconfiguration_1966171420_c CHECK ((length((domain_dns_name)::text) <= 250)),
CONSTRAINT adsdomainconfiguration_2008335066_c CHECK ((length((domain_name)::text) <= 250)),
CONSTRAINT adsdomainconfiguration_430581066_c CHECK ((length((default_naming_context)::text) <= 256)),
CONSTRAINT adsdomainconfiguration_57436073_c CHECK ((length((is_default_domain)::text) <= 256)),
CONSTRAINT adsdomainconfiguration_833272246_c CHECK ((length((domain_dns_zones)::text) <= 256))
);
CREATE TABLE public.adsdomaindiscovery (
unique_id bigint NOT NULL,
is_enabled boolean DEFAULT true NOT NULL,
search_scope citext DEFAULT 'LOCAL' NOT NULL,
CONSTRAINT adsdomaindiscovery_599055139_c CHECK ((length((search_scope)::text) <= 100))
);
CREATE TABLE public.adsdomainmodules (
module_id bigint NOT NULL,
module_name citext NOT NULL,
is_enabled boolean DEFAULT true NOT NULL,
CONSTRAINT adsdomainmodules_987509886_c CHECK ((length((module_name)::text) <= 20))
);
CREATE TABLE public.adsdomainpolicies (
domain_name citext NOT NULL,
min_pwd_age citext,
max_pwd_age citext,
min_pwd_length citext,
pwd_history_length citext,
pwd_props citext,
lock_out_duration citext,
lock_out_threshold citext,
CONSTRAINT adsdomainpolicies_1266092976_c CHECK ((length((min_pwd_age)::text) <= 100)),
CONSTRAINT adsdomainpolicies_1455088046_c CHECK ((length((pwd_props)::text) <= 100)),
CONSTRAINT adsdomainpolicies_1647192166_c CHECK ((length((lock_out_threshold)::text) <= 100)),
CONSTRAINT adsdomainpolicies_1943525570_c CHECK ((length((max_pwd_age)::text) <= 100)),
CONSTRAINT adsdomainpolicies_1990302233_c CHECK ((length((lock_out_duration)::text) <= 100)),
CONSTRAINT adsdomainpolicies_2008335066_c CHECK ((length((domain_name)::text) <= 250)),
CONSTRAINT adsdomainpolicies_583830131_c CHECK ((length((pwd_history_length)::text) <= 100)),
CONSTRAINT adsdomainpolicies_86467189_c CHECK ((length((min_pwd_length)::text) <= 100))
);
CREATE TABLE public.adsdomainpsobjects (
domain_name citext NOT NULL,
pso_name citext NOT NULL,
pso_dis_name citext NOT NULL,
min_pwd_age citext NOT NULL,
max_pwd_age citext,
min_pwd_length citext,
pwd_history_length citext,
pwd_complexity citext,
lock_out_duration citext,
lock_out_threshold citext,
CONSTRAINT adsdomainpsobjects_1266092976_c CHECK ((length((min_pwd_age)::text) <= 100)),
CONSTRAINT adsdomainpsobjects_1446048751_c CHECK ((length((pso_dis_name)::text) <= 255)),
CONSTRAINT adsdomainpsobjects_1647192166_c CHECK ((length((lock_out_threshold)::text) <= 100)),
CONSTRAINT adsdomainpsobjects_1943525570_c CHECK ((length((max_pwd_age)::text) <= 100)),
CONSTRAINT adsdomainpsobjects_1990302233_c CHECK ((length((lock_out_duration)::text) <= 100)),
CONSTRAINT adsdomainpsobjects_2008335066_c CHECK ((length((domain_name)::text) <= 250)),
CONSTRAINT adsdomainpsobjects_326230944_c CHECK ((length((pwd_complexity)::text) <= 100)),
CONSTRAINT adsdomainpsobjects_583830131_c CHECK ((length((pwd_history_length)::text) <= 100)),
CONSTRAINT adsdomainpsobjects_691093566_c CHECK ((length((pso_name)::text) <= 250)),
CONSTRAINT adsdomainpsobjects_86467189_c CHECK ((length((min_pwd_length)::text) <= 100))
);
CREATE TABLE public.adsdomains (
domain_uid bigint NOT NULL,
domain_name citext NOT NULL,
CONSTRAINT adsdomains_2008335066_c CHECK ((length((domain_name)::text) <= 250))
);
CREATE TABLE public.adsdomainsubmodules (
sub_module_id bigint NOT NULL,
module_id bigint,
sub_module_name citext NOT NULL,
db_impl_class_name citext NOT NULL,
impl_class_name citext NOT NULL,
is_enabled boolean DEFAULT true NOT NULL,
is_del_update_enabled boolean DEFAULT true NOT NULL,
order_id integer NOT NULL,
CONSTRAINT adsdomainsubmodules_1269324577_c CHECK ((length((sub_module_name)::text) <= 20)),
CONSTRAINT adsdomainsubmodules_1355745135_c CHECK ((length((impl_class_name)::text) <= 250)),
CONSTRAINT adsdomainsubmodules_1725799120_c CHECK ((length((db_impl_class_name)::text) <= 250))
);
CREATE TABLE public.adserrorcodes (
error_code bigint NOT NULL,
error_key citext NOT NULL,
severity citext NOT NULL,
display_text citext,
text_key citext,
CONSTRAINT adserrorcodes_1177553048_c CHECK ((length((error_key)::text) <= 100)),
CONSTRAINT adserrorcodes_2034040067_c CHECK ((length((severity)::text) <= 100)),
CONSTRAINT adserrorcodes_219729875_c CHECK ((length((text_key)::text) <= 100)),
CONSTRAINT adserrorcodes_332863830_c CHECK ((length((display_text)::text) <= 100))
);
CREATE TABLE public.adsexchactivesyncpolicy (
policy_id bigint NOT NULL,
object_guid citext,
domain_name citext NOT NULL,
policy_name citext,
policy_distinguished_name citext NOT NULL,
CONSTRAINT adsexchactivesyncpolicy_2008335066_c CHECK ((length((domain_name)::text) <= 250)),
CONSTRAINT adsexchactivesyncpolicy_52986232_c CHECK ((length((policy_name)::text) <= 250)),
CONSTRAINT adsexchactivesyncpolicy_904945545_c CHECK ((length((object_guid)::text) <= 50)),
CONSTRAINT adsexchactivesyncpolicy_977644429_c CHECK ((length((policy_distinguished_name)::text) <= 1000))
);
CREATE TABLE public.adsexchadmingroups (
domain_exch_admin_grp_id bigint NOT NULL,
domain_name citext NOT NULL,
admin_group_name citext,
admin_group_dn citext NOT NULL,
admin_grp_legacydn citext NOT NULL,
CONSTRAINT adsexchadmingroups_2008335066_c CHECK ((length((domain_name)::text) <= 250)),
CONSTRAINT adsexchadmingroups_395374755_c CHECK ((length((admin_grp_legacydn)::text) <= 1000)),
CONSTRAINT adsexchadmingroups_461248379_c CHECK ((length((admin_group_name)::text) <= 250)),
CONSTRAINT adsexchadmingroups_979249530_c CHECK ((length((admin_group_dn)::text) <= 1000))
);
CREATE TABLE public.adsexchangeservers (
domain_exch_admin_grp_id bigint NOT NULL,
domain_exchange_server_id bigint NOT NULL,
domain_name citext NOT NULL,
server_name citext,
server_distinguished_name citext NOT NULL,
legacy_exchange_dn citext NOT NULL,
version citext NOT NULL,
exch_type integer DEFAULT 2003,
connection_uri citext,
CONSTRAINT adsexchangeservers_1069590712_c CHECK ((length((version)::text) <= 1000)),
CONSTRAINT adsexchangeservers_1423743495_c CHECK ((length((server_name)::text) <= 250)),
CONSTRAINT adsexchangeservers_1954609328_c CHECK ((length((legacy_exchange_dn)::text) <= 1000)),
CONSTRAINT adsexchangeservers_2008335066_c CHECK ((length((domain_name)::text) <= 250)),
CONSTRAINT adsexchangeservers_806041918_c CHECK ((length((server_distinguished_name)::text) <= 1000)),
CONSTRAINT adsexchangeservers_909228949_c CHECK ((length((connection_uri)::text) <= 1000))
);
CREATE TABLE public.adsexchofflineaddress (
exchange_offline_address_id bigint NOT NULL,
domain_name citext NOT NULL,
offline_addlist_name citext,
offline_addlist_dn citext NOT NULL,
CONSTRAINT adsexchofflineaddress_1139916583_c CHECK ((length((offline_addlist_name)::text) <= 250)),
CONSTRAINT adsexchofflineaddress_1330656218_c CHECK ((length((offline_addlist_dn)::text) <= 1000)),
CONSTRAINT adsexchofflineaddress_2008335066_c CHECK ((length((domain_name)::text) <= 250))
);
CREATE TABLE public.adsexchowamailboxpolicy (
policy_id bigint NOT NULL,
object_guid citext,
domain_name citext NOT NULL,
policy_name citext,
policy_distinguished_name citext NOT NULL,
CONSTRAINT adsexchowamailboxpolicy_2008335066_c CHECK ((length((domain_name)::text) <= 250)),
CONSTRAINT adsexchowamailboxpolicy_52986232_c CHECK ((length((policy_name)::text) <= 250)),
CONSTRAINT adsexchowamailboxpolicy_904945545_c CHECK ((length((object_guid)::text) <= 50)),
CONSTRAINT adsexchowamailboxpolicy_977644429_c CHECK ((length((policy_distinguished_name)::text) <= 1000))
);
CREATE TABLE public.adsexchrbacpolicy (
policy_id bigint NOT NULL,
object_guid citext,
domain_name citext NOT NULL,
policy_name citext,
policy_distinguished_name citext NOT NULL,
CONSTRAINT adsexchrbacpolicy_2008335066_c CHECK ((length((domain_name)::text) <= 250)),
CONSTRAINT adsexchrbacpolicy_52986232_c CHECK ((length((policy_name)::text) <= 250)),
CONSTRAINT adsexchrbacpolicy_904945545_c CHECK ((length((object_guid)::text) <= 50)),
CONSTRAINT adsexchrbacpolicy_977644429_c CHECK ((length((policy_distinguished_name)::text) <= 1000))
);
CREATE TABLE public.adsexchretensionpolicy (
policy_id bigint NOT NULL,
object_guid citext,
domain_name citext NOT NULL,
policy_name citext,
policy_distinguished_name citext NOT NULL,
CONSTRAINT adsexchretensionpolicy_2008335066_c CHECK ((length((domain_name)::text) <= 250)),
CONSTRAINT adsexchretensionpolicy_52986232_c CHECK ((length((policy_name)::text) <= 250)),
CONSTRAINT adsexchretensionpolicy_904945545_c CHECK ((length((object_guid)::text) <= 50)),
CONSTRAINT adsexchretensionpolicy_977644429_c CHECK ((length((policy_distinguished_name)::text) <= 1000))
);
CREATE TABLE public.adsexchsharingpolicy (
policy_id bigint NOT NULL,
object_guid citext,
domain_name citext NOT NULL,
policy_name citext,
policy_distinguished_name citext NOT NULL,
CONSTRAINT adsexchsharingpolicy_2008335066_c CHECK ((length((domain_name)::text) <= 250)),
CONSTRAINT adsexchsharingpolicy_52986232_c CHECK ((length((policy_name)::text) <= 250)),
CONSTRAINT adsexchsharingpolicy_904945545_c CHECK ((length((object_guid)::text) <= 50)),
CONSTRAINT adsexchsharingpolicy_977644429_c CHECK ((length((policy_distinguished_name)::text) <= 1000))
);
CREATE TABLE public.adsexchumdialplan (
policy_id bigint NOT NULL,
object_guid citext,
domain_name citext NOT NULL,
policy_name citext,
distinguished_name citext NOT NULL,
phone_context_name citext NOT NULL,
extension_min_count citext NOT NULL,
dial_plan_uri_type integer,
CONSTRAINT adsexchumdialplan_1155777666_c CHECK ((length((extension_min_count)::text) <= 10)),
CONSTRAINT adsexchumdialplan_1276362380_c CHECK ((length((phone_context_name)::text) <= 1000)),
CONSTRAINT adsexchumdialplan_2008335066_c CHECK ((length((domain_name)::text) <= 250)),
CONSTRAINT adsexchumdialplan_52986232_c CHECK ((length((policy_name)::text) <= 250)),
CONSTRAINT adsexchumdialplan_700803142_c CHECK ((length((distinguished_name)::text) <= 1000)),
CONSTRAINT adsexchumdialplan_904945545_c CHECK ((length((object_guid)::text) <= 50))
);
CREATE TABLE public.adsexchumrecipientpolicy (
policy_id bigint NOT NULL,
object_guid citext,
domain_name citext NOT NULL,
policy_name citext,
policy_distinguished_name citext NOT NULL,
dial_plan_link citext NOT NULL,
min_password_length citext NOT NULL,
CONSTRAINT adsexchumrecipientpolicy_1394587395_c CHECK ((length((min_password_length)::text) <= 1000)),
CONSTRAINT adsexchumrecipientpolicy_156180159_c CHECK ((length((dial_plan_link)::text) <= 1000)),
CONSTRAINT adsexchumrecipientpolicy_2008335066_c CHECK ((length((domain_name)::text) <= 250)),
CONSTRAINT adsexchumrecipientpolicy_52986232_c CHECK ((length((policy_name)::text) <= 250)),
CONSTRAINT adsexchumrecipientpolicy_904945545_c CHECK ((length((object_guid)::text) <= 50)),
CONSTRAINT adsexchumrecipientpolicy_977644429_c CHECK ((length((policy_distinguished_name)::text) <= 1000))
);
CREATE TABLE public.adsexportpasswords (
unique_id bigint NOT NULL,
user_id bigint,
password bytea
);
CREATE TABLE public.adsfeatures (
product_id bigint NOT NULL,
feature_name citext NOT NULL,
is_enabled boolean DEFAULT true,
db_sync_module_name citext,
is_db_sync_enabled boolean DEFAULT true,
CONSTRAINT adsfeatures_249480581_c CHECK ((length((db_sync_module_name)::text) <= 250)),
CONSTRAINT adsfeatures_739116460_c CHECK ((length((feature_name)::text) <= 250))
);
CREATE TABLE public.adsfeatureversions (
product_id bigint NOT NULL,
feature_name citext NOT NULL,
supported_build_no bigint,
CONSTRAINT adsfeatureversions_739116460_c CHECK ((length((feature_name)::text) <= 250))
);
CREATE TABLE public.adsfeedbackalerts (
alert_id bigint NOT NULL,
alert_name citext,
status integer DEFAULT 1,
popup_state integer DEFAULT 0,
reminder_time bigint,
end_time bigint,
duration bigint,
is_trial_alert boolean DEFAULT false,
show_dd boolean DEFAULT false,
priority integer,
reminder_duration bigint,
CONSTRAINT adsfeedbackalerts_1860370514_c CHECK ((length((alert_name)::text) <= 250))
);
CREATE TABLE public.adsfeedbackfields (
field_id bigint NOT NULL,
field_name citext,
field_placeholder citext,
field_type citext,
is_custom_field boolean DEFAULT false,
CONSTRAINT adsfeedbackfields_1091304144_c CHECK ((length((field_name)::text) <= 150)),
CONSTRAINT adsfeedbackfields_1091506047_c CHECK ((length((field_type)::text) <= 150)),
CONSTRAINT adsfeedbackfields_2135119506_c CHECK ((length((field_placeholder)::text) <= 250))
);
CREATE TABLE public.adsfeedbackforms (
form_id bigint NOT NULL,
form_name citext,
form_order citext,
success_status citext,
mail_subject citext,
demo_mail_subject citext,
CONSTRAINT adsfeedbackforms_1664046067_c CHECK ((length((form_order)::text) <= 250)),
CONSTRAINT adsfeedbackforms_1975043232_c CHECK ((length((demo_mail_subject)::text) <= 250)),
CONSTRAINT adsfeedbackforms_330727718_c CHECK ((length((form_name)::text) <= 150)),
CONSTRAINT adsfeedbackforms_331865732_c CHECK ((length((mail_subject)::text) <= 250)),
CONSTRAINT adsfeedbackforms_865099726_c CHECK ((length((success_status)::text) <= 250))
);
CREATE TABLE public.adsfeedbackformsvsfields (
unique_id bigint NOT NULL,
form_id bigint,
field_id bigint,
priority bigint,
is_mandatory boolean DEFAULT false
);
CREATE TABLE public.adsfeedbacklicensecomponents (
product_id bigint NOT NULL,
param_name citext NOT NULL,
param_value citext,
CONSTRAINT adsfeedbacklicensecomponents_60008705_c CHECK ((length((param_value)::text) <= 50)),
CONSTRAINT adsfeedbacklicensecomponents_967657245_c CHECK ((length((param_name)::text) <= 50))
);
CREATE TABLE public.adsfeedbackparams (
unique_id bigint NOT NULL,
param_name citext,
param_value citext,
CONSTRAINT adsfeedbackparams_60008705_c CHECK ((length((param_value)::text) <= 1000)),
CONSTRAINT adsfeedbackparams_967657245_c CHECK ((length((param_name)::text) <= 150))
);
CREATE TABLE public.adsfields (
field_id bigint NOT NULL,
name citext NOT NULL,
is_predefined boolean DEFAULT true,
field_type citext,
run_time_type citext,
CONSTRAINT adsfields_1091506047_c CHECK ((length((field_type)::text) <= 50)),
CONSTRAINT adsfields_1561453416_c CHECK ((length((run_time_type)::text) <= 50)),
CONSTRAINT adsfields_2388619_c CHECK ((length((name)::text) <= 255))
);
CREATE TABLE public.adsfileservers (
object_guid citext NOT NULL,
name citext,
dns_name citext,
domain_name citext,
object_class citext,
CONSTRAINT adsfileservers_1224171521_c CHECK ((length((dns_name)::text) <= 250)),
CONSTRAINT adsfileservers_2008335066_c CHECK ((length((domain_name)::text) <= 250)),
CONSTRAINT adsfileservers_2015428520_c CHECK ((length((object_class)::text) <= 100)),
CONSTRAINT adsfileservers_2388619_c CHECK ((length((name)::text) <= 250)),
CONSTRAINT adsfileservers_904945545_c CHECK ((length((object_guid)::text) <= 50))
);
CREATE TABLE public.adsfilterparams (
product_id bigint NOT NULL,
param_name citext NOT NULL,
param_value citext,
CONSTRAINT adsfilterparams_60008705_c CHECK ((length((param_value)::text) <= 1000)),
CONSTRAINT adsfilterparams_967657245_c CHECK ((length((param_name)::text) <= 100))
);
CREATE TABLE public.adsforestconfiguration (
forest_id bigint NOT NULL,
forest_name citext,
forest_dn citext,
root_domain_naming_context citext NOT NULL,
schema_naming_context citext,
configuration_naming_context citext,
forest_dns_zones citext,
credential_id bigint,
CONSTRAINT adsforestconfiguration_1157890538_c CHECK ((length((root_domain_naming_context)::text) <= 256)),
CONSTRAINT adsforestconfiguration_1378542957_c CHECK ((length((forest_name)::text) <= 255)),
CONSTRAINT adsforestconfiguration_2071179423_c CHECK ((length((configuration_naming_context)::text) <= 256)),
CONSTRAINT adsforestconfiguration_229188406_c CHECK ((length((schema_naming_context)::text) <= 256)),
CONSTRAINT adsforestconfiguration_495180337_c CHECK ((length((forest_dns_zones)::text) <= 256)),
CONSTRAINT adsforestconfiguration_90819564_c CHECK ((length((forest_dn)::text) <= 255))
);
CREATE TABLE public.adsgcconfiguration (
forest_id bigint NOT NULL,
gc_name citext NOT NULL,
CONSTRAINT adsgcconfiguration_596528142_c CHECK ((length((gc_name)::text) <= 250))
);
CREATE TABLE public.adshaconfiguration (
config_id bigint NOT NULL,
product_id bigint NOT NULL,
master_server_name citext NOT NULL,
slave_server_name citext NOT NULL,
common_db_name citext,
public_ip citext,
virtual_host_name citext,
username citext,
password bytea,
CONSTRAINT adshaconfiguration_1219643263_c CHECK ((length((slave_server_name)::text) <= 100)),
CONSTRAINT adshaconfiguration_1345023062_c CHECK ((length((master_server_name)::text) <= 100)),
CONSTRAINT adshaconfiguration_1877830488_c CHECK ((length((common_db_name)::text) <= 100)),
CONSTRAINT adshaconfiguration_516913366_c CHECK ((length((username)::text) <= 100)),
CONSTRAINT adshaconfiguration_61422915_c CHECK ((length((public_ip)::text) <= 100)),
CONSTRAINT adshaconfiguration_829373842_c CHECK ((length((virtual_host_name)::text) <= 100))
);
CREATE TABLE public.adshafilereplication (
config_id bigint NOT NULL,
is_replication_enabled boolean DEFAULT false NOT NULL,
replication_schedule bigint NOT NULL,
mirror_dir_list citext,
copy_dir_list citext,
copy_exclude_dir_list citext,
copy_exclude_files_list citext,
CONSTRAINT adshafilereplication_1034048080_c CHECK ((length((mirror_dir_list)::text) <= 2048)),
CONSTRAINT adshafilereplication_1874646475_c CHECK ((length((copy_exclude_files_list)::text) <= 2048)),
CONSTRAINT adshafilereplication_2059095366_c CHECK ((length((copy_dir_list)::text) <= 2048)),
CONSTRAINT adshafilereplication_609657247_c CHECK ((length((copy_exclude_dir_list)::text) <= 2048))
);
CREATE TABLE public.adshtmltemplateconfig (
unique_id bigint NOT NULL,
template_id bigint,
index integer,
key_name citext,
param_name citext,
CONSTRAINT adshtmltemplateconfig_1313118347_c CHECK ((length((key_name)::text) <= 250)),
CONSTRAINT adshtmltemplateconfig_967657245_c CHECK ((length((param_name)::text) <= 500))
);
CREATE TABLE public.adshtmltemplates (
template_id bigint NOT NULL,
name citext,
description citext,
path citext,
CONSTRAINT adshtmltemplates_2388619_c CHECK ((length((name)::text) <= 150)),
CONSTRAINT adshtmltemplates_2448421_c CHECK ((length((path)::text) <= 500)),
CONSTRAINT adshtmltemplates_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.adsiprestriction (
id bigint NOT NULL,
ip_address citext,
is_allowed_ips boolean DEFAULT true,
is_enabled boolean DEFAULT false,
is_url_based_enabled boolean DEFAULT false,
url_allowed_ip_address citext
);
CREATE TABLE public.adsjumptopromotion (
promotional_product_id bigint NOT NULL,
promotional_product_name citext NOT NULL,
promotional_display_name citext NOT NULL,
promotional_icon_style citext,
promotional_category_id bigint,
promotional_priority_id bigint DEFAULT '0',
promotional_description citext,
promotional_learn_more_link citext,
promotional_additional_icon citext,
is_child_product boolean DEFAULT false NOT NULL,
child_product_id bigint,
CONSTRAINT adsjumptopromotion_1035380551_c CHECK ((length((promotional_display_name)::text) <= 250)),
CONSTRAINT adsjumptopromotion_1411300544_c CHECK ((length((promotional_additional_icon)::text) <= 100)),
CONSTRAINT adsjumptopromotion_1636091732_c CHECK ((length((promotional_product_name)::text) <= 250)),
CONSTRAINT adsjumptopromotion_425524981_c CHECK ((length((promotional_description)::text) <= 250)),
CONSTRAINT adsjumptopromotion_461875192_c CHECK ((length((promotional_learn_more_link)::text) <= 500)),
CONSTRAINT adsjumptopromotion_858819780_c CHECK ((length((promotional_icon_style)::text) <= 100))
);
CREATE TABLE public.adsjumptopromotioncategories (
promotional_category_id bigint NOT NULL,
promotional_category_name citext,
CONSTRAINT adsjumptopromotioncategories_1107999077_c CHECK ((length((promotional_category_name)::text) <= 150))
);
CREATE TABLE public.adskeymapper (
unique_id bigint NOT NULL,
unique_name citext,
criteria_table citext NOT NULL,
criteria_column citext NOT NULL,
criteria_value citext NOT NULL,
required_column citext NOT NULL,
CONSTRAINT adskeymapper_163653622_c CHECK ((length((required_column)::text) <= 250)),
CONSTRAINT adskeymapper_1710258063_c CHECK ((length((criteria_value)::text) <= 250)),
CONSTRAINT adskeymapper_1712114994_c CHECK ((length((criteria_table)::text) <= 250)),
CONSTRAINT adskeymapper_2009416650_c CHECK ((length((criteria_column)::text) <= 250)),
CONSTRAINT adskeymapper_262268473_c CHECK ((length((unique_name)::text) <= 250))
);
CREATE TABLE public.adskeystoreentry (
entry_id bigint NOT NULL,
alias citext,
key_pass bytea,
CONSTRAINT adskeystoreentry_62365232_c CHECK ((length((alias)::text) <= 250))
);
CREATE TABLE public.adslcsservers (
domain_lcs_server_id bigint NOT NULL,
forest_id bigint NOT NULL,
server_name citext,
server_distinguished_name citext NOT NULL,
pool_version citext NOT NULL,
dns_host_name citext NOT NULL,
CONSTRAINT adslcsservers_1423743495_c CHECK ((length((server_name)::text) <= 250)),
CONSTRAINT adslcsservers_1922956395_c CHECK ((length((pool_version)::text) <= 1000)),
CONSTRAINT adslcsservers_493654796_c CHECK ((length((dns_host_name)::text) <= 1000)),
CONSTRAINT adslcsservers_806041918_c CHECK ((length((server_distinguished_name)::text) <= 1000))
);
CREATE TABLE public.adslicenseexpiration (
unique_id bigint NOT NULL,
days integer NOT NULL,
subject citext,
content citext,
subject_ams citext,
content_ams citext,
template_id bigint,
template_id_ams bigint,
is_primary boolean DEFAULT false,
is_enabled boolean DEFAULT true,
is_mail_sent boolean DEFAULT false,
CONSTRAINT adslicenseexpiration_1149902580_c CHECK ((length((subject)::text) <= 250)),
CONSTRAINT adslicenseexpiration_1551017972_c CHECK ((length((subject_ams)::text) <= 250)),
CONSTRAINT adslicenseexpiration_1669513305_c CHECK ((length((content)::text) <= 250)),
CONSTRAINT adslicenseexpiration_1765087425_c CHECK ((length((content_ams)::text) <= 250))
);
CREATE TABLE public.adslicpromotionparams (
unique_id bigint NOT NULL,
reminder_days bigint,
reminder_date citext,
reminder_status boolean DEFAULT false,
expiry_date citext,
is_enabled boolean DEFAULT false,
CONSTRAINT adslicpromotionparams_1636534470_c CHECK ((length((expiry_date)::text) <= 150)),
CONSTRAINT adslicpromotionparams_2104203429_c CHECK ((length((reminder_date)::text) <= 150))
);
CREATE TABLE public.adslicpromotionsettings (
unique_id bigint NOT NULL,
product_id bigint NOT NULL,
dashboard_content citext,
login_content citext,
mailer_content citext,
rhs_display_date citext,
priority integer,
is_promotion_enabled boolean DEFAULT false,
expiry_date citext,
is_license_applied boolean DEFAULT false NOT NULL,
download_link citext,
CONSTRAINT adslicpromotionsettings_1073939811_c CHECK ((length((login_content)::text) <= 250)),
CONSTRAINT adslicpromotionsettings_1117536943_c CHECK ((length((download_link)::text) <= 500)),
CONSTRAINT adslicpromotionsettings_1636534470_c CHECK ((length((expiry_date)::text) <= 150)),
CONSTRAINT adslicpromotionsettings_1726108274_c CHECK ((length((dashboard_content)::text) <= 250)),
CONSTRAINT adslicpromotionsettings_709949374_c CHECK ((length((mailer_content)::text) <= 250)),
CONSTRAINT adslicpromotionsettings_806899021_c CHECK ((length((rhs_display_date)::text) <= 150))
);
CREATE TABLE public.adslicusagealarmconfig (
unique_id bigint NOT NULL,
component_id bigint,
limit_percent numeric(16,2),
limit_count integer,
template_id bigint,
is_set boolean DEFAULT false,
is_primary boolean DEFAULT false
);
CREATE TABLE public.adslicusagecomponents (
component_id bigint NOT NULL,
component_name citext,
component_value citext NOT NULL,
property_name citext,
default_limit integer,
attempts_left integer,
CONSTRAINT adslicusagecomponents_1565413231_c CHECK ((length((component_value)::text) <= 50)),
CONSTRAINT adslicusagecomponents_2126232245_c CHECK ((length((property_name)::text) <= 150)),
CONSTRAINT adslicusagecomponents_781025107_c CHECK ((length((component_name)::text) <= 150))
);
CREATE TABLE public.adslicusageparams (
unique_id bigint NOT NULL,
"interval" integer,
schedule_date citext,
attempts integer,
is_enabled boolean DEFAULT true,
CONSTRAINT adslicusageparams_528163926_c CHECK ((length((schedule_date)::text) <= 150))
);
CREATE TABLE public.adslocaledetails (
locale_id bigint NOT NULL,
language citext NOT NULL,
country citext,
display_name citext NOT NULL,
CONSTRAINT adslocaledetails_1675813750_c CHECK ((length((country)::text) <= 250)),
CONSTRAINT adslocaledetails_333046776_c CHECK ((length((display_name)::text) <= 250)),
CONSTRAINT adslocaledetails_830962856_c CHECK ((length((language)::text) <= 250))
);
CREATE TABLE public.adslogforwardconfig (
config_id bigint NOT NULL,
forwarder_name citext,
forwarder_class citext,
type citext,
host citext,
port bigint,
is_default boolean,
is_enabled boolean,
CONSTRAINT adslogforwardconfig_1340920043_c CHECK ((length((forwarder_class)::text) <= 250)),
CONSTRAINT adslogforwardconfig_1567593624_c CHECK ((length((forwarder_name)::text) <= 250)),
CONSTRAINT adslogforwardconfig_2223528_c CHECK ((length((host)::text) <= 250)),
CONSTRAINT adslogforwardconfig_2590522_c CHECK ((length((type)::text) <= 250))
);
CREATE TABLE public.adslogforwardconfigaudit (
product_id bigint NOT NULL,
audit_value citext,
CONSTRAINT adslogforwardconfigaudit_296114227_c CHECK ((length((audit_value)::text) <= 250))
);
CREATE TABLE public.adslogforwardconfigparams (
config_id bigint NOT NULL,
param_name citext NOT NULL,
param_value citext,
CONSTRAINT adslogforwardconfigparams_60008705_c CHECK ((length((param_value)::text) <= 250)),
CONSTRAINT adslogforwardconfigparams_967657245_c CHECK ((length((param_name)::text) <= 250))
);
CREATE TABLE public.adsloginattributes (
attribute_id bigint NOT NULL,
attribute_name citext NOT NULL,
is_enabled boolean DEFAULT true,
CONSTRAINT adsloginattributes_182230638_c CHECK ((length((attribute_name)::text) <= 50))
);
CREATE TABLE public.adslogoncaptchasettings (
unique_id bigint NOT NULL,
is_enabled boolean,
max_invalid_login integer,
time_to_reset integer
);
CREATE TABLE public.adslyncpolicies (
unique_id bigint NOT NULL,
policy_type citext,
policy_name citext,
forest_id bigint NOT NULL,
CONSTRAINT adslyncpolicies_52986232_c CHECK ((length((policy_name)::text) <= 1000)),
CONSTRAINT adslyncpolicies_53188135_c CHECK ((length((policy_type)::text) <= 250))
);
CREATE TABLE public.adslyncpolicytypes (
policy_type_id bigint NOT NULL,
policy_type citext,
get_cmdlet citext,
set_cmdlet citext,
CONSTRAINT adslyncpolicytypes_1480991038_c CHECK ((length((set_cmdlet)::text) <= 250)),
CONSTRAINT adslyncpolicytypes_455814198_c CHECK ((length((get_cmdlet)::text) <= 250)),
CONSTRAINT adslyncpolicytypes_53188135_c CHECK ((length((policy_type)::text) <= 250))
);
CREATE TABLE public.adslyncservers (
domain_lync_server_id bigint NOT NULL,
server_name citext,
fqdn citext NOT NULL,
site citext NOT NULL,
forest_id bigint NOT NULL,
CONSTRAINT adslyncservers_1423743495_c CHECK ((length((server_name)::text) <= 250)),
CONSTRAINT adslyncservers_2197173_c CHECK ((length((fqdn)::text) <= 250)),
CONSTRAINT adslyncservers_2577255_c CHECK ((length((site)::text) <= 250))
);
CREATE TABLE public.adsmacros (
macro_id bigint NOT NULL,
macro_value citext,
macro_display_value citext,
CONSTRAINT adsmacros_1200207905_c CHECK ((length((macro_display_value)::text) <= 255)),
CONSTRAINT adsmacros_579064066_c CHECK ((length((macro_value)::text) <= 255))
);
CREATE TABLE public.adsmailboxobjects (
object_guid citext NOT NULL,
domain_name citext NOT NULL,
name citext NOT NULL,
distinguished_name citext NOT NULL,
object_class citext NOT NULL,
logon_name citext NOT NULL,
email_address citext NOT NULL,
folder citext NOT NULL,
home_mdb citext,
recipient_type citext,
alias_name citext NOT NULL,
canonical_name citext,
upn citext,
display_name citext NOT NULL,
legacy_exchange_dn citext NOT NULL,
user_account_control citext,
mbx_policy_link citext,
audit_logging_status citext,
CONSTRAINT adsmailboxobjects_1284215959_c CHECK ((length((user_account_control)::text) <= 255)),
CONSTRAINT adsmailboxobjects_1415386310_c CHECK ((length((alias_name)::text) <= 255)),
CONSTRAINT adsmailboxobjects_1674833418_c CHECK ((length((audit_logging_status)::text) <= 255)),
CONSTRAINT adsmailboxobjects_1813516736_c CHECK ((length((recipient_type)::text) <= 1000)),
CONSTRAINT adsmailboxobjects_1954609328_c CHECK ((length((legacy_exchange_dn)::text) <= 255)),
CONSTRAINT adsmailboxobjects_2008335066_c CHECK ((length((domain_name)::text) <= 250)),
CONSTRAINT adsmailboxobjects_2012879343_c CHECK ((length((email_address)::text) <= 300)),
CONSTRAINT adsmailboxobjects_2015428520_c CHECK ((length((object_class)::text) <= 250)),
CONSTRAINT adsmailboxobjects_203113145_c CHECK ((length((logon_name)::text) <= 250)),
CONSTRAINT adsmailboxobjects_2079330414_c CHECK ((length((folder)::text) <= 500)),
CONSTRAINT adsmailboxobjects_2388619_c CHECK ((length((name)::text) <= 250)),
CONSTRAINT adsmailboxobjects_297713195_c CHECK ((length((home_mdb)::text) <= 1000)),
CONSTRAINT adsmailboxobjects_333046776_c CHECK ((length((display_name)::text) <= 255)),
CONSTRAINT adsmailboxobjects_491471371_c CHECK ((length((mbx_policy_link)::text) <= 512)),
CONSTRAINT adsmailboxobjects_700803142_c CHECK ((length((distinguished_name)::text) <= 1025)),
CONSTRAINT adsmailboxobjects_765764842_c CHECK ((length((canonical_name)::text) <= 1000)),
CONSTRAINT adsmailboxobjects_84243_c CHECK ((length((upn)::text) <= 270)),
CONSTRAINT adsmailboxobjects_904945545_c CHECK ((length((object_guid)::text) <= 50))
);
CREATE TABLE public.adsmailboxstores (
domain_exchange_server_id bigint NOT NULL,
domain_store_id bigint NOT NULL,
store_name citext,
store_distinguished_name citext NOT NULL,
store_guid citext NOT NULL,
canonical_name citext,
store_email citext,
edb_path citext,
stm_path citext,
storage_quota_limit citext,
hard_quota_limit citext,
CONSTRAINT adsmailboxstores_1436194631_c CHECK ((length((store_guid)::text) <= 40)),
CONSTRAINT adsmailboxstores_1436384073_c CHECK ((length((store_name)::text) <= 250)),
CONSTRAINT adsmailboxstores_1570267774_c CHECK ((length((store_email)::text) <= 255)),
CONSTRAINT adsmailboxstores_182195808_c CHECK ((length((hard_quota_limit)::text) <= 500)),
CONSTRAINT adsmailboxstores_1840104840_c CHECK ((length((stm_path)::text) <= 500)),
CONSTRAINT adsmailboxstores_2086056828_c CHECK ((length((store_distinguished_name)::text) <= 1000)),
CONSTRAINT adsmailboxstores_2099723423_c CHECK ((length((edb_path)::text) <= 500)),
CONSTRAINT adsmailboxstores_291067664_c CHECK ((length((storage_quota_limit)::text) <= 500)),
CONSTRAINT adsmailboxstores_765764842_c CHECK ((length((canonical_name)::text) <= 1000))
);
CREATE TABLE public.adsmailsettings (
unique_id bigint NOT NULL,
server_name citext,
port citext DEFAULT '25',
user_name citext,
password bytea,
connection_security_id bigint,
from_mail_id citext DEFAULT 'noreply@ad360.com',
admin_mail_id citext,
enable_html_format boolean DEFAULT true,
CONSTRAINT adsmailsettings_1139478913_c CHECK ((length((user_name)::text) <= 250)),
CONSTRAINT adsmailsettings_1342771954_c CHECK ((length((from_mail_id)::text) <= 250)),
CONSTRAINT adsmailsettings_1423743495_c CHECK ((length((server_name)::text) <= 250)),
CONSTRAINT adsmailsettings_2461825_c CHECK ((length((port)::text) <= 250)),
CONSTRAINT adsmailsettings_569152403_c CHECK ((length((admin_mail_id)::text) <= 1000))
);
CREATE TABLE public.adsmenu (
menu_id bigint NOT NULL,
name citext NOT NULL,
display_name citext NOT NULL,
description citext,
icon_style citext NOT NULL,
tool_tip_text citext,
onclick_func citext NOT NULL,
priority_id bigint,
is_default boolean DEFAULT true,
CONSTRAINT adsmenu_1246936651_c CHECK ((length((icon_style)::text) <= 100)),
CONSTRAINT adsmenu_1378310566_c CHECK ((length((onclick_func)::text) <= 100)),
CONSTRAINT adsmenu_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT adsmenu_333046776_c CHECK ((length((display_name)::text) <= 250)),
CONSTRAINT adsmenu_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT adsmenu_637181640_c CHECK ((length((tool_tip_text)::text) <= 250))
);
CREATE TABLE public.adsmyfavcategory (
category_id bigint NOT NULL,
category_name citext NOT NULL,
login_id bigint NOT NULL,
priority bigint NOT NULL,
is_default boolean DEFAULT false NOT NULL,
CONSTRAINT adsmyfavcategory_810488532_c CHECK ((length((category_name)::text) <= 200))
);
CREATE TABLE public.adsmyfavreportparams (
fav_rep_id bigint NOT NULL,
param_name citext NOT NULL,
param_value citext,
is_excluded boolean DEFAULT false,
CONSTRAINT adsmyfavreportparams_60008705_c CHECK ((length((param_value)::text) <= 100)),
CONSTRAINT adsmyfavreportparams_967657245_c CHECK ((length((param_name)::text) <= 100))
);
CREATE TABLE public.adsmyfavreports (
fav_rep_id bigint NOT NULL,
product_id bigint NOT NULL,
category_id bigint NOT NULL,
display_name citext NOT NULL,
priority bigint NOT NULL,
report_url citext NOT NULL,
CONSTRAINT adsmyfavreports_1877211196_c CHECK ((length((report_url)::text) <= 1000)),
CONSTRAINT adsmyfavreports_333046776_c CHECK ((length((display_name)::text) <= 200))
);
CREATE TABLE public.adsnotificationcenter (
notification_id bigint NOT NULL,
notification_name citext NOT NULL,
impl_class citext NOT NULL,
is_enabled boolean DEFAULT true NOT NULL,
CONSTRAINT adsnotificationcenter_1624337057_c CHECK ((length((notification_name)::text) <= 250)),
CONSTRAINT adsnotificationcenter_305026681_c CHECK ((length((impl_class)::text) <= 250))
);
CREATE TABLE public.adsnotificationdetails (
product_id bigint NOT NULL,
notification_index citext NOT NULL,
notification_type citext NOT NULL,
event_date citext,
CONSTRAINT adsnotificationdetails_1180919902_c CHECK ((length((notification_index)::text) <= 20)),
CONSTRAINT adsnotificationdetails_1498522195_c CHECK ((length((event_date)::text) <= 30)),
CONSTRAINT adsnotificationdetails_1624135154_c CHECK ((length((notification_type)::text) <= 30))
);
CREATE TABLE public.adsnotificationiconinfo (
icon_id bigint NOT NULL,
icon_type citext NOT NULL,
icon_url citext NOT NULL,
CONSTRAINT adsnotificationiconinfo_1425731392_c CHECK ((length((icon_type)::text) <= 150)),
CONSTRAINT adsnotificationiconinfo_45992073_c CHECK ((length((icon_url)::text) <= 500))
);
CREATE TABLE public.adsnotificationtypes (
notification_id bigint NOT NULL,
parent_id bigint,
notification_name citext NOT NULL,
display_name citext NOT NULL,
is_enabled boolean DEFAULT true NOT NULL,
CONSTRAINT adsnotificationtypes_1624337057_c CHECK ((length((notification_name)::text) <= 200)),
CONSTRAINT adsnotificationtypes_333046776_c CHECK ((length((display_name)::text) <= 200))
);
CREATE TABLE public.adsorgconfiguration (
org_id bigint NOT NULL,
org_guid citext NOT NULL,
org_name citext NOT NULL,
is_default boolean,
credential_id bigint,
forest_id bigint,
CONSTRAINT adsorgconfiguration_2126524196_c CHECK ((length((org_guid)::text) <= 40)),
CONSTRAINT adsorgconfiguration_2126713638_c CHECK ((length((org_name)::text) <= 100))
);
CREATE TABLE public.adsorgsettings (
org_id bigint NOT NULL,
message_sending_size integer,
message_receiving_size integer,
recipient_limit integer
);
CREATE TABLE public.adsparentproducts (
parent_product_id bigint NOT NULL,
is_parent_product boolean DEFAULT false NOT NULL
);
CREATE TABLE public.adsparentproductsvschildproducts (
child_product_id bigint NOT NULL,
parent_product_id bigint NOT NULL,
priority_id bigint NOT NULL
);
CREATE TABLE public.adspersonalizesettings (
user_id bigint NOT NULL,
browser_title citext,
logo_path citext,
logo_width citext,
logo_height citext,
favicon_path citext,
theme_color citext,
time_zone citext,
date_time_format citext,
enable_forgot_pwd boolean DEFAULT true,
CONSTRAINT adspersonalizesettings_1255615033_c CHECK ((length((logo_path)::text) <= 250)),
CONSTRAINT adspersonalizesettings_1313431440_c CHECK ((length((favicon_path)::text) <= 250)),
CONSTRAINT adspersonalizesettings_1394707155_c CHECK ((length((theme_color)::text) <= 250)),
CONSTRAINT adspersonalizesettings_1441971746_c CHECK ((length((time_zone)::text) <= 250)),
CONSTRAINT adspersonalizesettings_1766465983_c CHECK ((length((browser_title)::text) <= 250)),
CONSTRAINT adspersonalizesettings_276048402_c CHECK ((length((logo_width)::text) <= 250)),
CONSTRAINT adspersonalizesettings_465428933_c CHECK ((length((logo_height)::text) <= 250)),
CONSTRAINT adspersonalizesettings_907902616_c CHECK ((length((date_time_format)::text) <= 250))
);
CREATE TABLE public.adsprivacyconfiguration (
config_id bigint NOT NULL,
is_privacy_enabled boolean DEFAULT false,
is_export_audit_enabled boolean DEFAULT false,
is_anonymize_pii_enabled boolean DEFAULT false,
export_file_password bytea,
backup_zip_password bytea
);
CREATE TABLE public.adsproductapiparams (
api_param_id bigint NOT NULL,
api_id bigint NOT NULL,
param_name citext NOT NULL,
is_mandatory boolean DEFAULT false,
CONSTRAINT adsproductapiparams_967657245_c CHECK ((length((param_name)::text) <= 250))
);
CREATE TABLE public.adsproductapis (
product_id bigint,
api_id bigint NOT NULL,
api_name citext NOT NULL,
api_url citext NOT NULL,
servlet_class_name citext,
mtcall_name citext,
mtcall_value citext,
is_hs_required boolean DEFAULT true,
is_allowed_on_demo boolean DEFAULT true,
is_db_sync_enabled boolean DEFAULT true,
api_authorization citext,
api_error_handler citext,
is_api_exposed boolean DEFAULT false,
token_handshake boolean DEFAULT false,
CONSTRAINT adsproductapis_1516332549_c CHECK ((length((mtcall_name)::text) <= 250)),
CONSTRAINT adsproductapis_1672819122_c CHECK ((length((api_error_handler)::text) <= 1000)),
CONSTRAINT adsproductapis_1779423664_c CHECK ((length((api_name)::text) <= 250)),
CONSTRAINT adsproductapis_230943465_c CHECK ((length((mtcall_value)::text) <= 250)),
CONSTRAINT adsproductapis_355577708_c CHECK ((length((servlet_class_name)::text) <= 250)),
CONSTRAINT adsproductapis_792868140_c CHECK ((length((api_authorization)::text) <= 1000)),
CONSTRAINT adsproductapis_81139318_c CHECK ((length((api_url)::text) <= 1000))
);
CREATE TABLE public.adsproductapiscopes (
api_id bigint NOT NULL,
api_scope integer NOT NULL
);
CREATE TABLE public.adsproductapisvsallowedhttpmethod (
api_id bigint NOT NULL,
http_method bigint NOT NULL
);
CREATE TABLE public.adsproductcomponents (
component_id bigint NOT NULL,
product_id bigint,
name citext NOT NULL,
display_name citext NOT NULL,
child_component_id bigint,
status boolean DEFAULT true,
is_parent_component boolean DEFAULT false,
type integer DEFAULT 1,
CONSTRAINT adsproductcomponents_2388619_c CHECK ((length((name)::text) <= 250)),
CONSTRAINT adsproductcomponents_333046776_c CHECK ((length((display_name)::text) <= 250))
);
CREATE TABLE public.adsproductdetails (
product_id bigint NOT NULL,
protocol citext NOT NULL,
host citext NOT NULL,
port integer NOT NULL,
context citext,
username citext,
password bytea,
is_remotely_hosted boolean DEFAULT false,
is_integrated boolean DEFAULT true,
sequence_id citext,
integrated_product_name citext,
CONSTRAINT adsproductdetails_1213123737_c CHECK ((length((integrated_product_name)::text) <= 250)),
CONSTRAINT adsproductdetails_1347773017_c CHECK ((length((sequence_id)::text) <= 50)),
CONSTRAINT adsproductdetails_1669513615_c CHECK ((length((context)::text) <= 250)),
CONSTRAINT adsproductdetails_206537064_c CHECK ((length((protocol)::text) <= 50)),
CONSTRAINT adsproductdetails_2223528_c CHECK ((length((host)::text) <= 250)),
CONSTRAINT adsproductdetails_516913366_c CHECK ((length((username)::text) <= 250))
);
CREATE TABLE public.adsproductfeatureaudit (
product_id bigint NOT NULL,
feature_name citext NOT NULL,
audit_value citext,
CONSTRAINT adsproductfeatureaudit_296114227_c CHECK ((length((audit_value)::text) <= 250)),
CONSTRAINT adsproductfeatureaudit_739116460_c CHECK ((length((feature_name)::text) <= 250))
);
CREATE TABLE public.adsproductfeatureconfig (
product_id bigint NOT NULL,
feature_name citext NOT NULL,
is_enabled boolean DEFAULT false,
additonal_params citext,
CONSTRAINT adsproductfeatureconfig_1212331985_c CHECK ((length((additonal_params)::text) <= 250)),
CONSTRAINT adsproductfeatureconfig_739116460_c CHECK ((length((feature_name)::text) <= 250))
);
CREATE TABLE public.adsproductinfos (
product_id bigint NOT NULL,
installation_product_name citext,
installation_tag_name citext,
installation_display_name citext NOT NULL,
installation_folder_name citext NOT NULL,
default_port bigint NOT NULL,
default_context citext,
guid citext NOT NULL,
exe_link_32bit citext,
exe_link_64bit citext,
ppm_link citext,
release_note_link citext,
is_visible boolean DEFAULT true,
is_activated boolean DEFAULT false,
load_on_iframe boolean DEFAULT true,
show_splashscreen boolean DEFAULT false,
reverse_proxy_context citext,
activated_by_bundle citext,
CONSTRAINT adsproductinfos_1011650016_c CHECK ((length((installation_product_name)::text) <= 100)),
CONSTRAINT adsproductinfos_1345695595_c CHECK ((length((installation_tag_name)::text) <= 100)),
CONSTRAINT adsproductinfos_1386040631_c CHECK ((length((installation_folder_name)::text) <= 250)),
CONSTRAINT adsproductinfos_1612361197_c CHECK ((length((installation_display_name)::text) <= 250)),
CONSTRAINT adsproductinfos_176454564_c CHECK ((length((activated_by_bundle)::text) <= 100)),
CONSTRAINT adsproductinfos_2000820593_c CHECK ((length((default_context)::text) <= 250)),
CONSTRAINT adsproductinfos_2028727636_c CHECK ((length((ppm_link)::text) <= 500)),
CONSTRAINT adsproductinfos_203832863_c CHECK ((length((reverse_proxy_context)::text) <= 100)),
CONSTRAINT adsproductinfos_2199177_c CHECK ((length((guid)::text) <= 250)),
CONSTRAINT adsproductinfos_426121679_c CHECK ((length((release_note_link)::text) <= 500)),
CONSTRAINT adsproductinfos_903889577_c CHECK ((length((exe_link_64bit)::text) <= 500)),
CONSTRAINT adsproductinfos_906719722_c CHECK ((length((exe_link_32bit)::text) <= 500))
);
CREATE TABLE public.adsproductlocalevsinfos (
product_id bigint NOT NULL,
locale citext NOT NULL,
exe_link_32bit citext,
exe_link_64bit citext,
ppm_link citext,
CONSTRAINT adsproductlocalevsinfos_2028727636_c CHECK ((length((ppm_link)::text) <= 500)),
CONSTRAINT adsproductlocalevsinfos_2044132774_c CHECK ((length((locale)::text) <= 100)),
CONSTRAINT adsproductlocalevsinfos_903889577_c CHECK ((length((exe_link_64bit)::text) <= 500)),
CONSTRAINT adsproductlocalevsinfos_906719722_c CHECK ((length((exe_link_32bit)::text) <= 500))
);
CREATE TABLE public.adsproductnotificationsettings (
unique_id bigint NOT NULL,
notification_name citext NOT NULL,
mail_ids citext,
include_all_admins boolean DEFAULT false,
is_enabled boolean DEFAULT true,
CONSTRAINT adsproductnotificationsettings_1624337057_c CHECK ((length((notification_name)::text) <= 100)),
CONSTRAINT adsproductnotificationsettings_773624848_c CHECK ((length((mail_ids)::text) <= 1000))
);
CREATE TABLE public.adsproductparams (
product_id bigint NOT NULL,
param_name citext NOT NULL,
param_value citext,
CONSTRAINT adsproductparams_60008705_c CHECK ((length((param_value)::text) <= 4000)),
CONSTRAINT adsproductparams_967657245_c CHECK ((length((param_name)::text) <= 100))
);
CREATE TABLE public.adsproductpromotionlinks (
promotion_id bigint NOT NULL,
link_id bigint NOT NULL,
display_name citext,
url citext,
CONSTRAINT adsproductpromotionlinks_333046776_c CHECK ((length((display_name)::text) <= 250)),
CONSTRAINT adsproductpromotionlinks_84303_c CHECK ((length((url)::text) <= 250))
);
CREATE TABLE public.adsproductpromotions (
promotion_id bigint NOT NULL,
product_id bigint NOT NULL,
description citext,
learn_more_link citext,
CONSTRAINT adsproductpromotions_1393299895_c CHECK ((length((learn_more_link)::text) <= 250)),
CONSTRAINT adsproductpromotions_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.adsproducts (
product_id bigint NOT NULL,
product_name citext NOT NULL,
tag_name citext,
display_name citext NOT NULL,
icon_style citext,
is_custom_app boolean DEFAULT false NOT NULL,
is_primary_product boolean DEFAULT true NOT NULL,
priority_id bigint DEFAULT '0',
is_enabled boolean DEFAULT true NOT NULL,
component_name citext,
icon_display_name citext,
CONSTRAINT adsproducts_1246936651_c CHECK ((length((icon_style)::text) <= 250)),
CONSTRAINT adsproducts_333046776_c CHECK ((length((display_name)::text) <= 250)),
CONSTRAINT adsproducts_48170032_c CHECK ((length((tag_name)::text) <= 250)),
CONSTRAINT adsproducts_781025107_c CHECK ((length((component_name)::text) <= 250)),
CONSTRAINT adsproducts_78388750_c CHECK ((length((icon_display_name)::text) <= 100)),
CONSTRAINT adsproducts_933757957_c CHECK ((length((product_name)::text) <= 250))
);
CREATE TABLE public.adsproductsettings (
unique_id bigint NOT NULL,
session_expiry_time bigint DEFAULT '30' NOT NULL,
log_level citext DEFAULT 'Normal' NOT NULL,
enable_metrack boolean DEFAULT true NOT NULL,
CONSTRAINT adsproductsettings_1695826569_c CHECK ((length((log_level)::text) <= 10))
);
CREATE TABLE public.adsproductsvstypes (
product_id bigint NOT NULL,
product_type bigint NOT NULL
);
CREATE TABLE public.adsproducttypes (
product_type bigint NOT NULL,
description citext,
CONSTRAINT adsproducttypes_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.adsproductversions (
product_id bigint NOT NULL,
min_build_number bigint NOT NULL,
max_build_number bigint NOT NULL,
version citext NOT NULL,
CONSTRAINT adsproductversions_1069590712_c CHECK ((length((version)::text) <= 250))
);
CREATE TABLE public.adspromotionaudit (
audit_id bigint NOT NULL,
user_id bigint NOT NULL,
product_id bigint NOT NULL,
promotion_id bigint,
status_flag bigint
);
CREATE TABLE public.adsproxysettings (
unique_id bigint NOT NULL,
server_name citext NOT NULL,
port citext NOT NULL,
user_name citext,
password bytea,
use_in_restapi boolean DEFAULT false,
CONSTRAINT adsproxysettings_1139478913_c CHECK ((length((user_name)::text) <= 250)),
CONSTRAINT adsproxysettings_1423743495_c CHECK ((length((server_name)::text) <= 250)),
CONSTRAINT adsproxysettings_2461825_c CHECK ((length((port)::text) <= 50))
);
CREATE TABLE public.adspsagentsettings (
ps_agent_id bigint NOT NULL,
pwd_mgr_impl_class citext NOT NULL,
is_new_user_allowed boolean DEFAULT false,
secret_key bytea NOT NULL,
algorithm bytea NOT NULL,
CONSTRAINT adspsagentsettings_92499838_c CHECK ((length((pwd_mgr_impl_class)::text) <= 250))
);
CREATE TABLE public.adsreportcategories (
tab_id bigint,
category_id bigint NOT NULL,
category_name citext,
parent_category_id bigint,
CONSTRAINT adsreportcategories_810488532_c CHECK ((length((category_name)::text) <= 50))
);
CREATE TABLE public.adsreports (
unique_id bigint NOT NULL,
category_id bigint,
product_id bigint NOT NULL,
menu_id bigint,
report_id bigint NOT NULL,
report_name citext NOT NULL,
report_url citext,
route_name citext NOT NULL,
is_selected boolean DEFAULT true,
CONSTRAINT adsreports_1427202785_c CHECK ((length((route_name)::text) <= 100)),
CONSTRAINT adsreports_1877211196_c CHECK ((length((report_url)::text) <= 500)),
CONSTRAINT adsreports_1935770294_c CHECK ((length((report_name)::text) <= 100))
);
CREATE TABLE public.adsreportscustomizationaudit (
unique_id bigint NOT NULL,
customize_action_count bigint
);
CREATE TABLE public.adsreporttabs (
tab_id bigint NOT NULL,
tab_name citext,
is_customizable boolean DEFAULT true,
is_enabled boolean DEFAULT true,
priority_id bigint,
login_id bigint,
CONSTRAINT adsreporttabs_94975723_c CHECK ((length((tab_name)::text) <= 250))
);
CREATE TABLE public.adsresponsestatuscodes (
unique_id bigint NOT NULL,
status_code bigint NOT NULL,
description citext NOT NULL,
displaytext citext NOT NULL,
troubleshooting_link citext,
CONSTRAINT adsresponsestatuscodes_426721073_c CHECK ((length((displaytext)::text) <= 255)),
CONSTRAINT adsresponsestatuscodes_428414940_c CHECK ((length((description)::text) <= 255))
);
CREATE TABLE public.adsreverseproxyconfig (
config_id bigint NOT NULL,
protocol citext NOT NULL,
port integer NOT NULL,
keystore_path citext,
keystore_password bytea,
is_context_based boolean DEFAULT false NOT NULL,
is_enabled boolean DEFAULT true NOT NULL,
CONSTRAINT adsreverseproxyconfig_206537064_c CHECK ((length((protocol)::text) <= 50)),
CONSTRAINT adsreverseproxyconfig_207946850_c CHECK ((length((keystore_path)::text) <= 250))
);
CREATE TABLE public.adsreverseproxyconfigvsproduct (
config_id bigint NOT NULL,
product_id bigint NOT NULL,
context citext,
is_enabled boolean DEFAULT true NOT NULL,
CONSTRAINT adsreverseproxyconfigvsproduct_1669513615_c CHECK ((length((context)::text) <= 50))
);
CREATE TABLE public.adsroboupdatemanager (
rum_id bigint NOT NULL,
configured_products citext,
enable_update boolean DEFAULT false NOT NULL,
update_my_self boolean DEFAULT false NOT NULL,
notify_admin boolean DEFAULT false NOT NULL,
notify_after_upgrade boolean DEFAULT false NOT NULL,
CONSTRAINT adsroboupdatemanager_1474678203_c CHECK ((length((configured_products)::text) <= 250))
);
CREATE TABLE public.adsrolevsnotification (
notification_id bigint NOT NULL,
role_id bigint NOT NULL,
is_enabled boolean DEFAULT true NOT NULL
);
CREATE TABLE public.adsrolevstab (
role_id bigint NOT NULL,
tab_id bigint NOT NULL
);
CREATE TABLE public.adsrumaudit (
audit_id bigint NOT NULL,
version citext NOT NULL,
build_no bigint,
updated_time bigint NOT NULL,
status boolean DEFAULT true NOT NULL,
status_message citext,
product_id bigint NOT NULL,
CONSTRAINT adsrumaudit_1069590712_c CHECK ((length((version)::text) <= 10)),
CONSTRAINT adsrumaudit_1810162842_c CHECK ((length((status_message)::text) <= 100))
);
CREATE TABLE public.adsrumparams (
param_id bigint NOT NULL,
product_id bigint NOT NULL,
param_name citext NOT NULL,
param_value citext NOT NULL,
CONSTRAINT adsrumparams_60008705_c CHECK ((length((param_value)::text) <= 250)),
CONSTRAINT adsrumparams_967657245_c CHECK ((length((param_name)::text) <= 250))
);
CREATE TABLE public.adsrumpatchdetails (
product_id bigint NOT NULL,
version citext NOT NULL,
base_build bigint,
build_no bigint NOT NULL,
patch_file citext NOT NULL,
status_flag bigint DEFAULT '0',
tried_count bigint DEFAULT '0',
CONSTRAINT adsrumpatchdetails_1069590712_c CHECK ((length((version)::text) <= 10)),
CONSTRAINT adsrumpatchdetails_1789941555_c CHECK ((length((patch_file)::text) <= 500))
);
CREATE TABLE public.adsrumprocessaudit (
audit_id bigint NOT NULL,
version citext NOT NULL,
build_no bigint,
updated_time bigint NOT NULL,
process_name citext,
status boolean DEFAULT true,
status_message citext,
product_id bigint,
CONSTRAINT adsrumprocessaudit_1069590712_c CHECK ((length((version)::text) <= 10)),
CONSTRAINT adsrumprocessaudit_1810162842_c CHECK ((length((status_message)::text) <= 100)),
CONSTRAINT adsrumprocessaudit_45062779_c CHECK ((length((process_name)::text) <= 100))
);
CREATE TABLE public.adsrumscheduler (
rum_id bigint NOT NULL,
schedule_id bigint NOT NULL
);
CREATE TABLE public.adsrumserverdetails (
product_id bigint NOT NULL,
is_patch_available boolean DEFAULT false NOT NULL,
is_connection_failed boolean DEFAULT false NOT NULL
);
CREATE TABLE public.adsrunqueryconf (
unique_id bigint NOT NULL,
sql_task citext NOT NULL,
is_enabled boolean DEFAULT false NOT NULL,
CONSTRAINT adsrunqueryconf_236158602_c CHECK ((length((sql_task)::text) <= 50))
);
CREATE TABLE public.adsrunqueryparams (
unique_id bigint NOT NULL,
param_name citext,
param_value citext,
CONSTRAINT adsrunqueryparams_60008705_c CHECK ((length((param_value)::text) <= 250)),
CONSTRAINT adsrunqueryparams_967657245_c CHECK ((length((param_name)::text) <= 50))
);
CREATE TABLE public.adssearchhistory (
search_id bigint NOT NULL,
user_id bigint NOT NULL,
report_id bigint,
menu_name citext NOT NULL,
tab_name citext NOT NULL,
subtab_name citext NOT NULL,
search_count bigint,
search_frequency double,
search_count_per_day double DEFAULT '0',
last_accessed_time timestamp without time zone,
CONSTRAINT adssearchhistory_1289199979_c CHECK ((length((menu_name)::text) <= 100)),
CONSTRAINT adssearchhistory_1769739467_c CHECK ((length((subtab_name)::text) <= 50)),
CONSTRAINT adssearchhistory_94975723_c CHECK ((length((tab_name)::text) <= 50))
);
CREATE TABLE public.adssecondaryliccomponents (
product_id bigint NOT NULL,
secondary_component_id bigint NOT NULL,
priority_id bigint
);
CREATE TABLE public.adssecretkeys (
secret_id bigint NOT NULL,
secret_key citext NOT NULL,
secret_value bytea,
CONSTRAINT adssecretkeys_965100496_c CHECK ((length((secret_key)::text) <= 250))
);
CREATE TABLE public.adssmartcarddetails (
smartcard_id bigint NOT NULL,
certificate_name citext NOT NULL,
certificate_file_name citext NOT NULL,
alias_name citext,
ca_dn citext NOT NULL,
expires_on bigint NOT NULL,
cretificate_mapping_attribute citext NOT NULL,
ad_mapping_attribute citext NOT NULL,
ocsp_server_name citext,
ocsp_server_port integer,
is_enabled boolean DEFAULT true,
CONSTRAINT adssmartcarddetails_1109396826_c CHECK ((length((certificate_file_name)::text) <= 1000)),
CONSTRAINT adssmartcarddetails_1251324567_c CHECK ((length((cretificate_mapping_attribute)::text) <= 100)),
CONSTRAINT adssmartcarddetails_1415386310_c CHECK ((length((alias_name)::text) <= 1000)),
CONSTRAINT adssmartcarddetails_1933191251_c CHECK ((length((certificate_name)::text) <= 250)),
CONSTRAINT adssmartcarddetails_1953945841_c CHECK ((length((ad_mapping_attribute)::text) <= 100)),
CONSTRAINT adssmartcarddetails_336831993_c CHECK ((length((ocsp_server_name)::text) <= 100)),
CONSTRAINT adssmartcarddetails_63905803_c CHECK ((length((ca_dn)::text) <= 1000))
);
CREATE TABLE public.adssmartcardvsdomain (
smartcard_id bigint NOT NULL,
domain_dns_name citext NOT NULL,
CONSTRAINT adssmartcardvsdomain_1966171420_c CHECK ((length((domain_dns_name)::text) <= 255))
);
CREATE TABLE public.adssmsapisettings (
provider_id bigint NOT NULL,
api_type citext NOT NULL,
api_id bytea,
user_name bytea,
password bytea,
access_param bytea,
port_speed citext DEFAULT '9600',
msg_center citext,
pin_number citext,
CONSTRAINT adssmsapisettings_1620104937_c CHECK ((length((port_speed)::text) <= 20)),
CONSTRAINT adssmsapisettings_1779625567_c CHECK ((length((api_type)::text) <= 50)),
CONSTRAINT adssmsapisettings_1886288211_c CHECK ((length((pin_number)::text) <= 8)),
CONSTRAINT adssmsapisettings_1936732915_c CHECK ((length((msg_center)::text) <= 20))
);
CREATE TABLE public.adssmsprovider (
provider_id bigint NOT NULL,
provider_name citext NOT NULL,
class_name citext NOT NULL,
display_name citext,
CONSTRAINT adssmsprovider_1245297639_c CHECK ((length((provider_name)::text) <= 250)),
CONSTRAINT adssmsprovider_224170258_c CHECK ((length((class_name)::text) <= 250)),
CONSTRAINT adssmsprovider_333046776_c CHECK ((length((display_name)::text) <= 250))
);
CREATE TABLE public.adssmsserverconfig (
provider_id bigint NOT NULL,
no_of_sms_sent bytea NOT NULL,
notify_admin citext DEFAULT '0' NOT NULL,
account_threshold bigint,
email_id citext,
mobile_no citext,
is_selected boolean DEFAULT false NOT NULL,
CONSTRAINT adssmsserverconfig_1543805118_c CHECK ((length((email_id)::text) <= 250)),
CONSTRAINT adssmsserverconfig_733847225_c CHECK ((length((notify_admin)::text) <= 10)),
CONSTRAINT adssmsserverconfig_884011394_c CHECK ((length((mobile_no)::text) <= 250))
);
CREATE TABLE public.adsssltooltracking (
entry_id bigint NOT NULL,
csr_download_count bigint DEFAULT '0',
zip_upload_count bigint DEFAULT '0',
cert_file_upload_count bigint DEFAULT '0',
cert_content_upload_count bigint DEFAULT '0'
);
CREATE TABLE public.adsssoconfig (
domain_dns_name citext NOT NULL,
account_name citext NOT NULL,
account_password bytea NOT NULL,
dns_server citext,
dns_site citext,
is_enabled boolean DEFAULT true NOT NULL,
CONSTRAINT adsssoconfig_1224328381_c CHECK ((length((dns_site)::text) <= 250)),
CONSTRAINT adsssoconfig_1966171420_c CHECK ((length((domain_dns_name)::text) <= 250)),
CONSTRAINT adsssoconfig_856894083_c CHECK ((length((account_name)::text) <= 250))
);
CREATE TABLE public.adsstatusboxes (
box_id bigint NOT NULL,
box_name citext NOT NULL,
box_style citext NOT NULL,
box_template_name citext,
lhs_icon_style citext,
is_slide_open boolean DEFAULT false NOT NULL,
close_icon_style citext,
close_action_script citext,
auto_close bigint DEFAULT '-1',
CONSTRAINT adsstatusboxes_1230799713_c CHECK ((length((box_name)::text) <= 250)),
CONSTRAINT adsstatusboxes_1548719890_c CHECK ((length((close_icon_style)::text) <= 250)),
CONSTRAINT adsstatusboxes_261086003_c CHECK ((length((close_action_script)::text) <= 250)),
CONSTRAINT adsstatusboxes_505110013_c CHECK ((length((box_style)::text) <= 250)),
CONSTRAINT adsstatusboxes_746283315_c CHECK ((length((lhs_icon_style)::text) <= 250)),
CONSTRAINT adsstatusboxes_850643044_c CHECK ((length((box_template_name)::text) <= 250))
);
CREATE TABLE public.adsstatusmessages (
message_id bigint NOT NULL,
module_id bigint NOT NULL,
box_id bigint NOT NULL,
message citext,
message_tag citext NOT NULL,
element_id citext NOT NULL,
request_param_name citext,
is_visible boolean DEFAULT false NOT NULL,
priority bigint NOT NULL,
CONSTRAINT adsstatusmessages_1061061982_c CHECK ((length((element_id)::text) <= 250)),
CONSTRAINT adsstatusmessages_1281143586_c CHECK ((length((message_tag)::text) <= 250)),
CONSTRAINT adsstatusmessages_1672907751_c CHECK ((length((message)::text) <= 250)),
CONSTRAINT adsstatusmessages_530387693_c CHECK ((length((request_param_name)::text) <= 250))
);
CREATE TABLE public.adsstatusmsgmodules (
module_id bigint NOT NULL,
module_name citext NOT NULL,
module_class citext,
priority bigint NOT NULL,
CONSTRAINT adsstatusmsgmodules_538193349_c CHECK ((length((module_class)::text) <= 250)),
CONSTRAINT adsstatusmsgmodules_987509886_c CHECK ((length((module_name)::text) <= 250))
);
CREATE TABLE public.adsstatusmsgmodulevstab (
tab_id bigint NOT NULL,
module_id bigint NOT NULL
);
CREATE TABLE public.adssystemdefaults (
unique_id bigint NOT NULL,
browser_title citext,
logo_path citext,
logo_width citext,
logo_height citext,
favicon_path citext,
theme_color citext,
time_zone citext,
date_time_format citext,
enable_forgot_pwd boolean DEFAULT true,
CONSTRAINT adssystemdefaults_1255615033_c CHECK ((length((logo_path)::text) <= 250)),
CONSTRAINT adssystemdefaults_1313431440_c CHECK ((length((favicon_path)::text) <= 250)),
CONSTRAINT adssystemdefaults_1394707155_c CHECK ((length((theme_color)::text) <= 250)),
CONSTRAINT adssystemdefaults_1441971746_c CHECK ((length((time_zone)::text) <= 250)),
CONSTRAINT adssystemdefaults_1766465983_c CHECK ((length((browser_title)::text) <= 250)),
CONSTRAINT adssystemdefaults_276048402_c CHECK ((length((logo_width)::text) <= 250)),
CONSTRAINT adssystemdefaults_465428933_c CHECK ((length((logo_height)::text) <= 250)),
CONSTRAINT adssystemdefaults_907902616_c CHECK ((length((date_time_format)::text) <= 250))
);
CREATE TABLE public.adstabs (
tab_id bigint NOT NULL,
tab_name citext NOT NULL,
tab_display_name citext NOT NULL,
tab_url citext NOT NULL,
priority bigint NOT NULL,
CONSTRAINT adstabs_2122729618_c CHECK ((length((tab_display_name)::text) <= 100)),
CONSTRAINT adstabs_834340475_c CHECK ((length((tab_url)::text) <= 255)),
CONSTRAINT adstabs_94975723_c CHECK ((length((tab_name)::text) <= 100))
);
CREATE TABLE public.adstfabackupverificationcode (
code_id bigint NOT NULL,
enrollment_id bigint NOT NULL,
verification_code bytea NOT NULL
);
CREATE TABLE public.adstfabvcuserenrollement (
login_name citext NOT NULL,
domain_name citext NOT NULL,
enrollment_id bigint NOT NULL,
generated_time bigint DEFAULT '0',
CONSTRAINT adstfabvcuserenrollement_1233167935_c CHECK ((length((login_name)::text) <= 125)),
CONSTRAINT adstfabvcuserenrollement_2008335066_c CHECK ((length((domain_name)::text) <= 125))
);
CREATE TABLE public.adstfaenrollment (
user_id bigint NOT NULL,
mode_id bigint NOT NULL,
is_enrolled boolean DEFAULT false NOT NULL,
is_verified boolean DEFAULT false NOT NULL,
attribute_value citext NOT NULL,
CONSTRAINT adstfaenrollment_1361570254_c CHECK ((length((attribute_value)::text) <= 250))
);
CREATE TABLE public.adstfamodeparams (
mode_id bigint NOT NULL,
param_name citext NOT NULL,
param_display_name citext,
param_value citext NOT NULL,
CONSTRAINT adstfamodeparams_1487027866_c CHECK ((length((param_display_name)::text) <= 250)),
CONSTRAINT adstfamodeparams_967657245_c CHECK ((length((param_name)::text) <= 50))
);
CREATE TABLE public.adstfaprovidermodes (
mode_id bigint NOT NULL,
mode_name citext NOT NULL,
mode_display_name citext,
provider_id bigint NOT NULL,
provider_display_name citext,
enabled boolean DEFAULT false NOT NULL,
config_url citext,
help_url citext,
is_primary boolean DEFAULT true NOT NULL,
CONSTRAINT adstfaprovidermodes_1317895890_c CHECK ((length((config_url)::text) <= 250)),
CONSTRAINT adstfaprovidermodes_1923317866_c CHECK ((length((provider_display_name)::text) <= 100)),
CONSTRAINT adstfaprovidermodes_217077028_c CHECK ((length((mode_display_name)::text) <= 250)),
CONSTRAINT adstfaprovidermodes_5851311_c CHECK ((length((help_url)::text) <= 1000)),
CONSTRAINT adstfaprovidermodes_794265511_c CHECK ((length((mode_name)::text) <= 100))
);
CREATE TABLE public.adstfatrust (
id bigint NOT NULL,
login_name citext NOT NULL,
domain_name citext NOT NULL,
mode_id bigint NOT NULL,
ip citext NOT NULL,
user_agent citext NOT NULL,
"time" bigint DEFAULT '0',
CONSTRAINT adstfatrust_1233167935_c CHECK ((length((login_name)::text) <= 255)),
CONSTRAINT adstfatrust_2008335066_c CHECK ((length((domain_name)::text) <= 250)),
CONSTRAINT adstfatrust_2343_c CHECK ((length((ip)::text) <= 250)),
CONSTRAINT adstfatrust_975942287_c CHECK ((length((user_agent)::text) <= 1000))
);
CREATE TABLE public.adstfatrustedbrowser (
unique_id bigint NOT NULL,
user_id bigint,
started_time bigint NOT NULL,
ip_address citext NOT NULL,
user_agent citext NOT NULL,
CONSTRAINT adstfatrustedbrowser_1900462268_c CHECK ((length((ip_address)::text) <= 250)),
CONSTRAINT adstfatrustedbrowser_975942287_c CHECK ((length((user_agent)::text) <= 250))
);
CREATE TABLE public.adstfauserenrollment (
login_name citext NOT NULL,
domain_name citext NOT NULL,
mode_id bigint NOT NULL,
is_enrolled boolean DEFAULT false NOT NULL,
attribute_value bytea NOT NULL,
CONSTRAINT adstfauserenrollment_1233167935_c CHECK ((length((login_name)::text) <= 125)),
CONSTRAINT adstfauserenrollment_2008335066_c CHECK ((length((domain_name)::text) <= 125))
);
CREATE TABLE public.adsusersbadloginstatus (
login_name citext NOT NULL,
domain_name citext NOT NULL,
bad_login_count integer NOT NULL,
last_bad_login_time timestamp without time zone NOT NULL,
first_bad_login_time timestamp without time zone NOT NULL,
blocking_status integer DEFAULT 0,
CONSTRAINT adsusersbadloginstatus_1233167935_c CHECK ((length((login_name)::text) <= 100)),
CONSTRAINT adsusersbadloginstatus_2008335066_c CHECK ((length((domain_name)::text) <= 100))
);
CREATE TABLE public.adsusersvsrunqueryoperations (
user_id bigint NOT NULL,
sql_task_id bigint NOT NULL
);
CREATE TABLE public.adsuservslocale (
user_id bigint NOT NULL,
locale_id bigint NOT NULL
);
CREATE TABLE public.adsuservsnotification (
notification_id bigint NOT NULL,
user_id bigint NOT NULL,
is_enabled boolean DEFAULT true NOT NULL
);
CREATE TABLE public.adsvpnprovider (
vpn_provider_id bigint NOT NULL,
vpn_name citext NOT NULL,
vpn_display_name citext NOT NULL,
vpn_type bigint,
priority bigint,
CONSTRAINT adsvpnprovider_133119210_c CHECK ((length((vpn_name)::text) <= 250)),
CONSTRAINT adsvpnprovider_468365715_c CHECK ((length((vpn_display_name)::text) <= 1000))
);
CREATE TABLE public.adsvpnproviderparams (
provider_param_id bigint NOT NULL,
adsvpnprovider_id bigint,
param_name citext,
param_value citext,
CONSTRAINT adsvpnproviderparams_60008705_c CHECK ((length((param_value)::text) <= 5000)),
CONSTRAINT adsvpnproviderparams_967657245_c CHECK ((length((param_name)::text) <= 5000))
);
CREATE TABLE public.adsvpnprovidersettings (
provider_config_id bigint NOT NULL,
adsvpnprovider_id bigint,
vpn_server_name citext NOT NULL,
vpn_port_no citext NOT NULL,
is_vpn_enabled boolean DEFAULT false,
CONSTRAINT adsvpnprovidersettings_1598445796_c CHECK ((length((vpn_server_name)::text) <= 250)),
CONSTRAINT adsvpnprovidersettings_681402836_c CHECK ((length((vpn_port_no)::text) <= 250))
);
CREATE TABLE public.adswebsocketconfig (
websocket_id bigint NOT NULL,
websocket_name citext NOT NULL,
websocket_class citext NOT NULL,
CONSTRAINT adswebsocketconfig_1007538141_c CHECK ((length((websocket_name)::text) <= 100)),
CONSTRAINT adswebsocketconfig_1178753344_c CHECK ((length((websocket_class)::text) <= 250))
);
CREATE TABLE public.aduserprops (
userid bigint NOT NULL,
objectguid citext,
distinguishedname citext,
lookup_oguid citext,
userprincipalname citext,
CONSTRAINT aduserprops_1168880557_c CHECK ((length((lookup_oguid)::text) <= 150)),
CONSTRAINT aduserprops_1552510536_c CHECK ((length((objectguid)::text) <= 150)),
CONSTRAINT aduserprops_299182639_c CHECK ((length((distinguishedname)::text) <= 1000)),
CONSTRAINT aduserprops_945808978_c CHECK ((length((userprincipalname)::text) <= 1024))
);
CREATE TABLE public.advmatrixreportdetails (
reportid bigint NOT NULL,
row_group1 bigint NOT NULL,
row_group2 bigint,
row_group3 bigint,
row_group4 bigint,
row_group5 bigint,
column_group bigint NOT NULL,
column_group_by citext,
column_group2 bigint,
column_group_by2 citext,
column_group3 bigint,
column_group_by3 citext,
column_group4 bigint,
column_group_by4 citext,
column_group5 bigint,
column_group_by5 citext,
summary_column bigint,
summary_type citext,
CONSTRAINT advmatrixreportdetails_1503594699_c CHECK ((length((column_group_by5)::text) <= 30)),
CONSTRAINT advmatrixreportdetails_1503594700_c CHECK ((length((column_group_by4)::text) <= 30)),
CONSTRAINT advmatrixreportdetails_1503594701_c CHECK ((length((column_group_by3)::text) <= 30)),
CONSTRAINT advmatrixreportdetails_1503594702_c CHECK ((length((column_group_by2)::text) <= 30)),
CONSTRAINT advmatrixreportdetails_262057901_c CHECK ((length((summary_type)::text) <= 10)),
CONSTRAINT advmatrixreportdetails_505686272_c CHECK ((length((column_group_by)::text) <= 30))
);
CREATE TABLE public.agentaudit (
auditid bigint NOT NULL,
workstationid bigint NOT NULL,
auditstatus citext DEFAULT 'SUCCESS' NOT NULL,
errorcode integer DEFAULT 0 NOT NULL,
action citext,
userid bigint,
audittime bigint NOT NULL,
CONSTRAINT agentaudit_1925345846_c CHECK ((length((action)::text) <= 20)),
CONSTRAINT agentaudit_641503379_c CHECK ((length((auditstatus)::text) <= 19))
);
CREATE TABLE public.agentinfo (
workstationid bigint NOT NULL,
agentversion citext,
is_rds_prompt boolean DEFAULT true NOT NULL,
CONSTRAINT agentinfo_1714339277_c CHECK ((length((agentversion)::text) <= 250))
);
CREATE TABLE public.agentsettings (
paramid bigint NOT NULL,
paramname citext NOT NULL,
paramvalue citext NOT NULL,
description citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT agentsettings_428414940_c CHECK ((length((description)::text) <= 2000)),
CONSTRAINT agentsettings_446338168_c CHECK ((length((paramname)::text) <= 2000))
);
CREATE TABLE public.agreementproducts (
agproductid bigint NOT NULL,
agreementid bigint NOT NULL,
softwareid bigint NOT NULL,
licensetypeid bigint DEFAULT '1' NOT NULL,
licenseoptionid bigint NOT NULL,
installationscount bigint,
licensecost double DEFAULT '0' NOT NULL,
licensekey citext,
CONSTRAINT agreementproducts_921038210_c CHECK ((length((licensekey)::text) <= 100))
);
CREATE TABLE public.agreementstatus (
statusid bigint NOT NULL,
statusname citext NOT NULL,
displayname citext NOT NULL,
description citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT agreementstatus_426904019_c CHECK ((length((displayname)::text) <= 100)),
CONSTRAINT agreementstatus_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT agreementstatus_733867389_c CHECK ((length((statusname)::text) <= 100))
);
CREATE TABLE public.ai_accuracydetails (
id bigint NOT NULL,
modelid citext NOT NULL,
moduleid bigint NOT NULL,
accuracy_on bigint NOT NULL,
accuracy integer NOT NULL,
CONSTRAINT ai_accuracydetails_1944940004_c CHECK ((length((modelid)::text) <= 100))
);
CREATE TABLE public.ai_module (
moduleid bigint NOT NULL,
modulename citext NOT NULL,
actionname citext NOT NULL,
displayname citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
training_enabled boolean DEFAULT true NOT NULL,
action_enabled boolean DEFAULT false NOT NULL,
is_default_training boolean DEFAULT false NOT NULL,
initiatedby bigint DEFAULT '1',
CONSTRAINT ai_module_1957242431_c CHECK ((length((actionname)::text) <= 100)),
CONSTRAINT ai_module_384305417_c CHECK ((length((modulename)::text) <= 25)),
CONSTRAINT ai_module_426904019_c CHECK ((length((displayname)::text) <= 100))
);
CREATE TABLE public.ai_properties (
propid bigint NOT NULL,
propname citext NOT NULL,
propvalue citext,
description citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT ai_properties_2079171534_c CHECK ((length((propvalue)::text) <= 250)),
CONSTRAINT ai_properties_210262930_c CHECK ((length((propname)::text) <= 250)),
CONSTRAINT ai_properties_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.ai_task_input (
instance_id bigint NOT NULL,
jobid bigint NOT NULL,
userid bigint,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.ai_trainingdetail (
trainingid bigint NOT NULL,
jobid bigint NOT NULL,
firstrecord bigint NOT NULL,
lastrecord bigint NOT NULL,
recordcount bigint NOT NULL,
status citext DEFAULT '25' NOT NULL,
starttime bigint,
endtime bigint,
operation citext NOT NULL,
CONSTRAINT ai_trainingdetail_154330439_c CHECK ((length((operation)::text) <= 25)),
CONSTRAINT ai_trainingdetail_1839152142_c CHECK ((length((status)::text) <= 50))
);
CREATE TABLE public.ai_trainingjob (
jobid bigint NOT NULL,
name citext NOT NULL,
moduleid bigint,
duration integer,
durationtype citext,
fromdate bigint,
todate bigint,
rows integer,
CONSTRAINT ai_trainingjob_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT ai_trainingjob_382786254_c CHECK ((length((durationtype)::text) <= 10))
);
CREATE TABLE public.ai_wodiscarddetails (
id bigint NOT NULL,
workorderid bigint NOT NULL,
action citext NOT NULL,
is_recommended boolean DEFAULT false NOT NULL,
is_applied boolean DEFAULT false NOT NULL,
istech_discarded boolean DEFAULT false NOT NULL,
isuser_discarded boolean DEFAULT false NOT NULL,
CONSTRAINT ai_wodiscarddetails_1925345846_c CHECK ((length((action)::text) <= 250))
);
CREATE TABLE public.ai_wosuggestion (
suggestionid bigint NOT NULL,
workorderid bigint NOT NULL,
categoryid bigint,
templateid bigint
);
CREATE TABLE public.ai_ziamodel (
id bigint NOT NULL,
moduleid bigint NOT NULL,
modelid citext NOT NULL,
enabled boolean DEFAULT true NOT NULL,
trainingid bigint,
accuracy integer,
lastupdatetime bigint NOT NULL,
lastupdatedby bigint NOT NULL,
CONSTRAINT ai_ziamodel_1944940004_c CHECK ((length((modelid)::text) <= 100))
);
CREATE TABLE public.aixserver (
ciid bigint NOT NULL
);
CREATE TABLE public.aixworkstation (
ciid bigint NOT NULL
);
CREATE TABLE public.all_share_list (
shareid bigint NOT NULL,
for_all citext NOT NULL,
CONSTRAINT all_share_list_41074923_c CHECK ((length((for_all)::text) <= 50))
);
CREATE TABLE public.allowedpattern (
column_id bigint NOT NULL,
pattern citext NOT NULL
);
CREATE TABLE public.allowedvalues (
column_id bigint NOT NULL,
value citext NOT NULL,
CONSTRAINT allowedvalues_81434961_c CHECK ((length((value)::text) <= 180))
);
CREATE TABLE public.androidrestrictionsinfo (
resourceid bigint NOT NULL,
allow_camera integer DEFAULT 2 NOT NULL,
allow_background_data integer DEFAULT 2 NOT NULL,
activate_data_network integer DEFAULT 2 NOT NULL,
allow_bluetooth integer DEFAULT 2 NOT NULL,
allow_nfc integer DEFAULT 2 NOT NULL,
device_admin_enabled integer DEFAULT 2 NOT NULL
);
CREATE TABLE public.announcement (
announceid bigint NOT NULL,
title citext NOT NULL,
ispublic boolean DEFAULT true NOT NULL,
date_from bigint NOT NULL,
date_to bigint DEFAULT '0',
createddate bigint NOT NULL,
message citext NOT NULL,
userid bigint NOT NULL,
has_user_group boolean DEFAULT false NOT NULL,
announcementtypeid bigint,
dc_announcementid bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
priorityid bigint,
CONSTRAINT announcement_79833656_c CHECK ((length((title)::text) <= 250))
);
CREATE TABLE public.announcementservicemapping (
mappingid bigint NOT NULL,
serviceid bigint NOT NULL,
announceid bigint NOT NULL
);
CREATE TABLE public.announcementtype (
announcementtypeid bigint NOT NULL,
name citext NOT NULL,
description citext,
isdeleted boolean DEFAULT false,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT announcementtype_2388619_c CHECK ((length((name)::text) <= 250)),
CONSTRAINT announcementtype_428414940_c CHECK ((length((description)::text) <= 1000))
);
CREATE TABLE public.announcementugmapping (
mappingid bigint NOT NULL,
usergroupid bigint NOT NULL,
announceid bigint NOT NULL
);
CREATE TABLE public.apacheci (
ciid bigint NOT NULL
);
CREATE TABLE public.apiallowedremotehosts (
allowedhostid bigint NOT NULL,
ipaddress citext NOT NULL,
hostname citext NOT NULL,
CONSTRAINT apiallowedremotehosts_1538992947_c CHECK ((length((ipaddress)::text) <= 50)),
CONSTRAINT apiallowedremotehosts_482823219_c CHECK ((length((hostname)::text) <= 100))
);
CREATE TABLE public.apisettings (
settingid bigint NOT NULL,
isapienabled boolean DEFAULT true NOT NULL,
isnewapiregenabled boolean DEFAULT true NOT NULL,
enableapilogs boolean DEFAULT true NOT NULL,
fetch_size integer DEFAULT 50 NOT NULL,
default_return_columns integer DEFAULT 10 NOT NULL,
display_date_format citext DEFAULT 'MM-dd-yyyy HH:mm' NOT NULL,
compare_date_format citext DEFAULT 'yyyy-MM-DD' NOT NULL,
replacenullas citext DEFAULT '(null)' NOT NULL,
isrestrictedaccess boolean DEFAULT false NOT NULL,
apiversion citext NOT NULL,
CONSTRAINT apisettings_2002698635_c CHECK ((length((display_date_format)::text) <= 50)),
CONSTRAINT apisettings_499857106_c CHECK ((length((compare_date_format)::text) <= 50)),
CONSTRAINT apisettings_661094285_c CHECK ((length((replacenullas)::text) <= 50)),
CONSTRAINT apisettings_989781374_c CHECK ((length((apiversion)::text) <= 20))
);
CREATE TABLE public.apistatuscodes (
code bigint NOT NULL,
message citext NOT NULL,
description citext,
CONSTRAINT apistatuscodes_1672907751_c CHECK ((length((message)::text) <= 150)),
CONSTRAINT apistatuscodes_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.applicationci (
ciid bigint NOT NULL
);
CREATE TABLE public.applicationserver (
ciid bigint NOT NULL
);
CREATE TABLE public.applicationstatus (
uid bigint NOT NULL,
startuptime bigint,
shutdowntime bigint
);
CREATE TABLE public.approval_messageid (
approval_entityid bigint NOT NULL,
approvalid bigint,
messageid citext NOT NULL,
CONSTRAINT approval_messageid_1346582338_c CHECK ((length((messageid)::text) <= 250))
);
CREATE TABLE public.approvalclarification (
approvalid bigint NOT NULL,
commentid bigint NOT NULL,
is_resolved boolean DEFAULT false,
resolved_by bigint,
resolved_time bigint
);
CREATE TABLE public.approvalconfigurations (
config_id bigint NOT NULL,
category citext NOT NULL,
parameter citext NOT NULL,
paramvalue citext DEFAULT 'false' NOT NULL,
description citext DEFAULT '-' NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT approvalconfigurations_428414940_c CHECK ((length((description)::text) <= 200)),
CONSTRAINT approvalconfigurations_446088073_c CHECK ((length((parameter)::text) <= 100)),
CONSTRAINT approvalconfigurations_833137918_c CHECK ((length((category)::text) <= 100)),
CONSTRAINT approvalconfigurations_958969092_c CHECK ((length((paramvalue)::text) <= 100))
);
CREATE TABLE public.approvaldetails (
approvalid bigint NOT NULL,
approval_level_id bigint NOT NULL,
sender_id bigint,
sent_time bigint,
approval_stageid bigint,
email citext,
action_date bigint,
statusid bigint,
comments citext,
approval_key bytea,
approvedby bigint,
approverid bigint,
isdeleted boolean DEFAULT false,
stageid bigint DEFAULT '1' NOT NULL,
org_roleid bigint,
obo_approverid bigint,
CONSTRAINT approvaldetails_66081660_c CHECK ((length((email)::text) <= 3500))
);
CREATE TABLE public.approvalhistory (
approval_historyid bigint NOT NULL,
approvalid bigint,
approval_level_id bigint,
action_date bigint,
statusid bigint,
comments citext,
approvedby bigint,
action_mode citext
);
CREATE TABLE public.approvallevel (
id bigint NOT NULL,
level integer NOT NULL,
name citext NOT NULL,
status_id bigint NOT NULL,
rule citext NOT NULL,
comments citext,
action_by bigint,
action_on bigint,
is_deleted boolean DEFAULT false NOT NULL,
created_by bigint,
created_on bigint,
CONSTRAINT approvallevel_3373707_c CHECK ((length((name)::text) <= 200)),
CONSTRAINT approvallevel_3512060_c CHECK ((length((rule)::text) <= 100))
);
CREATE TABLE public.approvalreminder (
reminderid bigint NOT NULL,
approvalid bigint NOT NULL,
clarificationid bigint,
appr_remind_time bigint,
reminder_count bigint DEFAULT '0',
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.approvalresetconfig (
configid bigint NOT NULL,
columnname citext NOT NULL,
CONSTRAINT approvalresetconfig_1619616031_c CHECK ((length((columnname)::text) <= 50))
);
CREATE TABLE public.approvalrule (
rule_id bigint NOT NULL,
rule_name citext NOT NULL,
rule_type citext NOT NULL,
rule_value citext,
CONSTRAINT approvalrule_723950062_c CHECK ((length((rule_name)::text) <= 100)),
CONSTRAINT approvalrule_724151965_c CHECK ((length((rule_type)::text) <= 100)),
CONSTRAINT approvalrule_975003214_c CHECK ((length((rule_value)::text) <= 5000))
);
CREATE TABLE public.approvalstage (
approval_stageid bigint NOT NULL,
userid bigint,
sent_date bigint,
statusid bigint
);
CREATE TABLE public.approvalstagedefinition (
stageid bigint NOT NULL,
stagename citext NOT NULL,
internalstagename citext NOT NULL,
CONSTRAINT approvalstagedefinition_1027615820_c CHECK ((length((internalstagename)::text) <= 100)),
CONSTRAINT approvalstagedefinition_329293417_c CHECK ((length((stagename)::text) <= 100))
);
CREATE TABLE public.approvalstagemapping (
approval_stageid bigint NOT NULL,
workorderid bigint NOT NULL
);
CREATE TABLE public.approvalstatusdefinition (
statusid bigint NOT NULL,
statusname citext NOT NULL,
statusdescription citext,
CONSTRAINT approvalstatusdefinition_502347606_c CHECK ((length((statusdescription)::text) <= 250)),
CONSTRAINT approvalstatusdefinition_733867389_c CHECK ((length((statusname)::text) <= 100))
);
CREATE TABLE public.apprstagetochange (
approval_stageid bigint NOT NULL,
changeid bigint NOT NULL,
stageid bigint
);
CREATE TABLE public.arc_all_share_list (
shareid bigint NOT NULL,
for_all citext NOT NULL,
CONSTRAINT arc_all_share_list_41074923_c CHECK ((length((for_all)::text) <= 50))
);
CREATE TABLE public.arc_approvaldetails (
approvalid bigint NOT NULL,
approval_level_id bigint DEFAULT '-1' NOT NULL,
email citext,
action_date bigint,
status citext,
comments citext,
approval_key citext,
approvedby bigint,
approverid bigint,
obo_approverid bigint,
CONSTRAINT arc_approvaldetails_1752379837_c CHECK ((length((approval_key)::text) <= 3500)),
CONSTRAINT arc_approvaldetails_1839152142_c CHECK ((length((status)::text) <= 100)),
CONSTRAINT arc_approvaldetails_66081660_c CHECK ((length((email)::text) <= 3500))
);
CREATE TABLE public.arc_approvalhistory (
approval_historyid bigint NOT NULL,
approvalid bigint NOT NULL,
action_date bigint,
status citext,
comments citext,
approvedby bigint,
CONSTRAINT arc_approvalhistory_1839152142_c CHECK ((length((status)::text) <= 100))
);
CREATE TABLE public.arc_approvalstage (
approval_stageid bigint NOT NULL,
workorderid bigint NOT NULL,
userid bigint,
sent_date bigint,
status citext,
CONSTRAINT arc_approvalstage_1839152142_c CHECK ((length((status)::text) <= 100))
);
CREATE TABLE public.arc_chargesimages (
chargeid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.arc_chargestable (
chargeid bigint NOT NULL,
technicianid bigint,
createdby bigint NOT NULL,
description citext,
timespent bigint DEFAULT '0' NOT NULL,
tech_charge double DEFAULT '0' NOT NULL,
other_charge double DEFAULT '0' NOT NULL,
total_charge double DEFAULT '0' NOT NULL,
createdtime bigint,
ts_starttime bigint,
ts_endtime bigint,
worklogtypename citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT arc_chargestable_1611568072_c CHECK ((length((worklogtypename)::text) <= 100))
);
CREATE TABLE public.arc_commentimages (
commentid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.arc_conv_attachment (
attachmentid bigint NOT NULL,
conversationid bigint NOT NULL
);
CREATE TABLE public.arc_conv_history (
historyid bigint NOT NULL,
conversationid bigint NOT NULL,
operationownerid bigint NOT NULL,
operationtime bigint NOT NULL,
description citext,
operation citext DEFAULT 'CREATE',
CONSTRAINT arc_conv_history_154330439_c CHECK ((length((operation)::text) <= 50))
);
CREATE TABLE public.arc_conv_historydiff (
historydiffid bigint NOT NULL,
historyid bigint NOT NULL,
columnname citext NOT NULL,
prev_value citext,
current_value citext,
CONSTRAINT arc_conv_historydiff_1619616031_c CHECK ((length((columnname)::text) <= 30))
);
CREATE TABLE public.arc_conv_recipients (
conversationid bigint NOT NULL,
recipient_name citext,
recipient_email citext NOT NULL,
to_cc_bcc citext,
CONSTRAINT arc_conv_recipients_1813314833_c CHECK ((length((recipient_name)::text) <= 250)),
CONSTRAINT arc_conv_recipients_370219446_c CHECK ((length((recipient_email)::text) <= 250)),
CONSTRAINT arc_conv_recipients_862828025_c CHECK ((length((to_cc_bcc)::text) <= 250))
);
CREATE TABLE public.arc_conversation (
conversationid bigint NOT NULL,
workorderid bigint NOT NULL,
requesterid bigint NOT NULL,
createdtime bigint DEFAULT '0' NOT NULL,
title citext,
child_woid bigint,
ispublic boolean DEFAULT true NOT NULL,
CONSTRAINT arc_conversation_79833656_c CHECK ((length((title)::text) <= 250))
);
CREATE TABLE public.arc_department_share_list (
shareid bigint NOT NULL,
deptname citext DEFAULT '-',
sitename citext DEFAULT '-',
CONSTRAINT arc_department_share_list_1458589266_c CHECK ((length((sitename)::text) <= 100)),
CONSTRAINT arc_department_share_list_1730526800_c CHECK ((length((deptname)::text) <= 100))
);
CREATE TABLE public.arc_externaltask (
taskid bigint NOT NULL,
createdby bigint NOT NULL,
createdtime bigint NOT NULL
);
CREATE TABLE public.arc_externaltaskdetails (
paramid bigint NOT NULL,
taskid bigint NOT NULL,
paramname citext NOT NULL,
paramvalue citext NOT NULL,
CONSTRAINT arc_externaltaskdetails_446338168_c CHECK ((length((paramname)::text) <= 250)),
CONSTRAINT arc_externaltaskdetails_958969092_c CHECK ((length((paramvalue)::text) <= 3000))
);
CREATE TABLE public.arc_group_share_list (
shareid bigint NOT NULL,
queuename citext DEFAULT '-',
sitename citext DEFAULT '-',
CONSTRAINT arc_group_share_list_1047900924_c CHECK ((length((queuename)::text) <= 100)),
CONSTRAINT arc_group_share_list_1458589266_c CHECK ((length((sitename)::text) <= 100))
);
CREATE TABLE public.arc_hold_period_group (
hold_period_id bigint NOT NULL,
assessmentid bigint NOT NULL,
hold_time bigint NOT NULL,
hold_off_time bigint,
hold_period bigint
);
CREATE TABLE public.arc_hold_period_tech (
hold_period_id bigint NOT NULL,
assessmentid bigint NOT NULL,
hold_time bigint NOT NULL,
hold_off_time bigint,
hold_period bigint
);
CREATE TABLE public.arc_incicausedbychange (
workorderid bigint NOT NULL,
changeid bigint NOT NULL
);
CREATE TABLE public.arc_incitochangemapping (
workorderid bigint NOT NULL,
changeid bigint NOT NULL
);
CREATE TABLE public.arc_modulechecklist (
checklistid bigint NOT NULL,
title citext NOT NULL,
description citext,
status citext,
checklistorder bigint NOT NULL,
CONSTRAINT arc_modulechecklist_1839152142_c CHECK ((length((status)::text) <= 100)),
CONSTRAINT arc_modulechecklist_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT arc_modulechecklist_79833656_c CHECK ((length((title)::text) <= 100))
);
CREATE TABLE public.arc_modulechecklistitem (
checklistitemid bigint NOT NULL,
checklistid bigint NOT NULL,
fieldname citext NOT NULL,
field_type citext NOT NULL,
cl_bool boolean DEFAULT false NOT NULL,
cl_char citext,
cl_long bigint,
comments citext,
lastupdatedby bigint,
lastupdatedtime bigint,
iscompleted boolean DEFAULT false NOT NULL,
checklistitemorder bigint NOT NULL,
options citext,
help_text citext,
CONSTRAINT arc_modulechecklistitem_1091506047_c CHECK ((length((field_type)::text) <= 30)),
CONSTRAINT arc_modulechecklistitem_1598821740_c CHECK ((length((cl_char)::text) <= 500)),
CONSTRAINT arc_modulechecklistitem_180211188_c CHECK ((length((comments)::text) <= 5000)),
CONSTRAINT arc_modulechecklistitem_181432469_c CHECK ((length((help_text)::text) <= 250)),
CONSTRAINT arc_modulechecklistitem_242409883_c CHECK ((length((fieldname)::text) <= 100)),
CONSTRAINT arc_modulechecklistitem_531492226_c CHECK ((length((options)::text) <= 5000))
);
CREATE TABLE public.arc_notesattachment (
notesid bigint NOT NULL,
attachmentid bigint NOT NULL
);
CREATE TABLE public.arc_notesimages (
notesid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.arc_notification (
notificationid bigint NOT NULL,
notificationtitle citext,
notificationdate bigint DEFAULT '0' NOT NULL,
senderid bigint NOT NULL,
recipientid bigint,
messageid citext DEFAULT '-' NOT NULL,
notificationtype citext,
ispublic boolean DEFAULT true NOT NULL,
old_conv_id bigint,
CONSTRAINT arc_notification_1346582338_c CHECK ((length((messageid)::text) <= 250)),
CONSTRAINT arc_notification_1634626515_c CHECK ((length((notificationtitle)::text) <= 500)),
CONSTRAINT arc_notification_1886948005_c CHECK ((length((notificationtype)::text) <= 50))
);
CREATE TABLE public.arc_notificationimages (
notificationid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.arc_notify_attachments (
attachmentid bigint NOT NULL,
notificationid bigint NOT NULL
);
CREATE TABLE public.arc_notify_recipients (
notificationid bigint NOT NULL,
recipient_email citext NOT NULL,
to_cc_bcc citext,
CONSTRAINT arc_notify_recipients_370219446_c CHECK ((length((recipient_email)::text) <= 250)),
CONSTRAINT arc_notify_recipients_862828025_c CHECK ((length((to_cc_bcc)::text) <= 250))
);
CREATE TABLE public.arc_notify_workorder (
notificationid bigint NOT NULL,
workorderid bigint NOT NULL,
child_woid bigint,
is_bcc_reply boolean DEFAULT false NOT NULL
);
CREATE TABLE public.arc_probtoincidentmapping (
problemid bigint NOT NULL,
workorderid bigint NOT NULL
);
CREATE TABLE public.arc_request_approvallevel (
entityid bigint NOT NULL,
levelid bigint NOT NULL,
name citext NOT NULL,
level integer NOT NULL,
status_id bigint,
CONSTRAINT arc_request_approvallevel_3373707_c CHECK ((length((name)::text) <= 200))
);
CREATE TABLE public.arc_requestnotificationhistory (
historyid bigint NOT NULL,
conversationid bigint NOT NULL,
operationownerid bigint NOT NULL,
operationtime bigint NOT NULL,
description citext,
operation citext DEFAULT 'CREATE',
CONSTRAINT arc_requestnotificationhistory_154330439_c CHECK ((length((operation)::text) <= 50))
);
CREATE TABLE public.arc_requestresolution (
requestid bigint NOT NULL,
technicianid bigint NOT NULL,
resolution citext,
lastupdatedtime bigint NOT NULL
);
CREATE TABLE public.arc_requestslaescalations (
id bigint NOT NULL,
itemid bigint NOT NULL,
level bigint NOT NULL,
escalation_type citext NOT NULL,
escalationtime bigint NOT NULL,
CONSTRAINT arc_requestslaescalations_825179812_c CHECK ((length((escalation_type)::text) <= 10))
);
CREATE TABLE public.arc_servicecatalog_fields (
workorderid bigint NOT NULL
);
CREATE TABLE public.arc_servicereq_app (
workorderid bigint NOT NULL,
udf_char1 citext,
CONSTRAINT arc_servicereq_app_278184717_c CHECK ((length((udf_char1)::text) <= 3500))
);
CREATE TABLE public.arc_servicereq_comm (
workorderid bigint NOT NULL
);
CREATE TABLE public.arc_servicereq_data (
workorderid bigint NOT NULL
);
CREATE TABLE public.arc_servicereq_email (
workorderid bigint NOT NULL,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
udf_char5 citext,
udf_char6 citext,
udf_char7 citext,
CONSTRAINT arc_servicereq_email_278184711_c CHECK ((length((udf_char7)::text) <= 3500)),
CONSTRAINT arc_servicereq_email_278184712_c CHECK ((length((udf_char6)::text) <= 3500)),
CONSTRAINT arc_servicereq_email_278184713_c CHECK ((length((udf_char5)::text) <= 3500)),
CONSTRAINT arc_servicereq_email_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT arc_servicereq_email_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT arc_servicereq_email_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT arc_servicereq_email_278184717_c CHECK ((length((udf_char1)::text) <= 3500))
);
CREATE TABLE public.arc_servicereq_hw (
workorderid bigint NOT NULL,
udf_char1 citext,
CONSTRAINT arc_servicereq_hw_278184717_c CHECK ((length((udf_char1)::text) <= 3500))
);
CREATE TABLE public.arc_servicereq_net (
workorderid bigint NOT NULL,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
udf_date1 bigint,
udf_char5 citext,
CONSTRAINT arc_servicereq_net_278184713_c CHECK ((length((udf_char5)::text) <= 3500)),
CONSTRAINT arc_servicereq_net_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT arc_servicereq_net_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT arc_servicereq_net_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT arc_servicereq_net_278184717_c CHECK ((length((udf_char1)::text) <= 3500))
);
CREATE TABLE public.arc_servicereq_sw (
workorderid bigint NOT NULL,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
CONSTRAINT arc_servicereq_sw_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT arc_servicereq_sw_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT arc_servicereq_sw_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT arc_servicereq_sw_278184717_c CHECK ((length((udf_char1)::text) <= 3500))
);
CREATE TABLE public.arc_servicereq_user (
workorderid bigint NOT NULL,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
udf_char5 citext,
udf_char6 citext,
udf_char7 citext,
CONSTRAINT arc_servicereq_user_278184711_c CHECK ((length((udf_char7)::text) <= 3500)),
CONSTRAINT arc_servicereq_user_278184712_c CHECK ((length((udf_char6)::text) <= 3500)),
CONSTRAINT arc_servicereq_user_278184713_c CHECK ((length((udf_char5)::text) <= 3500)),
CONSTRAINT arc_servicereq_user_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT arc_servicereq_user_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT arc_servicereq_user_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT arc_servicereq_user_278184717_c CHECK ((length((udf_char1)::text) <= 3500))
);
CREATE TABLE public.arc_site_share_list (
shareid bigint NOT NULL,
sitename citext DEFAULT '-',
CONSTRAINT arc_site_share_list_1458589266_c CHECK ((length((sitename)::text) <= 100))
);
CREATE TABLE public.arc_solutiontorequest (
mappingid bigint NOT NULL,
requestid bigint NOT NULL,
solutionid bigint NOT NULL,
associationtype citext NOT NULL,
comments citext,
associatedby bigint NOT NULL,
associatedtime bigint,
CONSTRAINT arc_solutiontorequest_1125982437_c CHECK ((length((associationtype)::text) <= 100)),
CONSTRAINT arc_solutiontorequest_180211188_c CHECK ((length((comments)::text) <= 3000))
);
CREATE TABLE public.arc_spacetoworkordermapping (
mappingid bigint NOT NULL,
spaceid bigint NOT NULL,
workorderid bigint NOT NULL,
instance_name citext NOT NULL,
CONSTRAINT arc_spacetoworkordermapping_1763130357_c CHECK ((length((instance_name)::text) <= 250))
);
CREATE TABLE public.arc_survey_response_answer (
answerid bigint NOT NULL,
responseid bigint NOT NULL,
quesid bigint NOT NULL,
type citext,
value bigint NOT NULL,
answer citext NOT NULL,
CONSTRAINT arc_survey_response_answer_1935487934_c CHECK ((length((answer)::text) <= 500)),
CONSTRAINT arc_survey_response_answer_2590522_c CHECK ((length((type)::text) <= 100))
);
CREATE TABLE public.arc_survey_response_comment (
responseid bigint NOT NULL,
commenttext citext NOT NULL
);
CREATE TABLE public.arc_survey_response_main (
responseid bigint NOT NULL,
surveyid bigint NOT NULL,
userid bigint,
typeid bigint NOT NULL,
responsetime bigint,
sendtime bigint,
result integer,
responsetype integer,
typename citext NOT NULL,
CONSTRAINT arc_survey_response_main_107072709_c CHECK ((length((typename)::text) <= 20))
);
CREATE TABLE public.arc_surveyrespreqmapping (
responseid bigint NOT NULL,
workorderid bigint NOT NULL
);
CREATE TABLE public.arc_task_dependencies (
dependency_index bigint NOT NULL,
taskid bigint NOT NULL,
child_taskid bigint NOT NULL
);
CREATE TABLE public.arc_taskattachments (
attachmentid bigint NOT NULL,
taskid bigint
);
CREATE TABLE public.arc_taskcomments (
commentid bigint NOT NULL,
taskid bigint NOT NULL,
commentowner bigint,
createdtime bigint,
comment citext,
parentid bigint
);
CREATE TABLE public.arc_taskdetails (
taskid bigint NOT NULL,
taskindex bigint DEFAULT '-1' NOT NULL,
createdby bigint,
queuename citext,
ownerid bigint,
createddate bigint DEFAULT '0' NOT NULL,
scheduledstarttime bigint,
scheduledendtime bigint,
actualstarttime bigint,
actualendtime bigint,
title citext DEFAULT '-' NOT NULL,
description citext,
statusname citext,
priorityname citext,
tasktypename citext,
per_of_completion integer,
addtional_cost double DEFAULT '0',
isescalated boolean DEFAULT false NOT NULL,
isoverdue boolean DEFAULT false NOT NULL,
estimatedeffortdays bigint DEFAULT '0',
estimatedefforthours bigint DEFAULT '0',
estimatedeffortminutes bigint DEFAULT '0',
estimatedeffort bigint DEFAULT '0',
helpdeskid bigint DEFAULT '1' NOT NULL,
templateid bigint,
duebytime bigint,
CONSTRAINT arc_taskdetails_1047900924_c CHECK ((length((queuename)::text) <= 50)),
CONSTRAINT arc_taskdetails_1929210415_c CHECK ((length((priorityname)::text) <= 100)),
CONSTRAINT arc_taskdetails_23485110_c CHECK ((length((tasktypename)::text) <= 100)),
CONSTRAINT arc_taskdetails_733867389_c CHECK ((length((statusname)::text) <= 100)),
CONSTRAINT arc_taskdetails_79833656_c CHECK ((length((title)::text) <= 250))
);
CREATE TABLE public.arc_taskdetailshistory (
historyid bigint NOT NULL,
taskid bigint NOT NULL,
operationownerid bigint NOT NULL,
operationtime bigint NOT NULL,
operation citext,
CONSTRAINT arc_taskdetailshistory_154330439_c CHECK ((length((operation)::text) <= 50))
);
CREATE TABLE public.arc_taskdetailshistorydiff (
historydiffid bigint NOT NULL,
historyid bigint NOT NULL,
columnname citext NOT NULL,
prev_value citext,
current_value citext,
CONSTRAINT arc_taskdetailshistorydiff_1619616031_c CHECK ((length((columnname)::text) <= 30))
);
CREATE TABLE public.arc_taskimages (
taskid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.arc_tasktocharge (
taskid bigint NOT NULL,
chargeid bigint NOT NULL
);
CREATE TABLE public.arc_technician_share_list (
shareid bigint NOT NULL,
techid bigint NOT NULL
);
CREATE TABLE public.arc_user_share_list (
shareid bigint NOT NULL,
userid bigint NOT NULL
);
CREATE TABLE public.arc_wo_assessment (
assessmentid bigint NOT NULL,
workorderid bigint NOT NULL,
executedtime bigint NOT NULL
);
CREATE TABLE public.arc_wo_group_info (
assessmentid bigint NOT NULL,
groupname citext,
nextgroup citext,
endtime bigint,
timespent bigint,
operationowner citext,
CONSTRAINT arc_wo_group_info_1304373610_c CHECK ((length((groupname)::text) <= 250)),
CONSTRAINT arc_wo_group_info_283813044_c CHECK ((length((nextgroup)::text) <= 250)),
CONSTRAINT arc_wo_group_info_696142252_c CHECK ((length((operationowner)::text) <= 250))
);
CREATE TABLE public.arc_wo_group_ola_info (
wotogroupid bigint NOT NULL,
workorderid bigint NOT NULL,
queuename citext DEFAULT '-',
sitename citext DEFAULT '-',
is_current_group boolean DEFAULT false,
assigned_time bigint NOT NULL,
violation_time bigint NOT NULL,
completed_time bigint,
is_violated boolean DEFAULT false,
timespent bigint DEFAULT '0' NOT NULL,
allowed_time bigint DEFAULT '0' NOT NULL,
CONSTRAINT arc_wo_group_ola_info_1047900924_c CHECK ((length((queuename)::text) <= 100)),
CONSTRAINT arc_wo_group_ola_info_1458589266_c CHECK ((length((sitename)::text) <= 100))
);
CREATE TABLE public.arc_wo_share_comments (
workorderid bigint NOT NULL,
technician_comments citext,
user_comments citext,
CONSTRAINT arc_wo_share_comments_1202316689_c CHECK ((length((technician_comments)::text) <= 150)),
CONSTRAINT arc_wo_share_comments_560410600_c CHECK ((length((user_comments)::text) <= 150))
);
CREATE TABLE public.arc_wo_share_list (
shareid bigint NOT NULL,
workorderid bigint NOT NULL,
shared_by bigint NOT NULL,
shared_time bigint NOT NULL
);
CREATE TABLE public.arc_wo_status_info (
assessmentid bigint NOT NULL,
status citext NOT NULL,
nextstatus citext,
endtime bigint,
timespent bigint,
comments citext,
operationowner citext,
CONSTRAINT arc_wo_status_info_136709285_c CHECK ((length((nextstatus)::text) <= 250)),
CONSTRAINT arc_wo_status_info_1839152142_c CHECK ((length((status)::text) <= 250)),
CONSTRAINT arc_wo_status_info_696142252_c CHECK ((length((operationowner)::text) <= 250))
);
CREATE TABLE public.arc_wo_tech_info (
assessmentid bigint NOT NULL,
technician citext,
nexttechnician citext,
endtime bigint,
timespent bigint,
operationowner citext,
CONSTRAINT arc_wo_tech_info_1200048796_c CHECK ((length((technician)::text) <= 250)),
CONSTRAINT arc_wo_tech_info_1400398999_c CHECK ((length((nexttechnician)::text) <= 250)),
CONSTRAINT arc_wo_tech_info_696142252_c CHECK ((length((operationowner)::text) <= 250))
);
CREATE TABLE public.arc_wo_totaskdetails (
workorderid bigint NOT NULL,
taskid bigint NOT NULL
);
CREATE TABLE public.arc_woresolutionattachment (
workorderid bigint NOT NULL,
attachmentid bigint NOT NULL
);
CREATE TABLE public.arc_worklog_fields (
worklogid bigint NOT NULL
);
CREATE TABLE public.arc_workorder (
workorderid bigint NOT NULL,
requesterid bigint NOT NULL,
oboid bigint,
createdbyid bigint,
createdtime bigint DEFAULT '0' NOT NULL,
title citext,
description citext,
respondedtime bigint DEFAULT '0' NOT NULL,
duebytime bigint DEFAULT '0' NOT NULL,
completedtime bigint DEFAULT '0' NOT NULL,
timespentonreq bigint DEFAULT '0' NOT NULL,
totalunassignedtime bigint DEFAULT '0',
onholdtime bigint DEFAULT '0',
ageafterviolation bigint DEFAULT '0',
ageafterslaresponseviolation bigint DEFAULT '0',
modename citext DEFAULT '-',
ciname citext,
resourcename citext,
deptname citext DEFAULT '-',
sitename citext DEFAULT '-',
categoryname citext DEFAULT '-',
subcategoryname citext DEFAULT '-',
itemname citext DEFAULT '-',
ownerid bigint,
queuename citext DEFAULT '-',
slaviolatedtechnician bigint,
slaviolatedgroupname citext DEFAULT '-',
statusname citext DEFAULT '-' NOT NULL,
priorityname citext DEFAULT '-',
levelname citext DEFAULT '-',
impactname citext DEFAULT '-',
impactdetails citext,
urgencyname citext DEFAULT '-',
requesttype citext DEFAULT '-',
closeaccepted citext,
close_comments citext,
hasattachment boolean DEFAULT false NOT NULL,
hasdependency boolean DEFAULT false NOT NULL,
templateid bigint,
shownotestotech boolean DEFAULT false NOT NULL,
notificationstatus citext,
is_catalog_template boolean DEFAULT false NOT NULL,
servicename citext,
fr_duetime bigint DEFAULT '0' NOT NULL,
slaname citext DEFAULT '-',
isoverdue boolean DEFAULT false NOT NULL,
appr_statusname citext,
is_fr_overdue boolean DEFAULT false NOT NULL,
closurecodename citext,
closurecomments citext,
email_cc bytea,
haschange boolean DEFAULT false NOT NULL,
hasproblem boolean DEFAULT false NOT NULL,
hascausedbychange boolean DEFAULT false NOT NULL,
editorid bigint,
last_tech_update bigint DEFAULT '0' NOT NULL,
resolvedtime bigint DEFAULT '0' NOT NULL,
reopenedtime bigint DEFAULT '0' NOT NULL,
hasproject boolean DEFAULT false NOT NULL,
isfcr boolean DEFAULT false NOT NULL,
service_cost double,
total_cost double DEFAULT '0' NOT NULL,
reopened boolean DEFAULT false NOT NULL,
ola_status citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
response_timespent bigint DEFAULT '0' NOT NULL,
outside_operational_hour boolean,
actual_sla_resolution_time bigint DEFAULT '0' NOT NULL,
actual_sla_response_time bigint DEFAULT '0' NOT NULL,
is_cancel_requested boolean DEFAULT false NOT NULL,
cancel_requested_by bigint,
cancel_requested_reason citext,
cancel_requested_time bigint DEFAULT '0' NOT NULL,
CONSTRAINT arc_workorder_1047900924_c CHECK ((length((queuename)::text) <= 50)),
CONSTRAINT arc_workorder_1109492393_c CHECK ((length((subcategoryname)::text) <= 100)),
CONSTRAINT arc_workorder_1131135983_c CHECK ((length((levelname)::text) <= 100)),
CONSTRAINT arc_workorder_1277764883_c CHECK ((length((closurecodename)::text) <= 100)),
CONSTRAINT arc_workorder_1297707548_c CHECK ((length((impactdetails)::text) <= 250)),
CONSTRAINT arc_workorder_1379746880_c CHECK ((length((slaviolatedgroupname)::text) <= 50)),
CONSTRAINT arc_workorder_1408372845_c CHECK ((length((slaname)::text) <= 100)),
CONSTRAINT arc_workorder_1458589266_c CHECK ((length((sitename)::text) <= 100)),
CONSTRAINT arc_workorder_1542560015_c CHECK ((length((closurecomments)::text) <= 1000)),
CONSTRAINT arc_workorder_1550684023_c CHECK ((length((categoryname)::text) <= 100)),
CONSTRAINT arc_workorder_163650222_c CHECK ((length((modename)::text) <= 100)),
CONSTRAINT arc_workorder_1653436207_c CHECK ((length((impactname)::text) <= 100)),
CONSTRAINT arc_workorder_1671877940_c CHECK ((length((urgencyname)::text) <= 100)),
CONSTRAINT arc_workorder_1730526800_c CHECK ((length((deptname)::text) <= 100)),
CONSTRAINT arc_workorder_1929210415_c CHECK ((length((priorityname)::text) <= 100)),
CONSTRAINT arc_workorder_1933668249_c CHECK ((length((resourcename)::text) <= 100)),
CONSTRAINT arc_workorder_1960911902_c CHECK ((length((itemname)::text) <= 100)),
CONSTRAINT arc_workorder_1987958769_c CHECK ((length((ciname)::text) <= 100)),
CONSTRAINT arc_workorder_2044210299_c CHECK ((length((close_comments)::text) <= 1000)),
CONSTRAINT arc_workorder_2137973377_c CHECK ((length((closeaccepted)::text) <= 250)),
CONSTRAINT arc_workorder_225342112_c CHECK ((length((servicename)::text) <= 250)),
CONSTRAINT arc_workorder_610265978_c CHECK ((length((cancel_requested_reason)::text) <= 500)),
CONSTRAINT arc_workorder_733867389_c CHECK ((length((statusname)::text) <= 100)),
CONSTRAINT arc_workorder_763740149_c CHECK ((length((appr_statusname)::text) <= 100)),
CONSTRAINT arc_workorder_79833656_c CHECK ((length((title)::text) <= 250)),
CONSTRAINT arc_workorder_84409715_c CHECK ((length((ola_status)::text) <= 100)),
CONSTRAINT arc_workorder_847157405_c CHECK ((length((notificationstatus)::text) <= 250)),
CONSTRAINT arc_workorder_990955991_c CHECK ((length((requesttype)::text) <= 100))
);
CREATE TABLE public.arc_workorder_catresources (
resourceid bigint NOT NULL,
workorderid bigint NOT NULL,
title citext NOT NULL,
description citext NOT NULL,
CONSTRAINT arc_workorder_catresources_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT arc_workorder_catresources_79833656_c CHECK ((length((title)::text) <= 200))
);
CREATE TABLE public.arc_workorder_catresquestions (
uid bigint NOT NULL,
resourceid bigint NOT NULL,
question citext NOT NULL,
answer citext,
answercost double DEFAULT '0' NOT NULL,
CONSTRAINT arc_workorder_catresquestions_1935487934_c CHECK ((length((answer)::text) <= 250)),
CONSTRAINT arc_workorder_catresquestions_383243290_c CHECK ((length((question)::text) <= 250))
);
CREATE TABLE public.arc_workorder_fields (
workorderid bigint NOT NULL
);
CREATE TABLE public.arc_workorder_multi_fields (
workorderid bigint NOT NULL
);
CREATE TABLE public.arc_workorder_notes (
notesid bigint NOT NULL,
workorderid bigint NOT NULL,
createdby bigint NOT NULL,
createdtime bigint NOT NULL,
notestext citext NOT NULL,
ispublic boolean DEFAULT false NOT NULL,
hasattachment boolean DEFAULT false NOT NULL,
updatedby bigint,
updatedtime bigint
);
CREATE TABLE public.arc_workorder_recipients (
workorderid bigint NOT NULL,
recipient_name citext,
recipient_email citext NOT NULL,
to_cc_bcc citext,
CONSTRAINT arc_workorder_recipients_1813314833_c CHECK ((length((recipient_name)::text) <= 250)),
CONSTRAINT arc_workorder_recipients_370219446_c CHECK ((length((recipient_email)::text) <= 250)),
CONSTRAINT arc_workorder_recipients_862828025_c CHECK ((length((to_cc_bcc)::text) <= 250))
);
CREATE TABLE public.arc_workorder_tags (
workorder_tagid bigint NOT NULL,
tagname citext NOT NULL,
workorderid bigint NOT NULL,
CONSTRAINT arc_workorder_tags_830248699_c CHECK ((length((tagname)::text) <= 250))
);
CREATE TABLE public.arc_workorderattachment (
workorderid bigint NOT NULL,
attachmentid bigint NOT NULL
);
CREATE TABLE public.arc_workorderhistory (
historyid bigint NOT NULL,
workorderid bigint NOT NULL,
operationownerid bigint,
operationtime bigint NOT NULL,
description citext,
operation citext DEFAULT 'CREATE',
CONSTRAINT arc_workorderhistory_154330439_c CHECK ((length((operation)::text) <= 50))
);
CREATE TABLE public.arc_workorderhistorydiff (
historydiffid bigint NOT NULL,
historyid bigint NOT NULL,
columnname citext NOT NULL,
prev_value citext,
current_value citext,
prev_encrypted_value bytea,
current_encrypted_value bytea
);
CREATE TABLE public.arc_workorderimages (
workorderid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.arc_workordersignoff (
signoffid bigint NOT NULL,
workorderid bigint NOT NULL,
requestername citext NOT NULL,
comments citext,
attachmentid bigint NOT NULL,
signofftime bigint NOT NULL
);
CREATE TABLE public.arc_workordertoasset (
wotoassetid bigint NOT NULL,
workorderid bigint NOT NULL,
assetid bigint,
resourcename citext,
CONSTRAINT arc_workordertoasset_1933668249_c CHECK ((length((resourcename)::text) <= 256))
);
CREATE TABLE public.arc_workordertocharge (
workorderid bigint NOT NULL,
chargeid bigint NOT NULL
);
CREATE TABLE public.arc_workordertochecklist (
workorderid bigint NOT NULL,
checklistid bigint NOT NULL
);
CREATE TABLE public.arc_workordertoci (
wotociid bigint NOT NULL,
workorderid bigint NOT NULL,
ciid bigint,
ciname citext,
CONSTRAINT arc_workordertoci_1987958769_c CHECK ((length((ciname)::text) <= 256))
);
CREATE TABLE public.arc_workordertopurchaseorder (
workorderid bigint NOT NULL,
purchaseorderid bigint NOT NULL
);
CREATE TABLE public.arc_wotodeletedasset (
wotoasset bigint NOT NULL,
workorderid bigint NOT NULL,
assetname citext,
CONSTRAINT arc_wotodeletedasset_192316069_c CHECK ((length((assetname)::text) <= 256))
);
CREATE TABLE public.arc_wotodeletedci (
wotoci bigint NOT NULL,
workorderid bigint NOT NULL,
ciname citext,
CONSTRAINT arc_wotodeletedci_1987958769_c CHECK ((length((ciname)::text) <= 256))
);
CREATE TABLE public.arc_wotoexternaltasks (
taskid bigint NOT NULL,
workorderid bigint NOT NULL
);
CREATE TABLE public.arc_wotoprojects (
associationid bigint NOT NULL,
workorderid bigint NOT NULL,
projectid bigint NOT NULL
);
CREATE TABLE public.arc_wotopurchaserequests (
workorderid bigint NOT NULL,
requestid bigint NOT NULL
);
CREATE TABLE public.archive_exceptions (
exception_id bigint NOT NULL,
exception_type citext DEFAULT 'REQUESTS_ARCHIVE' NOT NULL,
rule_string citext NOT NULL,
condition_string citext NOT NULL,
value citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT archive_exceptions_1098535893_c CHECK ((length((condition_string)::text) <= 250)),
CONSTRAINT archive_exceptions_2098865482_c CHECK ((length((exception_type)::text) <= 25)),
CONSTRAINT archive_exceptions_92155572_c CHECK ((length((rule_string)::text) <= 250))
);
CREATE TABLE public.archivepolicy (
archive_policy_id bigint NOT NULL,
archive_policy_name citext NOT NULL,
tablename citext NOT NULL,
criteria_string citext,
threshold bigint,
mode citext DEFAULT 'PULL' NOT NULL,
datasource_id bigint,
CONSTRAINT archivepolicy_1546565391_c CHECK ((length((criteria_string)::text) <= 1000)),
CONSTRAINT archivepolicy_1676765531_c CHECK ((length((archive_policy_name)::text) <= 255)),
CONSTRAINT archivepolicy_2372003_c CHECK ((length((mode)::text) <= 50)),
CONSTRAINT archivepolicy_798830393_c CHECK ((length((tablename)::text) <= 255))
);
CREATE TABLE public.archivestatus (
db_id bigint NOT NULL,
is_archival_running boolean DEFAULT false NOT NULL
);
CREATE TABLE public.archivetabledetails (
archive_table_id bigint NOT NULL,
archive_policy_id bigint NOT NULL,
actual_tablename citext NOT NULL,
archived_tablename citext NOT NULL,
archived_date timestamp without time zone NOT NULL,
description citext,
CONSTRAINT archivetabledetails_219701020_c CHECK ((length((archived_tablename)::text) <= 255)),
CONSTRAINT archivetabledetails_396078536_c CHECK ((length((actual_tablename)::text) <= 255)),
CONSTRAINT archivetabledetails_428414940_c CHECK ((length((description)::text) <= 1000))
);
CREATE TABLE public.areachartproperties (
reportid bigint NOT NULL,
areaxdate bigint NOT NULL,
areaxgroup bigint NOT NULL,
areaycountcoulmn bigint NOT NULL,
dateformat citext NOT NULL,
areaytargetfrom bigint,
areaytargetto bigint,
CONSTRAINT areachartproperties_1556470053_c CHECK ((length((dateformat)::text) <= 20))
);
CREATE TABLE public.assessmentdetails (
assessmentid bigint NOT NULL,
changeid bigint NOT NULL,
assessedby bigint NOT NULL,
recommendations citext,
assesseddate bigint NOT NULL,
estimatedcost bigint,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.assessmentfileattachment (
attachmentid bigint NOT NULL,
assessmentid bigint NOT NULL,
attachedby bigint NOT NULL,
attachedon bigint,
title citext,
CONSTRAINT assessmentfileattachment_79833656_c CHECK ((length((title)::text) <= 1000))
);
CREATE TABLE public.assetinfoholder (
assetinfoid bigint NOT NULL,
tableinfo citext NOT NULL,
columninfo citext NOT NULL,
oid citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT assetinfoholder_1619752700_c CHECK ((length((columninfo)::text) <= 30)),
CONSTRAINT assetinfoholder_78250_c CHECK ((length((oid)::text) <= 100)),
CONSTRAINT assetinfoholder_798693724_c CHECK ((length((tableinfo)::text) <= 30))
);
CREATE TABLE public.assetnotificationsstatus (
resourceid bigint NOT NULL,
assetexpirynotificationstatus boolean DEFAULT false NOT NULL,
warrantyexpirynotificationstatus boolean DEFAULT false NOT NULL
);
CREATE TABLE public.assetreplenishments (
assetreplenishmentid bigint NOT NULL,
createdby bigint,
siteid bigint,
producttypeid bigint NOT NULL,
productid bigint,
thresholdcount bigint NOT NULL,
isnotificationsent boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.assetreplenishmentshistory (
historyid bigint NOT NULL,
assetreplenishmentid bigint NOT NULL,
operation citext NOT NULL,
operationownerid bigint NOT NULL,
description citext,
operationtime bigint NOT NULL,
CONSTRAINT assetreplenishmentshistory_154330439_c CHECK ((length((operation)::text) <= 300)),
CONSTRAINT assetreplenishmentshistory_428414940_c CHECK ((length((description)::text) <= 300))
);
CREATE TABLE public.assetreplenishmentshistorydetails (
historyinfoid bigint NOT NULL,
historyid bigint NOT NULL,
columnname citext NOT NULL,
prev_value citext,
current_value citext,
CONSTRAINT assetreplenishmentshistorydetails_1088349253_c CHECK ((length((prev_value)::text) <= 250)),
CONSTRAINT assetreplenishmentshistorydetails_1619616031_c CHECK ((length((columnname)::text) <= 300)),
CONSTRAINT assetreplenishmentshistorydetails_1969348885_c CHECK ((length((current_value)::text) <= 250))
);
CREATE TABLE public.assetreplenishmentstates (
assetrepstateid bigint NOT NULL,
resourcestateid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.assetreplenishmentstateshistory (
historyid bigint NOT NULL,
assetrepstateid bigint NOT NULL,
operation citext NOT NULL,
operationownerid bigint NOT NULL,
description citext,
operationtime bigint NOT NULL,
CONSTRAINT assetreplenishmentstateshistory_154330439_c CHECK ((length((operation)::text) <= 300)),
CONSTRAINT assetreplenishmentstateshistory_428414940_c CHECK ((length((description)::text) <= 300))
);
CREATE TABLE public.assetri (
itemid bigint NOT NULL,
assetid bigint NOT NULL
);
CREATE TABLE public.associated_app_userdata (
id bigint NOT NULL,
userid bigint NOT NULL,
app_id bigint NOT NULL,
authobject citext
);
CREATE TABLE public.associated_applications (
app_id bigint NOT NULL,
appname citext NOT NULL,
protocol citext,
server citext,
port citext,
defaultpage citext,
marketingpage citext,
api_key bytea,
CONSTRAINT associated_applications_1620262507_c CHECK ((length((marketingpage)::text) <= 200)),
CONSTRAINT associated_applications_1716831280_c CHECK ((length((defaultpage)::text) <= 200)),
CONSTRAINT associated_applications_1852497085_c CHECK ((length((server)::text) <= 100)),
CONSTRAINT associated_applications_206537064_c CHECK ((length((protocol)::text) <= 20)),
CONSTRAINT associated_applications_2461825_c CHECK ((length((port)::text) <= 20)),
CONSTRAINT associated_applications_75200500_c CHECK ((length((appname)::text) <= 200))
);
CREATE TABLE public.attachmentauthconfig (
id bigint NOT NULL,
authenticationkey bytea NOT NULL
);
CREATE TABLE public.attachmentconfig (
attachmentconfigid bigint NOT NULL,
parameter citext NOT NULL,
paramvalue citext NOT NULL,
description citext DEFAULT '-' NOT NULL,
CONSTRAINT attachmentconfig_428414940_c CHECK ((length((description)::text) <= 200)),
CONSTRAINT attachmentconfig_446088073_c CHECK ((length((parameter)::text) <= 100)),
CONSTRAINT attachmentconfig_958969092_c CHECK ((length((paramvalue)::text) <= 3000))
);
CREATE TABLE public.attributes (
attributeid bigint NOT NULL,
attribute citext NOT NULL,
description citext,
datatypeid integer,
sourcefieldid bigint,
typeoffield citext,
columnname citext,
operator citext,
operand citext,
unitstodisplay citext,
isattachment boolean DEFAULT false,
isdeletable boolean DEFAULT true NOT NULL,
default_value citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT attributes_1056080307_c CHECK ((length((default_value)::text) <= 250)),
CONSTRAINT attributes_1495287172_c CHECK ((length((attribute)::text) <= 250)),
CONSTRAINT attributes_1619616031_c CHECK ((length((columnname)::text) <= 100)),
CONSTRAINT attributes_282073252_c CHECK ((length((operator)::text) <= 100)),
CONSTRAINT attributes_333254423_c CHECK ((length((typeoffield)::text) <= 100)),
CONSTRAINT attributes_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT attributes_545090391_c CHECK ((length((operand)::text) <= 100)),
CONSTRAINT attributes_779375448_c CHECK ((length((unitstodisplay)::text) <= 100))
);
CREATE TABLE public.auditconfig (
id bigint NOT NULL,
module_id bigint,
customprovider citext,
currentlevel citext NOT NULL,
disableallaudit boolean NOT NULL,
enablecriteria citext,
CONSTRAINT auditconfig_1757842334_c CHECK ((length((customprovider)::text) <= 100)),
CONSTRAINT auditconfig_497202773_c CHECK ((length((currentlevel)::text) <= 50)),
CONSTRAINT auditconfig_50574818_c CHECK ((length((enablecriteria)::text) <= 200))
);
CREATE TABLE public.auditconfigproperty (
auditconfig_id bigint NOT NULL,
propertyname citext NOT NULL,
propertytype citext NOT NULL,
CONSTRAINT auditconfigproperty_1453542880_c CHECK ((length((propertyname)::text) <= 50)),
CONSTRAINT auditconfigproperty_1453744783_c CHECK ((length((propertytype)::text) <= 50))
);
CREATE TABLE public.auditconfiguration (
auditconfigid bigint NOT NULL,
cleanupinterval bigint DEFAULT '30' NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.auditfailureinfo (
auditid bigint NOT NULL,
errorcode integer NOT NULL
);
CREATE TABLE public.audithistory (
auditid bigint NOT NULL,
workstationid bigint NOT NULL,
audittime bigint NOT NULL,
auditstatus citext DEFAULT 'SUCCESS' NOT NULL,
audittoken citext,
comments citext DEFAULT '-' NOT NULL,
scanmode bigint,
scantype bigint,
isdeltascan boolean DEFAULT false NOT NULL,
CONSTRAINT audithistory_180211188_c CHECK ((length((comments)::text) <= 250)),
CONSTRAINT audithistory_2098119938_c CHECK ((length((audittoken)::text) <= 250)),
CONSTRAINT audithistory_641503379_c CHECK ((length((auditstatus)::text) <= 19))
);
CREATE TABLE public.auditlevel (
auditconfig_id bigint NOT NULL,
levelname citext NOT NULL,
CONSTRAINT auditlevel_1131135983_c CHECK ((length((levelname)::text) <= 50))
);
CREATE TABLE public.auditnotifycriteria (
auditconfig_id bigint NOT NULL,
criteria citext NOT NULL,
repeatcount integer,
repeatinterval bigint NOT NULL,
CONSTRAINT auditnotifycriteria_1560293537_c CHECK ((length((criteria)::text) <= 188))
);
CREATE TABLE public.auditoperation (
operation bigint NOT NULL,
operationstring citext NOT NULL,
CONSTRAINT auditoperation_217442328_c CHECK ((length((operationstring)::text) <= 100))
);
CREATE TABLE public.auditoperproperty (
auditid bigint NOT NULL,
propertyname citext NOT NULL,
propertyvalue citext NOT NULL,
CONSTRAINT auditoperproperty_1453542880_c CHECK ((length((propertyname)::text) <= 100)),
CONSTRAINT auditoperproperty_2117544092_c CHECK ((length((propertyvalue)::text) <= 250))
);
CREATE TABLE public.auditrecord (
auditid bigint NOT NULL,
principal citext NOT NULL,
"timestamp" bigint NOT NULL,
recordtype citext DEFAULT 'OperationAuditRecord' NOT NULL,
CONSTRAINT auditrecord_1220957963_c CHECK ((length((recordtype)::text) <= 25)),
CONSTRAINT auditrecord_974553102_c CHECK ((length((principal)::text) <= 100))
);
CREATE TABLE public.auditresourceprop (
auditid bigint NOT NULL,
propertyname citext NOT NULL,
propertyvalue citext NOT NULL,
CONSTRAINT auditresourceprop_1453542880_c CHECK ((length((propertyname)::text) <= 100)),
CONSTRAINT auditresourceprop_2117544092_c CHECK ((length((propertyvalue)::text) <= 250))
);
CREATE TABLE public.auditresultproperty (
auditid bigint NOT NULL,
propertyname citext NOT NULL,
propertyvalue citext NOT NULL,
CONSTRAINT auditresultproperty_1453542880_c CHECK ((length((propertyname)::text) <= 100)),
CONSTRAINT auditresultproperty_2117544092_c CHECK ((length((propertyvalue)::text) <= 250))
);
CREATE TABLE public.auditseveritylevel (
auditconfig_id bigint NOT NULL,
severity citext NOT NULL,
criteria citext NOT NULL,
CONSTRAINT auditseveritylevel_1560293537_c CHECK ((length((criteria)::text) <= 200)),
CONSTRAINT auditseveritylevel_2034040067_c CHECK ((length((severity)::text) <= 25))
);
CREATE TABLE public.audittableconfig (
auditconfig_id bigint NOT NULL,
audittablename citext NOT NULL,
buffersize integer,
batchsize integer,
CONSTRAINT audittableconfig_1659801054_c CHECK ((length((audittablename)::text) <= 50))
);
CREATE TABLE public.audittokens (
tokenid bigint NOT NULL,
audittoken citext NOT NULL,
scanstarttime timestamp without time zone NOT NULL,
scanstoptime timestamp without time zone,
description citext DEFAULT '-',
scantypeid bigint NOT NULL,
siteid bigint,
domainid bigint,
networkid bigint,
interrupted citext,
totalcount bigint,
success_final_count bigint,
failed_final_count bigint,
agent_not_installed_final_count bigint,
agent_not_live_final_count bigint,
scan_excluded_final_count bigint,
scan_disabled_final_count bigint,
discovery_status citext,
dc_status boolean DEFAULT false,
is_dc_compatible boolean DEFAULT true,
attempt_scan_non_dc_user boolean DEFAULT false,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT audittokens_1023003009_c CHECK ((length((discovery_status)::text) <= 200)),
CONSTRAINT audittokens_205308450_c CHECK ((length((interrupted)::text) <= 200)),
CONSTRAINT audittokens_2098119938_c CHECK ((length((audittoken)::text) <= 250)),
CONSTRAINT audittokens_428414940_c CHECK ((length((description)::text) <= 200))
);
CREATE TABLE public.audituserproperty (
auditid bigint NOT NULL,
propertyname citext NOT NULL,
propertyvalue citext NOT NULL,
CONSTRAINT audituserproperty_1453542880_c CHECK ((length((propertyname)::text) <= 100)),
CONSTRAINT audituserproperty_2117544092_c CHECK ((length((propertyvalue)::text) <= 250))
);
CREATE TABLE public.authconfig (
id bigint NOT NULL,
auth_mode citext DEFAULT 'GENERAL',
CONSTRAINT authconfig_18129446_c CHECK ((length((auth_mode)::text) <= 100))
);
CREATE TABLE public.auto_assign_exceptions (
exception_id bigint NOT NULL,
rule_string citext NOT NULL,
condition_string citext NOT NULL,
value citext NOT NULL,
operator citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT auto_assign_exceptions_1098535893_c CHECK ((length((condition_string)::text) <= 250)),
CONSTRAINT auto_assign_exceptions_282073252_c CHECK ((length((operator)::text) <= 100)),
CONSTRAINT auto_assign_exceptions_92155572_c CHECK ((length((rule_string)::text) <= 250))
);
CREATE TABLE public.autosuggestinfo (
id bigint NOT NULL,
year integer NOT NULL,
month integer NOT NULL,
announcement_count bigint NOT NULL,
solution_count bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.axiscolumn (
viewname bigint NOT NULL,
columntype citext NOT NULL,
datacolumn citext,
CONSTRAINT axiscolumn_1619414128_c CHECK ((length((columntype)::text) <= 50)),
CONSTRAINT axiscolumn_2079602816_c CHECK ((length((datacolumn)::text) <= 50))
);
CREATE TABLE public.backupapproverdetails (
backup_config_id bigint NOT NULL,
from_date bigint NOT NULL,
to_date bigint NOT NULL,
user_id bigint NOT NULL,
backup_approverid bigint NOT NULL,
move_pending_approvals boolean DEFAULT false NOT NULL,
is_pending_moved boolean DEFAULT false NOT NULL,
comments citext,
created_by bigint NOT NULL,
created_time bigint NOT NULL,
CONSTRAINT backupapproverdetails_180211188_c CHECK ((length((comments)::text) <= 250))
);
CREATE TABLE public.backupdetails (
backup_id bigint NOT NULL,
backup_type integer DEFAULT 2 NOT NULL,
backup_starttime bigint DEFAULT '-1' NOT NULL,
backup_endtime bigint DEFAULT '-1' NOT NULL,
backup_status integer DEFAULT 1 NOT NULL,
backup_zipname citext,
backup_zip_cleaned boolean DEFAULT false NOT NULL,
last_datafile_name citext,
last_datafile_modifiedtime bigint DEFAULT '-1' NOT NULL,
datafile_count integer,
first_backup_after_ppm boolean DEFAULT false NOT NULL,
database_size bigint DEFAULT '-1' NOT NULL,
backup_zipsize bigint DEFAULT '-1' NOT NULL,
CONSTRAINT backupdetails_2058054769_c CHECK ((length((backup_zipname)::text) <= 255)),
CONSTRAINT backupdetails_805011173_c CHECK ((length((last_datafile_name)::text) <= 255))
);
CREATE TABLE public.backupschedule (
backupid bigint NOT NULL,
backupfilepath citext,
createddate bigint DEFAULT '0' NOT NULL,
status citext DEFAULT 'NA' NOT NULL,
version citext DEFAULT '-' NOT NULL,
password bytea,
CONSTRAINT backupschedule_1069590712_c CHECK ((length((version)::text) <= 25)),
CONSTRAINT backupschedule_1839152142_c CHECK ((length((status)::text) <= 100))
);
CREATE TABLE public.barchartproperties (
reportid bigint NOT NULL,
barxgroup1 bigint NOT NULL,
barxgroup2 bigint,
barycountcoulmn bigint NOT NULL,
barytargetfrom bigint,
barytargetto bigint,
barchartby citext DEFAULT 'V',
CONSTRAINT barchartproperties_1028172098_c CHECK ((length((barchartby)::text) <= 5))
);
CREATE TABLE public.barcodegenerationtypes (
generationtypeid bigint NOT NULL,
type citext NOT NULL,
displayname citext NOT NULL,
CONSTRAINT barcodegenerationtypes_2590522_c CHECK ((length((type)::text) <= 100)),
CONSTRAINT barcodegenerationtypes_426904019_c CHECK ((length((displayname)::text) <= 250))
);
CREATE TABLE public.barcodehistory (
historyid bigint NOT NULL,
generatedtime bigint NOT NULL,
generatedby bigint,
comments citext,
sequence citext,
barcodetypeid bigint,
site bigint,
propertyname citext,
generatedtype bigint,
citypename citext NOT NULL,
mappingfieldid bigint,
successcount bigint DEFAULT '0' NOT NULL,
failurecount bigint DEFAULT '0' NOT NULL,
isadded boolean DEFAULT false NOT NULL,
isvendorbarcode boolean DEFAULT false NOT NULL,
isprintlater boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT barcodehistory_1025380139_c CHECK ((length((citypename)::text) <= 250)),
CONSTRAINT barcodehistory_1453542880_c CHECK ((length((propertyname)::text) <= 250)),
CONSTRAINT barcodehistory_2132174785_c CHECK ((length((sequence)::text) <= 250))
);
CREATE TABLE public.barcodehistorymapping (
mappingid bigint NOT NULL,
historyid bigint NOT NULL,
barcode citext NOT NULL,
CONSTRAINT barcodehistorymapping_384398432_c CHECK ((length((barcode)::text) <= 250))
);
CREATE TABLE public.barcodelabelproperty (
labelpropertyid bigint NOT NULL,
propertyname citext NOT NULL,
width double NOT NULL,
height double NOT NULL,
margintop double DEFAULT '0' NOT NULL,
marginbottom double DEFAULT '0' NOT NULL,
marginleft double DEFAULT '0' NOT NULL,
marginright double DEFAULT '0' NOT NULL,
labelsperrow bigint NOT NULL,
gapbtwlabels double DEFAULT '0' NOT NULL,
dpi double DEFAULT '150' NOT NULL,
site bigint,
description citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT barcodelabelproperty_1453542880_c CHECK ((length((propertyname)::text) <= 250))
);
CREATE TABLE public.barcodemappingfields (
mappingfieldid bigint NOT NULL,
mappingfield citext NOT NULL,
displayname citext NOT NULL,
CONSTRAINT barcodemappingfields_426904019_c CHECK ((length((displayname)::text) <= 250)),
CONSTRAINT barcodemappingfields_89571564_c CHECK ((length((mappingfield)::text) <= 100))
);
CREATE TABLE public.barcodes (
barcodeid bigint NOT NULL,
barcode citext NOT NULL,
CONSTRAINT barcodes_384398432_c CHECK ((length((barcode)::text) <= 100))
);
CREATE TABLE public.barcodesequences (
barcodesequenceid bigint NOT NULL,
citypeid bigint NOT NULL,
nextsequencestart bigint NOT NULL,
prefix citext,
suffix citext,
CONSTRAINT barcodesequences_1838093487_c CHECK ((length((suffix)::text) <= 100)),
CONSTRAINT barcodesequences_1926781294_c CHECK ((length((prefix)::text) <= 100))
);
CREATE TABLE public.barcodetypes (
barcodetypeid bigint NOT NULL,
barcodetype citext NOT NULL,
description citext,
CONSTRAINT barcodetypes_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT barcodetypes_494941286_c CHECK ((length((barcodetype)::text) <= 100))
);
CREATE TABLE public.baseelement (
ciid bigint NOT NULL,
impactid bigint
);
CREATE TABLE public.bean (
bean_id bigint NOT NULL,
module_id bigint NOT NULL,
bean_name citext NOT NULL,
classname citext NOT NULL,
transaction_type integer DEFAULT 1 NOT NULL,
CONSTRAINT bean_1517307933_c CHECK ((length((classname)::text) <= 250)),
CONSTRAINT bean_843312570_c CHECK ((length((bean_name)::text) <= 100))
);
CREATE TABLE public.beaninterceptor (
bean_incp_id bigint NOT NULL,
order_no integer NOT NULL,
bean_id bigint NOT NULL,
incp_name citext,
classname citext NOT NULL,
CONSTRAINT beaninterceptor_1413722712_c CHECK ((length((incp_name)::text) <= 100)),
CONSTRAINT beaninterceptor_1517307933_c CHECK ((length((classname)::text) <= 250))
);
CREATE TABLE public.beaninterceptorproperties (
bean_incp_prop_id bigint NOT NULL,
bean_incp_id bigint NOT NULL,
property citext NOT NULL,
value citext NOT NULL,
CONSTRAINT beaninterceptorproperties_210514475_c CHECK ((length((property)::text) <= 100)),
CONSTRAINT beaninterceptorproperties_81434961_c CHECK ((length((value)::text) <= 100))
);
CREATE TABLE public.beanproperties (
beanprop_id bigint NOT NULL,
bean_id bigint NOT NULL,
property citext NOT NULL,
value citext NOT NULL,
CONSTRAINT beanproperties_210514475_c CHECK ((length((property)::text) <= 100)),
CONSTRAINT beanproperties_81434961_c CHECK ((length((value)::text) <= 100))
);
CREATE TABLE public.botcommands (
botcommandid bigint NOT NULL,
serviceid bigint,
internalname citext NOT NULL,
command citext NOT NULL,
description citext NOT NULL,
isenabled boolean DEFAULT true NOT NULL,
configuration citext,
CONSTRAINT botcommands_1668377387_c CHECK ((length((command)::text) <= 200)),
CONSTRAINT botcommands_2056879416_c CHECK ((length((internalname)::text) <= 250)),
CONSTRAINT botcommands_428414940_c CHECK ((length((description)::text) <= 500))
);
CREATE TABLE public.broadcast_messages (
id bigint NOT NULL,
message citext NOT NULL,
created_by bigint NOT NULL,
created_time bigint NOT NULL,
type citext NOT NULL,
selected_sites_groups citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT broadcast_messages_2590522_c CHECK ((length((type)::text) <= 100))
);
CREATE TABLE public.browsercompatibility (
compatibilityid bigint NOT NULL,
browsermatch citext NOT NULL,
compatiblestring citext NOT NULL,
actualbrowser citext NOT NULL,
CONSTRAINT browsercompatibility_1718244379_c CHECK ((length((compatiblestring)::text) <= 30)),
CONSTRAINT browsercompatibility_212709475_c CHECK ((length((browsermatch)::text) <= 30)),
CONSTRAINT browsercompatibility_976510394_c CHECK ((length((actualbrowser)::text) <= 30))
);
CREATE TABLE public.browserlogincount (
countid bigint NOT NULL,
year integer NOT NULL,
month citext NOT NULL,
browserid bigint NOT NULL,
techcount bigint NOT NULL,
requestercount bigint NOT NULL,
CONSTRAINT browserlogincount_73542240_c CHECK ((length((month)::text) <= 25))
);
CREATE TABLE public.browsertype (
browserid bigint NOT NULL,
browsername citext NOT NULL,
browsermatch citext NOT NULL,
browserorder integer,
CONSTRAINT browsertype_1378641299_c CHECK ((length((browsername)::text) <= 200)),
CONSTRAINT browsertype_212709475_c CHECK ((length((browsermatch)::text) <= 30))
);
CREATE TABLE public.bs_softwareinstallation (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.bs_technician (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.buildingdefinition (
buildingid bigint NOT NULL,
siteid bigint NOT NULL,
buildingname citext NOT NULL,
buildingdesc citext,
buildingarea bigint,
constructedon bigint,
isdeleted boolean DEFAULT false,
CONSTRAINT buildingdefinition_1335328581_c CHECK ((length((buildingdesc)::text) <= 300)),
CONSTRAINT buildingdefinition_1335622463_c CHECK ((length((buildingname)::text) <= 100))
);
CREATE TABLE public.businessservice (
ciid bigint NOT NULL,
availabilitytarget citext,
supporthours citext,
cost citext,
restorationtarget citext,
ownedby bigint,
CONSTRAINT businessservice_2074573_c CHECK ((length((cost)::text) <= 250)),
CONSTRAINT businessservice_262409329_c CHECK ((length((restorationtarget)::text) <= 250)),
CONSTRAINT businessservice_780974240_c CHECK ((length((supporthours)::text) <= 250)),
CONSTRAINT businessservice_802835796_c CHECK ((length((availabilitytarget)::text) <= 250))
);
CREATE TABLE public.businessservice_server (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.businessservice_sg (
primarykeyid bigint NOT NULL,
supportlevel citext,
CONSTRAINT businessservice_sg_784370965_c CHECK ((length((supportlevel)::text) <= 100))
);
CREATE TABLE public.businessviewstats (
id bigint NOT NULL,
viewid bigint NOT NULL,
incident bigint DEFAULT '0' NOT NULL,
problem bigint DEFAULT '0' NOT NULL,
change bigint DEFAULT '0' NOT NULL,
emergencychange bigint DEFAULT '0' NOT NULL,
release bigint DEFAULT '0' NOT NULL,
emergencyrelease bigint DEFAULT '0' NOT NULL
);
CREATE TABLE public.cabdefinition (
cabid bigint NOT NULL,
name citext NOT NULL,
description citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT cabdefinition_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT cabdefinition_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.cabmembers (
cabid bigint NOT NULL,
userid bigint NOT NULL
);
CREATE TABLE public.cachestatistics (
cachestatsticsid bigint NOT NULL,
cachekey citext NOT NULL,
year citext NOT NULL,
month citext NOT NULL,
accessedcount bigint DEFAULT '0' NOT NULL,
missedcount bigint DEFAULT '0' NOT NULL,
CONSTRAINT cachestatistics_2719805_c CHECK ((length((year)::text) <= 4)),
CONSTRAINT cachestatistics_349149085_c CHECK ((length((cachekey)::text) <= 100)),
CONSTRAINT cachestatistics_73542240_c CHECK ((length((month)::text) <= 20))
);
CREATE TABLE public.calendar (
schedule_id bigint NOT NULL,
repeat_frequency citext DEFAULT 'NONE' NOT NULL,
time_of_day bigint DEFAULT '0' NOT NULL,
unit_of_time citext DEFAULT 'seconds' NOT NULL,
day_of_week integer DEFAULT '-1' NOT NULL,
week bigint DEFAULT '-1' NOT NULL,
date_of_month integer DEFAULT '-1' NOT NULL,
month_of_year integer DEFAULT '-1' NOT NULL,
year_of_decade integer DEFAULT '-1' NOT NULL,
tz citext,
skip_frequency integer DEFAULT 0 NOT NULL,
use_date_in_reverse boolean DEFAULT false NOT NULL,
first_day_of_week integer DEFAULT '-1' NOT NULL,
CONSTRAINT calendar_1753138054_c CHECK ((length((unit_of_time)::text) <= 20)),
CONSTRAINT calendar_1875815320_c CHECK ((length((repeat_frequency)::text) <= 20)),
CONSTRAINT calendar_2694_c CHECK ((length((tz)::text) <= 50))
);
CREATE TABLE public.calendar_periodicity (
schedule_id bigint NOT NULL,
working_hours_id bigint NOT NULL,
periodicity bigint DEFAULT '1' NOT NULL,
unit_of_periodicity citext DEFAULT 'hour' NOT NULL,
CONSTRAINT calendar_periodicity_1735455290_c CHECK ((length((unit_of_periodicity)::text) <= 20))
);
CREATE TABLE public.call_history (
id bigint NOT NULL,
status citext NOT NULL,
type citext NOT NULL,
start bigint NOT NULL,
finish bigint,
callernumber citext NOT NULL,
receivernumber citext NOT NULL,
callerid bigint,
receiverid bigint,
external_call_id citext,
entity citext,
entity_id bigint,
CONSTRAINT call_history_1161283080_c CHECK ((length((receivernumber)::text) <= 25)),
CONSTRAINT call_history_1839152142_c CHECK ((length((status)::text) <= 20)),
CONSTRAINT call_history_2050021347_c CHECK ((length((entity)::text) <= 100)),
CONSTRAINT call_history_2590522_c CHECK ((length((type)::text) <= 20)),
CONSTRAINT call_history_687204716_c CHECK ((length((callernumber)::text) <= 25)),
CONSTRAINT call_history_848333272_c CHECK ((length((external_call_id)::text) <= 100))
);
CREATE TABLE public.calusageinfo (
usageinfoid bigint NOT NULL,
softwareid bigint NOT NULL,
licenseid bigint NOT NULL,
workstationid bigint,
userid bigint,
clientsoftwareid bigint
);
CREATE TABLE public.catalogresource (
uid bigint NOT NULL,
title citext NOT NULL,
description citext,
fixed boolean DEFAULT false NOT NULL,
is_expendable boolean DEFAULT false NOT NULL,
is_optional boolean DEFAULT false NOT NULL,
isdeleted boolean DEFAULT false,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT catalogresource_428414940_c CHECK ((length((description)::text) <= 1500)),
CONSTRAINT catalogresource_79833656_c CHECK ((length((title)::text) <= 200))
);
CREATE TABLE public.category_changemanager (
categoryid bigint NOT NULL,
changemanagerid bigint NOT NULL,
portaltechid_autoid bigint NOT NULL
);
CREATE TABLE public.category_technician (
categoryid bigint NOT NULL,
technicianid bigint NOT NULL,
portaltechid_autoid bigint NOT NULL
);
CREATE TABLE public.categorydefinition (
categoryid bigint NOT NULL,
categoryname citext NOT NULL,
categorydescription citext,
isdeleted boolean DEFAULT false,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT categorydefinition_1550684023_c CHECK ((length((categoryname)::text) <= 100)),
CONSTRAINT categorydefinition_868286434_c CHECK ((length((categorydescription)::text) <= 250))
);
CREATE TABLE public.centraldatainfo (
centraldataid bigint NOT NULL,
data citext NOT NULL,
siteid bigint,
receivedtime bigint,
importedtime bigint,
importstatus citext NOT NULL,
comments citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT centraldatainfo_1183849431_c CHECK ((length((importstatus)::text) <= 100)),
CONSTRAINT centraldatainfo_180211188_c CHECK ((length((comments)::text) <= 250)),
CONSTRAINT centraldatainfo_2090922_c CHECK ((length((data)::text) <= 250))
);
CREATE TABLE public.change_approvallevel (
id bigint NOT NULL,
entityid bigint NOT NULL,
levelid bigint NOT NULL,
stageid bigint NOT NULL
);
CREATE TABLE public.change_closurecode (
id bigint NOT NULL,
name citext NOT NULL,
description citext,
isdeleted boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT change_closurecode_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT change_closurecode_428414940_c CHECK ((length((description)::text) <= 500))
);
CREATE TABLE public.change_downtimedetails (
dtid bigint NOT NULL,
changeid bigint NOT NULL,
description citext NOT NULL,
starttime bigint,
endtime bigint
);
CREATE TABLE public.change_fields (
changeid bigint NOT NULL,
udf_long1 bigint,
udf_long2 bigint,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
udf_char5 citext,
udf_char6 citext,
udf_date1 bigint,
udf_date2 bigint,
udf_long3 bigint,
udf_long4 bigint,
udf_char7 citext,
udf_char8 citext,
udf_char9 citext,
udf_char10 citext,
udf_char11 citext,
udf_char12 citext,
udf_date3 bigint,
udf_date4 bigint,
CONSTRAINT change_fields_278184709_c CHECK ((length((udf_char9)::text) <= 3500)),
CONSTRAINT change_fields_278184710_c CHECK ((length((udf_char8)::text) <= 3500)),
CONSTRAINT change_fields_278184711_c CHECK ((length((udf_char7)::text) <= 3500)),
CONSTRAINT change_fields_278184712_c CHECK ((length((udf_char6)::text) <= 3500)),
CONSTRAINT change_fields_278184713_c CHECK ((length((udf_char5)::text) <= 3500)),
CONSTRAINT change_fields_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT change_fields_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT change_fields_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT change_fields_278184717_c CHECK ((length((udf_char1)::text) <= 3500)),
CONSTRAINT change_fields_33791585_c CHECK ((length((udf_char12)::text) <= 3500)),
CONSTRAINT change_fields_33791586_c CHECK ((length((udf_char11)::text) <= 3500)),
CONSTRAINT change_fields_33791587_c CHECK ((length((udf_char10)::text) <= 3500))
);
CREATE TABLE public.change_nonloginkeys (
changeid bigint NOT NULL,
userid bigint NOT NULL,
authkey citext NOT NULL,
CONSTRAINT change_nonloginkeys_71469975_c CHECK ((length((authkey)::text) <= 200))
);
CREATE TABLE public.change_stagedefinition (
wfstageid bigint NOT NULL,
name citext NOT NULL,
displayname citext NOT NULL,
description citext,
isdeleted boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
stageindex integer DEFAULT '-1',
CONSTRAINT change_stagedefinition_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT change_stagedefinition_426904019_c CHECK ((length((displayname)::text) <= 100)),
CONSTRAINT change_stagedefinition_428414940_c CHECK ((length((description)::text) <= 500))
);
CREATE TABLE public.change_statusdefinition (
wfstatusid bigint NOT NULL,
statusname citext NOT NULL,
statusdisplayname citext NOT NULL,
description citext,
isdeleted boolean DEFAULT false,
wfstageid bigint NOT NULL,
actionname citext,
isprominentaction boolean DEFAULT false,
notificationcontentid bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT change_statusdefinition_1357666565_c CHECK ((length((statusdisplayname)::text) <= 100)),
CONSTRAINT change_statusdefinition_1957242431_c CHECK ((length((actionname)::text) <= 100)),
CONSTRAINT change_statusdefinition_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT change_statusdefinition_733867389_c CHECK ((length((statusname)::text) <= 100))
);
CREATE TABLE public.changeapprovaldetails (
changeid bigint NOT NULL,
action_date bigint,
statusid bigint,
comments citext,
approverid bigint
);
CREATE TABLE public.changeclosurerules (
closureid bigint NOT NULL,
stageid bigint NOT NULL,
columnname citext NOT NULL,
displayname citext NOT NULL,
mandatory boolean DEFAULT false NOT NULL,
CONSTRAINT changeclosurerules_1619616031_c CHECK ((length((columnname)::text) <= 100)),
CONSTRAINT changeclosurerules_426904019_c CHECK ((length((displayname)::text) <= 100))
);
CREATE TABLE public.changeconfigurations (
config_id bigint NOT NULL,
category citext NOT NULL,
parameter citext NOT NULL,
paramvalue citext DEFAULT 'false' NOT NULL,
description citext DEFAULT '-' NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT changeconfigurations_428414940_c CHECK ((length((description)::text) <= 200)),
CONSTRAINT changeconfigurations_446088073_c CHECK ((length((parameter)::text) <= 100)),
CONSTRAINT changeconfigurations_833137918_c CHECK ((length((category)::text) <= 100)),
CONSTRAINT changeconfigurations_958969092_c CHECK ((length((paramvalue)::text) <= 100))
);
CREATE TABLE public.changedefaultfields (
changeid bigint NOT NULL,
rolloutplan bigint,
backoutplan bigint,
impactdesc bigint,
checklist bigint,
review bigint,
closedesc bigint
);
CREATE TABLE public.changedescriptiontoattachments (
attachmentid bigint NOT NULL,
descriptionid bigint NOT NULL
);
CREATE TABLE public.changedescriptivefield (
id bigint NOT NULL,
name citext NOT NULL,
internal_name citext NOT NULL,
content citext,
changeid bigint NOT NULL,
stageid bigint NOT NULL,
updated_by bigint,
updated_on bigint,
CONSTRAINT changedescriptivefield_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT changedescriptivefield_677323469_c CHECK ((length((internal_name)::text) <= 100))
);
CREATE TABLE public.changedescriptiveimages (
id bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.changedetails (
changeid bigint NOT NULL,
initiatorid bigint,
technicianid bigint,
stageid bigint,
priorityid bigint,
categoryid bigint,
subcategoryid bigint,
itemid bigint,
appr_statusid bigint,
changetypeid bigint,
urgencyid bigint,
title citext NOT NULL,
description citext,
createdtime bigint NOT NULL,
scheduledstarttime bigint,
scheduledendtime bigint,
completedtime bigint,
notespresent boolean DEFAULT false NOT NULL,
siteid bigint,
groupid bigint,
templateid bigint,
wfid bigint,
wfstageid bigint,
wfstatusid bigint,
isemergency boolean DEFAULT false NOT NULL,
isretrospective boolean DEFAULT false NOT NULL,
reasonforchangeid bigint,
closurecodeid bigint,
changemanagerid bigint,
riskid bigint,
impactid bigint,
slaid bigint,
isoverdue boolean,
helpdeskid bigint DEFAULT '1' NOT NULL,
next_review_on bigint,
deletedtime bigint,
CONSTRAINT changedetails_428414940_c CHECK ((length((description)::text) <= 500)),
CONSTRAINT changedetails_79833656_c CHECK ((length((title)::text) <= 250))
);
CREATE TABLE public.changedetailstotasktable (
changeid bigint NOT NULL,
taskid bigint NOT NULL
);
CREATE TABLE public.changefileattachment (
attachmentid bigint NOT NULL,
changeid bigint NOT NULL
);
CREATE TABLE public.changehistory (
historyid bigint NOT NULL,
changeid bigint NOT NULL,
operationownerid bigint NOT NULL,
operationtime bigint NOT NULL,
description citext,
operation citext DEFAULT 'CREATE',
CONSTRAINT changehistory_154330439_c CHECK ((length((operation)::text) <= 50))
);
CREATE TABLE public.changehistorydiff (
historydiffid bigint NOT NULL,
historyid bigint NOT NULL,
columnname citext NOT NULL,
prev_value citext,
current_value citext,
CONSTRAINT changehistorydiff_1619616031_c CHECK ((length((columnname)::text) <= 30))
);
CREATE TABLE public.changeimages (
changeid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.changemigration_dummy (
id bigint NOT NULL,
oldstageid bigint,
newstageid bigint,
newstatusid bigint
);
CREATE TABLE public.changeri (
itemid bigint NOT NULL,
changeid bigint NOT NULL
);
CREATE TABLE public.changeroles (
id bigint NOT NULL,
name citext NOT NULL,
displayname citext NOT NULL,
description citext,
isprominent boolean DEFAULT false,
isdeleted boolean DEFAULT false,
usertype citext DEFAULT 'ALL' NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT changeroles_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT changeroles_426904019_c CHECK ((length((displayname)::text) <= 100)),
CONSTRAINT changeroles_428414940_c CHECK ((length((description)::text) <= 500)),
CONSTRAINT changeroles_517115269_c CHECK ((length((usertype)::text) <= 50))
);
CREATE TABLE public.changerolesvsstages (
id bigint NOT NULL,
roleid bigint NOT NULL,
stageid bigint NOT NULL,
viewpermission boolean DEFAULT false,
editpermission boolean DEFAULT false,
approvepermission boolean DEFAULT false,
deletepermission boolean DEFAULT false
);
CREATE TABLE public.changeroleusermapping (
id bigint NOT NULL,
changeid bigint NOT NULL,
roleid bigint NOT NULL,
userid bigint,
groupid bigint,
labelid bigint
);
CREATE TABLE public.changesladef (
slaid bigint NOT NULL,
slaname citext NOT NULL,
isduetimedefined boolean NOT NULL,
duebydays bigint,
duebyhours bigint,
duebyminutes bigint,
overrideoh boolean DEFAULT false NOT NULL,
description citext,
siteid bigint,
orderid bigint,
isdeleted boolean NOT NULL,
isenabled boolean NOT NULL,
criteriaquery bigint NOT NULL,
updatedby bigint,
updatedtime bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT changesladef_1408372845_c CHECK ((length((slaname)::text) <= 100))
);
CREATE TABLE public.changeslaescalationdef (
escalationid bigint NOT NULL,
level bigint NOT NULL,
slaid bigint NOT NULL,
escafterpercentage bigint DEFAULT '0',
escafterdays bigint DEFAULT '0',
escafterhours bigint DEFAULT '0',
escafterminutes bigint DEFAULT '0'
);
CREATE TABLE public.changeslaescalationtoroles (
id bigint NOT NULL,
escalationid bigint NOT NULL,
escalatetorole bigint NOT NULL
);
CREATE TABLE public.changeslaescpipeline (
id bigint NOT NULL,
itemid bigint NOT NULL,
escalationid bigint NOT NULL,
alreadysent boolean NOT NULL,
escalationtime bigint NOT NULL
);
CREATE TABLE public.changestatuscomments (
commentid bigint NOT NULL,
changeid bigint NOT NULL,
wfstageid bigint NOT NULL,
wfstatusid bigint NOT NULL,
comments citext,
commentedon bigint NOT NULL,
commentedby bigint NOT NULL
);
CREATE TABLE public.changetemplate (
templateid bigint NOT NULL,
name citext NOT NULL,
comments citext,
createdby bigint,
wfid bigint,
isemergency boolean DEFAULT false NOT NULL,
isdeleted boolean DEFAULT false NOT NULL,
isdefault boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT changetemplate_180211188_c CHECK ((length((comments)::text) <= 250)),
CONSTRAINT changetemplate_2388619_c CHECK ((length((name)::text) <= 100))
);
CREATE TABLE public.changetemplateimages (
template_id bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.changetocab (
userid bigint NOT NULL,
changeid bigint NOT NULL
);
CREATE TABLE public.changetocharge (
changeid bigint NOT NULL,
chargeid bigint NOT NULL
);
CREATE TABLE public.changetoci (
id bigint NOT NULL,
changeid bigint NOT NULL,
ciid bigint NOT NULL
);
CREATE TABLE public.changetoclosurecode (
changeid bigint NOT NULL,
id bigint NOT NULL
);
CREATE TABLE public.changetodescription (
changeid bigint NOT NULL,
full_description citext,
closurecomment citext,
CONSTRAINT changetodescription_1889902652_c CHECK ((length((closurecomment)::text) <= 500))
);
CREATE TABLE public.changetonotes (
changeid bigint NOT NULL,
notesid bigint NOT NULL
);
CREATE TABLE public.changetoprojects (
associationid bigint NOT NULL,
changeid bigint NOT NULL,
projectid bigint NOT NULL,
initiated_by citext NOT NULL,
CONSTRAINT changetoprojects_2141905995_c CHECK ((length((initiated_by)::text) <= 50))
);
CREATE TABLE public.changetoservice (
changeid bigint NOT NULL,
serviceid bigint NOT NULL
);
CREATE TABLE public.changetotaskdetails (
changeid bigint NOT NULL,
taskid bigint NOT NULL
);
CREATE TABLE public.changetplt_changemanager (
templateid bigint NOT NULL,
changemanagerid bigint
);
CREATE TABLE public.changetplt_ci (
templateid bigint NOT NULL,
ciid bigint NOT NULL
);
CREATE TABLE public.changetplt_defaultvalues (
templateid bigint NOT NULL,
wfstageid bigint,
wfstatusid bigint,
riskid bigint,
technicianid bigint,
initiatorid bigint,
categoryid bigint,
subcategoryid bigint,
itemid bigint,
changetypeid bigint,
priorityid bigint,
title citext,
impactid bigint,
urgencyid bigint,
siteid bigint,
groupid bigint,
workflowid bigint,
reasonforchangeid bigint,
statuscomments citext,
isretrospective boolean DEFAULT false NOT NULL,
CONSTRAINT changetplt_defaultvalues_2040758298_c CHECK ((length((statuscomments)::text) <= 3000)),
CONSTRAINT changetplt_defaultvalues_79833656_c CHECK ((length((title)::text) <= 250))
);
CREATE TABLE public.changetplt_desc (
templateid bigint NOT NULL,
description citext
);
CREATE TABLE public.changetplt_roles (
templateid bigint NOT NULL,
roleid bigint NOT NULL,
field_index bigint DEFAULT '-1' NOT NULL,
is_mandatory boolean DEFAULT false NOT NULL
);
CREATE TABLE public.changetplt_roles_defval (
id bigint NOT NULL,
templateid bigint NOT NULL,
roleid bigint NOT NULL,
userid bigint,
groupid bigint,
labelid bigint
);
CREATE TABLE public.changetplt_services (
templateid bigint NOT NULL,
serviceid bigint NOT NULL
);
CREATE TABLE public.changetplt_udf (
templateid bigint NOT NULL,
udf_long1 bigint,
udf_long2 bigint,
udf_long3 bigint,
udf_long4 bigint,
udf_long5 bigint,
udf_long6 bigint,
udf_long7 bigint,
udf_long8 bigint,
udf_date1 bigint,
udf_date2 bigint,
udf_date3 bigint,
udf_date4 bigint,
udf_date5 bigint,
udf_date6 bigint,
udf_date7 bigint,
udf_date8 bigint,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
udf_char5 citext,
udf_char6 citext,
udf_char7 citext,
udf_char8 citext,
udf_char9 citext,
udf_char10 citext,
udf_char11 citext,
udf_char12 citext,
udf_char13 citext,
udf_char14 citext,
udf_char15 citext,
udf_char16 citext,
udf_char17 citext,
udf_char18 citext,
udf_char19 citext,
udf_char20 citext,
udf_char21 citext,
udf_char22 citext,
udf_char23 citext,
udf_char24 citext,
CONSTRAINT changetplt_udf_278184709_c CHECK ((length((udf_char9)::text) <= 3500)),
CONSTRAINT changetplt_udf_278184710_c CHECK ((length((udf_char8)::text) <= 3500)),
CONSTRAINT changetplt_udf_278184711_c CHECK ((length((udf_char7)::text) <= 3500)),
CONSTRAINT changetplt_udf_278184712_c CHECK ((length((udf_char6)::text) <= 3500)),
CONSTRAINT changetplt_udf_278184713_c CHECK ((length((udf_char5)::text) <= 3500)),
CONSTRAINT changetplt_udf_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT changetplt_udf_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT changetplt_udf_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT changetplt_udf_278184717_c CHECK ((length((udf_char1)::text) <= 3500)),
CONSTRAINT changetplt_udf_33791552_c CHECK ((length((udf_char24)::text) <= 3500)),
CONSTRAINT changetplt_udf_33791553_c CHECK ((length((udf_char23)::text) <= 3500)),
CONSTRAINT changetplt_udf_33791554_c CHECK ((length((udf_char22)::text) <= 3500)),
CONSTRAINT changetplt_udf_33791555_c CHECK ((length((udf_char21)::text) <= 3500)),
CONSTRAINT changetplt_udf_33791556_c CHECK ((length((udf_char20)::text) <= 3500)),
CONSTRAINT changetplt_udf_33791578_c CHECK ((length((udf_char19)::text) <= 3500)),
CONSTRAINT changetplt_udf_33791579_c CHECK ((length((udf_char18)::text) <= 3500)),
CONSTRAINT changetplt_udf_33791580_c CHECK ((length((udf_char17)::text) <= 3500)),
CONSTRAINT changetplt_udf_33791581_c CHECK ((length((udf_char16)::text) <= 3500)),
CONSTRAINT changetplt_udf_33791582_c CHECK ((length((udf_char15)::text) <= 3500)),
CONSTRAINT changetplt_udf_33791583_c CHECK ((length((udf_char14)::text) <= 3500)),
CONSTRAINT changetplt_udf_33791584_c CHECK ((length((udf_char13)::text) <= 3500)),
CONSTRAINT changetplt_udf_33791585_c CHECK ((length((udf_char12)::text) <= 3500)),
CONSTRAINT changetplt_udf_33791586_c CHECK ((length((udf_char11)::text) <= 3500)),
CONSTRAINT changetplt_udf_33791587_c CHECK ((length((udf_char10)::text) <= 3500))
);
CREATE TABLE public.changetypedefinition (
changetypeid bigint NOT NULL,
name citext NOT NULL,
description citext,
colorcode citext,
isdeleted boolean DEFAULT false,
ispreapproved boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT changetypedefinition_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT changetypedefinition_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT changetypedefinition_473007024_c CHECK ((length((colorcode)::text) <= 10))
);
CREATE TABLE public.changewf_rolesconfigurations (
statusid bigint NOT NULL,
roleid bigint NOT NULL
);
CREATE TABLE public.changewf_statusconfigurations (
statusid bigint NOT NULL,
notificationcontentid bigint NOT NULL,
isactiveinwf boolean DEFAULT true NOT NULL
);
CREATE TABLE public.changeworkflowstatement (
changeid bigint NOT NULL,
statementid bigint,
approvalid bigint
);
CREATE TABLE public.chargesimages (
chargeid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.chargestable (
chargeid bigint NOT NULL,
technicianid bigint NOT NULL,
createdby bigint NOT NULL,
description citext,
timespent bigint DEFAULT '0' NOT NULL,
tech_charge double DEFAULT '0' NOT NULL,
other_charge double DEFAULT '0' NOT NULL,
total_charge double DEFAULT '0' NOT NULL,
createdtime bigint,
ts_starttime bigint,
ts_endtime bigint,
inc_nonoper_hours boolean DEFAULT true,
worklogtypeid bigint,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.chartproperty (
propid integer NOT NULL,
propset bigint NOT NULL,
name bigint NOT NULL,
graphtype citext DEFAULT 'ALL' NOT NULL,
value citext NOT NULL,
scope citext DEFAULT 'STATIC' NOT NULL,
defaultvalue citext,
CONSTRAINT chartproperty_1613891944_c CHECK ((length((graphtype)::text) <= 50)),
CONSTRAINT chartproperty_1687708624_c CHECK ((length((defaultvalue)::text) <= 250)),
CONSTRAINT chartproperty_78726708_c CHECK ((length((scope)::text) <= 7)),
CONSTRAINT chartproperty_81434961_c CHECK ((length((value)::text) <= 250))
);
CREATE TABLE public.chartpropertyset (
name_no bigint NOT NULL,
name citext NOT NULL,
parentset bigint,
CONSTRAINT chartpropertyset_2388619_c CHECK ((length((name)::text) <= 50))
);
CREATE TABLE public.chartpropkey (
ckey_no bigint NOT NULL,
ckey citext NOT NULL,
description citext,
CONSTRAINT chartpropkey_2070300_c CHECK ((length((ckey)::text) <= 50)),
CONSTRAINT chartpropkey_428414940_c CHECK ((length((description)::text) <= 300))
);
CREATE TABLE public.chartviewconfig (
viewname bigint NOT NULL,
cvname bigint,
graphtype citext NOT NULL,
propset bigint,
isxaxis_time boolean DEFAULT false,
urlvalue citext DEFAULT 'URL' NOT NULL,
urlscope citext DEFAULT 'STATE' NOT NULL,
CONSTRAINT chartviewconfig_1613891944_c CHECK ((length((graphtype)::text) <= 50)),
CONSTRAINT chartviewconfig_166868638_c CHECK ((length((urlvalue)::text) <= 250)),
CONSTRAINT chartviewconfig_169576891_c CHECK ((length((urlscope)::text) <= 7))
);
CREATE TABLE public.chassistypes (
id bigint NOT NULL,
name citext NOT NULL,
wmiwindowschassisid bigint NOT NULL,
computergroupid bigint NOT NULL,
CONSTRAINT chassistypes_2388619_c CHECK ((length((name)::text) <= 50))
);
CREATE TABLE public.chat (
id bigint NOT NULL,
status bigint NOT NULL,
start bigint,
finish bigint,
siteid bigint,
groupid bigint,
is_reopened integer DEFAULT 0 NOT NULL,
title citext,
senderid bigint NOT NULL,
chat_entity integer DEFAULT 0,
chat_entityid bigint,
last_mesg_time bigint,
last_mesg_info citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
serviceid bigint,
CONSTRAINT chat_613311304_c CHECK ((length((last_mesg_info)::text) <= 250)),
CONSTRAINT chat_79833656_c CHECK ((length((title)::text) <= 250))
);
CREATE TABLE public.chat_exclude_groups (
queueid bigint NOT NULL
);
CREATE TABLE public.chat_exclude_sites (
id bigint NOT NULL,
siteid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.chat_exclude_techs (
id bigint NOT NULL,
technicianid bigint NOT NULL,
technicianid_autoid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.chat_exclude_usergroups (
id bigint NOT NULL,
user_groupid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.chat_info (
chat_infoid bigint NOT NULL,
chatid bigint NOT NULL,
"time" bigint NOT NULL,
fromuser bigint NOT NULL,
type citext NOT NULL,
CONSTRAINT chat_info_2590522_c CHECK ((length((type)::text) <= 20))
);
CREATE TABLE public.chat_notifications (
id bigint NOT NULL,
chatid bigint NOT NULL,
from_user bigint NOT NULL,
to_user bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.chat_settings (
id bigint NOT NULL,
parameter citext NOT NULL,
value citext NOT NULL,
description citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT chat_settings_428414940_c CHECK ((length((description)::text) <= 200)),
CONSTRAINT chat_settings_446088073_c CHECK ((length((parameter)::text) <= 100)),
CONSTRAINT chat_settings_81434961_c CHECK ((length((value)::text) <= 1000))
);
CREATE TABLE public.chat_transcript (
chatid bigint NOT NULL,
chat_json citext NOT NULL
);
CREATE TABLE public.chatattachments (
chat_infoid bigint NOT NULL,
attachmentid bigint
);
CREATE TABLE public.chatjson (
chat_infoid bigint NOT NULL,
json citext NOT NULL
);
CREATE TABLE public.chatmessages (
chat_infoid bigint NOT NULL,
message citext NOT NULL
);
CREATE TABLE public.chatnotes (
chat_infoid bigint NOT NULL,
note citext NOT NULL,
share integer DEFAULT 1
);
CREATE TABLE public.chatrequestmap (
mappingid bigint NOT NULL,
chatid bigint NOT NULL,
requestid bigint NOT NULL
);
CREATE TABLE public.chatstates (
id bigint NOT NULL,
status citext NOT NULL,
is_pending integer DEFAULT 0,
CONSTRAINT chatstates_1839152142_c CHECK ((length((status)::text) <= 100))
);
CREATE TABLE public.chatusers (
id bigint NOT NULL,
chatid bigint NOT NULL,
userid bigint NOT NULL,
status citext NOT NULL,
"time" bigint NOT NULL,
CONSTRAINT chatusers_1839152142_c CHECK ((length((status)::text) <= 20))
);
CREATE TABLE public.checklist (
checklistid bigint NOT NULL,
title citext NOT NULL,
description citext,
createdby bigint,
createdtime bigint NOT NULL,
lastupdatedby bigint,
lastupdatedtime bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT checklist_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT checklist_79833656_c CHECK ((length((title)::text) <= 100))
);
CREATE TABLE public.checklistitem (
checklistitemid bigint NOT NULL,
checklistid bigint NOT NULL,
columnaliasesid bigint NOT NULL,
checklistitemorder bigint NOT NULL
);
CREATE TABLE public.ci (
ciid bigint NOT NULL,
citypeid bigint NOT NULL,
ciname citext NOT NULL,
description citext,
label citext,
createddate bigint,
lastmodified bigint,
version citext,
lifecyclegroupidentifier citext,
siteid bigint,
statusid bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT ci_1069590712_c CHECK ((length((version)::text) <= 100)),
CONSTRAINT ci_1987958769_c CHECK ((length((ciname)::text) <= 250)),
CONSTRAINT ci_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT ci_673494974_c CHECK ((length((lifecyclegroupidentifier)::text) <= 100)),
CONSTRAINT ci_72189652_c CHECK ((length((label)::text) <= 100))
);
CREATE TABLE public.ciextappmappings (
otherappmapid bigint NOT NULL,
ciid bigint NOT NULL,
moduleid bigint NOT NULL,
description citext NOT NULL,
additionalurlparams citext,
count bigint NOT NULL,
lastupdateddate bigint NOT NULL,
CONSTRAINT ciextappmappings_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT ciextappmappings_450271054_c CHECK ((length((additionalurlparams)::text) <= 100))
);
CREATE TABLE public.cihistory (
historyid bigint NOT NULL,
ciid bigint NOT NULL,
editmode citext NOT NULL,
operationtime bigint NOT NULL,
userid bigint,
username citext,
CONSTRAINT cihistory_1909554515_c CHECK ((length((editmode)::text) <= 100)),
CONSTRAINT cihistory_516913366_c CHECK ((length((username)::text) <= 500))
);
CREATE TABLE public.cihistorydetails (
cihistoryid bigint NOT NULL,
historyid bigint NOT NULL,
tablename citext NOT NULL,
attribute citext,
conversiontype citext,
newvalue citext,
oldvalue citext,
primarykey citext,
operation bigint NOT NULL,
additionalinfo citext,
CONSTRAINT cihistorydetails_1002083242_c CHECK ((length((oldvalue)::text) <= 3500)),
CONSTRAINT cihistorydetails_1190118064_c CHECK ((length((conversiontype)::text) <= 100)),
CONSTRAINT cihistorydetails_1495287172_c CHECK ((length((attribute)::text) <= 500)),
CONSTRAINT cihistorydetails_2114331695_c CHECK ((length((newvalue)::text) <= 3500)),
CONSTRAINT cihistorydetails_789797603_c CHECK ((length((primarykey)::text) <= 100)),
CONSTRAINT cihistorydetails_798830393_c CHECK ((length((tablename)::text) <= 100))
);
CREATE TABLE public.ciinfo_otherapps (
ciinfoid bigint NOT NULL,
ciid bigint NOT NULL,
application citext NOT NULL,
module citext NOT NULL,
url citext NOT NULL,
count bigint DEFAULT '1' NOT NULL,
CONSTRAINT ciinfo_otherapps_2015454612_c CHECK ((length((module)::text) <= 200)),
CONSTRAINT ciinfo_otherapps_587753168_c CHECK ((length((application)::text) <= 200)),
CONSTRAINT ciinfo_otherapps_84303_c CHECK ((length((url)::text) <= 200))
);
CREATE TABLE public.ciqueryfiltercolumn (
column_id bigint NOT NULL,
name citext NOT NULL,
alias citext NOT NULL,
queryid bigint,
subqueryid bigint,
type_id bigint NOT NULL,
pickupquery citext,
CONSTRAINT ciqueryfiltercolumn_1965240404_c CHECK ((length((pickupquery)::text) <= 300)),
CONSTRAINT ciqueryfiltercolumn_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT ciqueryfiltercolumn_62365232_c CHECK ((length((alias)::text) <= 100))
);
CREATE TABLE public.ciqueryreport (
queryid bigint NOT NULL,
query citext NOT NULL,
paramcolumn bigint,
headercolumn bigint NOT NULL,
title citext NOT NULL,
icon_file citext,
CONSTRAINT ciqueryreport_1425298818_c CHECK ((length((icon_file)::text) <= 100)),
CONSTRAINT ciqueryreport_79833656_c CHECK ((length((title)::text) <= 100))
);
CREATE TABLE public.ciqueryreport_datefilter (
reportid bigint NOT NULL,
column_id bigint NOT NULL,
time_choice bigint,
datefiltertype citext NOT NULL,
from_date bigint,
to_date bigint,
CONSTRAINT ciqueryreport_datefilter_159158048_c CHECK ((length((datefiltertype)::text) <= 100))
);
CREATE TABLE public.cirelationships (
cirelationshipid bigint NOT NULL,
ciid bigint NOT NULL,
ciid2 bigint NOT NULL,
relationshiptypeid bigint NOT NULL,
attributetablename citext,
relationshipid bigint,
relationshiptext citext,
CONSTRAINT cirelationships_1327448219_c CHECK ((length((relationshiptext)::text) <= 100)),
CONSTRAINT cirelationships_2090762179_c CHECK ((length((attributetablename)::text) <= 100))
);
CREATE TABLE public.cirelationshipshierarchy (
cirelationshipid bigint NOT NULL,
cirelationshipid2 bigint NOT NULL
);
CREATE TABLE public.cirelattributes (
primarykeyid bigint NOT NULL,
reldid1 bigint NOT NULL,
reldid2 bigint NOT NULL
);
CREATE TABLE public.ciri (
itemid bigint NOT NULL,
ciid bigint NOT NULL
);
CREATE TABLE public.ciscoipphone (
ciid bigint NOT NULL,
phonedn citext,
apploadid citext,
bootloadid citext,
version citext,
hardwarerevision citext,
messagewaiting citext,
udi citext,
timezone citext,
systemfreememory citext,
javaheapfreememory citext,
javapoolfreememory citext,
fipsmodeenabled citext,
CONSTRAINT ciscoipphone_1069590712_c CHECK ((length((version)::text) <= 50)),
CONSTRAINT ciscoipphone_1130155003_c CHECK ((length((javaheapfreememory)::text) <= 19)),
CONSTRAINT ciscoipphone_1148347861_c CHECK ((length((javapoolfreememory)::text) <= 19)),
CONSTRAINT ciscoipphone_122499672_c CHECK ((length((phonedn)::text) <= 19)),
CONSTRAINT ciscoipphone_1239935549_c CHECK ((length((hardwarerevision)::text) <= 50)),
CONSTRAINT ciscoipphone_1293600775_c CHECK ((length((timezone)::text) <= 150)),
CONSTRAINT ciscoipphone_1405232653_c CHECK ((length((bootloadid)::text) <= 50)),
CONSTRAINT ciscoipphone_1509263960_c CHECK ((length((fipsmodeenabled)::text) <= 20)),
CONSTRAINT ciscoipphone_1871989658_c CHECK ((length((messagewaiting)::text) <= 20)),
CONSTRAINT ciscoipphone_702078402_c CHECK ((length((apploadid)::text) <= 50)),
CONSTRAINT ciscoipphone_83866_c CHECK ((length((udi)::text) <= 250)),
CONSTRAINT ciscoipphone_868616740_c CHECK ((length((systemfreememory)::text) <= 19))
);
CREATE TABLE public.cistatus (
statusid bigint NOT NULL,
status citext NOT NULL,
displayname citext NOT NULL,
helpdeskid bigint NOT NULL,
CONSTRAINT cistatus_1839152142_c CHECK ((length((status)::text) <= 100)),
CONSTRAINT cistatus_426904019_c CHECK ((length((displayname)::text) <= 250))
);
CREATE TABLE public.cisubqueryreport (
subqueryid bigint NOT NULL,
queryid bigint NOT NULL,
query citext NOT NULL,
map2 bigint,
groupby citext,
orderby bigint,
title citext NOT NULL,
CONSTRAINT cisubqueryreport_1011411702_c CHECK ((length((groupby)::text) <= 100)),
CONSTRAINT cisubqueryreport_79833656_c CHECK ((length((title)::text) <= 100))
);
CREATE TABLE public.citoreleasemapping (
ciid bigint NOT NULL,
releaseid bigint NOT NULL
);
CREATE TABLE public.citype (
typeid bigint NOT NULL,
typename citext NOT NULL,
description citext,
mapto bigint,
othermapto citext,
tablename citext,
viewname citext,
isdefault boolean DEFAULT false NOT NULL,
imagepath citext,
icon citext,
viewname_no bigint,
isvisible boolean DEFAULT true NOT NULL,
helpdeskid bigint,
CONSTRAINT citype_107072709_c CHECK ((length((typename)::text) <= 250)),
CONSTRAINT citype_1909258208_c CHECK ((length((imagepath)::text) <= 250)),
CONSTRAINT citype_1979239088_c CHECK ((length((viewname)::text) <= 50)),
CONSTRAINT citype_2241657_c CHECK ((length((icon)::text) <= 250)),
CONSTRAINT citype_315237319_c CHECK ((length((othermapto)::text) <= 50)),
CONSTRAINT citype_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT citype_798830393_c CHECK ((length((tablename)::text) <= 50))
);
CREATE TABLE public.citypeattribute (
citypeid bigint NOT NULL,
attributeid bigint NOT NULL,
attribute_index integer,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.citypehierarchy (
typeid bigint NOT NULL,
parenttypeid bigint NOT NULL,
childlevel bigint,
helpdeskid bigint
);
CREATE TABLE public.clarification_to_user (
commentid bigint NOT NULL,
user_id bigint NOT NULL
);
CREATE TABLE public.clientaccesslicense (
licenseid bigint NOT NULL,
noofcal bigint,
processorcount bigint
);
CREATE TABLE public.clientserviceproviders (
cvtypeid bigint NOT NULL,
comm_mode integer NOT NULL,
spindex integer NOT NULL,
serviceprovider citext NOT NULL,
CONSTRAINT clientserviceproviders_1295770502_c CHECK ((length((serviceprovider)::text) <= 96))
);
CREATE TABLE public.close_mandatory (
id bigint NOT NULL,
module citext NOT NULL,
field_name citext NOT NULL,
mandatory boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT close_mandatory_1091304144_c CHECK ((length((field_name)::text) <= 100)),
CONSTRAINT close_mandatory_2015454612_c CHECK ((length((module)::text) <= 150))
);
CREATE TABLE public.closurecode (
closurecodeid bigint NOT NULL,
closurecodename citext NOT NULL,
description citext,
moduleid bigint NOT NULL,
isdeleted boolean DEFAULT false,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT closurecode_1277764883_c CHECK ((length((closurecodename)::text) <= 100)),
CONSTRAINT closurecode_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.cluster (
ciid bigint NOT NULL,
clustertype citext,
ipaddress citext,
ownedby bigint,
CONSTRAINT cluster_1012377620_c CHECK ((length((clustertype)::text) <= 250)),
CONSTRAINT cluster_1538992947_c CHECK ((length((ipaddress)::text) <= 250))
);
CREATE TABLE public.cluster_sd (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.cluster_server (
primarykeyid bigint NOT NULL,
type citext,
state citext,
CONSTRAINT cluster_server_2590522_c CHECK ((length((type)::text) <= 250)),
CONSTRAINT cluster_server_79219825_c CHECK ((length((state)::text) <= 250))
);
CREATE TABLE public.cm_attachments (
instance_id bigint NOT NULL,
attachment_id bigint NOT NULL
);
CREATE TABLE public.cm_comments (
instance_id bigint NOT NULL,
comment_id bigint NOT NULL
);
CREATE TABLE public.cm_tasks (
instance_id bigint NOT NULL,
task_id bigint NOT NULL
);
CREATE TABLE public.color_settings (
color_settingsid bigint NOT NULL,
module citext NOT NULL,
createdby bigint NOT NULL,
createdtime bigint NOT NULL,
lastupdatedby bigint,
lastupdatedtime bigint,
isenabled boolean DEFAULT true NOT NULL,
techpersonalized boolean DEFAULT false NOT NULL,
color_json citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT color_settings_2015454612_c CHECK ((length((module)::text) <= 50))
);
CREATE TABLE public.columnaliases (
columnaliasesid bigint NOT NULL,
tablename citext NOT NULL,
columnname citext NOT NULL,
aliasname citext,
adminlabel citext NOT NULL,
columndesc citext,
field_type citext,
default_value citext,
fixed_length integer DEFAULT '-1' NOT NULL,
only_numeric boolean DEFAULT false NOT NULL,
is_common boolean DEFAULT false NOT NULL,
is_pii boolean DEFAULT false NOT NULL,
to_delete boolean DEFAULT false NOT NULL,
is_encrypted boolean DEFAULT false NOT NULL,
config_json citext,
options_additional_attributes citext,
category_id bigint,
api_name citext,
reference_entity_id bigint,
fk_constraint citext,
criteria_json citext,
reference_column_id bigint,
field_group citext,
options_has_image boolean DEFAULT false NOT NULL,
is_udf boolean DEFAULT true NOT NULL,
inactive boolean DEFAULT false NOT NULL,
helpdeskid bigint,
CONSTRAINT columnaliases_1091506047_c CHECK ((length((field_type)::text) <= 30)),
CONSTRAINT columnaliases_1184637189_c CHECK ((length((adminlabel)::text) <= 100)),
CONSTRAINT columnaliases_1619616031_c CHECK ((length((columnname)::text) <= 100)),
CONSTRAINT columnaliases_1619909913_c CHECK ((length((columndesc)::text) <= 250)),
CONSTRAINT columnaliases_1779423664_c CHECK ((length((api_name)::text) <= 300)),
CONSTRAINT columnaliases_535265606_c CHECK ((length((field_group)::text) <= 50)),
CONSTRAINT columnaliases_798830393_c CHECK ((length((tablename)::text) <= 100)),
CONSTRAINT columnaliases_884043369_c CHECK ((length((fk_constraint)::text) <= 50)),
CONSTRAINT columnaliases_92371131_c CHECK ((length((aliasname)::text) <= 500))
);
CREATE TABLE public.columndetails (
column_id bigint NOT NULL,
table_id bigint NOT NULL,
column_name citext NOT NULL,
data_type citext NOT NULL,
isnullable boolean DEFAULT false NOT NULL,
generator_name citext,
name_column citext,
column_desc citext,
default_value citext,
max_size integer,
display_name citext,
sql_type integer,
is_instancespecific_seqgen boolean DEFAULT false NOT NULL,
is_dynamic boolean DEFAULT false NOT NULL,
physical_column citext,
CONSTRAINT columndetails_1056080307_c CHECK ((length((default_value)::text) <= 255)),
CONSTRAINT columndetails_1186609303_c CHECK ((length((generator_name)::text) <= 250)),
CONSTRAINT columndetails_1347292634_c CHECK ((length((column_desc)::text) <= 1000)),
CONSTRAINT columndetails_1347586516_c CHECK ((length((column_name)::text) <= 60)),
CONSTRAINT columndetails_1842179409_c CHECK ((length((data_type)::text) <= 50)),
CONSTRAINT columndetails_333046776_c CHECK ((length((display_name)::text) <= 255)),
CONSTRAINT columndetails_33381442_c CHECK ((length((physical_column)::text) <= 150)),
CONSTRAINT columndetails_349990794_c CHECK ((length((name_column)::text) <= 150))
);
CREATE TABLE public.columnlink (
linkid bigint NOT NULL,
link citext,
class citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT columnlink_2336762_c CHECK ((length((link)::text) <= 250)),
CONSTRAINT columnlink_64205144_c CHECK ((length((class)::text) <= 100))
);
CREATE TABLE public.commands (
commandid bigint NOT NULL,
command citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT commands_1668377387_c CHECK ((length((command)::text) <= 250))
);
CREATE TABLE public.commentimages (
commentid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.comments (
commentid bigint NOT NULL,
commentowner bigint NOT NULL,
createdtime bigint NOT NULL,
comment citext,
parentid bigint
);
CREATE TABLE public.commonmailproperties (
propid bigint NOT NULL,
mailbox citext DEFAULT 'INBOX',
disablenewrequest boolean DEFAULT false,
exceptionlist citext,
mailfetchinterval bigint DEFAULT '1',
maildebug boolean DEFAULT false,
error_folder_enabled boolean DEFAULT false,
error_folder_name citext,
error_folder_identifier citext,
error_stop_mail_fetching boolean DEFAULT false,
error_mails_threshold bigint DEFAULT '10',
error_mail_notification_enabled boolean DEFAULT true,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT commonmailproperties_1137560549_c CHECK ((length((error_folder_name)::text) <= 100)),
CONSTRAINT commonmailproperties_1548948628_c CHECK ((length((mailbox)::text) <= 50)),
CONSTRAINT commonmailproperties_2132408701_c CHECK ((length((error_folder_identifier)::text) <= 500))
);
CREATE TABLE public.commonpassword (
id bigint NOT NULL,
category citext NOT NULL,
password bytea NOT NULL,
description citext DEFAULT '-',
CONSTRAINT commonpassword_428414940_c CHECK ((length((description)::text) <= 200)),
CONSTRAINT commonpassword_833137918_c CHECK ((length((category)::text) <= 100))
);
CREATE TABLE public.commonrule_selectquery (
commonrulesqid bigint NOT NULL,
modulename citext NOT NULL,
queryid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT commonrule_selectquery_384305417_c CHECK ((length((modulename)::text) <= 100))
);
CREATE TABLE public.compliancependinglist (
softwareid bigint NOT NULL
);
CREATE TABLE public.componentdefinition (
componentid bigint NOT NULL,
componentname citext NOT NULL,
manufacturername citext DEFAULT '-',
componenttypeid bigint,
partno citext DEFAULT '-',
comments citext,
cost double DEFAULT '0' NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT componentdefinition_1942080268_c CHECK ((length((partno)::text) <= 100)),
CONSTRAINT componentdefinition_350563804_c CHECK ((length((manufacturername)::text) <= 100)),
CONSTRAINT componentdefinition_528476392_c CHECK ((length((componentname)::text) <= 150))
);
CREATE TABLE public.componentdefinitioncomputer (
componentid bigint NOT NULL,
computergroupid bigint NOT NULL
);
CREATE TABLE public.componentdefinitionmodel (
componentid bigint NOT NULL,
discoveredkey citext NOT NULL,
CONSTRAINT componentdefinitionmodel_981435127_c CHECK ((length((discoveredkey)::text) <= 100))
);
CREATE TABLE public.componentdefinitionsoftware (
componentid bigint NOT NULL,
softwareid bigint NOT NULL
);
CREATE TABLE public.componentdepreciation (
componentid bigint NOT NULL,
depreciationid bigint NOT NULL
);
CREATE TABLE public.componenticons (
componentid bigint NOT NULL,
mediaid bigint NOT NULL,
"PRIMARY" boolean DEFAULT false NOT NULL
);
CREATE TABLE public.componentimages (
componentid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.componentstore (
componentid bigint NOT NULL,
stockcount bigint,
replenishmentperiod bigint,
thresholdcount bigint,
escalatetoid bigint
);
CREATE TABLE public.componenttype (
componenttypeid bigint NOT NULL,
resourcetypeid bigint NOT NULL,
resourcecategoryid bigint NOT NULL,
componenttypename citext NOT NULL,
description citext DEFAULT '-',
isvisible boolean DEFAULT true NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
isdefault boolean DEFAULT false NOT NULL,
isdeletable boolean DEFAULT true NOT NULL,
CONSTRAINT componenttype_2077176670_c CHECK ((length((componenttypename)::text) <= 250)),
CONSTRAINT componenttype_428414940_c CHECK ((length((description)::text) <= 100))
);
CREATE TABLE public.componentvendor (
componentvendorid bigint NOT NULL,
componentid bigint NOT NULL,
vendorid bigint NOT NULL,
componentprice double DEFAULT '0',
warrantyperiodyrs bigint,
warrantyperiodmths bigint,
maintvendorid bigint,
support citext DEFAULT '-',
comments citext,
taxrate double DEFAULT '0' NOT NULL,
CONSTRAINT componentvendor_1136784465_c CHECK ((length((support)::text) <= 250))
);
CREATE TABLE public.composite (
schedule_id bigint NOT NULL,
sub_schedule_id1 bigint NOT NULL,
operator citext NOT NULL,
sub_schedule_id2 bigint NOT NULL,
CONSTRAINT composite_282073252_c CHECK ((length((operator)::text) <= 150))
);
CREATE TABLE public.computergroups (
id bigint NOT NULL,
name citext NOT NULL,
CONSTRAINT computergroups_2388619_c CHECK ((length((name)::text) <= 50))
);
CREATE TABLE public.conffile (
fileid bigint NOT NULL,
url citext NOT NULL,
handlerclass citext,
populatorclass citext,
CONSTRAINT conffile_1899903086_c CHECK ((length((handlerclass)::text) <= 200)),
CONSTRAINT conffile_722396730_c CHECK ((length((populatorclass)::text) <= 200)),
CONSTRAINT conffile_84303_c CHECK ((length((url)::text) <= 300))
);
CREATE TABLE public.conffiletohelpdesk (
conffileid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.conffiletomodule (
fileid bigint NOT NULL,
module_id bigint
);
CREATE TABLE public.connectivity_status (
record_id bigint NOT NULL,
success_time timestamp without time zone,
error_time timestamp without time zone,
status citext,
CONSTRAINT connectivity_status_1839152142_c CHECK ((length((status)::text) <= 50))
);
CREATE TABLE public.constituenttable (
personalityid bigint NOT NULL,
tableid bigint NOT NULL,
tableindex integer,
mandatory boolean DEFAULT true NOT NULL,
fkconstraint_id bigint
);
CREATE TABLE public.constraintdefinition (
constraint_id bigint NOT NULL,
constraint_name citext NOT NULL,
table_id bigint NOT NULL,
actual_constraint_name citext,
CONSTRAINT constraintdefinition_1012342020_c CHECK ((length((actual_constraint_name)::text) <= 100)),
CONSTRAINT constraintdefinition_1952828333_c CHECK ((length((constraint_name)::text) <= 100))
);
CREATE TABLE public.contract_fields (
contractid bigint NOT NULL,
udf_long1 bigint,
udf_long2 bigint,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
udf_char5 citext,
udf_char6 citext,
udf_date1 bigint,
udf_date2 bigint,
udf_long3 bigint,
udf_long4 bigint,
udf_char7 citext,
udf_char8 citext,
udf_char9 citext,
udf_char10 citext,
udf_char11 citext,
udf_char12 citext,
udf_date3 bigint,
udf_date4 bigint,
CONSTRAINT contract_fields_278184709_c CHECK ((length((udf_char9)::text) <= 3500)),
CONSTRAINT contract_fields_278184710_c CHECK ((length((udf_char8)::text) <= 3500)),
CONSTRAINT contract_fields_278184711_c CHECK ((length((udf_char7)::text) <= 3500)),
CONSTRAINT contract_fields_278184712_c CHECK ((length((udf_char6)::text) <= 3500)),
CONSTRAINT contract_fields_278184713_c CHECK ((length((udf_char5)::text) <= 3500)),
CONSTRAINT contract_fields_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT contract_fields_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT contract_fields_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT contract_fields_278184717_c CHECK ((length((udf_char1)::text) <= 3500)),
CONSTRAINT contract_fields_33791585_c CHECK ((length((udf_char12)::text) <= 3500)),
CONSTRAINT contract_fields_33791586_c CHECK ((length((udf_char11)::text) <= 3500)),
CONSTRAINT contract_fields_33791587_c CHECK ((length((udf_char10)::text) <= 3500))
);
CREATE TABLE public.contractattachment (
attachmentid bigint NOT NULL,
contractid bigint NOT NULL
);
CREATE TABLE public.contractcategory (
categoryid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
categoryname citext NOT NULL,
description citext,
createdby bigint,
deleted boolean DEFAULT false NOT NULL,
CONSTRAINT contractcategory_1550684023_c CHECK ((length((categoryname)::text) <= 100)),
CONSTRAINT contractcategory_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.contractdetails (
cdid bigint NOT NULL,
contractid bigint NOT NULL,
resourceid bigint NOT NULL
);
CREATE TABLE public.contractnotificationmailids (
contractid bigint NOT NULL,
mailid citext NOT NULL,
CONSTRAINT contractnotificationmailids_2028243694_c CHECK ((length((mailid)::text) <= 500))
);
CREATE TABLE public.contractnotificationsettings (
id bigint NOT NULL,
contractid bigint NOT NULL,
days bigint NOT NULL,
issent boolean DEFAULT false NOT NULL
);
CREATE TABLE public.contractref (
contractid bigint NOT NULL,
refcontractid bigint NOT NULL
);
CREATE TABLE public.contractri (
itemid bigint NOT NULL,
contractid bigint NOT NULL
);
CREATE TABLE public.contractstatus (
statusid bigint NOT NULL,
statusname citext NOT NULL,
ispending citext DEFAULT 'true' NOT NULL,
statusdescription citext,
CONSTRAINT contractstatus_140424947_c CHECK ((length((ispending)::text) <= 5)),
CONSTRAINT contractstatus_502347606_c CHECK ((length((statusdescription)::text) <= 250)),
CONSTRAINT contractstatus_733867389_c CHECK ((length((statusname)::text) <= 100))
);
CREATE TABLE public.conversation (
conversationid bigint NOT NULL,
workorderid bigint NOT NULL,
requesterid bigint NOT NULL,
createdtime bigint NOT NULL,
title citext,
hasattachment boolean DEFAULT false NOT NULL,
child_woid bigint,
type citext DEFAULT 'conversation',
ispublic boolean DEFAULT true NOT NULL,
CONSTRAINT conversation_2590522_c CHECK ((length((type)::text) <= 50)),
CONSTRAINT conversation_79833656_c CHECK ((length((title)::text) <= 250))
);
CREATE TABLE public.conversationattachment (
attachmentid bigint NOT NULL,
conversationid bigint NOT NULL
);
CREATE TABLE public.conversationdescription (
conversationid bigint NOT NULL,
description citext,
attachmentid bigint
);
CREATE TABLE public.conversationhistory (
historyid bigint NOT NULL,
conversationid bigint NOT NULL,
operationownerid bigint NOT NULL,
operationtime bigint NOT NULL,
description citext,
operation citext DEFAULT 'CREATE',
CONSTRAINT conversationhistory_154330439_c CHECK ((length((operation)::text) <= 50))
);
CREATE TABLE public.conversationrecipients (
conversationid bigint NOT NULL,
recipient_name citext,
recipient_email citext NOT NULL,
to_cc_bcc citext,
CONSTRAINT conversationrecipients_1813314833_c CHECK ((length((recipient_name)::text) <= 250)),
CONSTRAINT conversationrecipients_370219446_c CHECK ((length((recipient_email)::text) <= 250)),
CONSTRAINT conversationrecipients_862828025_c CHECK ((length((to_cc_bcc)::text) <= 250))
);
CREATE TABLE public.countrydefinition (
country_id bigint NOT NULL,
country_code citext NOT NULL,
name citext NOT NULL,
CONSTRAINT countrydefinition_2388619_c CHECK ((length((name)::text) <= 250)),
CONSTRAINT countrydefinition_467061482_c CHECK ((length((country_code)::text) <= 10))
);
CREATE TABLE public.countryregionmappingdefinition (
mappingid bigint NOT NULL,
countryname citext NOT NULL,
regionname citext NOT NULL,
CONSTRAINT countryregionmappingdefinition_1504644225_c CHECK ((length((regionname)::text) <= 100)),
CONSTRAINT countryregionmappingdefinition_677161729_c CHECK ((length((countryname)::text) <= 100))
);
CREATE TABLE public.crcolumnsettings (
column_id bigint NOT NULL,
width integer DEFAULT 100 NOT NULL
);
CREATE TABLE public.creatordashboard (
id bigint NOT NULL,
pagename citext NOT NULL,
structure citext NOT NULL,
previewfile citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
createdby bigint,
createdtime bigint NOT NULL,
lastupdatedby bigint,
lastupdatedtime bigint,
isselected boolean DEFAULT false NOT NULL,
CONSTRAINT creatordashboard_1642851738_c CHECK ((length((pagename)::text) <= 250)),
CONSTRAINT creatordashboard_862275876_c CHECK ((length((previewfile)::text) <= 250))
);
CREATE TABLE public.creatorlinkdetails (
id bigint NOT NULL,
name citext NOT NULL,
url citext NOT NULL,
show_to_requesters boolean DEFAULT false NOT NULL,
description citext,
orderid integer NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT creatorlinkdetails_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT creatorlinkdetails_428414940_c CHECK ((length((description)::text) <= 200)),
CONSTRAINT creatorlinkdetails_84303_c CHECK ((length((url)::text) <= 2000))
);
CREATE TABLE public.credentials (
credentialid bigint NOT NULL,
name citext NOT NULL,
description citext DEFAULT '-',
protocolid bigint NOT NULL,
username citext,
passwordid bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT credentials_2388619_c CHECK ((length((name)::text) <= 250)),
CONSTRAINT credentials_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT credentials_516913366_c CHECK ((length((username)::text) <= 250))
);
CREATE TABLE public.criteria (
queryid bigint NOT NULL,
criteriaid bigint NOT NULL,
logicalrepresentation citext,
is_expression_param boolean DEFAULT false NOT NULL,
CONSTRAINT criteria_1243883274_c CHECK ((length((logicalrepresentation)::text) <= 4000))
);
CREATE TABLE public.csrmenuitem (
menuitemid bigint NOT NULL,
actionname citext DEFAULT 'invokeMenuAction',
actionarg citext,
routeto citext,
CONSTRAINT csrmenuitem_1957242431_c CHECK ((length((actionname)::text) <= 100))
);
CREATE TABLE public.ct_fieldchar (
fieldid bigint NOT NULL,
templateid bigint NOT NULL,
field_name citext NOT NULL,
mandatory boolean DEFAULT false NOT NULL,
field_index integer DEFAULT '-1' NOT NULL,
colspanval integer DEFAULT 1 NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT ct_fieldchar_1091304144_c CHECK ((length((field_name)::text) <= 100))
);
CREATE TABLE public.cudroles (
role_id bigint NOT NULL
);
CREATE TABLE public.currency (
currencyid bigint NOT NULL,
currencyname citext NOT NULL,
currencycode citext NOT NULL,
currencysymbol citext NOT NULL,
exchangerate double DEFAULT '0' NOT NULL,
frequentcurrency boolean DEFAULT false NOT NULL,
basecurrency boolean DEFAULT false NOT NULL,
CONSTRAINT currency_1577043735_c CHECK ((length((currencysymbol)::text) <= 250)),
CONSTRAINT currency_971644388_c CHECK ((length((currencyname)::text) <= 250)),
CONSTRAINT currency_971958914_c CHECK ((length((currencycode)::text) <= 250))
);
CREATE TABLE public.currentapprovalstage (
id bigint NOT NULL,
workorderid bigint NOT NULL,
stageid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.custom_001 (
instance_id bigint NOT NULL
);
CREATE TABLE public.custom_multiselect_001 (
multiselect_id bigint NOT NULL,
instance_id bigint NOT NULL
);
CREATE TABLE public.custom_schedule (
schedule_id bigint NOT NULL,
executorclass citext NOT NULL,
execution_type citext NOT NULL,
created_by bigint NOT NULL,
created_time bigint NOT NULL,
result citext,
issdpdefault boolean DEFAULT false NOT NULL,
arguments citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT custom_schedule_751077686_c CHECK ((length((arguments)::text) <= 250))
);
CREATE TABLE public.custom_schedule_cfmapping (
schedule_id bigint NOT NULL,
cfdetailid bigint NOT NULL
);
CREATE TABLE public.customattributes (
custom_attr_id bigint NOT NULL,
attributes citext,
CONSTRAINT customattributes_890738007_c CHECK ((length((attributes)::text) <= 70000))
);
CREATE TABLE public.customfilter_critcols (
filter_criteria_id bigint NOT NULL,
filterid bigint NOT NULL,
column_id bigint NOT NULL,
criteria_id bigint NOT NULL,
match_type citext NOT NULL,
value citext NOT NULL,
CONSTRAINT customfilter_critcols_1915052652_c CHECK ((length((match_type)::text) <= 4))
);
CREATE TABLE public.customfilter_details (
filterid bigint NOT NULL,
filter_name citext NOT NULL,
module_id bigint NOT NULL,
is_public boolean DEFAULT true NOT NULL,
ownerid bigint DEFAULT '-1' NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
is_advancedsearch boolean DEFAULT false NOT NULL,
CONSTRAINT customfilter_details_1292392178_c CHECK ((length((filter_name)::text) <= 100))
);
CREATE TABLE public.customfilter_sql (
filterid bigint NOT NULL,
queryid bigint NOT NULL
);
CREATE TABLE public.customfilterdetails (
filterid bigint NOT NULL,
filtername citext NOT NULL,
internalname citext NOT NULL,
filtermodule citext NOT NULL,
description citext,
criteriajson citext,
ispublic boolean DEFAULT false,
createdon bigint NOT NULL,
createdby bigint NOT NULL,
updatedby bigint,
updatedon bigint,
helpdeskid bigint,
isadvancedsearch boolean DEFAULT false NOT NULL,
CONSTRAINT customfilterdetails_1067207165_c CHECK ((length((filtername)::text) <= 250)),
CONSTRAINT customfilterdetails_2056879416_c CHECK ((length((internalname)::text) <= 250)),
CONSTRAINT customfilterdetails_895148004_c CHECK ((length((filtermodule)::text) <= 250))
);
CREATE TABLE public.customfunctiondetails (
functionid bigint NOT NULL,
name citext NOT NULL,
returntype citext NOT NULL,
description citext,
delugescript bytea NOT NULL,
module citext,
paramdetails citext,
type citext NOT NULL,
isactive boolean DEFAULT true NOT NULL,
authtoken bytea,
iscallbackexposed boolean DEFAULT false NOT NULL,
apiname citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT customfunctiondetails_1823252586_c CHECK ((length((returntype)::text) <= 20)),
CONSTRAINT customfunctiondetails_2015454612_c CHECK ((length((module)::text) <= 20)),
CONSTRAINT customfunctiondetails_2388619_c CHECK ((length((name)::text) <= 150)),
CONSTRAINT customfunctiondetails_2590522_c CHECK ((length((type)::text) <= 50)),
CONSTRAINT customfunctiondetails_428414940_c CHECK ((length((description)::text) <= 1000)),
CONSTRAINT customfunctiondetails_81665147_c CHECK ((length((apiname)::text) <= 200))
);
CREATE TABLE public.custommoduledescription (
instance_id bigint NOT NULL,
description citext
);
CREATE TABLE public.custommodulefacilityserviceattachment (
custommoduleinstanceid bigint NOT NULL,
attachmentid bigint NOT NULL
);
CREATE TABLE public.custommodulefacilityservicehistory (
historyid bigint NOT NULL,
custommoduleinstanceid bigint,
operation citext,
operationtime bigint,
operationownerid bigint,
CONSTRAINT custommodulefacilityservicehistory_154330439_c CHECK ((length((operation)::text) <= 100))
);
CREATE TABLE public.custommodulefacilityservicehistorydiff (
historydiffid bigint NOT NULL,
historyid bigint,
columnname citext,
prev_value citext,
current_value citext,
CONSTRAINT custommodulefacilityservicehistorydiff_1619616031_c CHECK ((length((columnname)::text) <= 100))
);
CREATE TABLE public.custommodulehistory (
historyid bigint NOT NULL,
instance_id bigint,
operation citext,
operationtime bigint,
operationownerid bigint,
CONSTRAINT custommodulehistory_154330439_c CHECK ((length((operation)::text) <= 100))
);
CREATE TABLE public.custommodulehistorydiff (
historydiffid bigint NOT NULL,
historyid bigint,
columnname citext,
prev_value citext,
current_value citext,
CONSTRAINT custommodulehistorydiff_1619616031_c CHECK ((length((columnname)::text) <= 100))
);
CREATE TABLE public.custommoduleinstance (
instance_id bigint NOT NULL,
entity_id bigint,
title citext,
created_by bigint,
created_time bigint,
updated_by bigint,
updated_time bigint,
deleted_time bigint,
helpdeskid bigint NOT NULL,
CONSTRAINT custommoduleinstance_79833656_c CHECK ((length((title)::text) <= 100))
);
CREATE TABLE public.custommoduleinstanceimages (
instance_id bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.custommoduleinstanceservice (
custommoduleinstanceid bigint NOT NULL,
templateid bigint NOT NULL,
instance_name citext NOT NULL,
description citext,
created_time bigint,
created_by bigint,
last_modified_time bigint,
last_modified_by bigint,
supervisor bigint,
helpdeskid bigint NOT NULL,
CONSTRAINT custommoduleinstanceservice_1763130357_c CHECK ((length((instance_name)::text) <= 250)),
CONSTRAINT custommoduleinstanceservice_428414940_c CHECK ((length((description)::text) <= 500))
);
CREATE TABLE public.custommoduleinstancespace (
custommoduleinstanceid bigint NOT NULL,
moduleid bigint NOT NULL,
templateid bigint NOT NULL,
instance_name citext NOT NULL,
description citext,
created_time bigint,
created_by bigint,
last_modified_time bigint,
last_modified_by bigint,
alias citext,
space_area double,
total_capacity bigint,
occupied_capacity bigint,
available_capacity bigint,
statusid bigint,
supervisor bigint,
display_image citext,
spaceunit bigint,
building_type citext,
structure_type citext,
is_room_partitionable boolean,
is_floating_capacity boolean,
partition_capacity bigint,
department bigint,
helpdeskid bigint NOT NULL,
CONSTRAINT custommoduleinstancespace_1529098779_c CHECK ((length((building_type)::text) <= 20)),
CONSTRAINT custommoduleinstancespace_1738786978_c CHECK ((length((display_image)::text) <= 100)),
CONSTRAINT custommoduleinstancespace_1763130357_c CHECK ((length((instance_name)::text) <= 250)),
CONSTRAINT custommoduleinstancespace_428414940_c CHECK ((length((description)::text) <= 500)),
CONSTRAINT custommoduleinstancespace_452108634_c CHECK ((length((structure_type)::text) <= 20)),
CONSTRAINT custommoduleinstancespace_62365232_c CHECK ((length((alias)::text) <= 250))
);
CREATE TABLE public.custommodulespaceattachment (
custommoduleinstanceid bigint NOT NULL,
attachmentid bigint NOT NULL
);
CREATE TABLE public.custommodulespacehistory (
historyid bigint NOT NULL,
custommoduleinstanceid bigint,
operation citext,
operationtime bigint,
description citext,
operationownerid bigint,
CONSTRAINT custommodulespacehistory_154330439_c CHECK ((length((operation)::text) <= 100)),
CONSTRAINT custommodulespacehistory_428414940_c CHECK ((length((description)::text) <= 5000))
);
CREATE TABLE public.custommodulespacehistorydiff (
historydiffid bigint NOT NULL,
historyid bigint,
columnname citext,
prev_value citext,
current_value citext,
isencrypted boolean,
CONSTRAINT custommodulespacehistorydiff_1619616031_c CHECK ((length((columnname)::text) <= 100))
);
CREATE TABLE public.custompermission (
id bigint NOT NULL,
association citext NOT NULL,
all_permission citext,
add_permission citext,
edit_permission citext,
view_permission citext,
delete_permission citext,
custom_module_id bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT custompermission_1114494039_c CHECK ((length((view_permission)::text) <= 50000)),
CONSTRAINT custompermission_1344192691_c CHECK ((length((all_permission)::text) <= 50000)),
CONSTRAINT custompermission_1546151139_c CHECK ((length((delete_permission)::text) <= 50000)),
CONSTRAINT custompermission_2065461345_c CHECK ((length((association)::text) <= 19)),
CONSTRAINT custompermission_29630387_c CHECK ((length((add_permission)::text) <= 50000)),
CONSTRAINT custompermission_6138076_c CHECK ((length((edit_permission)::text) <= 50000))
);
CREATE TABLE public.customreport_colstototal (
summarycolid bigint NOT NULL,
reportid bigint NOT NULL,
column_id bigint NOT NULL,
is_count boolean DEFAULT false NOT NULL,
is_sum boolean DEFAULT false NOT NULL,
is_avg boolean DEFAULT false NOT NULL,
is_large boolean DEFAULT false NOT NULL,
is_small boolean DEFAULT false NOT NULL
);
CREATE TABLE public.customreport_datefilter (
reportid bigint NOT NULL,
column_id bigint NOT NULL,
time_choice bigint,
datefiltertype citext NOT NULL,
from_date bigint,
to_date bigint,
CONSTRAINT customreport_datefilter_159158048_c CHECK ((length((datefiltertype)::text) <= 100))
);
CREATE TABLE public.customreport_details (
reportid bigint NOT NULL,
report_name citext NOT NULL,
report_title citext NOT NULL,
report_desc citext,
module_id bigint NOT NULL,
folder_id bigint NOT NULL,
reporttype_id bigint NOT NULL,
is_public boolean DEFAULT true NOT NULL,
ownerid bigint DEFAULT '-1' NOT NULL,
chart_id bigint,
isreadonly boolean DEFAULT false NOT NULL,
helpdeskid bigint,
CONSTRAINT customreport_details_114876563_c CHECK ((length((report_title)::text) <= 100)),
CONSTRAINT customreport_details_1935476412_c CHECK ((length((report_desc)::text) <= 250)),
CONSTRAINT customreport_details_1935770294_c CHECK ((length((report_name)::text) <= 100))
);
CREATE TABLE public.customreport_displaycols (
reportid bigint NOT NULL,
column_id bigint NOT NULL,
column_order bigint NOT NULL
);
CREATE TABLE public.customreport_folder (
folder_id bigint NOT NULL,
folder_name citext NOT NULL,
folder_desc citext,
ownerid bigint DEFAULT '-1' NOT NULL,
helpdeskid bigint,
CONSTRAINT customreport_folder_2001850436_c CHECK ((length((folder_name)::text) <= 100)),
CONSTRAINT customreport_folder_2002144318_c CHECK ((length((folder_desc)::text) <= 250))
);
CREATE TABLE public.customreport_grouping (
reportid bigint NOT NULL,
column_id bigint NOT NULL,
sort_order bigint,
group_order bigint,
date_group citext,
CONSTRAINT customreport_grouping_2030154098_c CHECK ((length((date_group)::text) <= 100))
);
CREATE TABLE public.customreport_sorting (
reportid bigint NOT NULL,
column_id bigint NOT NULL,
sort_order bigint,
sort_type boolean DEFAULT true
);
CREATE TABLE public.customreport_summary (
summaryid bigint NOT NULL,
reportid bigint NOT NULL,
group_summary boolean DEFAULT false NOT NULL,
page_summary boolean DEFAULT false NOT NULL,
report_summary boolean DEFAULT false NOT NULL,
summary_only boolean DEFAULT false NOT NULL
);
CREATE TABLE public.customreportfiltercolumns (
filterid bigint NOT NULL,
reportid bigint NOT NULL,
column_id bigint NOT NULL,
criteria_id bigint NOT NULL,
match_type citext NOT NULL,
value citext NOT NULL,
CONSTRAINT customreportfiltercolumns_1915052652_c CHECK ((length((match_type)::text) <= 4))
);
CREATE TABLE public.customreportquery (
reportid bigint NOT NULL,
chart_query citext,
report_query citext,
report_query_mssql citext,
report_query_postgresql citext
);
CREATE TABLE public.customreportsettings (
setid bigint NOT NULL,
fstextsize bigint DEFAULT '130' NOT NULL,
ftextsize bigint NOT NULL,
fdatesize bigint NOT NULL,
ftimesize bigint NOT NULL,
fnumbersize bigint NOT NULL,
cellwidth bigint NOT NULL,
cellheight bigint NOT NULL,
dateformat citext DEFAULT 'MM-dd-yyyy HH:mm' NOT NULL,
groupdateformat citext DEFAULT 'MM-dd-yyyy' NOT NULL,
replacenullas citext NOT NULL,
fontpath citext DEFAULT '-' NOT NULL,
columnaliaslength integer DEFAULT 0 NOT NULL,
removetitle citext DEFAULT 'false' NOT NULL,
disablelink boolean DEFAULT false NOT NULL,
groupperpage boolean DEFAULT false NOT NULL,
requesthandlerclass citext,
reportutilclass citext,
reportdesignerclass citext,
reportschedulerclass citext,
include_share boolean DEFAULT false NOT NULL,
labellengthsbc integer DEFAULT 0 NOT NULL,
maxcolsbc integer DEFAULT 18 NOT NULL,
chartwidth integer DEFAULT 600 NOT NULL,
chartheight integer DEFAULT 400 NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT customreportsettings_1149083892_c CHECK ((length((fontpath)::text) <= 100)),
CONSTRAINT customreportsettings_1368239300_c CHECK ((length((groupdateformat)::text) <= 20)),
CONSTRAINT customreportsettings_1458850786_c CHECK ((length((reportutilclass)::text) <= 100)),
CONSTRAINT customreportsettings_1556470053_c CHECK ((length((dateformat)::text) <= 100)),
CONSTRAINT customreportsettings_1764632529_c CHECK ((length((reportschedulerclass)::text) <= 100)),
CONSTRAINT customreportsettings_1851492445_c CHECK ((length((requesthandlerclass)::text) <= 100)),
CONSTRAINT customreportsettings_1878487092_c CHECK ((length((removetitle)::text) <= 100)),
CONSTRAINT customreportsettings_2043129703_c CHECK ((length((reportdesignerclass)::text) <= 100)),
CONSTRAINT customreportsettings_661094285_c CHECK ((length((replacenullas)::text) <= 100))
);
CREATE TABLE public.customreporttimechoice (
time_choiceid bigint NOT NULL,
time_choice citext NOT NULL,
CONSTRAINT customreporttimechoice_874689363_c CHECK ((length((time_choice)::text) <= 20))
);
CREATE TABLE public.customreporttypes (
type_id bigint NOT NULL,
name citext NOT NULL,
CONSTRAINT customreporttypes_2388619_c CHECK ((length((name)::text) <= 100))
);
CREATE TABLE public.customviewconfiguration (
cvid bigint NOT NULL,
cvname citext,
queryid bigint NOT NULL,
CONSTRAINT customviewconfiguration_1999964542_c CHECK ((length((cvname)::text) <= 100))
);
CREATE TABLE public.customviewserviceproviders (
cvtypeid bigint NOT NULL,
cvtype citext NOT NULL,
coreclientservice citext NOT NULL,
coreserverservice citext NOT NULL,
CONSTRAINT customviewserviceproviders_1197347627_c CHECK ((length((coreclientservice)::text) <= 100)),
CONSTRAINT customviewserviceproviders_1752400051_c CHECK ((length((coreserverservice)::text) <= 100)),
CONSTRAINT customviewserviceproviders_2000166445_c CHECK ((length((cvtype)::text) <= 96))
);
CREATE TABLE public.dashboardviewdefinition (
dvdid bigint NOT NULL,
viewname citext NOT NULL,
description citext DEFAULT 'No Description' NOT NULL,
createdby bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT dashboardviewdefinition_1979239088_c CHECK ((length((viewname)::text) <= 50)),
CONSTRAINT dashboardviewdefinition_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.dashboardviewmodules (
moduleid bigint NOT NULL,
modulename citext NOT NULL,
CONSTRAINT dashboardviewmodules_384305417_c CHECK ((length((modulename)::text) <= 50))
);
CREATE TABLE public.dashboardviewtoreportmapping (
id bigint NOT NULL,
dvdid bigint NOT NULL,
moduleid bigint NOT NULL,
widgetid bigint NOT NULL,
reportid bigint
);
CREATE TABLE public.dashboardviewtousermapping (
mdumid bigint NOT NULL,
dvdid bigint NOT NULL,
reference_id bigint NOT NULL,
reference_table citext NOT NULL,
CONSTRAINT dashboardviewtousermapping_1031624294_c CHECK ((length((reference_table)::text) <= 50))
);
CREATE TABLE public.databaseci (
ciid bigint NOT NULL
);
CREATE TABLE public.databaseserver (
ciid bigint NOT NULL
);
CREATE TABLE public.datacenter (
ciid bigint NOT NULL,
powerconsumption citext,
floorspace citext,
floorspaceinuse citext,
ownedby bigint,
CONSTRAINT datacenter_1030528902_c CHECK ((length((floorspace)::text) <= 250)),
CONSTRAINT datacenter_145220982_c CHECK ((length((powerconsumption)::text) <= 250)),
CONSTRAINT datacenter_2032054808_c CHECK ((length((floorspaceinuse)::text) <= 250))
);
CREATE TABLE public.datasource (
dsid bigint NOT NULL,
dsname citext NOT NULL,
adapterclass citext NOT NULL,
description citext,
isactive boolean DEFAULT true NOT NULL,
CONSTRAINT datasource_2025823130_c CHECK ((length((dsname)::text) <= 100)),
CONSTRAINT datasource_428414940_c CHECK ((length((description)::text) <= 100)),
CONSTRAINT datasource_996890743_c CHECK ((length((adapterclass)::text) <= 200))
);
CREATE TABLE public.datatype (
datatypeid integer NOT NULL,
datatype citext NOT NULL,
CONSTRAINT datatype_1722316316_c CHECK ((length((datatype)::text) <= 250))
);
CREATE TABLE public.dateunavailability (
leaveid bigint NOT NULL,
leavedate bigint NOT NULL
);
CREATE TABLE public.daysofoperation (
daysofoperationid bigint NOT NULL,
operationalhoursdefid bigint NOT NULL,
weekday citext NOT NULL,
isworking boolean DEFAULT false NOT NULL,
daytype citext DEFAULT 'standard' NOT NULL,
exclude_weeks citext,
CONSTRAINT daysofoperation_1944845064_c CHECK ((length((weekday)::text) <= 10)),
CONSTRAINT daysofoperation_2128580426_c CHECK ((length((daytype)::text) <= 15))
);
CREATE TABLE public.db2 (
ciid bigint NOT NULL
);
CREATE TABLE public.dbadapter (
dsid bigint NOT NULL,
sqlgenerator citext NOT NULL,
drivername citext NOT NULL,
url citext NOT NULL,
username citext,
password citext,
transaction_level citext DEFAULT 'TRANSACTION_READ_COMMITTED' NOT NULL,
min_conn_count integer DEFAULT 1 NOT NULL,
max_conn_count integer DEFAULT 5 NOT NULL,
CONSTRAINT dbadapter_1080142515_c CHECK ((length((drivername)::text) <= 200)),
CONSTRAINT dbadapter_1999612571_c CHECK ((length((password)::text) <= 30)),
CONSTRAINT dbadapter_516913366_c CHECK ((length((username)::text) <= 30)),
CONSTRAINT dbadapter_572791133_c CHECK ((length((transaction_level)::text) <= 50)),
CONSTRAINT dbadapter_671781691_c CHECK ((length((sqlgenerator)::text) <= 200)),
CONSTRAINT dbadapter_84303_c CHECK ((length((url)::text) <= 200))
);
CREATE TABLE public.dbcredentialsaudit (
username citext NOT NULL,
password bytea NOT NULL,
last_modified_time timestamp without time zone NOT NULL,
CONSTRAINT dbcredentialsaudit_516913366_c CHECK ((length((username)::text) <= 50))
);
CREATE TABLE public.dcparameters (
paramid bigint NOT NULL,
paramname citext NOT NULL,
paramvalue citext NOT NULL,
description citext DEFAULT '-' NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT dcparameters_428414940_c CHECK ((length((description)::text) <= 200)),
CONSTRAINT dcparameters_446338168_c CHECK ((length((paramname)::text) <= 100)),
CONSTRAINT dcparameters_958969092_c CHECK ((length((paramvalue)::text) <= 3000))
);
CREATE TABLE public.dcsoftwareinfo (
softwareid bigint NOT NULL,
softwarename citext NOT NULL,
softwaretype integer NOT NULL,
CONSTRAINT dcsoftwareinfo_797874354_c CHECK ((length((softwarename)::text) <= 250))
);
CREATE TABLE public.default_task_input (
instance_id bigint NOT NULL,
variable_name citext NOT NULL,
variable_type citext,
variable_value citext,
CONSTRAINT default_task_input_1544352206_c CHECK ((length((variable_value)::text) <= 300)),
CONSTRAINT default_task_input_188126830_c CHECK ((length((variable_name)::text) <= 100)),
CONSTRAINT default_task_input_188328733_c CHECK ((length((variable_type)::text) <= 50))
);
CREATE TABLE public.defaultconfigvalue (
configid bigint NOT NULL,
reqstatus bigint,
reqpriority bigint,
reqcategory bigint,
reqlevel bigint,
reqmode bigint,
reqgroup bigint,
enableslaesc boolean DEFAULT true NOT NULL,
currency citext,
isfirstlogin boolean DEFAULT true NOT NULL,
emailreqoncreate boolean DEFAULT false NOT NULL,
emailreqonupdate boolean DEFAULT false NOT NULL,
emailreqonclose boolean DEFAULT false NOT NULL,
emailtechonassign boolean DEFAULT false NOT NULL,
smsreqoncreate boolean DEFAULT false NOT NULL,
smsreqonclose boolean DEFAULT false NOT NULL,
smstechonassign boolean DEFAULT false NOT NULL,
smstoaddress citext,
showwsofreqinss boolean DEFAULT false NOT NULL,
emailadminfornewreq boolean DEFAULT false NOT NULL,
smsadminfornewreq boolean DEFAULT false NOT NULL,
escalatetoid bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT defaultconfigvalue_1358028817_c CHECK ((length((currency)::text) <= 25)),
CONSTRAINT defaultconfigvalue_377912288_c CHECK ((length((smstoaddress)::text) <= 100))
);
CREATE TABLE public.defaultdateformat (
id bigint NOT NULL,
date_format citext,
CONSTRAINT defaultdateformat_1458413992_c CHECK ((length((date_format)::text) <= 250))
);
CREATE TABLE public.defaulttheme (
themename bigint NOT NULL
);
CREATE TABLE public.defaulttimeformat (
id bigint NOT NULL,
time_format citext,
CONSTRAINT defaulttimeformat_967134633_c CHECK ((length((time_format)::text) <= 250))
);
CREATE TABLE public.department_people (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.department_share_list (
shareid bigint NOT NULL,
deptid bigint NOT NULL
);
CREATE TABLE public.departmentci (
ciid bigint NOT NULL
);
CREATE TABLE public.departmentdefinition (
deptid bigint NOT NULL,
deptname citext NOT NULL,
deptheadid bigint,
phoneno citext,
fax citext,
siteid bigint,
deptdesc citext,
isdeleted boolean DEFAULT false,
CONSTRAINT departmentdefinition_122499983_c CHECK ((length((phoneno)::text) <= 50)),
CONSTRAINT departmentdefinition_1730232918_c CHECK ((length((deptdesc)::text) <= 250)),
CONSTRAINT departmentdefinition_1730526800_c CHECK ((length((deptname)::text) <= 100)),
CONSTRAINT departmentdefinition_69373_c CHECK ((length((fax)::text) <= 50))
);
CREATE TABLE public.depreciationdetails (
depreciationid bigint NOT NULL,
depreciationtypeid bigint,
salvagevalue double,
usefullife bigint,
depreciationpercent double
);
CREATE TABLE public.depreciationtype (
depreciationtypeid bigint NOT NULL,
depreciationtype citext NOT NULL,
CONSTRAINT depreciationtype_771923527_c CHECK ((length((depreciationtype)::text) <= 200))
);
CREATE TABLE public.deptroletousermapping (
mappingid bigint NOT NULL,
orgroleid bigint NOT NULL,
userid bigint NOT NULL,
deptid bigint NOT NULL,
helpdeskid bigint
);
CREATE TABLE public.desktop (
workstationid bigint NOT NULL
);
CREATE TABLE public.deviceidentification (
deviceidentificationid bigint NOT NULL,
criteriatable citext NOT NULL,
criteriacolumn citext NOT NULL,
criteriavalue citext NOT NULL,
componenttypeid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT deviceidentification_1180972975_c CHECK ((length((criteriatable)::text) <= 100)),
CONSTRAINT deviceidentification_1182829906_c CHECK ((length((criteriavalue)::text) <= 100)),
CONSTRAINT deviceidentification_1776964469_c CHECK ((length((criteriacolumn)::text) <= 100))
);
CREATE TABLE public.devicetypes (
devicetypeid bigint NOT NULL,
devicetype citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT devicetypes_1267236496_c CHECK ((length((devicetype)::text) <= 250))
);
CREATE TABLE public.discoveryconfiguration (
networkid bigint NOT NULL,
networkaddress citext NOT NULL,
fromipaddress citext,
toipaddress citext,
israngescan boolean DEFAULT false NOT NULL,
discoverystatus citext DEFAULT 'UNDISCOVERED' NOT NULL,
lastdiscoveredtime bigint,
description citext,
windowsagentscan boolean DEFAULT false NOT NULL,
CONSTRAINT discoveryconfiguration_1079393181_c CHECK ((length((fromipaddress)::text) <= 25)),
CONSTRAINT discoveryconfiguration_1893201414_c CHECK ((length((networkaddress)::text) <= 25)),
CONSTRAINT discoveryconfiguration_428414940_c CHECK ((length((description)::text) <= 300)),
CONSTRAINT discoveryconfiguration_503749454_c CHECK ((length((toipaddress)::text) <= 25)),
CONSTRAINT discoveryconfiguration_725815934_c CHECK ((length((discoverystatus)::text) <= 100))
);
CREATE TABLE public.discoverydetails (
resourceid bigint NOT NULL,
domainid bigint,
networkid bigint,
devicetypeid bigint,
credentialid bigint
);
CREATE TABLE public.discoveryprotocols (
devicetypeid bigint NOT NULL,
protocolid bigint NOT NULL
);
CREATE TABLE public.discoveryrules (
primarykeyid bigint NOT NULL,
componenttypeid bigint NOT NULL,
criteriatable citext NOT NULL,
criteriacolumn citext NOT NULL,
criteriavalue citext NOT NULL,
citypeid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT discoveryrules_1180972975_c CHECK ((length((criteriatable)::text) <= 100)),
CONSTRAINT discoveryrules_1182829906_c CHECK ((length((criteriavalue)::text) <= 100)),
CONSTRAINT discoveryrules_1776964469_c CHECK ((length((criteriacolumn)::text) <= 100))
);
CREATE TABLE public.discoverytypeconstants (
typeid bigint NOT NULL,
typename citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT discoverytypeconstants_107072709_c CHECK ((length((typename)::text) <= 250))
);
CREATE TABLE public.displaycolumndetails (
pkcolumnid bigint NOT NULL,
viewid bigint NOT NULL,
userid bigint NOT NULL,
columnid bigint NOT NULL,
width integer DEFAULT 180 NOT NULL,
isvisible boolean DEFAULT false NOT NULL,
orderid bigint DEFAULT '999' NOT NULL,
helpdeskid bigint
);
CREATE TABLE public.doc_technician (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.document (
ciid bigint NOT NULL,
date bigint,
keywords citext,
versionnumber citext,
reviewprocess citext,
type citext,
status citext,
CONSTRAINT document_1305776042_c CHECK ((length((keywords)::text) <= 250)),
CONSTRAINT document_1839152142_c CHECK ((length((status)::text) <= 250)),
CONSTRAINT document_2098213897_c CHECK ((length((reviewprocess)::text) <= 250)),
CONSTRAINT document_2590522_c CHECK ((length((type)::text) <= 250)),
CONSTRAINT document_369692161_c CHECK ((length((versionnumber)::text) <= 250))
);
CREATE TABLE public.document_technician (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.documentattachments (
attachmentid bigint NOT NULL,
ciid bigint NOT NULL
);
CREATE TABLE public.domaininfo (
domainid bigint NOT NULL,
domainname citext NOT NULL,
canonicalname citext,
discoverystatus citext DEFAULT 'UNDISCOVERED' NOT NULL,
comments citext,
lastdiscoveredtime bigint,
ispublic boolean DEFAULT true,
lastscantotalcount bigint,
CONSTRAINT domaininfo_725815934_c CHECK ((length((discoverystatus)::text) <= 100)),
CONSTRAINT domaininfo_758040241_c CHECK ((length((domainname)::text) <= 100)),
CONSTRAINT domaininfo_944610655_c CHECK ((length((canonicalname)::text) <= 100))
);
CREATE TABLE public.domainlogininfo (
domainid bigint NOT NULL,
domainloginname citext NOT NULL,
passwordid bigint NOT NULL,
CONSTRAINT domainlogininfo_1719562512_c CHECK ((length((domainloginname)::text) <= 100))
);
CREATE TABLE public.dominanttableconfig (
dominanttableid bigint NOT NULL,
isindexed boolean DEFAULT false NOT NULL,
nonindexlimit integer DEFAULT 10 NOT NULL
);
CREATE TABLE public.donotificationmodule (
moduleid bigint NOT NULL,
name citext NOT NULL,
isenabled boolean DEFAULT true NOT NULL,
helpdeskid bigint DEFAULT '1',
CONSTRAINT donotificationmodule_2388619_c CHECK ((length((name)::text) <= 200))
);
CREATE TABLE public.downgradelicenses (
ulid bigint NOT NULL,
baselicenseid bigint,
downgradedlicenseid bigint NOT NULL,
downgradedfrom bigint,
downgradedto bigint
);
CREATE TABLE public.downtimetypes (
downtimetypeid bigint NOT NULL,
typename citext NOT NULL,
description citext,
isdeleted boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT downtimetypes_107072709_c CHECK ((length((typename)::text) <= 100)),
CONSTRAINT downtimetypes_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.drafts (
draftid bigint NOT NULL,
toaddress citext NOT NULL,
cc citext,
subject citext,
description citext,
lastupdatedtime bigint NOT NULL,
hasattachment boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT drafts_1149902580_c CHECK ((length((subject)::text) <= 250))
);
CREATE TABLE public.drafts_notification (
draftid bigint NOT NULL,
workorderid bigint NOT NULL,
userid bigint NOT NULL,
recommend_templateid bigint,
reply_type citext,
CONSTRAINT drafts_notification_34516081_c CHECK ((length((reply_type)::text) <= 100))
);
CREATE TABLE public.driveinfo (
driveid bigint NOT NULL,
workstationid bigint NOT NULL,
drivename citext DEFAULT '-' NOT NULL,
drivetype citext DEFAULT '-' NOT NULL,
capacity bigint DEFAULT '0' NOT NULL,
freespace bigint DEFAULT '0' NOT NULL,
filesystem citext DEFAULT '-' NOT NULL,
serialnumber citext DEFAULT '-' NOT NULL,
description citext DEFAULT '-' NOT NULL,
remotehost citext DEFAULT '-' NOT NULL,
remotepath citext DEFAULT '-' NOT NULL,
CONSTRAINT driveinfo_1087420757_c CHECK ((length((filesystem)::text) <= 50)),
CONSTRAINT driveinfo_1420185333_c CHECK ((length((drivename)::text) <= 50)),
CONSTRAINT driveinfo_1420387236_c CHECK ((length((drivetype)::text) <= 25)),
CONSTRAINT driveinfo_1527006958_c CHECK ((length((remotehost)::text) <= 250)),
CONSTRAINT driveinfo_1527231851_c CHECK ((length((remotepath)::text) <= 250)),
CONSTRAINT driveinfo_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT driveinfo_977765827_c CHECK ((length((serialnumber)::text) <= 100))
);
CREATE TABLE public.duplicateservicetags (
id bigint NOT NULL,
matchedwsname citext NOT NULL,
scannedwsname citext NOT NULL,
servicetag citext,
macaddress citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT duplicateservicetags_1239651131_c CHECK ((length((servicetag)::text) <= 200)),
CONSTRAINT duplicateservicetags_1732875575_c CHECK ((length((scannedwsname)::text) <= 100)),
CONSTRAINT duplicateservicetags_720703125_c CHECK ((length((matchedwsname)::text) <= 100)),
CONSTRAINT duplicateservicetags_902372293_c CHECK ((length((macaddress)::text) <= 50))
);
CREATE TABLE public.dynamiccolumnconfiguration (
viewname bigint NOT NULL,
tablealias citext NOT NULL,
columnalias citext NOT NULL,
columnname citext NOT NULL,
dycolumnname citext NOT NULL,
CONSTRAINT dynamiccolumnconfiguration_1017743550_c CHECK ((length((tablealias)::text) <= 50)),
CONSTRAINT dynamiccolumnconfiguration_1319828634_c CHECK ((length((columnalias)::text) <= 50)),
CONSTRAINT dynamiccolumnconfiguration_1619616031_c CHECK ((length((columnname)::text) <= 50)),
CONSTRAINT dynamiccolumnconfiguration_1848160566_c CHECK ((length((dycolumnname)::text) <= 100))
);
CREATE TABLE public.dynamicdummy (
colname citext NOT NULL,
colalias citext NOT NULL,
CONSTRAINT dynamicdummy_140702928_c CHECK ((length((colalias)::text) <= 50)),
CONSTRAINT dynamicdummy_1667483627_c CHECK ((length((colname)::text) <= 50))
);
CREATE TABLE public.dynamicgroup (
groupid bigint NOT NULL,
queryid bigint NOT NULL
);
CREATE TABLE public.dynamicnotifications (
dynamicnotificationid bigint NOT NULL,
module citext NOT NULL,
moduleid bigint NOT NULL,
customid bigint,
notify_type citext NOT NULL,
notify_time bigint NOT NULL,
ownerid bigint,
CONSTRAINT dynamicnotifications_2015454612_c CHECK ((length((module)::text) <= 200)),
CONSTRAINT dynamicnotifications_439900784_c CHECK ((length((notify_type)::text) <= 200))
);
CREATE TABLE public.dynamictables (
dynamic_table_id bigint NOT NULL,
tablename citext NOT NULL,
module citext DEFAULT '-' NOT NULL,
char_cols integer,
num_cols integer,
date_cols integer,
dec_cols integer,
helpdeskid bigint,
CONSTRAINT dynamictables_2015454612_c CHECK ((length((module)::text) <= 100)),
CONSTRAINT dynamictables_798830393_c CHECK ((length((tablename)::text) <= 100))
);
CREATE TABLE public.dynamicusercriteria (
id bigint NOT NULL,
fieldid bigint NOT NULL,
criteriaid bigint NOT NULL,
operator citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT dynamicusercriteria_282073252_c CHECK ((length((operator)::text) <= 200))
);
CREATE TABLE public.email_retention (
id bigint NOT NULL,
emailid bytea NOT NULL,
userid bigint,
is_system_defined boolean DEFAULT false NOT NULL
);
CREATE TABLE public.emptytablemessage (
empty_message_id bigint NOT NULL,
icon_url citext,
title_text citext,
message_text citext NOT NULL,
menu_id bigint,
CONSTRAINT emptytablemessage_1060749957_c CHECK ((length((message_text)::text) <= 500)),
CONSTRAINT emptytablemessage_1258721580_c CHECK ((length((title_text)::text) <= 200)),
CONSTRAINT emptytablemessage_45992073_c CHECK ((length((icon_url)::text) <= 200))
);
CREATE TABLE public.entitycategories (
category_id bigint NOT NULL,
name citext NOT NULL,
template_entity citext,
base_table citext NOT NULL,
pk_column citext NOT NULL,
max_columns integer DEFAULT 250 NOT NULL,
CONSTRAINT entitycategories_2114190152_c CHECK ((length((template_entity)::text) <= 50)),
CONSTRAINT entitycategories_2388619_c CHECK ((length((name)::text) <= 50)),
CONSTRAINT entitycategories_593716710_c CHECK ((length((pk_column)::text) <= 50)),
CONSTRAINT entitycategories_926516416_c CHECK ((length((base_table)::text) <= 50))
);
CREATE TABLE public.entitycategoryconfig (
config_id bigint NOT NULL,
category_id bigint,
entity_id bigint,
current_table citext NOT NULL,
current_multiselect_table citext,
total_fields integer DEFAULT 0 NOT NULL,
max_fields integer DEFAULT 100 NOT NULL,
helpdeskid bigint,
CONSTRAINT entitycategoryconfig_1971205816_c CHECK ((length((current_table)::text) <= 50)),
CONSTRAINT entitycategoryconfig_887877410_c CHECK ((length((current_multiselect_table)::text) <= 50))
);
CREATE TABLE public.entitydefinition (
entity_id bigint NOT NULL,
api_name citext NOT NULL,
api_plural_name citext,
display_name citext NOT NULL,
display_plural_name citext,
created_by bigint,
created_time bigint,
updated_by bigint,
updated_time bigint,
parent_id bigint,
category_id bigint,
description citext,
icon bigint,
entity_type citext,
inactive boolean DEFAULT false NOT NULL,
is_task_supported boolean DEFAULT false NOT NULL,
is_attachment_supported boolean DEFAULT false NOT NULL,
is_comment_supported boolean DEFAULT false NOT NULL,
is_report_supported boolean DEFAULT false NOT NULL,
can_be_referred boolean DEFAULT false NOT NULL,
is_draft boolean DEFAULT false NOT NULL,
helpdeskid bigint,
CONSTRAINT entitydefinition_1542172087_c CHECK ((length((display_plural_name)::text) <= 50)),
CONSTRAINT entitydefinition_1779423664_c CHECK ((length((api_name)::text) <= 50)),
CONSTRAINT entitydefinition_333046776_c CHECK ((length((display_name)::text) <= 50)),
CONSTRAINT entitydefinition_428414940_c CHECK ((length((description)::text) <= 500)),
CONSTRAINT entitydefinition_830743018_c CHECK ((length((entity_type)::text) <= 50)),
CONSTRAINT entitydefinition_940480607_c CHECK ((length((api_plural_name)::text) <= 50))
);
CREATE TABLE public.entityfieldmapping (
entity_id bigint NOT NULL,
field_id bigint NOT NULL,
helpdeskid bigint
);
CREATE TABLE public.entitylayoutmapping (
layout_mapping_id bigint NOT NULL,
entity_id bigint NOT NULL,
template_id bigint,
layout_id bigint NOT NULL
);
CREATE TABLE public.entityreportmodule (
entity_id bigint NOT NULL,
report_id bigint NOT NULL,
helpdeskid bigint
);
CREATE TABLE public.errorlog (
errorlogid bigint NOT NULL,
occurredtime bigint NOT NULL,
message citext NOT NULL,
errormodule citext DEFAULT '-' NOT NULL,
suberrormodule citext DEFAULT '-',
probablecause citext,
ownerid bigint,
type citext,
action citext DEFAULT '-',
hasattachment boolean DEFAULT false NOT NULL,
helpdeskid bigint,
CONSTRAINT errorlog_1672907751_c CHECK ((length((message)::text) <= 3500)),
CONSTRAINT errorlog_1731225172_c CHECK ((length((errormodule)::text) <= 50)),
CONSTRAINT errorlog_1925345846_c CHECK ((length((action)::text) <= 20)),
CONSTRAINT errorlog_2001728646_c CHECK ((length((probablecause)::text) <= 3500)),
CONSTRAINT errorlog_2590522_c CHECK ((length((type)::text) <= 10)),
CONSTRAINT errorlog_815361996_c CHECK ((length((suberrormodule)::text) <= 50))
);
CREATE TABLE public.errorlogattachments (
attachmentid bigint NOT NULL,
errorlogid bigint NOT NULL,
helpdeskid bigint
);
CREATE TABLE public.errorlogowner (
errorlogid bigint NOT NULL,
operationownerid bigint
);
CREATE TABLE public.escalatetomediator (
escalatetoid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.escalateton (
escalatetonid bigint NOT NULL,
escalatetoid bigint NOT NULL,
userid bigint,
orgroleid bigint,
xpath citext,
CONSTRAINT escalateton_83718269_c CHECK ((length((xpath)::text) <= 200))
);
CREATE TABLE public.esmsecureattachmentconfig (
helpdeskid bigint NOT NULL,
ispasswordprotected boolean DEFAULT false NOT NULL,
authenticationid bigint
);
CREATE TABLE public.esmsequenceconfig (
start_sequence bigint NOT NULL,
end_sequence bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.eventnotification (
record_id bigint NOT NULL,
creator_id bigint NOT NULL,
creator_last_modified_time timestamp without time zone NOT NULL,
category citext NOT NULL,
title citext NOT NULL,
start_datetime timestamp without time zone,
end_datetime timestamp without time zone,
description citext,
primary_url citext,
viewable_build_number integer,
region_include_list citext,
country_exclude_list citext,
viewable_license_type citext,
is_viewable boolean DEFAULT false NOT NULL,
is_viewable_timezone boolean DEFAULT true NOT NULL,
impacted_build citext,
CONSTRAINT eventnotification_1286689138_c CHECK ((length((primary_url)::text) <= 500)),
CONSTRAINT eventnotification_1549233676_c CHECK ((length((impacted_build)::text) <= 255)),
CONSTRAINT eventnotification_15642068_c CHECK ((length((country_exclude_list)::text) <= 1000)),
CONSTRAINT eventnotification_609208152_c CHECK ((length((viewable_license_type)::text) <= 50)),
CONSTRAINT eventnotification_627790176_c CHECK ((length((region_include_list)::text) <= 500)),
CONSTRAINT eventnotification_79833656_c CHECK ((length((title)::text) <= 250)),
CONSTRAINT eventnotification_833137918_c CHECK ((length((category)::text) <= 100))
);
CREATE TABLE public.eventnotification_persview (
creator_id bigint NOT NULL,
user_id bigint NOT NULL,
is_read boolean DEFAULT false NOT NULL,
is_new boolean DEFAULT true NOT NULL
);
CREATE TABLE public.eventnotification_properties (
record_id bigint NOT NULL,
property_name citext NOT NULL,
property_value citext,
CONSTRAINT eventnotification_properties_1496077927_c CHECK ((length((property_value)::text) <= 100)),
CONSTRAINT eventnotification_properties_2126232245_c CHECK ((length((property_name)::text) <= 100))
);
CREATE TABLE public.excludedevice (
excludeid bigint NOT NULL,
devicename citext NOT NULL,
userid bigint NOT NULL,
excludedtime bigint NOT NULL,
CONSTRAINT excludedevice_1267034593_c CHECK ((length((devicename)::text) <= 200))
);
CREATE TABLE public.expression (
expression_id bigint NOT NULL,
root_expression_id bigint NOT NULL,
expression_name citext NOT NULL,
value_type integer NOT NULL,
CONSTRAINT expression_1063711790_c CHECK ((length((expression_name)::text) <= 50))
);
CREATE TABLE public.expressiontokens (
expressiontokenid bigint NOT NULL,
parserconfid bigint,
token bigint,
tablename citext,
columnname citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT expressiontokens_1619616031_c CHECK ((length((columnname)::text) <= 250)),
CONSTRAINT expressiontokens_798830393_c CHECK ((length((tablename)::text) <= 250))
);
CREATE TABLE public.externalactions (
executorid bigint NOT NULL,
executiontype citext NOT NULL,
executor citext NOT NULL,
CONSTRAINT externalactions_1469323053_c CHECK ((length((executor)::text) <= 1000)),
CONSTRAINT externalactions_255695310_c CHECK ((length((executiontype)::text) <= 100))
);
CREATE TABLE public.externalapiusage (
id bigint NOT NULL,
url citext,
technician_key citext,
authtoken_param citext,
portalid_param citext,
format_param citext,
inputdata_param citext,
accept_header citext,
count bigint,
last_used_time citext,
CONSTRAINT externalapiusage_1110749094_c CHECK ((length((last_used_time)::text) <= 50)),
CONSTRAINT externalapiusage_1195133724_c CHECK ((length((technician_key)::text) <= 50)),
CONSTRAINT externalapiusage_1201429029_c CHECK ((length((format_param)::text) <= 50)),
CONSTRAINT externalapiusage_1366732833_c CHECK ((length((authtoken_param)::text) <= 50)),
CONSTRAINT externalapiusage_303664732_c CHECK ((length((accept_header)::text) <= 50)),
CONSTRAINT externalapiusage_385472194_c CHECK ((length((inputdata_param)::text) <= 50)),
CONSTRAINT externalapiusage_542745419_c CHECK ((length((portalid_param)::text) <= 50)),
CONSTRAINT externalapiusage_84303_c CHECK ((length((url)::text) <= 50))
);
CREATE TABLE public.externalapplicationmodules (
moduleid bigint NOT NULL,
applicationid bigint NOT NULL,
modulename citext NOT NULL,
htmlcolorcode citext NOT NULL,
url citext NOT NULL,
CONSTRAINT externalapplicationmodules_384305417_c CHECK ((length((modulename)::text) <= 100)),
CONSTRAINT externalapplicationmodules_84303_c CHECK ((length((url)::text) <= 100)),
CONSTRAINT externalapplicationmodules_99415141_c CHECK ((length((htmlcolorcode)::text) <= 10))
);
CREATE TABLE public.externalapplications (
applicationid bigint NOT NULL,
applicationname citext NOT NULL,
protocol citext NOT NULL,
servername citext NOT NULL,
serverport integer NOT NULL,
removendaysoldhistory integer NOT NULL,
isenabled boolean DEFAULT true,
CONSTRAINT externalapplications_129240133_c CHECK ((length((applicationname)::text) <= 100)),
CONSTRAINT externalapplications_1340064690_c CHECK ((length((servername)::text) <= 100)),
CONSTRAINT externalapplications_206537064_c CHECK ((length((protocol)::text) <= 5))
);
CREATE TABLE public.externaltask (
taskid bigint NOT NULL,
createdby bigint NOT NULL,
createdtime bigint NOT NULL
);
CREATE TABLE public.externaltaskdetails (
paramid bigint NOT NULL,
taskid bigint NOT NULL,
paramname citext NOT NULL,
paramvalue citext NOT NULL,
CONSTRAINT externaltaskdetails_446338168_c CHECK ((length((paramname)::text) <= 250)),
CONSTRAINT externaltaskdetails_958969092_c CHECK ((length((paramvalue)::text) <= 3000))
);
CREATE TABLE public.externalwidgetdetail (
extwidgetid bigint NOT NULL,
userid bigint NOT NULL,
viewname citext NOT NULL,
urlinfo citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT externalwidgetdetail_1979239088_c CHECK ((length((viewname)::text) <= 50)),
CONSTRAINT externalwidgetdetail_548431485_c CHECK ((length((urlinfo)::text) <= 2000))
);
CREATE TABLE public.favouritebusinessviews (
id bigint NOT NULL,
userid bigint NOT NULL,
viewid bigint NOT NULL,
"position" integer NOT NULL
);
CREATE TABLE public.featureparams (
viewname bigint NOT NULL,
featurename citext NOT NULL,
featurevalue citext,
CONSTRAINT featureparams_1776754273_c CHECK ((length((featurename)::text) <= 100)),
CONSTRAINT featureparams_747804613_c CHECK ((length((featurevalue)::text) <= 250))
);
CREATE TABLE public.fielddefinition (
fieldid bigint NOT NULL,
fieldname citext NOT NULL,
fieldtype citext DEFAULT 'TEXT',
displayname citext,
CONSTRAINT fielddefinition_242207980_c CHECK ((length((fieldtype)::text) <= 250)),
CONSTRAINT fielddefinition_242409883_c CHECK ((length((fieldname)::text) <= 250)),
CONSTRAINT fielddefinition_426904019_c CHECK ((length((displayname)::text) <= 250))
);
CREATE TABLE public.fieldheadermapping (
id bigint NOT NULL,
userid bigint NOT NULL,
fieldid bigint NOT NULL,
header citext NOT NULL,
CONSTRAINT fieldheadermapping_2127025805_c CHECK ((length((header)::text) <= 100))
);
CREATE TABLE public.fieldvalues (
valueid bigint NOT NULL,
fieldid bigint NOT NULL,
fieldvalue citext NOT NULL,
displayvalue citext,
description citext,
CONSTRAINT fieldvalues_1082615991_c CHECK ((length((fieldvalue)::text) <= 250)),
CONSTRAINT fieldvalues_341734929_c CHECK ((length((displayvalue)::text) <= 250)),
CONSTRAINT fieldvalues_428414940_c CHECK ((length((description)::text) <= 500))
);
CREATE TABLE public.fileinfo (
fileid bigint NOT NULL,
path citext NOT NULL,
name citext NOT NULL,
size bigint NOT NULL,
type citext NOT NULL,
helpdeskid bigint,
CONSTRAINT fileinfo_2388619_c CHECK ((length((name)::text) <= 1000)),
CONSTRAINT fileinfo_2448421_c CHECK ((length((path)::text) <= 1000)),
CONSTRAINT fileinfo_2590522_c CHECK ((length((type)::text) <= 250))
);
CREATE TABLE public.fileserver (
ciid bigint NOT NULL
);
CREATE TABLE public.firewall (
ciid bigint NOT NULL,
firmware citext,
CONSTRAINT firewall_227289531_c CHECK ((length((firmware)::text) <= 200))
);
CREATE TABLE public.fkcolumndefinition (
fk_constraint_id bigint NOT NULL,
fk_local_col_id bigint NOT NULL,
fk_ref_col_id bigint NOT NULL,
"position" integer NOT NULL
);
CREATE TABLE public.fkdefinition (
fk_constraint_id bigint NOT NULL,
fk_ref_table_id bigint NOT NULL,
fk_constraint citext DEFAULT 'ON-DELETE-RESTRICT' NOT NULL,
is_bidirectional boolean DEFAULT false NOT NULL,
fk_desc citext,
CONSTRAINT fkdefinition_62236213_c CHECK ((length((fk_desc)::text) <= 250)),
CONSTRAINT fkdefinition_884043369_c CHECK ((length((fk_constraint)::text) <= 25))
);
CREATE TABLE public.flexiaction (
actionid bigint NOT NULL,
viewid bigint,
name citext,
styleclass citext,
styleid citext,
title citext,
onpress citext,
showseparator boolean DEFAULT false NOT NULL,
roles citext,
helpdeskid bigint,
CONSTRAINT flexiaction_1157230996_c CHECK ((length((styleid)::text) <= 50)),
CONSTRAINT flexiaction_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT flexiaction_592185948_c CHECK ((length((onpress)::text) <= 150)),
CONSTRAINT flexiaction_628645479_c CHECK ((length((styleclass)::text) <= 50)),
CONSTRAINT flexiaction_78157469_c CHECK ((length((roles)::text) <= 100)),
CONSTRAINT flexiaction_79833656_c CHECK ((length((title)::text) <= 250))
);
CREATE TABLE public.flexicolumn (
flexicolumnid bigint NOT NULL,
flexitableid bigint NOT NULL,
name citext NOT NULL,
alias citext,
displayname citext,
type citext DEFAULT 'text',
linkid bigint,
action citext,
ispkcolumn boolean DEFAULT false NOT NULL,
searchable boolean DEFAULT true NOT NULL,
sortable boolean DEFAULT true NOT NULL,
width integer DEFAULT 180 NOT NULL,
isdatecolumn boolean DEFAULT false NOT NULL,
istimecolumn boolean DEFAULT false NOT NULL,
iseditable boolean DEFAULT false NOT NULL,
isvisible boolean DEFAULT true NOT NULL,
orderid bigint DEFAULT '999' NOT NULL,
isdefaultinselect boolean DEFAULT false NOT NULL,
helpdeskid bigint,
CONSTRAINT flexicolumn_1925345846_c CHECK ((length((action)::text) <= 100)),
CONSTRAINT flexicolumn_2388619_c CHECK ((length((name)::text) <= 50)),
CONSTRAINT flexicolumn_2590522_c CHECK ((length((type)::text) <= 10)),
CONSTRAINT flexicolumn_426904019_c CHECK ((length((displayname)::text) <= 150)),
CONSTRAINT flexicolumn_62365232_c CHECK ((length((alias)::text) <= 50))
);
CREATE TABLE public.flexicustomviews (
customviewid bigint NOT NULL,
viewname citext NOT NULL,
userid bigint NOT NULL,
queryid bigint NOT NULL,
CONSTRAINT flexicustomviews_1979239088_c CHECK ((length((viewname)::text) <= 250))
);
CREATE TABLE public.flexifiltercolumns (
filterid bigint NOT NULL,
customviewid bigint NOT NULL,
column_id bigint NOT NULL,
criteria_id bigint NOT NULL,
match_type citext DEFAULT 'and' NOT NULL,
value citext NOT NULL,
CONSTRAINT flexifiltercolumns_1915052652_c CHECK ((length((match_type)::text) <= 4))
);
CREATE TABLE public.flexipersonalization (
persid bigint NOT NULL,
viewid bigint NOT NULL,
userid bigint NOT NULL,
width citext DEFAULT '100%' NOT NULL,
height citext DEFAULT '300' NOT NULL,
rowsperpage integer DEFAULT 10 NOT NULL,
helpdeskid bigint,
CONSTRAINT flexipersonalization_2127267111_c CHECK ((length((height)::text) <= 10)),
CONSTRAINT flexipersonalization_82589094_c CHECK ((length((width)::text) <= 10))
);
CREATE TABLE public.flexitable (
flexitableid bigint NOT NULL,
viewid bigint NOT NULL,
name citext NOT NULL,
alias citext,
parenttableid bigint,
ismandatoryinjoin boolean DEFAULT false NOT NULL,
join_with citext,
join_type citext DEFAULT 'LEFT' NOT NULL,
helpdeskid bigint,
CONSTRAINT flexitable_1972816197_c CHECK ((length((join_with)::text) <= 50)),
CONSTRAINT flexitable_1972890321_c CHECK ((length((join_type)::text) <= 10)),
CONSTRAINT flexitable_2388619_c CHECK ((length((name)::text) <= 50)),
CONSTRAINT flexitable_62365232_c CHECK ((length((alias)::text) <= 50))
);
CREATE TABLE public.flexiviews (
viewid bigint NOT NULL,
name citext NOT NULL,
displayname citext,
basetable citext NOT NULL,
preprocessor citext,
customfilterenabled boolean DEFAULT true NOT NULL,
navigationenabled boolean DEFAULT true NOT NULL,
inlineeditenabled boolean DEFAULT true NOT NULL,
menusenabled boolean DEFAULT true NOT NULL,
columnchooserenabled boolean DEFAULT true NOT NULL,
exportenabled boolean DEFAULT false NOT NULL,
width integer DEFAULT '-1' NOT NULL,
height integer DEFAULT 400 NOT NULL,
indexbyfield boolean DEFAULT false NOT NULL,
nodatamessage citext DEFAULT 'No data to display' NOT NULL,
exportrenderer citext,
roles citext,
helpdeskid bigint,
CONSTRAINT flexiviews_1432865103_c CHECK ((length((preprocessor)::text) <= 250)),
CONSTRAINT flexiviews_159028380_c CHECK ((length((nodatamessage)::text) <= 250)),
CONSTRAINT flexiviews_2388619_c CHECK ((length((name)::text) <= 50)),
CONSTRAINT flexiviews_426904019_c CHECK ((length((displayname)::text) <= 150)),
CONSTRAINT flexiviews_78157469_c CHECK ((length((roles)::text) <= 100)),
CONSTRAINT flexiviews_789202039_c CHECK ((length((exportrenderer)::text) <= 250)),
CONSTRAINT flexiviews_988995453_c CHECK ((length((basetable)::text) <= 50))
);
CREATE TABLE public.flexiviewsql (
viewsqlid bigint NOT NULL,
viewid bigint NOT NULL,
userid bigint NOT NULL,
queryid bigint NOT NULL,
helpdeskid bigint
);
CREATE TABLE public.floordefinition (
floorid bigint NOT NULL,
buildingid bigint NOT NULL,
floorname citext NOT NULL,
floordesc citext,
floorarea bigint,
isdeleted boolean DEFAULT false,
CONSTRAINT floordefinition_1074678909_c CHECK ((length((floordesc)::text) <= 300)),
CONSTRAINT floordefinition_1074972791_c CHECK ((length((floorname)::text) <= 100))
);
CREATE TABLE public.fonts (
fontid bigint NOT NULL,
fontname citext NOT NULL,
style citext NOT NULL,
is_enabled boolean DEFAULT false NOT NULL,
type citext NOT NULL,
filename citext,
CONSTRAINT fonts_1149024090_c CHECK ((length((fontname)::text) <= 50)),
CONSTRAINT fonts_2590522_c CHECK ((length((type)::text) <= 50)),
CONSTRAINT fonts_47858183_c CHECK ((length((filename)::text) <= 100)),
CONSTRAINT fonts_79242641_c CHECK ((length((style)::text) <= 100))
);
CREATE TABLE public.form_customizer (
customizer_id bigint NOT NULL,
form_name citext NOT NULL,
field_name citext NOT NULL,
mandatory boolean DEFAULT false NOT NULL,
edit boolean DEFAULT true NOT NULL,
viewable boolean DEFAULT true NOT NULL,
index_tech integer DEFAULT '-1' NOT NULL,
index_req integer DEFAULT '-1' NOT NULL,
default_value citext,
help_text citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT form_customizer_1056080307_c CHECK ((length((default_value)::text) <= 250)),
CONSTRAINT form_customizer_1091304144_c CHECK ((length((field_name)::text) <= 100)),
CONSTRAINT form_customizer_181432469_c CHECK ((length((help_text)::text) <= 1500)),
CONSTRAINT form_customizer_330727718_c CHECK ((length((form_name)::text) <= 300))
);
CREATE TABLE public.formdefinition (
formid bigint NOT NULL,
formname citext NOT NULL,
submit_url citext NOT NULL,
access_url citext NOT NULL,
form_method citext DEFAULT 'Post',
CONSTRAINT formdefinition_1257076047_c CHECK ((length((formname)::text) <= 250)),
CONSTRAINT formdefinition_1590435672_c CHECK ((length((submit_url)::text) <= 250)),
CONSTRAINT formdefinition_22964036_c CHECK ((length((form_method)::text) <= 100)),
CONSTRAINT formdefinition_655634444_c CHECK ((length((access_url)::text) <= 250))
);
CREATE TABLE public.forward (
menuitemid bigint NOT NULL,
name citext NOT NULL,
path citext,
redirect citext,
CONSTRAINT forward_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT forward_2448421_c CHECK ((length((path)::text) <= 100)),
CONSTRAINT forward_6481884_c CHECK ((length((redirect)::text) <= 100))
);
CREATE TABLE public.fosnodedetails (
ip citext NOT NULL,
counter bigint NOT NULL,
status citext NOT NULL,
lastservingtime timestamp without time zone,
replication_state citext,
build_number bigint NOT NULL,
CONSTRAINT fosnodedetails_1839152142_c CHECK ((length((status)::text) <= 255)),
CONSTRAINT fosnodedetails_2343_c CHECK ((length((ip)::text) <= 255)),
CONSTRAINT fosnodedetails_584820194_c CHECK ((length((replication_state)::text) <= 255))
);
CREATE TABLE public.fosreplicationdetails (
id bigint NOT NULL,
server citext NOT NULL,
internetprotocol citext NOT NULL,
username bytea,
password bytea,
CONSTRAINT fosreplicationdetails_1611621593_c CHECK ((length((internetprotocol)::text) <= 150)),
CONSTRAINT fosreplicationdetails_1852497085_c CHECK ((length((server)::text) <= 50))
);
CREATE TABLE public.functionparams (
expression_id bigint NOT NULL,
param_index integer NOT NULL,
param_value citext,
value_type integer NOT NULL,
CONSTRAINT functionparams_60008705_c CHECK ((length((param_value)::text) <= 255))
);
CREATE TABLE public.gatewayconf (
gatewayconfid bigint NOT NULL,
parameter citext NOT NULL,
paramvalue citext NOT NULL,
CONSTRAINT gatewayconf_446088073_c CHECK ((length((parameter)::text) <= 100)),
CONSTRAINT gatewayconf_958969092_c CHECK ((length((paramvalue)::text) <= 250))
);
CREATE TABLE public.globalconfig (
globalconfigid bigint NOT NULL,
category citext NOT NULL,
parameter citext NOT NULL,
paramvalue citext NOT NULL,
description citext,
helpdeskid bigint,
CONSTRAINT globalconfig_428414940_c CHECK ((length((description)::text) <= 200)),
CONSTRAINT globalconfig_446088073_c CHECK ((length((parameter)::text) <= 100)),
CONSTRAINT globalconfig_833137918_c CHECK ((length((category)::text) <= 100)),
CONSTRAINT globalconfig_958969092_c CHECK ((length((paramvalue)::text) <= 500))
);
CREATE TABLE public.globalconfig_nocache (
globalconfignocacheid bigint NOT NULL,
category citext NOT NULL,
parameter citext NOT NULL,
paramvalue citext NOT NULL,
description citext DEFAULT '-' NOT NULL,
CONSTRAINT globalconfig_nocache_428414940_c CHECK ((length((description)::text) <= 200)),
CONSTRAINT globalconfig_nocache_446088073_c CHECK ((length((parameter)::text) <= 100)),
CONSTRAINT globalconfig_nocache_833137918_c CHECK ((length((category)::text) <= 100)),
CONSTRAINT globalconfig_nocache_958969092_c CHECK ((length((paramvalue)::text) <= 100))
);
CREATE TABLE public.globalpersonalize (
id bigint NOT NULL,
key citext NOT NULL,
data citext,
createdby bigint NOT NULL,
createdtime bigint NOT NULL,
modifiedby bigint,
modifiedtime bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT globalpersonalize_74303_c CHECK ((length((key)::text) <= 250))
);
CREATE TABLE public.globalviews (
viewid bigint NOT NULL,
viewname citext NOT NULL,
url citext NOT NULL,
display_key citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT globalviews_1979239088_c CHECK ((length((viewname)::text) <= 200))
);
CREATE TABLE public.graphtype (
typeid bigint NOT NULL,
type citext NOT NULL,
CONSTRAINT graphtype_2590522_c CHECK ((length((type)::text) <= 100))
);
CREATE TABLE public.group_share_list (
shareid bigint NOT NULL,
queueid bigint NOT NULL
);
CREATE TABLE public.haconfig (
ha_config_id bigint NOT NULL,
category citext NOT NULL,
paramvalue citext,
description citext,
CONSTRAINT haconfig_428414940_c CHECK ((length((description)::text) <= 200)),
CONSTRAINT haconfig_833137918_c CHECK ((length((category)::text) <= 250)),
CONSTRAINT haconfig_958969092_c CHECK ((length((paramvalue)::text) <= 500))
);
CREATE TABLE public.harddiskinfo (
diskid bigint NOT NULL,
workstationid bigint NOT NULL,
modelnumber citext DEFAULT '-' NOT NULL,
serialnumber citext DEFAULT '-' NOT NULL,
capacity bigint DEFAULT '0' NOT NULL,
freespace bigint DEFAULT '0' NOT NULL,
drivetype citext DEFAULT '-' NOT NULL,
manufacturer citext DEFAULT '-' NOT NULL,
CONSTRAINT harddiskinfo_1420387236_c CHECK ((length((drivetype)::text) <= 25)),
CONSTRAINT harddiskinfo_347933649_c CHECK ((length((manufacturer)::text) <= 100)),
CONSTRAINT harddiskinfo_879253614_c CHECK ((length((modelnumber)::text) <= 50)),
CONSTRAINT harddiskinfo_977765827_c CHECK ((length((serialnumber)::text) <= 100))
);
CREATE TABLE public.helpdeskallowedroles (
haroleid bigint NOT NULL,
role_id bigint NOT NULL,
helpdeskid bigint NOT NULL
);
CREATE TABLE public.helpdeskdetails (
id bigint NOT NULL,
name citext NOT NULL,
displayname citext NOT NULL,
typeid bigint NOT NULL,
statusid bigint NOT NULL,
is_alluser_as_requester boolean DEFAULT false,
description citext DEFAULT 'No Description',
license_component_name bytea,
alias_url citext,
CONSTRAINT helpdeskdetails_2388619_c CHECK ((length((name)::text) <= 200)),
CONSTRAINT helpdeskdetails_426904019_c CHECK ((length((displayname)::text) <= 200)),
CONSTRAINT helpdeskdetails_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT helpdeskdetails_92896960_c CHECK ((length((alias_url)::text) <= 50))
);
CREATE TABLE public.helpdesklogo (
helpdeskid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.helpdeskowners (
id bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
ownedby bigint NOT NULL
);
CREATE TABLE public.helpdeskstatusdefinition (
id bigint NOT NULL,
name citext NOT NULL,
internal_name citext NOT NULL,
CONSTRAINT helpdeskstatusdefinition_2388619_c CHECK ((length((name)::text) <= 200)),
CONSTRAINT helpdeskstatusdefinition_677323469_c CHECK ((length((internal_name)::text) <= 200))
);
CREATE TABLE public.helpdesktypedefinition (
id bigint NOT NULL,
name citext NOT NULL,
short_name citext NOT NULL,
internal_name citext NOT NULL,
CONSTRAINT helpdesktypedefinition_2080438414_c CHECK ((length((short_name)::text) <= 10)),
CONSTRAINT helpdesktypedefinition_2388619_c CHECK ((length((name)::text) <= 200)),
CONSTRAINT helpdesktypedefinition_677323469_c CHECK ((length((internal_name)::text) <= 200))
);
CREATE TABLE public.hold_period_group (
hold_period_id bigint NOT NULL,
assessmentid bigint NOT NULL,
hold_time bigint NOT NULL,
hold_off_time bigint,
hold_period bigint
);
CREATE TABLE public.hold_period_tech (
hold_period_id bigint NOT NULL,
assessmentid bigint NOT NULL,
hold_time bigint NOT NULL,
hold_off_time bigint,
hold_period bigint
);
CREATE TABLE public.holidaydefinition (
holidaydefinitionid bigint NOT NULL,
holidaydate date NOT NULL,
description citext,
siteid bigint,
isrecurring boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT holidaydefinition_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.hotfixlist (
hotfixid bigint NOT NULL,
hotfixname citext NOT NULL,
ishotfix boolean DEFAULT true NOT NULL,
description citext DEFAULT '-' NOT NULL,
automodify boolean DEFAULT true NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT hotfixlist_2077537485_c CHECK ((length((hotfixname)::text) <= 250)),
CONSTRAINT hotfixlist_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.hotfixsoftwareinfo (
hotfixid bigint NOT NULL,
softwareid bigint NOT NULL
);
CREATE TABLE public.hoursofoperation (
hoursofoperationid bigint NOT NULL,
daysofoperationid bigint NOT NULL,
starttime citext DEFAULT '09:00:00' NOT NULL,
endtime citext DEFAULT '18:00:00' NOT NULL,
break_starttime citext DEFAULT '00:00:00' NOT NULL,
break_endtime citext DEFAULT '00:00:00' NOT NULL,
CONSTRAINT hoursofoperation_459130200_c CHECK ((length((break_endtime)::text) <= 25)),
CONSTRAINT hoursofoperation_658253327_c CHECK ((length((starttime)::text) <= 25)),
CONSTRAINT hoursofoperation_780482223_c CHECK ((length((break_starttime)::text) <= 25)),
CONSTRAINT hoursofoperation_888307192_c CHECK ((length((endtime)::text) <= 25))
);
CREATE TABLE public.hpuxserver (
ciid bigint NOT NULL
);
CREATE TABLE public.hpuxworkstation (
ciid bigint NOT NULL
);
CREATE TABLE public.httpcredentials (
credentialid bigint NOT NULL,
portnumber bigint NOT NULL,
timeout bigint NOT NULL
);
CREATE TABLE public.hwaudithistory (
hwauditid bigint NOT NULL,
auditid bigint NOT NULL,
tablename citext NOT NULL,
columnname citext NOT NULL,
columnvalue citext,
columnoldvalue citext,
secpkvalue citext,
operation bigint NOT NULL,
CONSTRAINT hwaudithistory_1338898363_c CHECK ((length((columnvalue)::text) <= 1000)),
CONSTRAINT hwaudithistory_1389536512_c CHECK ((length((columnoldvalue)::text) <= 1000)),
CONSTRAINT hwaudithistory_1619616031_c CHECK ((length((columnname)::text) <= 30)),
CONSTRAINT hwaudithistory_1727589093_c CHECK ((length((secpkvalue)::text) <= 300)),
CONSTRAINT hwaudithistory_798830393_c CHECK ((length((tablename)::text) <= 30))
);
CREATE TABLE public.hyperlinkconfiguration (
hrefid bigint NOT NULL,
url citext NOT NULL,
CONSTRAINT hyperlinkconfiguration_84303_c CHECK ((length((url)::text) <= 250))
);
CREATE TABLE public.ibmmainframe (
ciid bigint NOT NULL
);
CREATE TABLE public.ibmworkstation (
ciid bigint NOT NULL
);
CREATE TABLE public.iisci (
ciid bigint NOT NULL
);
CREATE TABLE public.impactdefinition (
impactid bigint NOT NULL,
name citext NOT NULL,
description citext,
isdeleted boolean DEFAULT false,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT impactdefinition_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT impactdefinition_428414940_c CHECK ((length((description)::text) <= 3500))
);
CREATE TABLE public.impactdetail (
impactid bigint NOT NULL,
impact citext,
problemid bigint NOT NULL,
imp_updated_by bigint NOT NULL,
imp_updated_on bigint NOT NULL
);
CREATE TABLE public.impactdetailimages (
impactid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.impactdetailsattachment (
attachmentid bigint NOT NULL,
impactid bigint NOT NULL
);
CREATE TABLE public.importadfields (
id bigint NOT NULL,
phone boolean DEFAULT true NOT NULL,
mobile boolean DEFAULT true NOT NULL,
email boolean DEFAULT true NOT NULL,
department boolean DEFAULT true NOT NULL,
job boolean DEFAULT true NOT NULL,
office boolean DEFAULT false NOT NULL,
moveassociatedassetsto boolean DEFAULT true NOT NULL
);
CREATE TABLE public.importhistory (
importid bigint NOT NULL,
entity citext NOT NULL,
importedby bigint NOT NULL,
filename citext NOT NULL,
importedtime bigint NOT NULL,
importstatus citext NOT NULL,
operation integer DEFAULT 1 NOT NULL,
helpdeskid bigint,
CONSTRAINT importhistory_2050021347_c CHECK ((length((entity)::text) <= 100)),
CONSTRAINT importhistory_47858183_c CHECK ((length((filename)::text) <= 100))
);
CREATE TABLE public.importidmappings (
mappingid bigint NOT NULL,
importid bigint NOT NULL,
createdid bigint NOT NULL,
module citext NOT NULL,
inputid bigint NOT NULL,
helpdeskid bigint,
CONSTRAINT importidmappings_2015454612_c CHECK ((length((module)::text) <= 100))
);
CREATE TABLE public.importmodulefields (
id bigint NOT NULL,
module citext NOT NULL,
field citext NOT NULL,
"position" bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT importmodulefields_2015454612_c CHECK ((length((module)::text) <= 100)),
CONSTRAINT importmodulefields_66889946_c CHECK ((length((field)::text) <= 100))
);
CREATE TABLE public.importssl_history (
record_id bigint NOT NULL,
import_user_id bigint NOT NULL,
import_time bigint NOT NULL,
import_description citext NOT NULL,
is_import_success boolean DEFAULT false NOT NULL
);
CREATE TABLE public.incidentcausedbychange (
workorderid bigint NOT NULL,
changeid bigint NOT NULL
);
CREATE TABLE public.incidenttochangemapping (
workorderid bigint NOT NULL,
changeid bigint NOT NULL
);
CREATE TABLE public.incomingewsserver (
id bigint NOT NULL,
serverurl citext NOT NULL,
emailid citext NOT NULL,
username citext NOT NULL,
userpwd bytea NOT NULL,
authtypeid bigint NOT NULL,
oauthcredentialid bigint,
isenabled boolean DEFAULT false NOT NULL,
proxyid bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT incomingewsserver_1705788628_c CHECK ((length((serverurl)::text) <= 250)),
CONSTRAINT incomingewsserver_516913366_c CHECK ((length((username)::text) <= 100)),
CONSTRAINT incomingewsserver_920031849_c CHECK ((length((emailid)::text) <= 250))
);
CREATE TABLE public.incomingmailaliases (
serverid bigint NOT NULL,
id bigint NOT NULL,
emailid citext NOT NULL,
modulename citext DEFAULT 'NONE',
CONSTRAINT incomingmailaliases_384305417_c CHECK ((length((modulename)::text) <= 250)),
CONSTRAINT incomingmailaliases_920031849_c CHECK ((length((emailid)::text) <= 250))
);
CREATE TABLE public.incomingmailserver (
serverid bigint NOT NULL,
hostname citext NOT NULL,
username citext NOT NULL,
userpwd bytea NOT NULL,
retainmail boolean DEFAULT false NOT NULL,
portid bigint NOT NULL,
authtypeid bigint NOT NULL,
oauthcredentialid bigint,
isenabled boolean DEFAULT false NOT NULL,
proxyid bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT incomingmailserver_482823219_c CHECK ((length((hostname)::text) <= 100)),
CONSTRAINT incomingmailserver_516913366_c CHECK ((length((username)::text) <= 100))
);
CREATE TABLE public.indexcolumn (
indexcolumnid bigint NOT NULL,
indextableid bigint NOT NULL,
name citext,
CONSTRAINT indexcolumn_2388619_c CHECK ((length((name)::text) <= 50))
);
CREATE TABLE public.indexdefinition (
index_cons_id bigint NOT NULL,
column_id bigint NOT NULL,
"position" integer NOT NULL,
size integer DEFAULT '-1' NOT NULL,
isascending boolean DEFAULT true NOT NULL,
isnullsfirst boolean
);
CREATE TABLE public.indextable (
indextableid bigint NOT NULL,
moduleid bigint NOT NULL,
name citext NOT NULL,
joinwith citext,
alias citext,
parenttableid bigint,
CONSTRAINT indextable_2388619_c CHECK ((length((name)::text) <= 50)),
CONSTRAINT indextable_618080016_c CHECK ((length((joinwith)::text) <= 50)),
CONSTRAINT indextable_62365232_c CHECK ((length((alias)::text) <= 50))
);
CREATE TABLE public.inlineimagemigrationhistory (
id bigint NOT NULL,
entity citext NOT NULL,
entityid bigint NOT NULL,
reason citext,
ismigrated boolean DEFAULT false NOT NULL
);
CREATE TABLE public.inlineimageurlmigration (
id bigint NOT NULL,
entity citext NOT NULL,
entityid bigint NOT NULL,
migratedfrom citext NOT NULL,
migratedto citext,
issuccess boolean DEFAULT false NOT NULL
);
CREATE TABLE public.instanceattributes (
primarykeyid bigint NOT NULL,
ciid bigint NOT NULL,
attributename citext NOT NULL,
attributevalue citext NOT NULL,
CONSTRAINT instanceattributes_1667927815_c CHECK ((length((attributename)::text) <= 250)),
CONSTRAINT instanceattributes_173542485_c CHECK ((length((attributevalue)::text) <= 250))
);
CREATE TABLE public.integrationkeydefinition (
id bigint NOT NULL,
technicianid bigint NOT NULL,
technicianid_autoid bigint NOT NULL,
name citext NOT NULL,
integrationkey citext NOT NULL,
status citext DEFAULT 'active' NOT NULL,
validity bigint DEFAULT '-1' NOT NULL,
createdtime bigint NOT NULL,
description citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT integrationkeydefinition_1839152142_c CHECK ((length((status)::text) <= 20)),
CONSTRAINT integrationkeydefinition_2388619_c CHECK ((length((name)::text) <= 50)),
CONSTRAINT integrationkeydefinition_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT integrationkeydefinition_925518859_c CHECK ((length((integrationkey)::text) <= 250))
);
CREATE TABLE public.integrationkeyroles (
id bigint NOT NULL,
integrationkeyid bigint NOT NULL,
roleid bigint NOT NULL
);
CREATE TABLE public.internalcitype (
typeid bigint NOT NULL,
typename citext NOT NULL,
helpdeskid bigint,
CONSTRAINT internalcitype_107072709_c CHECK ((length((typename)::text) <= 250))
);
CREATE TABLE public.internalcomponenttype (
componenttypeid bigint NOT NULL,
componenttypename citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT internalcomponenttype_2077176670_c CHECK ((length((componenttypename)::text) <= 250))
);
CREATE TABLE public.internalrelationshiptype (
relationshiptypeid bigint NOT NULL,
relationship citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT internalrelationshiptype_2055429688_c CHECK ((length((relationship)::text) <= 250))
);
CREATE TABLE public.invalidservicetaglist (
invalidservicetagid bigint NOT NULL,
servicetag citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT invalidservicetaglist_1239651131_c CHECK ((length((servicetag)::text) <= 100))
);
CREATE TABLE public.inventorytypecommand (
inventorytypecommandid bigint NOT NULL,
inventorytype citext,
command citext,
parser citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT inventorytypecommand_1591784054_c CHECK ((length((inventorytype)::text) <= 100)),
CONSTRAINT inventorytypecommand_1668377387_c CHECK ((length((command)::text) <= 200)),
CONSTRAINT inventorytypecommand_1942081505_c CHECK ((length((parser)::text) <= 100))
);
CREATE TABLE public.invoicedetails (
invoicedetailsid bigint NOT NULL,
invoiceid citext,
datereceived bigint,
comments citext,
purchaseorderid bigint NOT NULL,
popaymentnotifyid bigint,
CONSTRAINT invoicedetails_1047152872_c CHECK ((length((invoiceid)::text) <= 50))
);
CREATE TABLE public.ipphone (
ciid bigint NOT NULL
);
CREATE TABLE public.ips (
ciid bigint NOT NULL,
hardwareversion citext,
softwareversion citext,
CONSTRAINT ips_1844043216_c CHECK ((length((hardwareversion)::text) <= 250)),
CONSTRAINT ips_244417231_c CHECK ((length((softwareversion)::text) <= 250))
);
CREATE TABLE public.itemdefinition (
itemid bigint NOT NULL,
subcategoryid bigint NOT NULL,
name citext NOT NULL,
description citext,
isdeleted boolean DEFAULT false,
CONSTRAINT itemdefinition_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT itemdefinition_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.itemlist (
itemid bigint NOT NULL,
itemname citext NOT NULL,
itemcost bigint NOT NULL,
itemavailability bigint NOT NULL,
CONSTRAINT itemlist_1960911902_c CHECK ((length((itemname)::text) <= 100))
);
CREATE TABLE public.itservice (
ciid bigint NOT NULL,
businesscriticality citext,
departmentid bigint,
managedby bigint,
availabilitytarget citext,
supporthours citext,
cost citext,
restorationtarget citext,
CONSTRAINT itservice_113732401_c CHECK ((length((businesscriticality)::text) <= 250)),
CONSTRAINT itservice_2074573_c CHECK ((length((cost)::text) <= 250)),
CONSTRAINT itservice_262409329_c CHECK ((length((restorationtarget)::text) <= 250)),
CONSTRAINT itservice_780974240_c CHECK ((length((supporthours)::text) <= 250)),
CONSTRAINT itservice_802835796_c CHECK ((length((availabilitytarget)::text) <= 250))
);
CREATE TABLE public.itservice_application (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.itservice_businessservice (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.itservice_server (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.itservice_supportgroup (
primarykeyid bigint NOT NULL,
supportlevel citext,
CONSTRAINT itservice_supportgroup_784370965_c CHECK ((length((supportlevel)::text) <= 100))
);
CREATE TABLE public.itservice_swins (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.itservice_technician (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.javascriptaction (
menuitemid bigint NOT NULL,
jsfilename citext,
jsmethodname citext DEFAULT 'invokeEmberMenuAction' NOT NULL,
CONSTRAINT javascriptaction_1304104368_c CHECK ((length((jsfilename)::text) <= 255)),
CONSTRAINT javascriptaction_1901961461_c CHECK ((length((jsmethodname)::text) <= 255))
);
CREATE TABLE public.jobdetails (
jobid bigint NOT NULL,
moduleid bigint NOT NULL,
statusid bigint NOT NULL,
updatedtime bigint NOT NULL,
inputjson citext NOT NULL
);
CREATE TABLE public.jobmoduletoexecutor (
moduleid bigint NOT NULL,
modulename citext NOT NULL,
executorclass citext NOT NULL,
timeoutinseconds integer DEFAULT 30 NOT NULL,
CONSTRAINT jobmoduletoexecutor_384305417_c CHECK ((length((modulename)::text) <= 250)),
CONSTRAINT jobmoduletoexecutor_849826917_c CHECK ((length((executorclass)::text) <= 250))
);
CREATE TABLE public.jobschedulerconfig (
configid bigint NOT NULL,
name citext NOT NULL,
value citext,
CONSTRAINT jobschedulerconfig_2388619_c CHECK ((length((name)::text) <= 250)),
CONSTRAINT jobschedulerconfig_81434961_c CHECK ((length((value)::text) <= 250))
);
CREATE TABLE public.jobstatusdefinition (
statusid bigint NOT NULL,
statusname citext NOT NULL,
CONSTRAINT jobstatusdefinition_733867389_c CHECK ((length((statusname)::text) <= 100))
);
CREATE TABLE public.joincolumns (
queryid bigint NOT NULL,
basetablecolumn citext NOT NULL,
referencedtablecolumn citext NOT NULL,
tablealias citext NOT NULL,
CONSTRAINT joincolumns_1017743550_c CHECK ((length((tablealias)::text) <= 50)),
CONSTRAINT joincolumns_1773382381_c CHECK ((length((basetablecolumn)::text) <= 50)),
CONSTRAINT joincolumns_810228629_c CHECK ((length((referencedtablecolumn)::text) <= 50))
);
CREATE TABLE public.joincriteria (
queryid bigint NOT NULL,
tablealias citext,
criteriaid bigint NOT NULL,
logicalrepresentation citext,
CONSTRAINT joincriteria_1017743550_c CHECK ((length((tablealias)::text) <= 50)),
CONSTRAINT joincriteria_1243883274_c CHECK ((length((logicalrepresentation)::text) <= 4000))
);
CREATE TABLE public.joinrelcri_expression (
queryid bigint NOT NULL,
criteriaid bigint NOT NULL,
relationalcriteriaid bigint NOT NULL,
expression_id bigint NOT NULL
);
CREATE TABLE public.joinrelcriteria (
queryid bigint NOT NULL,
criteriaid bigint NOT NULL,
relationalcriteriaid bigint NOT NULL,
tablealias citext,
columnname citext,
comparator integer,
value citext,
casesensitive boolean DEFAULT true NOT NULL,
value_datatype citext,
CONSTRAINT joinrelcriteria_1017743550_c CHECK ((length((tablealias)::text) <= 50)),
CONSTRAINT joinrelcriteria_1619616031_c CHECK ((length((columnname)::text) <= 50)),
CONSTRAINT joinrelcriteria_1627714286_c CHECK ((length((value_datatype)::text) <= 30)),
CONSTRAINT joinrelcriteria_81434961_c CHECK ((length((value)::text) <= 3500))
);
CREATE TABLE public.jointable (
queryid bigint NOT NULL,
tablealias citext NOT NULL,
referencedtable citext NOT NULL,
jointype integer,
joinorder integer,
CONSTRAINT jointable_1017743550_c CHECK ((length((tablealias)::text) <= 50)),
CONSTRAINT jointable_1804611371_c CHECK ((length((referencedtable)::text) <= 50))
);
CREATE TABLE public.kb_topics (
topicid bigint NOT NULL,
topicname citext NOT NULL,
solution_count bigint DEFAULT '0',
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT kb_topics_1119213542_c CHECK ((length((topicname)::text) <= 50))
);
CREATE TABLE public.keyboardci (
ciid bigint NOT NULL
);
CREATE TABLE public.keyboardinfo (
workstationid bigint NOT NULL,
keyboardtype citext DEFAULT '-' NOT NULL,
keyboardserialnumber citext DEFAULT '-' NOT NULL,
manufacturer citext DEFAULT '-' NOT NULL,
CONSTRAINT keyboardinfo_1411595172_c CHECK ((length((keyboardserialnumber)::text) <= 100)),
CONSTRAINT keyboardinfo_1767792735_c CHECK ((length((keyboardtype)::text) <= 100)),
CONSTRAINT keyboardinfo_347933649_c CHECK ((length((manufacturer)::text) <= 100))
);
CREATE TABLE public.laassociation (
laassociationid bigint NOT NULL,
agreementid bigint NOT NULL,
licenseid bigint NOT NULL
);
CREATE TABLE public.languagedetails (
languageid bigint NOT NULL,
language citext NOT NULL,
i18nkey citext NOT NULL,
locale citext NOT NULL,
fileextn citext NOT NULL,
CONSTRAINT languagedetails_1820202849_c CHECK ((length((i18nkey)::text) <= 200)),
CONSTRAINT languagedetails_2044132774_c CHECK ((length((locale)::text) <= 5)),
CONSTRAINT languagedetails_47612393_c CHECK ((length((fileextn)::text) <= 5)),
CONSTRAINT languagedetails_830962856_c CHECK ((length((language)::text) <= 100))
);
CREATE TABLE public.laptop (
workstationid bigint NOT NULL
);
CREATE TABLE public.lastauditinfo (
workstationid bigint NOT NULL,
last_auditid bigint NOT NULL,
last_success_auditid bigint
);
CREATE TABLE public.lastdependentwo (
dependentgroupid bigint NOT NULL,
lastdependentrequestid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.layoutconfig (
layout_id bigint NOT NULL,
name citext NOT NULL,
attributes citext,
helptext citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT layoutconfig_2388619_c CHECK ((length((name)::text) <= 100))
);
CREATE TABLE public.layoutsectionmapping (
section_mapping_id bigint NOT NULL,
layout_id bigint NOT NULL,
section_id bigint NOT NULL,
"position" citext NOT NULL,
collapsed_state citext NOT NULL
);
CREATE TABLE public.ldapadapter (
ldap_id bigint NOT NULL,
domaincontroller citext DEFAULT 'ldap://192.168.4.83:389' NOT NULL,
initial_context_factory citext DEFAULT 'com.sun.jndi.ldap.LdapCtxFactory' NOT NULL,
is_secured citext DEFAULT 'SIMPLE' NOT NULL,
username citext DEFAULT 'cn=Manager,o=adventnet,c=com',
passwordid bigint NOT NULL,
base_dn citext DEFAULT 'o=adventnet,c=com',
search_filter citext,
login_attribute citext DEFAULT 'sAMAccountName',
mail_attribute citext DEFAULT 'mail',
dn_attribute citext DEFAULT 'distinguishedName',
ldapserver_type citext DEFAULT 'Microsoft Active Directory',
isimported boolean DEFAULT false,
domainname citext,
CONSTRAINT ldapadapter_1224795897_c CHECK ((length((dn_attribute)::text) <= 200)),
CONSTRAINT ldapadapter_139125585_c CHECK ((length((ldapserver_type)::text) <= 200)),
CONSTRAINT ldapadapter_156372128_c CHECK ((length((domaincontroller)::text) <= 200)),
CONSTRAINT ldapadapter_1684202758_c CHECK ((length((login_attribute)::text) <= 200)),
CONSTRAINT ldapadapter_1757563409_c CHECK ((length((search_filter)::text) <= 2000)),
CONSTRAINT ldapadapter_1786931425_c CHECK ((length((initial_context_factory)::text) <= 200)),
CONSTRAINT ldapadapter_385396920_c CHECK ((length((base_dn)::text) <= 250)),
CONSTRAINT ldapadapter_403929704_c CHECK ((length((is_secured)::text) <= 10)),
CONSTRAINT ldapadapter_516913366_c CHECK ((length((username)::text) <= 250)),
CONSTRAINT ldapadapter_758040241_c CHECK ((length((domainname)::text) <= 100)),
CONSTRAINT ldapadapter_849885684_c CHECK ((length((mail_attribute)::text) <= 200))
);
CREATE TABLE public.leavetypedefinition (
leavetypeid bigint NOT NULL,
name citext NOT NULL,
description citext,
colorcode citext,
isdeleted boolean DEFAULT false,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT leavetypedefinition_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT leavetypedefinition_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT leavetypedefinition_473007024_c CHECK ((length((colorcode)::text) <= 10))
);
CREATE TABLE public.leveldefinition (
levelid bigint NOT NULL,
levelname citext NOT NULL,
leveldescription citext,
isdeleted boolean DEFAULT false,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT leveldefinition_1131135983_c CHECK ((length((levelname)::text) <= 100)),
CONSTRAINT leveldefinition_1148572168_c CHECK ((length((leveldescription)::text) <= 250))
);
CREATE TABLE public.license_upgrade (
id bigint NOT NULL,
schedule_id bigint,
added_time timestamp without time zone,
modified_time timestamp without time zone,
old_license bytea,
new_license bytea,
old_license_backp_path citext NOT NULL,
trial_status smallint DEFAULT '0' NOT NULL,
data_json citext NOT NULL,
CONSTRAINT license_upgrade_1842483107_c CHECK ((length((data_json)::text) <= 1000)),
CONSTRAINT license_upgrade_240681585_c CHECK ((length((old_license_backp_path)::text) <= 1000))
);
CREATE TABLE public.licenseagreement (
agreementid bigint NOT NULL,
agreementnumber citext NOT NULL,
authorizationnumber citext,
swmanufacturerid bigint NOT NULL,
vendorid bigint,
statusid bigint NOT NULL,
acquisitiondate bigint NOT NULL,
expirydate bigint,
pocustomid citext,
poname citext,
purchasedate bigint,
podescription citext DEFAULT '-',
invoicenumber citext,
invoicedate bigint,
totalprice double DEFAULT '0',
notifybefore bigint DEFAULT '1',
notifytoid bigint,
notificationid bigint,
isescalated boolean DEFAULT false NOT NULL,
siteid bigint,
createdby bigint NOT NULL,
terms citext,
description citext DEFAULT '-',
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT licenseagreement_107438230_c CHECK ((length((invoicenumber)::text) <= 50)),
CONSTRAINT licenseagreement_1792609099_c CHECK ((length((pocustomid)::text) <= 50)),
CONSTRAINT licenseagreement_1929288438_c CHECK ((length((poname)::text) <= 100)),
CONSTRAINT licenseagreement_206739891_c CHECK ((length((agreementnumber)::text) <= 50)),
CONSTRAINT licenseagreement_38611069_c CHECK ((length((podescription)::text) <= 250)),
CONSTRAINT licenseagreement_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT licenseagreement_625238242_c CHECK ((length((authorizationnumber)::text) <= 50)),
CONSTRAINT licenseagreement_79712615_c CHECK ((length((terms)::text) <= 3500))
);
CREATE TABLE public.licenseagreement_fields (
agreementid bigint NOT NULL,
udf_long1 bigint,
udf_long2 bigint,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
udf_char5 citext,
udf_char6 citext,
udf_date1 bigint,
udf_date2 bigint,
udf_long3 bigint,
udf_long4 bigint,
udf_char7 citext,
udf_char8 citext,
udf_char9 citext,
udf_char10 citext,
udf_char11 citext,
udf_char12 citext,
udf_date3 bigint,
udf_date4 bigint,
udf_cost1 double DEFAULT '0' NOT NULL,
udf_cost2 double DEFAULT '0' NOT NULL,
udf_cost3 double DEFAULT '0' NOT NULL,
udf_cost4 double DEFAULT '0' NOT NULL,
CONSTRAINT licenseagreement_fields_278184709_c CHECK ((length((udf_char9)::text) <= 3500)),
CONSTRAINT licenseagreement_fields_278184710_c CHECK ((length((udf_char8)::text) <= 3500)),
CONSTRAINT licenseagreement_fields_278184711_c CHECK ((length((udf_char7)::text) <= 3500)),
CONSTRAINT licenseagreement_fields_278184712_c CHECK ((length((udf_char6)::text) <= 3500)),
CONSTRAINT licenseagreement_fields_278184713_c CHECK ((length((udf_char5)::text) <= 3500)),
CONSTRAINT licenseagreement_fields_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT licenseagreement_fields_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT licenseagreement_fields_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT licenseagreement_fields_278184717_c CHECK ((length((udf_char1)::text) <= 3500)),
CONSTRAINT licenseagreement_fields_33791585_c CHECK ((length((udf_char12)::text) <= 3500)),
CONSTRAINT licenseagreement_fields_33791586_c CHECK ((length((udf_char11)::text) <= 3500)),
CONSTRAINT licenseagreement_fields_33791587_c CHECK ((length((udf_char10)::text) <= 3500))
);
CREATE TABLE public.licenseagreementattachment (
lattachmentid bigint NOT NULL,
agreementid bigint NOT NULL,
attachmentid bigint NOT NULL
);
CREATE TABLE public.licenseallocationhistory (
historyid bigint NOT NULL,
licenseid bigint NOT NULL,
workstationid bigint NOT NULL,
userid bigint,
deptid bigint,
allocatedon bigint NOT NULL,
revokedon bigint,
updatedby bigint NOT NULL
);
CREATE TABLE public.licensekey (
licenseid bigint NOT NULL,
org_id bigint,
license_type citext,
product_type citext,
product_name citext,
no_of_users bigint NOT NULL,
no_of_ws bigint NOT NULL,
islocalized boolean DEFAULT false NOT NULL,
expiry_date bigint,
instance_id bigint,
comments citext,
CONSTRAINT licensekey_180211188_c CHECK ((length((comments)::text) <= 200)),
CONSTRAINT licensekey_335537000_c CHECK ((length((license_type)::text) <= 50)),
CONSTRAINT licensekey_933556054_c CHECK ((length((product_type)::text) <= 50)),
CONSTRAINT licensekey_933757957_c CHECK ((length((product_name)::text) <= 50))
);
CREATE TABLE public.licenseorderhistory (
order_id bigint NOT NULL,
org_id bigint,
user_id bigint NOT NULL,
no_of_users bigint NOT NULL,
no_of_ws bigint NOT NULL,
subscription_startdate bigint,
subscription_expirydate bigint,
ordered_date bigint,
historytype citext,
plans citext,
reason citext,
CONSTRAINT licenseorderhistory_1789026898_c CHECK ((length((historytype)::text) <= 50)),
CONSTRAINT licenseorderhistory_1881635260_c CHECK ((length((reason)::text) <= 1000)),
CONSTRAINT licenseorderhistory_76210762_c CHECK ((length((plans)::text) <= 50))
);
CREATE TABLE public.licensereminder (
technicianid bigint NOT NULL,
nextshowdate bigint NOT NULL,
technicianid_autoid bigint NOT NULL
);
CREATE TABLE public.licenserenewalhistory (
historyid bigint NOT NULL,
baselicenseid bigint NOT NULL,
renewedlicenseid bigint NOT NULL,
renewedon bigint NOT NULL,
renewedby bigint NOT NULL
);
CREATE TABLE public.licensestatus (
statusid bigint NOT NULL,
statusname citext NOT NULL,
displayname citext NOT NULL,
description citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT licensestatus_426904019_c CHECK ((length((displayname)::text) <= 100)),
CONSTRAINT licensestatus_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT licensestatus_733867389_c CHECK ((length((statusname)::text) <= 100))
);
CREATE TABLE public.lifecycle (
lifecycleid bigint NOT NULL,
name citext NOT NULL,
description citext,
isenabled boolean DEFAULT true NOT NULL,
ispublished boolean DEFAULT false NOT NULL,
hasdraft boolean DEFAULT true NOT NULL,
moduleid bigint NOT NULL,
uiattributes citext,
createdby bigint NOT NULL,
createdtime bigint NOT NULL,
lastupdatedby bigint,
lastupdatedtime bigint,
publishedby bigint,
publishedtime bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT lifecycle_2388619_c CHECK ((length((name)::text) <= 50)),
CONSTRAINT lifecycle_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.lifecycle_drafts (
lifecycleid bigint NOT NULL,
lifecyclejson citext
);
CREATE TABLE public.lifecycle_node_map (
id bigint NOT NULL,
lifecycleid bigint NOT NULL,
nodeid bigint NOT NULL
);
CREATE TABLE public.lifecycle_transition_map (
lifecycleid bigint NOT NULL,
transitionid bigint NOT NULL
);
CREATE TABLE public.lifecyclehistory (
historyid bigint NOT NULL,
lifecycleid bigint NOT NULL,
operationownerid bigint NOT NULL,
operationtime bigint NOT NULL,
operation citext,
details citext,
CONSTRAINT lifecyclehistory_154330439_c CHECK ((length((operation)::text) <= 50))
);
CREATE TABLE public.lifecyclehistorydiff (
historydiffid bigint NOT NULL,
historyid bigint NOT NULL,
columnname citext NOT NULL,
prev_value citext,
current_value citext
);
CREATE TABLE public.linechartproperties (
reportid bigint NOT NULL,
linexdate bigint NOT NULL,
linexgroup bigint NOT NULL,
lineycountcoulmn bigint NOT NULL,
dateformat citext NOT NULL,
lineytargetfrom bigint,
lineytargetto bigint,
CONSTRAINT linechartproperties_1556470053_c CHECK ((length((dateformat)::text) <= 20))
);
CREATE TABLE public.linuxserver (
ciid bigint NOT NULL
);
CREATE TABLE public.linuxworkstation (
ciid bigint NOT NULL
);
CREATE TABLE public.loan (
loanid bigint NOT NULL,
loancustomid bigint NOT NULL,
userid bigint NOT NULL,
deptid bigint,
siteid bigint,
starttime bigint NOT NULL,
endtime bigint NOT NULL,
extendedto bigint NOT NULL,
returnedon bigint NOT NULL,
status citext DEFAULT 'On Loan' NOT NULL,
isescalated boolean DEFAULT false NOT NULL,
createdby bigint,
createdon bigint,
comments citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT loan_180211188_c CHECK ((length((comments)::text) <= 250)),
CONSTRAINT loan_1839152142_c CHECK ((length((status)::text) <= 20))
);
CREATE TABLE public.loanconfigvalue (
loanconfigid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
customloanid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.loanfrequency (
resourceid bigint NOT NULL,
loanfrequency bigint DEFAULT '0',
daysloaned bigint DEFAULT '0'
);
CREATE TABLE public.loanhistory (
historyid bigint NOT NULL,
loanid bigint NOT NULL,
operation citext DEFAULT 'ADD',
operationownerid bigint NOT NULL,
operationtime bigint NOT NULL,
description citext,
CONSTRAINT loanhistory_154330439_c CHECK ((length((operation)::text) <= 50))
);
CREATE TABLE public.loanhistorydiff (
historydiffid bigint NOT NULL,
historyid bigint NOT NULL,
columnname citext NOT NULL,
current_value citext,
prev_value citext,
CONSTRAINT loanhistorydiff_1088349253_c CHECK ((length((prev_value)::text) <= 250)),
CONSTRAINT loanhistorydiff_1619616031_c CHECK ((length((columnname)::text) <= 50)),
CONSTRAINT loanhistorydiff_1969348885_c CHECK ((length((current_value)::text) <= 250))
);
CREATE TABLE public.loanresources (
loanresourceid bigint NOT NULL,
loanid bigint NOT NULL,
resourceid bigint NOT NULL,
starttime bigint NOT NULL,
endtime bigint NOT NULL,
comments citext,
isreturned boolean DEFAULT false NOT NULL,
isescalated boolean DEFAULT false NOT NULL,
CONSTRAINT loanresources_180211188_c CHECK ((length((comments)::text) <= 250))
);
CREATE TABLE public.lockedaccountdetails (
lock_id bigint NOT NULL,
account_id bigint NOT NULL,
ipaddress citext DEFAULT '-' NOT NULL,
useragent citext NOT NULL,
is_captcha_auth_enabled boolean DEFAULT false NOT NULL,
is_account_locked boolean DEFAULT false NOT NULL,
CONSTRAINT lockedaccountdetails_1167389190_c CHECK ((length((useragent)::text) <= 200)),
CONSTRAINT lockedaccountdetails_1538992947_c CHECK ((length((ipaddress)::text) <= 100))
);
CREATE TABLE public.lucenesettings (
settingid bigint NOT NULL,
category citext NOT NULL,
value citext NOT NULL,
description citext DEFAULT '-' NOT NULL,
CONSTRAINT lucenesettings_428414940_c CHECK ((length((description)::text) <= 200)),
CONSTRAINT lucenesettings_81434961_c CHECK ((length((value)::text) <= 100)),
CONSTRAINT lucenesettings_833137918_c CHECK ((length((category)::text) <= 100))
);
CREATE TABLE public.macserver (
ciid bigint NOT NULL
);
CREATE TABLE public.macworkstation (
ciid bigint NOT NULL
);
CREATE TABLE public.mailauthtype (
id bigint NOT NULL,
authtype citext NOT NULL,
CONSTRAINT mailauthtype_2079110942_c CHECK ((length((authtype)::text) <= 100))
);
CREATE TABLE public.mailconfig (
mailconfigid bigint NOT NULL,
category citext NOT NULL,
parameter citext NOT NULL,
paramvalue citext NOT NULL,
description citext,
helpdeskid bigint,
CONSTRAINT mailconfig_428414940_c CHECK ((length((description)::text) <= 200)),
CONSTRAINT mailconfig_446088073_c CHECK ((length((parameter)::text) <= 100)),
CONSTRAINT mailconfig_833137918_c CHECK ((length((category)::text) <= 100)),
CONSTRAINT mailconfig_958969092_c CHECK ((length((paramvalue)::text) <= 100))
);
CREATE TABLE public.mailfetchingschedule (
id bigint NOT NULL,
scheduleid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.mailportdetails (
portid bigint NOT NULL,
emailtype citext NOT NULL,
port bigint NOT NULL,
tlsenabled boolean DEFAULT false NOT NULL,
authtypeid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT mailportdetails_613006518_c CHECK ((length((emailtype)::text) <= 100))
);
CREATE TABLE public.mailproperties (
propid bigint NOT NULL,
protocol citext NOT NULL,
propname citext NOT NULL,
propvalue citext,
description citext,
enabled boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT mailproperties_206537064_c CHECK ((length((protocol)::text) <= 100)),
CONSTRAINT mailproperties_2079171534_c CHECK ((length((propvalue)::text) <= 250)),
CONSTRAINT mailproperties_210262930_c CHECK ((length((propname)::text) <= 250)),
CONSTRAINT mailproperties_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.maintenancecontract (
contractid bigint NOT NULL,
customcontractid citext NOT NULL,
contractname citext NOT NULL,
comments citext,
support citext,
maintenancevendor bigint NOT NULL,
categoryid bigint NOT NULL,
escalatebefore bigint DEFAULT '0' NOT NULL,
escalatetoid bigint,
createdby bigint NOT NULL,
createddate bigint NOT NULL,
fromdate bigint NOT NULL,
todate bigint NOT NULL,
totalprice double DEFAULT '0' NOT NULL,
statusid bigint,
isescalated boolean DEFAULT false NOT NULL,
isrenewed boolean DEFAULT false NOT NULL,
ismaincontract boolean DEFAULT true NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT maintenancecontract_1136784465_c CHECK ((length((support)::text) <= 3500)),
CONSTRAINT maintenancecontract_915708573_c CHECK ((length((contractname)::text) <= 100)),
CONSTRAINT maintenancecontract_945245218_c CHECK ((length((customcontractid)::text) <= 100))
);
CREATE TABLE public.maintenancedetails (
maintenanceid bigint NOT NULL,
title citext,
createdby bigint,
createdtime bigint NOT NULL,
moduleid bigint NOT NULL,
description citext,
state integer DEFAULT 1 NOT NULL,
isdeleted boolean DEFAULT false,
helpdeskid bigint NOT NULL,
CONSTRAINT maintenancedetails_428414940_c CHECK ((length((description)::text) <= 1000)),
CONSTRAINT maintenancedetails_79833656_c CHECK ((length((title)::text) <= 250))
);
CREATE TABLE public.maintenancehistory (
historyid bigint NOT NULL,
maintenanceid bigint NOT NULL,
operationownerid bigint NOT NULL,
operationtime bigint NOT NULL,
description citext,
operation citext DEFAULT 'CREATE',
CONSTRAINT maintenancehistory_154330439_c CHECK ((length((operation)::text) <= 50))
);
CREATE TABLE public.maintenancehistorydiff (
historydiffid bigint NOT NULL,
historyid bigint NOT NULL,
columnname citext NOT NULL,
prev_value citext,
current_value citext,
prev_encrypted_value bytea,
current_encrypted_value bytea
);
CREATE TABLE public.maintenancetoschedulemapping (
maintenanceid bigint NOT NULL,
schedule_id bigint NOT NULL
);
CREATE TABLE public.managerialdashboarddetails (
mdvid bigint NOT NULL,
dvdid bigint NOT NULL,
viewoption bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.manufactureridentification (
manufactureridentificationid bigint NOT NULL,
pattern citext NOT NULL,
manufacturername citext NOT NULL,
CONSTRAINT manufactureridentification_350563804_c CHECK ((length((manufacturername)::text) <= 100)),
CONSTRAINT manufactureridentification_73107600_c CHECK ((length((pattern)::text) <= 100))
);
CREATE TABLE public.matrixreportdetails (
reportid bigint NOT NULL,
group_left_column bigint NOT NULL,
group_top_column bigint NOT NULL,
summary_column bigint NOT NULL,
summary_type citext,
CONSTRAINT matrixreportdetails_262057901_c CHECK ((length((summary_type)::text) <= 10))
);
CREATE TABLE public.maxusedswinfo (
softwareinfoid bigint NOT NULL
);
CREATE TABLE public.mediadetails (
mediaid bigint NOT NULL,
fileid bigint NOT NULL,
isdeleted boolean DEFAULT false NOT NULL,
addedby bigint NOT NULL,
addedon bigint NOT NULL,
module citext NOT NULL,
is_entity_associated boolean DEFAULT false NOT NULL,
helpdeskid bigint,
CONSTRAINT mediadetails_2015454612_c CHECK ((length((module)::text) <= 250))
);
CREATE TABLE public.memoryinfo (
workstationid bigint NOT NULL,
totalmemory bigint,
freememory bigint,
virtualmemory bigint,
freevirtualmemory bigint
);
CREATE TABLE public.memorymoduleinfo (
memorymoduleid bigint NOT NULL,
workstationid bigint NOT NULL,
name citext DEFAULT '-' NOT NULL,
capacity bigint,
socketlabel citext DEFAULT '-' NOT NULL,
banklabel citext DEFAULT '-' NOT NULL,
memorytype citext DEFAULT '-' NOT NULL,
frequency bigint,
CONSTRAINT memorymoduleinfo_1010830872_c CHECK ((length((banklabel)::text) <= 100)),
CONSTRAINT memorymoduleinfo_1151098047_c CHECK ((length((socketlabel)::text) <= 100)),
CONSTRAINT memorymoduleinfo_1823813701_c CHECK ((length((memorytype)::text) <= 100)),
CONSTRAINT memorymoduleinfo_2388619_c CHECK ((length((name)::text) <= 100))
);
CREATE TABLE public.menu (
menuid_no bigint NOT NULL,
menuid citext NOT NULL,
rolename citext,
displayname citext,
handler citext,
description citext,
displaytype citext,
displaystyle citext DEFAULT 'NORMAL',
menutemplate citext,
CONSTRAINT menu_1410786090_c CHECK ((length((handler)::text) <= 150)),
CONSTRAINT menu_2024392006_c CHECK ((length((menuid)::text) <= 50)),
CONSTRAINT menu_343927249_c CHECK ((length((displaystyle)::text) <= 50)),
CONSTRAINT menu_426702116_c CHECK ((length((displaytype)::text) <= 25)),
CONSTRAINT menu_426904019_c CHECK ((length((displayname)::text) <= 250)),
CONSTRAINT menu_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT menu_516800513_c CHECK ((length((rolename)::text) <= 100)),
CONSTRAINT menu_83035431_c CHECK ((length((menutemplate)::text) <= 50))
);
CREATE TABLE public.menuaction (
menuid bigint NOT NULL,
name citext DEFAULT '-' NOT NULL,
internal_name citext,
description citext DEFAULT '-' NOT NULL,
for_templates integer DEFAULT 1 NOT NULL,
is_all_roles boolean DEFAULT true NOT NULL,
isenabled boolean DEFAULT true NOT NULL,
module citext DEFAULT '-' NOT NULL,
app_id bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
thirdparty_app_id bigint,
serviceid bigint,
CONSTRAINT menuaction_2015454612_c CHECK ((length((module)::text) <= 100)),
CONSTRAINT menuaction_2388619_c CHECK ((length((name)::text) <= 250)),
CONSTRAINT menuaction_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT menuaction_677323469_c CHECK ((length((internal_name)::text) <= 250))
);
CREATE TABLE public.menuactionstatus (
action_status_id bigint NOT NULL,
action_id bigint,
action_status bigint DEFAULT '0' NOT NULL,
user_id bigint NOT NULL,
action_start_time bigint,
action_end_time bigint,
action_result citext
);
CREATE TABLE public.menuandmenuitem (
menuid bigint NOT NULL,
menuitemid bigint NOT NULL,
menuitemindex integer
);
CREATE TABLE public.menuitem (
menuitemid_no bigint NOT NULL,
menuitemid citext NOT NULL,
rolename citext,
displayname citext,
description citext,
image citext,
confirmstring citext,
imagecssclass citext,
atleastselectonestring citext,
title citext,
linkoption citext DEFAULT 'JAVASCRIPT',
cssclass citext,
titlefordisable citext,
imagecssclassfordisable citext,
imagefordisable citext,
cssclassfordisable citext,
CONSTRAINT menuitem_1003363974_c CHECK ((length((imagefordisable)::text) <= 100)),
CONSTRAINT menuitem_1061738608_c CHECK ((length((imagecssclass)::text) <= 250)),
CONSTRAINT menuitem_13873487_c CHECK ((length((confirmstring)::text) <= 250)),
CONSTRAINT menuitem_2120994417_c CHECK ((length((imagecssclassfordisable)::text) <= 250)),
CONSTRAINT menuitem_212205001_c CHECK ((length((titlefordisable)::text) <= 250)),
CONSTRAINT menuitem_2126364911_c CHECK ((length((linkoption)::text) <= 50)),
CONSTRAINT menuitem_402005675_c CHECK ((length((cssclass)::text) <= 250)),
CONSTRAINT menuitem_426904019_c CHECK ((length((displayname)::text) <= 250)),
CONSTRAINT menuitem_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT menuitem_516800513_c CHECK ((length((rolename)::text) <= 100)),
CONSTRAINT menuitem_59848980_c CHECK ((length((cssclassfordisable)::text) <= 250)),
CONSTRAINT menuitem_686312845_c CHECK ((length((menuitemid)::text) <= 50)),
CONSTRAINT menuitem_69775675_c CHECK ((length((image)::text) <= 100)),
CONSTRAINT menuitem_772961371_c CHECK ((length((atleastselectonestring)::text) <= 250)),
CONSTRAINT menuitem_79833656_c CHECK ((length((title)::text) <= 250))
);
CREATE TABLE public.menutoexecutor (
menuid bigint NOT NULL,
executorid bigint NOT NULL
);
CREATE TABLE public.menutoroles (
menu_roleid bigint NOT NULL,
menuid bigint NOT NULL,
roleid bigint NOT NULL
);
CREATE TABLE public.menutotemplates (
menu_templateid bigint NOT NULL,
menuid bigint NOT NULL,
templateid bigint NOT NULL
);
CREATE TABLE public.menuvstempid (
id bigint NOT NULL,
menuid bigint NOT NULL,
domainname citext NOT NULL,
tempid bigint NOT NULL,
CONSTRAINT menuvstempid_758040241_c CHECK ((length((domainname)::text) <= 100))
);
CREATE TABLE public.milestoneattachments (
attachmentid bigint NOT NULL,
milestoneid bigint NOT NULL
);
CREATE TABLE public.milestonedescription (
milestoneid bigint NOT NULL,
description citext
);
CREATE TABLE public.milestonedetails (
milestoneid bigint NOT NULL,
projectid bigint NOT NULL,
title citext NOT NULL,
ownerid bigint,
priorityid bigint,
duration citext,
statusid bigint NOT NULL,
createdby bigint NOT NULL,
createddate bigint NOT NULL,
scheduledstarttime bigint,
scheduledendtime bigint,
actualstarttime bigint,
actualendtime bigint,
milestoneindex integer NOT NULL,
estimatedhours bigint,
scheduletaskhours bigint,
actualtaskhours bigint,
projectedend bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT milestonedetails_1209385580_c CHECK ((length((duration)::text) <= 50)),
CONSTRAINT milestonedetails_79833656_c CHECK ((length((title)::text) <= 250))
);
CREATE TABLE public.milestoneimages (
milestoneid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.milestonetemplate (
milestonetemplateid bigint NOT NULL,
projecttemplateid bigint NOT NULL,
milestonetemplateindex bigint NOT NULL,
title citext NOT NULL,
priorityid bigint,
statusid bigint,
createdby bigint NOT NULL,
estimatedhours bigint,
description citext,
comments citext,
createdtime bigint NOT NULL,
CONSTRAINT milestonetemplate_79833656_c CHECK ((length((title)::text) <= 250))
);
CREATE TABLE public.milestonetemplateimages (
milestonetemplateid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.milestonetocomment (
commentid bigint NOT NULL,
milestoneid bigint NOT NULL
);
CREATE TABLE public.mobileappinfo (
mobileappinfoid bigint NOT NULL,
resourceid bigint NOT NULL,
appid bigint NOT NULL,
dynamicsize bigint
);
CREATE TABLE public.mobileapplications (
appid bigint NOT NULL,
appname citext DEFAULT '-',
appversion citext DEFAULT '-',
identifier citext DEFAULT '-',
bundlesize bigint,
ostypeid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT mobileapplications_1133340503_c CHECK ((length((identifier)::text) <= 250)),
CONSTRAINT mobileapplications_304551831_c CHECK ((length((appversion)::text) <= 250)),
CONSTRAINT mobileapplications_75200500_c CHECK ((length((appname)::text) <= 250))
);
CREATE TABLE public.mobileauthkey (
id bigint NOT NULL,
login_id bigint NOT NULL,
device_uid citext NOT NULL,
mobile_auth_key bytea NOT NULL,
last_accessed_time bigint NOT NULL,
CONSTRAINT mobileauthkey_1267560135_c CHECK ((length((device_uid)::text) <= 200))
);
CREATE TABLE public.mobilecertificatesinfo (
mobilecertificateid bigint NOT NULL,
resourceid bigint NOT NULL,
commonname citext DEFAULT '-',
isidentity boolean DEFAULT false NOT NULL,
CONSTRAINT mobilecertificatesinfo_1670357750_c CHECK ((length((commonname)::text) <= 250))
);
CREATE TABLE public.mobiledevices (
resourceid bigint NOT NULL,
imei citext DEFAULT '-',
model citext DEFAULT '-',
modemfirmwareversion citext DEFAULT '-',
udid citext DEFAULT '-',
serialnumber citext DEFAULT '-',
CONSTRAINT mobiledevices_16093613_c CHECK ((length((modemfirmwareversion)::text) <= 250)),
CONSTRAINT mobiledevices_2250952_c CHECK ((length((imei)::text) <= 250)),
CONSTRAINT mobiledevices_2599914_c CHECK ((length((udid)::text) <= 250)),
CONSTRAINT mobiledevices_73532169_c CHECK ((length((model)::text) <= 250)),
CONSTRAINT mobiledevices_977765827_c CHECK ((length((serialnumber)::text) <= 250))
);
CREATE TABLE public.mobilememoryinfo (
resourceid bigint NOT NULL,
totalcapacity bigint,
availablecapacity bigint
);
CREATE TABLE public.mobilenetworkinfo (
mobilenetworkid bigint NOT NULL,
resourceid bigint NOT NULL,
bluetoothmac citext DEFAULT '-',
wifimac citext DEFAULT '-',
iccid citext DEFAULT '-',
phonenumber citext DEFAULT '-',
currentcarriernetwork citext DEFAULT '-',
carriersettingsversion citext DEFAULT '-',
simcarriernetwork citext DEFAULT '-',
voiceroamingenabled boolean DEFAULT false NOT NULL,
dataroamingenabled boolean DEFAULT false NOT NULL,
isroaming boolean DEFAULT false NOT NULL,
cellulartechnology citext DEFAULT '-',
currentmcc citext DEFAULT '-',
currentmnc citext DEFAULT '-',
subscribermcc citext DEFAULT '-',
subscribermnc citext DEFAULT '-',
CONSTRAINT mobilenetworkinfo_1122183517_c CHECK ((length((carriersettingsversion)::text) <= 100)),
CONSTRAINT mobilenetworkinfo_1391759823_c CHECK ((length((currentcarriernetwork)::text) <= 100)),
CONSTRAINT mobilenetworkinfo_1876124183_c CHECK ((length((phonenumber)::text) <= 100)),
CONSTRAINT mobilenetworkinfo_2060234234_c CHECK ((length((wifimac)::text) <= 100)),
CONSTRAINT mobilenetworkinfo_2096630_c CHECK ((length((cellulartechnology)::text) <= 100)),
CONSTRAINT mobilenetworkinfo_394246149_c CHECK ((length((subscribermcc)::text) <= 100)),
CONSTRAINT mobilenetworkinfo_394246490_c CHECK ((length((subscribermnc)::text) <= 100)),
CONSTRAINT mobilenetworkinfo_603867447_c CHECK ((length((currentmnc)::text) <= 100)),
CONSTRAINT mobilenetworkinfo_603867788_c CHECK ((length((currentmcc)::text) <= 100)),
CONSTRAINT mobilenetworkinfo_69479748_c CHECK ((length((iccid)::text) <= 100)),
CONSTRAINT mobilenetworkinfo_749515603_c CHECK ((length((simcarriernetwork)::text) <= 100)),
CONSTRAINT mobilenetworkinfo_923116513_c CHECK ((length((bluetoothmac)::text) <= 100))
);
CREATE TABLE public.mobilenotificationconfig (
mobile_not_id bigint NOT NULL,
notif_attr_id bigint NOT NULL,
isenabled boolean DEFAULT false NOT NULL,
notifyalways boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.mobilenotifications (
uid bigint NOT NULL,
userid bigint NOT NULL,
deviceid citext NOT NULL,
os citext NOT NULL,
osversion citext,
model citext,
isregistered boolean DEFAULT false NOT NULL,
isproduction boolean DEFAULT false NOT NULL,
createdtime bigint,
CONSTRAINT mobilenotifications_1361021356_c CHECK ((length((osversion)::text) <= 250)),
CONSTRAINT mobilenotifications_1891818993_c CHECK ((length((deviceid)::text) <= 250)),
CONSTRAINT mobilenotifications_2532_c CHECK ((length((os)::text) <= 250)),
CONSTRAINT mobilenotifications_73532169_c CHECK ((length((model)::text) <= 250))
);
CREATE TABLE public.mobileosinfo (
resourceid bigint NOT NULL,
ostypeid bigint NOT NULL,
osversion citext DEFAULT '-',
buildversion citext DEFAULT '-',
CONSTRAINT mobileosinfo_1361021356_c CHECK ((length((osversion)::text) <= 250)),
CONSTRAINT mobileosinfo_259078486_c CHECK ((length((buildversion)::text) <= 250))
);
CREATE TABLE public.mobileostype (
ostypeid bigint NOT NULL,
os citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT mobileostype_2532_c CHECK ((length((os)::text) <= 250))
);
CREATE TABLE public.mobileproductidentification (
identificationid bigint NOT NULL,
namefromdevice citext,
generalname citext,
componenttypeid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT mobileproductidentification_1262394541_c CHECK ((length((generalname)::text) <= 250)),
CONSTRAINT mobileproductidentification_1935262901_c CHECK ((length((namefromdevice)::text) <= 250))
);
CREATE TABLE public.mobilerestrictionsinfo (
resourceid bigint NOT NULL,
allow_appinstallation integer DEFAULT 2 NOT NULL,
allow_camera integer DEFAULT 2 NOT NULL,
allow_facetime integer DEFAULT 2 NOT NULL,
allow_screencapture integer DEFAULT 2 NOT NULL,
allow_syncwhileroaming integer DEFAULT 2 NOT NULL,
allow_voicedialing integer DEFAULT 2 NOT NULL,
allow_inapppurchase integer DEFAULT 2 NOT NULL,
allow_multiplayergaming integer DEFAULT 2 NOT NULL,
allow_addinggamefriends integer DEFAULT 2 NOT NULL,
force_encryptedbackup integer DEFAULT 2 NOT NULL,
allow_youtube integer DEFAULT 2 NOT NULL,
allow_itunes integer DEFAULT 2 NOT NULL,
allow_safari integer DEFAULT 2 NOT NULL,
safari_allow_autofill integer DEFAULT 2 NOT NULL,
safari_force_fraudwarning integer DEFAULT 2 NOT NULL,
safari_allow_javascript integer DEFAULT 2 NOT NULL,
safari_allow_popups integer DEFAULT 2 NOT NULL,
safari_accept_cookies integer DEFAULT 2 NOT NULL,
allow_explicitcontents integer DEFAULT 2 NOT NULL
);
CREATE TABLE public.mobilesecurityinfo (
resourceid bigint NOT NULL,
hardwareencryptionscaps citext DEFAULT '-',
passcodecompliant boolean DEFAULT false NOT NULL,
passcodecompliantwithprofiles boolean DEFAULT false NOT NULL,
passcodepresent boolean DEFAULT false NOT NULL,
CONSTRAINT mobilesecurityinfo_812543273_c CHECK ((length((hardwareencryptionscaps)::text) <= 100))
);
CREATE TABLE public.modedefinition (
modeid bigint NOT NULL,
modename citext NOT NULL,
modedescription citext,
isdeleted boolean DEFAULT false,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT modedefinition_1101566553_c CHECK ((length((modedescription)::text) <= 250)),
CONSTRAINT modedefinition_163650222_c CHECK ((length((modename)::text) <= 100))
);
CREATE TABLE public.modespecificserviceproviders (
cvtypeid bigint NOT NULL,
comm_mode integer NOT NULL
);
CREATE TABLE public.module (
module_id bigint NOT NULL,
moduleorder integer NOT NULL,
modulename citext NOT NULL,
version_no citext,
ispopulated boolean,
CONSTRAINT module_185374040_c CHECK ((length((version_no)::text) <= 100)),
CONSTRAINT module_384305417_c CHECK ((length((modulename)::text) <= 100))
);
CREATE TABLE public.modulechecklist (
checklistid bigint NOT NULL,
title citext NOT NULL,
description citext,
status citext,
checklistorder bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT modulechecklist_1839152142_c CHECK ((length((status)::text) <= 100)),
CONSTRAINT modulechecklist_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT modulechecklist_79833656_c CHECK ((length((title)::text) <= 100))
);
CREATE TABLE public.modulechecklistitem (
checklistitemid bigint NOT NULL,
checklistid bigint NOT NULL,
fieldname citext NOT NULL,
field_type citext NOT NULL,
cl_bool boolean DEFAULT false NOT NULL,
cl_char citext,
cl_long bigint,
comments citext,
lastupdatedby bigint,
lastupdatedtime bigint,
iscompleted boolean DEFAULT false NOT NULL,
checklistitemorder bigint NOT NULL,
options citext,
help_text citext,
CONSTRAINT modulechecklistitem_1091506047_c CHECK ((length((field_type)::text) <= 30)),
CONSTRAINT modulechecklistitem_1598821740_c CHECK ((length((cl_char)::text) <= 500)),
CONSTRAINT modulechecklistitem_180211188_c CHECK ((length((comments)::text) <= 5000)),
CONSTRAINT modulechecklistitem_181432469_c CHECK ((length((help_text)::text) <= 250)),
CONSTRAINT modulechecklistitem_242409883_c CHECK ((length((fieldname)::text) <= 100)),
CONSTRAINT modulechecklistitem_531492226_c CHECK ((length((options)::text) <= 5000))
);
CREATE TABLE public.moduleconfiguration (
id bigint NOT NULL,
module citext NOT NULL,
pii_handler citext NOT NULL,
pii_handler_order bigint NOT NULL,
pii_info_table citext NOT NULL,
display_name citext NOT NULL,
CONSTRAINT moduleconfiguration_1115071244_c CHECK ((length((pii_info_table)::text) <= 250)),
CONSTRAINT moduleconfiguration_1486049115_c CHECK ((length((pii_handler)::text) <= 250)),
CONSTRAINT moduleconfiguration_2015454612_c CHECK ((length((module)::text) <= 250)),
CONSTRAINT moduleconfiguration_333046776_c CHECK ((length((display_name)::text) <= 250))
);
CREATE TABLE public.modulecontext (
module_id bigint NOT NULL,
context citext NOT NULL,
CONSTRAINT modulecontext_1669513615_c CHECK ((length((context)::text) <= 50))
);
CREATE TABLE public.moduledelimiter (
delimiterid bigint NOT NULL,
module citext NOT NULL,
delimiter citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT moduledelimiter_1758890521_c CHECK ((length((delimiter)::text) <= 10)),
CONSTRAINT moduledelimiter_2015454612_c CHECK ((length((module)::text) <= 100))
);
CREATE TABLE public.monitorinfo (
monitorid bigint NOT NULL,
workstationid bigint NOT NULL,
monitortype citext DEFAULT '-' NOT NULL,
maxresolution citext DEFAULT '-' NOT NULL,
manufacturer citext DEFAULT '-' NOT NULL,
serialnumber citext DEFAULT '-' NOT NULL,
CONSTRAINT monitorinfo_1649620752_c CHECK ((length((maxresolution)::text) <= 100)),
CONSTRAINT monitorinfo_347933649_c CHECK ((length((manufacturer)::text) <= 100)),
CONSTRAINT monitorinfo_561470604_c CHECK ((length((monitortype)::text) <= 100)),
CONSTRAINT monitorinfo_977765827_c CHECK ((length((serialnumber)::text) <= 100))
);
CREATE TABLE public.mouseinfo (
mouseid bigint NOT NULL,
workstationid bigint NOT NULL,
mousetype citext DEFAULT '-' NOT NULL,
mousebuttons bigint DEFAULT '0',
mouseserialnumber citext DEFAULT '-' NOT NULL,
mousemanufacturer citext DEFAULT '-' NOT NULL,
CONSTRAINT mouseinfo_1307291862_c CHECK ((length((mousemanufacturer)::text) <= 100)),
CONSTRAINT mouseinfo_18407614_c CHECK ((length((mouseserialnumber)::text) <= 100)),
CONSTRAINT mouseinfo_921042625_c CHECK ((length((mousetype)::text) <= 100))
);
CREATE TABLE public.mssql (
ciid bigint NOT NULL
);
CREATE TABLE public.multimediainfo (
multimediaid bigint NOT NULL,
workstationid bigint NOT NULL,
vidoecardname citext DEFAULT '-' NOT NULL,
videocardmemory bigint DEFAULT '0' NOT NULL,
vidoecardchipset citext DEFAULT '-' NOT NULL,
videocardbiosversion citext DEFAULT '-' NOT NULL,
vidoecardbiosdate citext DEFAULT '-' NOT NULL,
CONSTRAINT multimediainfo_1706787874_c CHECK ((length((vidoecardname)::text) <= 250)),
CONSTRAINT multimediainfo_2119218047_c CHECK ((length((vidoecardchipset)::text) <= 250)),
CONSTRAINT multimediainfo_271389474_c CHECK ((length((videocardbiosversion)::text) <= 25)),
CONSTRAINT multimediainfo_590038192_c CHECK ((length((vidoecardbiosdate)::text) <= 50))
);
CREATE TABLE public.mysql (
ciid bigint NOT NULL
);
CREATE TABLE public.netappaggregators (
ciid bigint NOT NULL,
aggregatorindex bigint NOT NULL,
aggregatorname citext,
status citext,
CONSTRAINT netappaggregators_1839152142_c CHECK ((length((status)::text) <= 100)),
CONSTRAINT netappaggregators_1860039212_c CHECK ((length((aggregatorname)::text) <= 100))
);
CREATE TABLE public.netappphysicaldisks (
ciid bigint NOT NULL,
raidindex bigint NOT NULL,
raidvolumeid bigint NOT NULL,
raidgroupid bigint NOT NULL,
diskname citext,
shelf citext,
bay citext,
model citext,
type citext,
status citext,
totalsize bigint,
usedsize bigint,
serialnumber citext,
firmwarerevision citext,
CONSTRAINT netappphysicaldisks_1063149992_c CHECK ((length((diskname)::text) <= 100)),
CONSTRAINT netappphysicaldisks_1839152142_c CHECK ((length((status)::text) <= 100)),
CONSTRAINT netappphysicaldisks_2590522_c CHECK ((length((type)::text) <= 100)),
CONSTRAINT netappphysicaldisks_610985622_c CHECK ((length((firmwarerevision)::text) <= 100)),
CONSTRAINT netappphysicaldisks_65530_c CHECK ((length((bay)::text) <= 100)),
CONSTRAINT netappphysicaldisks_73532169_c CHECK ((length((model)::text) <= 100)),
CONSTRAINT netappphysicaldisks_78865930_c CHECK ((length((shelf)::text) <= 100)),
CONSTRAINT netappphysicaldisks_977765827_c CHECK ((length((serialnumber)::text) <= 100))
);
CREATE TABLE public.netappvolumes (
ciid bigint NOT NULL,
volumeindex bigint NOT NULL,
volumename citext,
status citext,
aggregatorname citext,
CONSTRAINT netappvolumes_1066717019_c CHECK ((length((volumename)::text) <= 100)),
CONSTRAINT netappvolumes_1839152142_c CHECK ((length((status)::text) <= 100)),
CONSTRAINT netappvolumes_1860039212_c CHECK ((length((aggregatorname)::text) <= 100))
);
CREATE TABLE public.network (
ciid bigint NOT NULL,
rangeofips citext,
bandwidth citext,
CONSTRAINT network_1315629096_c CHECK ((length((rangeofips)::text) <= 250)),
CONSTRAINT network_820826257_c CHECK ((length((bandwidth)::text) <= 250))
);
CREATE TABLE public.network_router (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.network_server (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.network_sg (
primarykeyid bigint NOT NULL,
supportlevel citext,
CONSTRAINT network_sg_784370965_c CHECK ((length((supportlevel)::text) <= 250))
);
CREATE TABLE public.network_switch (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.network_technician (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.network_workstation (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.networkcredentials (
networkid bigint NOT NULL,
devicetypeid bigint NOT NULL,
credentialid bigint NOT NULL
);
CREATE TABLE public.networkdeviceinterfaces (
ciid bigint NOT NULL,
ifindex citext NOT NULL,
ifdescr citext,
iftype citext,
ifspeed citext,
ifphyaddr citext,
address citext,
netmask citext,
ifoperstatus citext,
ifadminstatus citext,
CONSTRAINT networkdeviceinterfaces_1210744156_c CHECK ((length((ifadminstatus)::text) <= 100)),
CONSTRAINT networkdeviceinterfaces_1226171115_c CHECK ((length((ifphyaddr)::text) <= 100)),
CONSTRAINT networkdeviceinterfaces_1733810711_c CHECK ((length((netmask)::text) <= 100)),
CONSTRAINT networkdeviceinterfaces_1848563414_c CHECK ((length((ifspeed)::text) <= 100)),
CONSTRAINT networkdeviceinterfaces_1857859147_c CHECK ((length((ifindex)::text) <= 100)),
CONSTRAINT networkdeviceinterfaces_1862730524_c CHECK ((length((ifdescr)::text) <= 100)),
CONSTRAINT networkdeviceinterfaces_2137802281_c CHECK ((length((iftype)::text) <= 100)),
CONSTRAINT networkdeviceinterfaces_429709356_c CHECK ((length((address)::text) <= 100)),
CONSTRAINT networkdeviceinterfaces_604928157_c CHECK ((length((ifoperstatus)::text) <= 100))
);
CREATE TABLE public.networkdevicesvendor (
vendorid bigint NOT NULL,
vendor citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT networkdevicesvendor_1766745784_c CHECK ((length((vendor)::text) <= 200))
);
CREATE TABLE public.networkdnsinfo (
dnsid bigint NOT NULL,
workstationid bigint NOT NULL,
dnsservername citext NOT NULL,
CONSTRAINT networkdnsinfo_1456189929_c CHECK ((length((dnsservername)::text) <= 50))
);
CREATE TABLE public.networkdomaininfo (
networkdomainid bigint NOT NULL,
workstationid bigint NOT NULL,
domainname citext NOT NULL,
CONSTRAINT networkdomaininfo_758040241_c CHECK ((length((domainname)::text) <= 50))
);
CREATE TABLE public.networkinfo (
networkid bigint NOT NULL,
workstationid bigint NOT NULL,
nicname citext DEFAULT '-' NOT NULL,
nicdescription citext DEFAULT '-' NOT NULL,
ipaddress citext DEFAULT '-' NOT NULL,
macaddress citext DEFAULT '-' NOT NULL,
ipnetmask citext DEFAULT '-' NOT NULL,
network citext DEFAULT '-' NOT NULL,
gateway citext DEFAULT '-' NOT NULL,
isdhcp citext DEFAULT 'false' NOT NULL,
dhcpserver citext DEFAULT '-' NOT NULL,
niclease citext DEFAULT '-' NOT NULL,
CONSTRAINT networkinfo_1451872994_c CHECK ((length((ipnetmask)::text) <= 25)),
CONSTRAINT networkinfo_1538992947_c CHECK ((length((ipaddress)::text) <= 250)),
CONSTRAINT networkinfo_1634964365_c CHECK ((length((nicname)::text) <= 100)),
CONSTRAINT networkinfo_1733499378_c CHECK ((length((network)::text) <= 25)),
CONSTRAINT networkinfo_2126289893_c CHECK ((length((isdhcp)::text) <= 50)),
CONSTRAINT networkinfo_235427596_c CHECK ((length((nicdescription)::text) <= 250)),
CONSTRAINT networkinfo_528863780_c CHECK ((length((gateway)::text) <= 100)),
CONSTRAINT networkinfo_533222796_c CHECK ((length((dhcpserver)::text) <= 100)),
CONSTRAINT networkinfo_853973330_c CHECK ((length((niclease)::text) <= 100)),
CONSTRAINT networkinfo_902372293_c CHECK ((length((macaddress)::text) <= 50))
);
CREATE TABLE public.networkproxydetails (
id bigint NOT NULL,
host citext NOT NULL,
port citext NOT NULL,
username citext,
password citext,
CONSTRAINT networkproxydetails_1999612571_c CHECK ((length((password)::text) <= 100)),
CONSTRAINT networkproxydetails_2223528_c CHECK ((length((host)::text) <= 50)),
CONSTRAINT networkproxydetails_2461825_c CHECK ((length((port)::text) <= 19)),
CONSTRAINT networkproxydetails_516913366_c CHECK ((length((username)::text) <= 100))
);
CREATE TABLE public.node (
nodeid bigint NOT NULL,
entity citext,
entityid bigint,
uiattributes citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT node_2050021347_c CHECK ((length((entity)::text) <= 50))
);
CREATE TABLE public.nodelockedlicenses (
licenseid bigint NOT NULL,
workstationid bigint,
osname citext DEFAULT '-' NOT NULL,
hostid citext DEFAULT '-' NOT NULL,
CONSTRAINT nodelockedlicenses_1954223505_c CHECK ((length((osname)::text) <= 100)),
CONSTRAINT nodelockedlicenses_2136812739_c CHECK ((length((hostid)::text) <= 100))
);
CREATE TABLE public.notes (
notesid bigint NOT NULL,
createdby bigint NOT NULL,
createdtime bigint NOT NULL,
notestext citext NOT NULL,
hasattachment boolean DEFAULT false NOT NULL,
updatedby bigint,
updatedtime bigint,
notestype citext DEFAULT 'notes',
CONSTRAINT notes_291087707_c CHECK ((length((notestype)::text) <= 50))
);
CREATE TABLE public.notesattachment (
attachmentid bigint NOT NULL,
notesid bigint NOT NULL
);
CREATE TABLE public.notesimages (
notesid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.notification (
notificationid bigint NOT NULL,
notificationtitle citext,
notificationdate bigint NOT NULL,
senderid bigint NOT NULL,
recipientid bigint,
messageid citext NOT NULL,
notificationtype citext,
ispublic boolean DEFAULT true NOT NULL,
hasattachment boolean DEFAULT false NOT NULL,
is_draft boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT notification_1346582338_c CHECK ((length((messageid)::text) <= 250)),
CONSTRAINT notification_1634626515_c CHECK ((length((notificationtitle)::text) <= 500)),
CONSTRAINT notification_1886948005_c CHECK ((length((notificationtype)::text) <= 50))
);
CREATE TABLE public.notification_recipients (
notificationid bigint NOT NULL,
recipient_email citext NOT NULL,
to_cc_bcc citext,
CONSTRAINT notification_recipients_370219446_c CHECK ((length((recipient_email)::text) <= 250)),
CONSTRAINT notification_recipients_862828025_c CHECK ((length((to_cc_bcc)::text) <= 250))
);
CREATE TABLE public.notificationattributes (
notif_attr_id bigint NOT NULL,
notify_type citext NOT NULL,
message_key citext NOT NULL,
message_url_key citext NOT NULL,
title citext,
iscommonnotification boolean DEFAULT false NOT NULL,
CONSTRAINT notificationattributes_1281135079_c CHECK ((length((message_key)::text) <= 500)),
CONSTRAINT notificationattributes_318392585_c CHECK ((length((message_url_key)::text) <= 500)),
CONSTRAINT notificationattributes_439900784_c CHECK ((length((notify_type)::text) <= 200)),
CONSTRAINT notificationattributes_79833656_c CHECK ((length((title)::text) <= 500))
);
CREATE TABLE public.notificationcontent (
notificationcontentid bigint NOT NULL,
notificationtype citext NOT NULL,
subject citext,
content citext,
isenabled boolean DEFAULT false NOT NULL,
escalatetoid bigint,
module citext DEFAULT 'Request',
displayname citext,
name citext,
escalatebefore bigint,
escalateafter bigint,
frequency bigint,
emailids citext,
helpdeskid bigint,
CONSTRAINT notificationcontent_1886948005_c CHECK ((length((notificationtype)::text) <= 150)),
CONSTRAINT notificationcontent_2015454612_c CHECK ((length((module)::text) <= 20)),
CONSTRAINT notificationcontent_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT notificationcontent_426904019_c CHECK ((length((displayname)::text) <= 250))
);
CREATE TABLE public.notificationcontentimages (
notificationcontentid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.notificationimages (
notificationid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.notificationtemplate (
templateid bigint NOT NULL,
notificationcontentid bigint NOT NULL,
variablename citext NOT NULL,
displayname citext NOT NULL,
tablename citext NOT NULL,
columnname citext NOT NULL,
isdatecolumn boolean DEFAULT false NOT NULL,
CONSTRAINT notificationtemplate_1619616031_c CHECK ((length((columnname)::text) <= 50)),
CONSTRAINT notificationtemplate_1945212679_c CHECK ((length((variablename)::text) <= 100)),
CONSTRAINT notificationtemplate_426904019_c CHECK ((length((displayname)::text) <= 250)),
CONSTRAINT notificationtemplate_798830393_c CHECK ((length((tablename)::text) <= 50))
);
CREATE TABLE public.notificationtemplateattachments (
attachmentid bigint NOT NULL,
notificationcontentid bigint NOT NULL,
helpdeskid bigint
);
CREATE TABLE public.notificationtemplatefields (
notificationtemplatefieldid bigint NOT NULL,
templateid bigint NOT NULL,
fieldname citext NOT NULL,
displayname citext NOT NULL,
tablename citext NOT NULL,
columnname citext NOT NULL,
isdatecolumn boolean DEFAULT false NOT NULL,
isselected boolean DEFAULT false NOT NULL,
order_by bigint,
CONSTRAINT notificationtemplatefields_1619616031_c CHECK ((length((columnname)::text) <= 50)),
CONSTRAINT notificationtemplatefields_242409883_c CHECK ((length((fieldname)::text) <= 100)),
CONSTRAINT notificationtemplatefields_426904019_c CHECK ((length((displayname)::text) <= 250)),
CONSTRAINT notificationtemplatefields_798830393_c CHECK ((length((tablename)::text) <= 50))
);
CREATE TABLE public.notificationtodesc (
notificationid bigint NOT NULL,
description citext NOT NULL,
attachmentid bigint
);
CREATE TABLE public.notify_announcement (
notificationid bigint NOT NULL,
announceid bigint NOT NULL
);
CREATE TABLE public.notify_attachments (
attachmentid bigint NOT NULL,
notificationid bigint NOT NULL
);
CREATE TABLE public.notify_change (
notificationid bigint NOT NULL,
changeid bigint NOT NULL
);
CREATE TABLE public.notify_contract (
notificationid bigint NOT NULL,
contractid bigint NOT NULL
);
CREATE TABLE public.notify_po (
notificationid bigint NOT NULL,
purchaseorderid bigint NOT NULL
);
CREATE TABLE public.notify_pr (
notificationid bigint NOT NULL,
requestid bigint NOT NULL
);
CREATE TABLE public.notify_problem (
notificationid bigint NOT NULL,
problemid bigint NOT NULL
);
CREATE TABLE public.notify_release (
notificationid bigint NOT NULL,
releaseid bigint NOT NULL
);
CREATE TABLE public.notify_solution (
solutionid bigint NOT NULL,
notificationid bigint NOT NULL
);
CREATE TABLE public.notify_space (
notificationid bigint NOT NULL,
spaceid bigint NOT NULL
);
CREATE TABLE public.notify_workorder (
notificationid bigint NOT NULL,
workorderid bigint NOT NULL,
child_woid bigint,
recommend_templateid bigint,
is_bcc_reply boolean DEFAULT false NOT NULL
);
CREATE TABLE public.notifycontentdef (
fieldid bigint NOT NULL,
notifyid bigint NOT NULL,
tablename citext NOT NULL,
columnname citext NOT NULL,
columnalias citext NOT NULL,
columnorder bigint NOT NULL,
CONSTRAINT notifycontentdef_1319828634_c CHECK ((length((columnalias)::text) <= 30)),
CONSTRAINT notifycontentdef_1619616031_c CHECK ((length((columnname)::text) <= 20)),
CONSTRAINT notifycontentdef_798830393_c CHECK ((length((tablename)::text) <= 20))
);
CREATE TABLE public.notifydefinition (
notifyid bigint NOT NULL,
module citext,
notifytypeid bigint NOT NULL,
description citext,
filename citext,
status boolean DEFAULT false NOT NULL,
CONSTRAINT notifydefinition_2015454612_c CHECK ((length((module)::text) <= 20)),
CONSTRAINT notifydefinition_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT notifydefinition_47858183_c CHECK ((length((filename)::text) <= 250))
);
CREATE TABLE public.notifylockedaccountto (
technicianid bigint NOT NULL
);
CREATE TABLE public.notifytypedef (
notifytypeid bigint NOT NULL,
notifytypename citext NOT NULL,
notifytypedesc citext,
CONSTRAINT notifytypedef_976945394_c CHECK ((length((notifytypename)::text) <= 100)),
CONSTRAINT notifytypedef_977239276_c CHECK ((length((notifytypedesc)::text) <= 250))
);
CREATE TABLE public.ntp (
ciid bigint NOT NULL,
osversion citext,
systemtype citext,
CONSTRAINT ntp_1128938985_c CHECK ((length((systemtype)::text) <= 250)),
CONSTRAINT ntp_1361021356_c CHECK ((length((osversion)::text) <= 250))
);
CREATE TABLE public.oauthcredential (
credentialid bigint NOT NULL,
clientid bytea NOT NULL,
clientsecret bytea NOT NULL,
authurl bytea NOT NULL,
tokenurl bytea NOT NULL,
scope bytea NOT NULL
);
CREATE TABLE public.oauthtoken (
id bigint NOT NULL,
credentialid bigint NOT NULL,
accesstoken bytea NOT NULL,
accesstokenexpiry bigint NOT NULL,
refreshtoken bytea NOT NULL
);
CREATE TABLE public.objectidentifiercolumns (
queryid bigint NOT NULL,
tablename citext,
columnname citext NOT NULL,
columnvalue citext,
CONSTRAINT objectidentifiercolumns_1338898363_c CHECK ((length((columnvalue)::text) <= 50)),
CONSTRAINT objectidentifiercolumns_1619616031_c CHECK ((length((columnname)::text) <= 50)),
CONSTRAINT objectidentifiercolumns_798830393_c CHECK ((length((tablename)::text) <= 50))
);
CREATE TABLE public.oidtype (
oidtypeid bigint NOT NULL,
oid citext NOT NULL,
type citext NOT NULL,
componenttypeid bigint NOT NULL,
os citext,
vendorid bigint,
snmpinventorytypeid bigint,
sshinventorytype citext,
sysdescr citext,
modeloid citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT oidtype_1551024812_c CHECK ((length((sysdescr)::text) <= 500)),
CONSTRAINT oidtype_163603969_c CHECK ((length((modeloid)::text) <= 100)),
CONSTRAINT oidtype_2532_c CHECK ((length((os)::text) <= 200)),
CONSTRAINT oidtype_2590522_c CHECK ((length((type)::text) <= 150)),
CONSTRAINT oidtype_699386254_c CHECK ((length((sshinventorytype)::text) <= 100)),
CONSTRAINT oidtype_78250_c CHECK ((length((oid)::text) <= 200))
);
CREATE TABLE public.oladefinition (
olaid bigint NOT NULL,
olaname citext,
description citext,
slaid bigint NOT NULL,
groupname citext NOT NULL,
duebydays bigint DEFAULT '0' NOT NULL,
duebyhours bigint DEFAULT '0' NOT NULL,
duebyminutes bigint DEFAULT '0' NOT NULL,
groupset bigint DEFAULT '1' NOT NULL,
CONSTRAINT oladefinition_1304373610_c CHECK ((length((groupname)::text) <= 250)),
CONSTRAINT oladefinition_428414940_c CHECK ((length((description)::text) <= 500)),
CONSTRAINT oladefinition_663420273_c CHECK ((length((olaname)::text) <= 250))
);
CREATE TABLE public.olastatusdefinition (
status_id bigint NOT NULL,
status_name citext NOT NULL,
display_name citext,
CONSTRAINT olastatusdefinition_1291128504_c CHECK ((length((status_name)::text) <= 100)),
CONSTRAINT olastatusdefinition_333046776_c CHECK ((length((display_name)::text) <= 250))
);
CREATE TABLE public.onholdscheduler (
workorderid bigint DEFAULT '0' NOT NULL,
changestatusid bigint,
userid bigint,
scheduledtime bigint,
onholdcomments citext,
CONSTRAINT onholdscheduler_1855962898_c CHECK ((length((onholdcomments)::text) <= 1000))
);
CREATE TABLE public.openviewincontentarea (
menuitemid bigint NOT NULL,
viewname bigint NOT NULL,
parentviewname citext,
contentareaname citext DEFAULT 'DEFAULTCONTENTAREA' NOT NULL,
addtolist boolean DEFAULT true NOT NULL,
requestparams citext,
retrieveparamsfromreq boolean DEFAULT true NOT NULL,
dacindex integer DEFAULT 0 NOT NULL,
CONSTRAINT openviewincontentarea_1037409461_c CHECK ((length((requestparams)::text) <= 250)),
CONSTRAINT openviewincontentarea_1206680922_c CHECK ((length((parentviewname)::text) <= 250)),
CONSTRAINT openviewincontentarea_1810858993_c CHECK ((length((contentareaname)::text) <= 250))
);
CREATE TABLE public.operatingsystem (
ciid bigint NOT NULL
);
CREATE TABLE public.operationalhoursdef (
operationalhoursdefid bigint NOT NULL,
siteid bigint,
sitetype citext DEFAULT 'standard' NOT NULL,
starttime citext DEFAULT '09:00:00' NOT NULL,
endtime citext DEFAULT '18:00:00' NOT NULL,
break_starttime citext DEFAULT '00:00:00' NOT NULL,
break_endtime citext DEFAULT '00:00:00' NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT operationalhoursdef_1458791169_c CHECK ((length((sitetype)::text) <= 15)),
CONSTRAINT operationalhoursdef_459130200_c CHECK ((length((break_endtime)::text) <= 25)),
CONSTRAINT operationalhoursdef_658253327_c CHECK ((length((starttime)::text) <= 25)),
CONSTRAINT operationalhoursdef_780482223_c CHECK ((length((break_starttime)::text) <= 25)),
CONSTRAINT operationalhoursdef_888307192_c CHECK ((length((endtime)::text) <= 25))
);
CREATE TABLE public.operationauditrecord (
auditid bigint NOT NULL,
hostname citext NOT NULL,
resourcename citext NOT NULL,
operationname citext NOT NULL,
starttime bigint,
completiontime bigint NOT NULL,
result citext NOT NULL,
severity citext,
CONSTRAINT operationauditrecord_1085973422_c CHECK ((length((operationname)::text) <= 50)),
CONSTRAINT operationauditrecord_1881097187_c CHECK ((length((result)::text) <= 50)),
CONSTRAINT operationauditrecord_1933668249_c CHECK ((length((resourcename)::text) <= 50)),
CONSTRAINT operationauditrecord_2034040067_c CHECK ((length((severity)::text) <= 25)),
CONSTRAINT operationauditrecord_482823219_c CHECK ((length((hostname)::text) <= 50))
);
CREATE TABLE public.operationparams (
expression_id bigint NOT NULL,
lvalue citext,
lvalue_type integer NOT NULL,
rvalue citext,
rvalue_type integer NOT NULL,
CONSTRAINT operationparams_1865941953_c CHECK ((length((rvalue)::text) <= 255)),
CONSTRAINT operationparams_2037716859_c CHECK ((length((lvalue)::text) <= 255))
);
CREATE TABLE public.optoodcoreconfig (
id bigint NOT NULL,
cloud_portal_name citext,
cloud_dc_name citext,
max_zip_size bigint NOT NULL,
max_zip_count bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
is_trial boolean DEFAULT false NOT NULL,
start_time bigint,
from_date bigint,
to_date bigint,
user_id bigint,
credential_id bytea,
migration_status integer DEFAULT 0 NOT NULL,
CONSTRAINT optoodcoreconfig_1984651092_c CHECK ((length((cloud_portal_name)::text) <= 100)),
CONSTRAINT optoodcoreconfig_932594209_c CHECK ((length((cloud_dc_name)::text) <= 50))
);
CREATE TABLE public.optoodentitydetails (
entity_id bigint NOT NULL,
entity_name citext NOT NULL,
displayname citext NOT NULL,
isadminentity boolean DEFAULT false NOT NULL,
total_count bigint,
processed_count bigint,
import_failed_count bigint,
last_processed_id bigint,
start_time bigint,
end_time bigint,
status integer NOT NULL,
primarykeydefinition citext,
apiframework citext,
orderid bigint NOT NULL,
od_release_status integer DEFAULT 1 NOT NULL,
opt_migration integer DEFAULT 1 NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT optoodentitydetails_1082276304_c CHECK ((length((primarykeydefinition)::text) <= 100)),
CONSTRAINT optoodentitydetails_349561564_c CHECK ((length((apiframework)::text) <= 2)),
CONSTRAINT optoodentitydetails_426904019_c CHECK ((length((displayname)::text) <= 100)),
CONSTRAINT optoodentitydetails_830944921_c CHECK ((length((entity_name)::text) <= 100))
);
CREATE TABLE public.optoodsubentitydetails (
subentity_id bigint NOT NULL,
entity_name citext NOT NULL,
subentity_name citext NOT NULL,
primarykeydefinition citext,
foreignkeydefinition citext,
apiframework citext,
orderid bigint NOT NULL,
od_release_status integer DEFAULT 1 NOT NULL,
CONSTRAINT optoodsubentitydetails_1082276304_c CHECK ((length((primarykeydefinition)::text) <= 100)),
CONSTRAINT optoodsubentitydetails_349561564_c CHECK ((length((apiframework)::text) <= 2)),
CONSTRAINT optoodsubentitydetails_697825438_c CHECK ((length((foreignkeydefinition)::text) <= 100)),
CONSTRAINT optoodsubentitydetails_830944921_c CHECK ((length((entity_name)::text) <= 100)),
CONSTRAINT optoodsubentitydetails_917435207_c CHECK ((length((subentity_name)::text) <= 100))
);
CREATE TABLE public.optoodzipdetails (
zip_id bigint NOT NULL,
zip_name citext NOT NULL,
created_time bigint NOT NULL,
sent_time bigint,
completed_time bigint,
ack_id bigint,
status integer NOT NULL,
entity_id bigint NOT NULL,
entity_count bigint NOT NULL,
orderid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT optoodzipdetails_682854665_c CHECK ((length((zip_name)::text) <= 100))
);
CREATE TABLE public.oracle (
ciid bigint NOT NULL
);
CREATE TABLE public.organizationdefaultportal (
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.organizationlicenses (
resourceid bigint NOT NULL
);
CREATE TABLE public.organizationroletousermapping (
mappingid bigint NOT NULL,
orgroleid bigint NOT NULL,
userid bigint NOT NULL,
helpdeskid bigint
);
CREATE TABLE public.orgroles (
orgroleid bigint NOT NULL,
orgrolename citext NOT NULL,
associatedentity citext NOT NULL,
description citext,
helpdeskid bigint,
CONSTRAINT orgroles_1877077701_c CHECK ((length((orgrolename)::text) <= 50)),
CONSTRAINT orgroles_362988439_c CHECK ((length((associatedentity)::text) <= 50)),
CONSTRAINT orgroles_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.oshotfixinfo (
hotfixid bigint NOT NULL,
workstationid bigint NOT NULL,
hotfixname citext DEFAULT '-' NOT NULL,
description citext DEFAULT '-' NOT NULL,
installedby citext DEFAULT '-' NOT NULL,
installeddate bigint,
type citext DEFAULT '-' NOT NULL,
CONSTRAINT oshotfixinfo_2023729_c CHECK ((length((installedby)::text) <= 100)),
CONSTRAINT oshotfixinfo_2077537485_c CHECK ((length((hotfixname)::text) <= 100)),
CONSTRAINT oshotfixinfo_2590522_c CHECK ((length((type)::text) <= 50)),
CONSTRAINT oshotfixinfo_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.osinfo (
workstationid bigint NOT NULL,
osname citext,
version citext,
buildnumber citext,
servicepack citext,
productid citext,
systemtype citext,
CONSTRAINT osinfo_1069590712_c CHECK ((length((version)::text) <= 50)),
CONSTRAINT osinfo_1128938985_c CHECK ((length((systemtype)::text) <= 50)),
CONSTRAINT osinfo_1734765098_c CHECK ((length((productid)::text) <= 50)),
CONSTRAINT osinfo_1954223505_c CHECK ((length((osname)::text) <= 100)),
CONSTRAINT osinfo_225401390_c CHECK ((length((servicepack)::text) <= 50)),
CONSTRAINT osinfo_885598999_c CHECK ((length((buildnumber)::text) <= 50))
);
CREATE TABLE public.ostype (
ostypeid bigint NOT NULL,
ostype citext NOT NULL,
pattern citext NOT NULL,
usage_order bigint NOT NULL,
icon citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT ostype_1954021602_c CHECK ((length((ostype)::text) <= 250)),
CONSTRAINT ostype_2241657_c CHECK ((length((icon)::text) <= 250)),
CONSTRAINT ostype_73107600_c CHECK ((length((pattern)::text) <= 250))
);
CREATE TABLE public.otherapp_sccmconfigmap (
mappingid bigint NOT NULL,
sccmid bigint
);
CREATE TABLE public.outgoingewsserver (
id bigint NOT NULL,
serverurl citext NOT NULL,
username citext NOT NULL,
userpwd bytea NOT NULL,
fromemailid citext NOT NULL,
sendername citext,
authtypeid bigint NOT NULL,
oauthcredentialid bigint,
isenabled boolean DEFAULT false NOT NULL,
proxyid bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT outgoingewsserver_1089385811_c CHECK ((length((fromemailid)::text) <= 250)),
CONSTRAINT outgoingewsserver_1483431488_c CHECK ((length((sendername)::text) <= 250)),
CONSTRAINT outgoingewsserver_1705788628_c CHECK ((length((serverurl)::text) <= 250)),
CONSTRAINT outgoingewsserver_516913366_c CHECK ((length((username)::text) <= 100))
);
CREATE TABLE public.outgoingmailaliases (
serverid bigint NOT NULL,
fromemailid citext NOT NULL,
sendername citext,
modulename citext DEFAULT 'NONE',
CONSTRAINT outgoingmailaliases_1089385811_c CHECK ((length((fromemailid)::text) <= 250)),
CONSTRAINT outgoingmailaliases_1483431488_c CHECK ((length((sendername)::text) <= 250)),
CONSTRAINT outgoingmailaliases_384305417_c CHECK ((length((modulename)::text) <= 250))
);
CREATE TABLE public.outgoingmailserver (
serverid bigint NOT NULL,
hostname citext NOT NULL,
alternatehostname citext,
portid bigint NOT NULL,
authtypeid bigint NOT NULL,
oauthcredentialid bigint,
isenabled boolean DEFAULT false NOT NULL,
proxyid bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT outgoingmailserver_1766743411_c CHECK ((length((alternatehostname)::text) <= 100)),
CONSTRAINT outgoingmailserver_482823219_c CHECK ((length((hostname)::text) <= 100))
);
CREATE TABLE public.overviewdata (
record_id bigint NOT NULL,
technician_email citext NOT NULL,
form_message citext,
addons_list citext,
submission_time bigint NOT NULL,
posted_flag boolean DEFAULT false NOT NULL,
CONSTRAINT overviewdata_1772564255_c CHECK ((length((technician_email)::text) <= 250)),
CONSTRAINT overviewdata_712494228_c CHECK ((length((form_message)::text) <= 500)),
CONSTRAINT overviewdata_748392662_c CHECK ((length((addons_list)::text) <= 500))
);
CREATE TABLE public.parserconf (
parserconfid bigint NOT NULL,
parser citext,
expression citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT parserconf_1310359912_c CHECK ((length((expression)::text) <= 250)),
CONSTRAINT parserconf_1942081505_c CHECK ((length((parser)::text) <= 100))
);
CREATE TABLE public.passwordinfo (
passwordid bigint NOT NULL,
domainpassword bytea NOT NULL
);
CREATE TABLE public.passwordresetlink (
id bigint NOT NULL,
userid bigint NOT NULL,
uuid bytea NOT NULL,
createdtime bigint NOT NULL
);
CREATE TABLE public.paymentdetails (
paymentdetailsid bigint NOT NULL,
paymentdate bigint,
comments citext,
purchaseorderid bigint NOT NULL,
amountpaid double DEFAULT '0',
popaymentnotifyid bigint,
exchangerate double DEFAULT '0'
);
CREATE TABLE public.pdfuicomponent (
name bigint NOT NULL,
viewclass citext,
viewcontroller citext,
CONSTRAINT pdfuicomponent_1217027539_c CHECK ((length((viewclass)::text) <= 250)),
CONSTRAINT pdfuicomponent_748603391_c CHECK ((length((viewcontroller)::text) <= 250))
);
CREATE TABLE public.pdfviewconfig (
viewname bigint NOT NULL,
viewclass citext,
viewcontroller citext,
CONSTRAINT pdfviewconfig_1217027539_c CHECK ((length((viewclass)::text) <= 250)),
CONSTRAINT pdfviewconfig_748603391_c CHECK ((length((viewcontroller)::text) <= 250))
);
CREATE TABLE public.pendingindexrecords (
recordid bigint NOT NULL,
moduleid bigint NOT NULL,
pkcolumnvalue bigint NOT NULL,
operationid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.pendingstaticdatarecords (
id bigint NOT NULL,
impactmoduleid bigint NOT NULL,
alias_name citext NOT NULL,
pre_value citext NOT NULL,
new_value citext NOT NULL,
refertoalias1 citext,
refertovalue1 citext,
refertoalias2 citext,
refertovalue2 citext,
operationtime bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT pendingstaticdatarecords_1415386310_c CHECK ((length((alias_name)::text) <= 100)),
CONSTRAINT pendingstaticdatarecords_1631895196_c CHECK ((length((refertoalias1)::text) <= 100)),
CONSTRAINT pendingstaticdatarecords_1631895197_c CHECK ((length((refertoalias2)::text) <= 100)),
CONSTRAINT pendingstaticdatarecords_2071460715_c CHECK ((length((pre_value)::text) <= 200)),
CONSTRAINT pendingstaticdatarecords_2071910500_c CHECK ((length((refertovalue2)::text) <= 100)),
CONSTRAINT pendingstaticdatarecords_2071910501_c CHECK ((length((refertovalue1)::text) <= 100)),
CONSTRAINT pendingstaticdatarecords_843052590_c CHECK ((length((new_value)::text) <= 200))
);
CREATE TABLE public.pendinguploadrecords (
recordid bigint NOT NULL,
moduleid bigint NOT NULL,
pkcolumnvalue bigint NOT NULL,
operationid bigint NOT NULL,
operationtime bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.people (
ciid bigint NOT NULL
);
CREATE TABLE public.people_server (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.people_workstation (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.periodic (
schedule_id bigint NOT NULL,
start_date timestamp without time zone,
end_date timestamp without time zone,
time_period bigint DEFAULT '5' NOT NULL,
unit_of_time citext DEFAULT 'minutes' NOT NULL,
execute_immediately boolean DEFAULT false NOT NULL,
CONSTRAINT periodic_1753138054_c CHECK ((length((unit_of_time)::text) <= 20))
);
CREATE TABLE public.personalityconfiguration (
personalityid bigint NOT NULL,
personalityname citext NOT NULL,
dominanttableid bigint NOT NULL,
modulename citext NOT NULL,
description citext,
CONSTRAINT personalityconfiguration_1629419993_c CHECK ((length((personalityname)::text) <= 50)),
CONSTRAINT personalityconfiguration_384305417_c CHECK ((length((modulename)::text) <= 50)),
CONSTRAINT personalityconfiguration_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.personalizedviewmap (
origviewname bigint NOT NULL,
account_id bigint NOT NULL,
persviewname bigint NOT NULL
);
CREATE TABLE public.physicaldriveinfo (
physicaldriveid bigint NOT NULL,
workstationid bigint NOT NULL,
drivename citext DEFAULT '-' NOT NULL,
description citext DEFAULT '-' NOT NULL,
manufacturer citext DEFAULT '-' NOT NULL,
driverversion citext DEFAULT '-' NOT NULL,
driverdate citext DEFAULT '-' NOT NULL,
driverprovider citext DEFAULT '-' NOT NULL,
CONSTRAINT physicaldriveinfo_1079844822_c CHECK ((length((driverdate)::text) <= 30)),
CONSTRAINT physicaldriveinfo_1420185333_c CHECK ((length((drivename)::text) <= 100)),
CONSTRAINT physicaldriveinfo_347933649_c CHECK ((length((manufacturer)::text) <= 100)),
CONSTRAINT physicaldriveinfo_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT physicaldriveinfo_455157223_c CHECK ((length((driverprovider)::text) <= 100)),
CONSTRAINT physicaldriveinfo_739598448_c CHECK ((length((driverversion)::text) <= 50))
);
CREATE TABLE public.picklistvalues (
picklistid bigint NOT NULL,
attributeid bigint NOT NULL,
value citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT picklistvalues_81434961_c CHECK ((length((value)::text) <= 200))
);
CREATE TABLE public.piechartproperties (
reportid bigint NOT NULL,
first_group_columnid bigint NOT NULL,
second_group_columnid bigint NOT NULL,
format_id bigint NOT NULL,
summary_type citext NOT NULL,
CONSTRAINT piechartproperties_262057901_c CHECK ((length((summary_type)::text) <= 100))
);
CREATE TABLE public.piiredactconfig (
viewname bigint NOT NULL,
columnalias citext NOT NULL,
redact_type citext DEFAULT 'MASK' NOT NULL,
CONSTRAINT piiredactconfig_1201572264_c CHECK ((length((redact_type)::text) <= 50)),
CONSTRAINT piiredactconfig_1319828634_c CHECK ((length((columnalias)::text) <= 50))
);
CREATE TABLE public.pkdefinition (
pk_column_id bigint NOT NULL,
pk_id bigint NOT NULL,
"position" integer NOT NULL
);
CREATE TABLE public.placeholders (
placeholderid bigint NOT NULL,
name citext NOT NULL,
display_name citext NOT NULL,
module citext NOT NULL,
CONSTRAINT placeholders_2015454612_c CHECK ((length((module)::text) <= 30)),
CONSTRAINT placeholders_2388619_c CHECK ((length((name)::text) <= 30)),
CONSTRAINT placeholders_333046776_c CHECK ((length((display_name)::text) <= 100))
);
CREATE TABLE public.pmtasktoworkorder (
workorderid bigint NOT NULL,
sworkorderid bigint NOT NULL
);
CREATE TABLE public.poapproverdetails (
approverid bigint NOT NULL,
approver bigint NOT NULL,
ceilinglimit double DEFAULT '-1' NOT NULL,
ccid bigint,
approverstatus boolean DEFAULT true NOT NULL,
description citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT poapproverdetails_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.poconflictws (
poconflictid bigint NOT NULL,
purchaseorderid bigint NOT NULL,
receivedwsid bigint NOT NULL,
scannedwsid bigint NOT NULL
);
CREATE TABLE public.pohistory (
historyid bigint NOT NULL,
purchaseorderid bigint NOT NULL,
operationownerid bigint NOT NULL,
operationtime bigint NOT NULL,
notificationid bigint,
comments citext,
operation citext,
CONSTRAINT pohistory_154330439_c CHECK ((length((operation)::text) <= 50)),
CONSTRAINT pohistory_180211188_c CHECK ((length((comments)::text) <= 3500))
);
CREATE TABLE public.pohistorydiff (
historydiffid bigint NOT NULL,
historyid bigint NOT NULL,
relativecolumn citext,
relativecolumn_value citext,
columnname citext NOT NULL,
prev_value citext,
current_value citext,
operation citext DEFAULT 'CREATE',
CONSTRAINT pohistorydiff_154330439_c CHECK ((length((operation)::text) <= 50)),
CONSTRAINT pohistorydiff_1619616031_c CHECK ((length((columnname)::text) <= 50)),
CONSTRAINT pohistorydiff_18643980_c CHECK ((length((relativecolumn_value)::text) <= 250)),
CONSTRAINT pohistorydiff_951359198_c CHECK ((length((relativecolumn)::text) <= 50))
);
CREATE TABLE public.popaymentnotification (
popaymentnotifyid bigint NOT NULL,
purchaseorderid bigint NOT NULL,
amountdue double DEFAULT '0',
isescalated boolean DEFAULT false NOT NULL,
escalatebefore bigint,
paymentduedate bigint,
escalatetoid bigint,
operationownerid bigint NOT NULL
);
CREATE TABLE public.portaldepartments (
id bigint NOT NULL,
deptid bigint NOT NULL,
ciid bigint,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.portaltechnicians (
id bigint NOT NULL,
userid bigint NOT NULL,
isdclogin boolean DEFAULT false NOT NULL,
ismdmplogin boolean DEFAULT false NOT NULL,
allowedtoviewcost boolean DEFAULT false NOT NULL
);
CREATE TABLE public.portaluserassociation (
id bigint NOT NULL,
criteriaid bigint NOT NULL,
userid bigint NOT NULL
);
CREATE TABLE public.portalusers (
id bigint NOT NULL,
userid bigint NOT NULL,
status citext DEFAULT 'ACTIVE',
ciid bigint,
costperhour double DEFAULT '0' NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT portalusers_1839152142_c CHECK ((length((status)::text) <= 50))
);
CREATE TABLE public.portinfo (
portid bigint NOT NULL,
workstationid bigint NOT NULL,
portname citext NOT NULL,
portstatus citext DEFAULT '-' NOT NULL,
CONSTRAINT portinfo_1277046707_c CHECK ((length((portstatus)::text) <= 25)),
CONSTRAINT portinfo_1511774860_c CHECK ((length((portname)::text) <= 100))
);
CREATE TABLE public.postatus (
statusid bigint NOT NULL,
statusname citext NOT NULL,
ispending boolean DEFAULT true NOT NULL,
statusdescription citext,
CONSTRAINT postatus_502347606_c CHECK ((length((statusdescription)::text) <= 250)),
CONSTRAINT postatus_733867389_c CHECK ((length((statusname)::text) <= 100))
);
CREATE TABLE public.postatusnotification (
ponotificationid bigint NOT NULL,
statusid bigint NOT NULL,
notificationcontentid bigint NOT NULL,
mailids citext,
CONSTRAINT postatusnotification_1548955009_c CHECK ((length((mailids)::text) <= 1000))
);
CREATE TABLE public.povendorcurrency (
purchaseorderid bigint NOT NULL,
currencyid bigint NOT NULL,
exchangerate double DEFAULT '0' NOT NULL,
salestax double DEFAULT '0' NOT NULL,
priceadjust double DEFAULT '0' NOT NULL,
shippingprice double DEFAULT '0' NOT NULL,
additionaltax double DEFAULT '0' NOT NULL,
discount double DEFAULT '0' NOT NULL,
totalprice double DEFAULT '0' NOT NULL,
udf_cost1 double DEFAULT '0' NOT NULL,
udf_cost2 double DEFAULT '0' NOT NULL,
udf_cost3 double DEFAULT '0' NOT NULL,
udf_cost4 double DEFAULT '0' NOT NULL
);
CREATE TABLE public.pr_approvallevel (
id bigint NOT NULL,
entityid bigint NOT NULL,
levelid bigint NOT NULL
);
CREATE TABLE public.prattachment (
uid bigint NOT NULL,
attachmentid bigint NOT NULL,
requestid bigint NOT NULL
);
CREATE TABLE public.prhistory (
historyid bigint NOT NULL,
requestid bigint NOT NULL,
operationownerid bigint NOT NULL,
operationtime bigint NOT NULL,
notificationid bigint,
comments citext,
operation citext,
CONSTRAINT prhistory_154330439_c CHECK ((length((operation)::text) <= 50)),
CONSTRAINT prhistory_180211188_c CHECK ((length((comments)::text) <= 3500))
);
CREATE TABLE public.prhistorydiff (
historydiffid bigint NOT NULL,
historyid bigint NOT NULL,
relativecolumn citext,
relativecolumn_value citext,
columnname citext NOT NULL,
prev_value citext,
current_value citext,
operation citext DEFAULT 'C',
CONSTRAINT prhistorydiff_1088349253_c CHECK ((length((prev_value)::text) <= 3500)),
CONSTRAINT prhistorydiff_154330439_c CHECK ((length((operation)::text) <= 50)),
CONSTRAINT prhistorydiff_1619616031_c CHECK ((length((columnname)::text) <= 50)),
CONSTRAINT prhistorydiff_18643980_c CHECK ((length((relativecolumn_value)::text) <= 250)),
CONSTRAINT prhistorydiff_1969348885_c CHECK ((length((current_value)::text) <= 3500)),
CONSTRAINT prhistorydiff_951359198_c CHECK ((length((relativecolumn)::text) <= 50))
);
CREATE TABLE public.printerci (
ciid bigint NOT NULL,
serialnumber citext,
CONSTRAINT printerci_977765827_c CHECK ((length((serialnumber)::text) <= 100))
);
CREATE TABLE public.printerconstants (
printerconstantsid bigint NOT NULL,
parameter citext NOT NULL,
id citext NOT NULL,
value citext NOT NULL,
CONSTRAINT printerconstants_2331_c CHECK ((length((id)::text) <= 30)),
CONSTRAINT printerconstants_446088073_c CHECK ((length((parameter)::text) <= 30)),
CONSTRAINT printerconstants_81434961_c CHECK ((length((value)::text) <= 50))
);
CREATE TABLE public.printerinfo (
printerid bigint NOT NULL,
workstationid bigint NOT NULL,
printername citext DEFAULT '-' NOT NULL,
servername citext DEFAULT '-' NOT NULL,
printertype citext DEFAULT '-' NOT NULL,
isdefaultprinter citext DEFAULT 'False' NOT NULL,
printermodel citext DEFAULT '-',
printerlocation citext DEFAULT '-',
CONSTRAINT printerinfo_1340064690_c CHECK ((length((servername)::text) <= 100)),
CONSTRAINT printerinfo_1714402897_c CHECK ((length((printerlocation)::text) <= 100)),
CONSTRAINT printerinfo_1961734604_c CHECK ((length((printertype)::text) <= 25)),
CONSTRAINT printerinfo_1961936507_c CHECK ((length((printername)::text) <= 100)),
CONSTRAINT printerinfo_197512605_c CHECK ((length((isdefaultprinter)::text) <= 5)),
CONSTRAINT printerinfo_691004593_c CHECK ((length((printermodel)::text) <= 100))
);
CREATE TABLE public.printerinputsubunits (
ciid bigint NOT NULL,
inputindex citext NOT NULL,
inputname citext,
inputtype citext,
inputvendorname citext,
inputcapacity citext,
inputcurrentlevel citext,
CONSTRAINT printerinputsubunits_1451918595_c CHECK ((length((inputvendorname)::text) <= 100)),
CONSTRAINT printerinputsubunits_1880820552_c CHECK ((length((inputindex)::text) <= 100)),
CONSTRAINT printerinputsubunits_199355701_c CHECK ((length((inputname)::text) <= 100)),
CONSTRAINT printerinputsubunits_199557604_c CHECK ((length((inputtype)::text) <= 100)),
CONSTRAINT printerinputsubunits_210601387_c CHECK ((length((inputcurrentlevel)::text) <= 100)),
CONSTRAINT printerinputsubunits_798549404_c CHECK ((length((inputcapacity)::text) <= 100))
);
CREATE TABLE public.printermarkersubunits (
ciid bigint NOT NULL,
markerindex citext NOT NULL,
markertech citext,
markerlifecount citext,
CONSTRAINT printermarkersubunits_1601443280_c CHECK ((length((markertech)::text) <= 100)),
CONSTRAINT printermarkersubunits_1904755528_c CHECK ((length((markerindex)::text) <= 100)),
CONSTRAINT printermarkersubunits_57948039_c CHECK ((length((markerlifecount)::text) <= 100))
);
CREATE TABLE public.printermarkersuppsubunits (
ciid bigint NOT NULL,
markersuppindex citext NOT NULL,
markersupptype citext,
markersuppdesc citext,
markersuppmaxcapacity bigint,
markersupplevel bigint,
markersuppsupplyunit citext,
CONSTRAINT printermarkersuppsubunits_1239517098_c CHECK ((length((markersupptype)::text) <= 100)),
CONSTRAINT printermarkersuppsubunits_1240012883_c CHECK ((length((markersuppdesc)::text) <= 100)),
CONSTRAINT printermarkersuppsubunits_1610877711_c CHECK ((length((markersuppsupplyunit)::text) <= 100)),
CONSTRAINT printermarkersuppsubunits_219177750_c CHECK ((length((markersuppindex)::text) <= 100))
);
CREATE TABLE public.printermemory (
ciid bigint NOT NULL,
type citext,
capacity bigint,
CONSTRAINT printermemory_2590522_c CHECK ((length((type)::text) <= 100))
);
CREATE TABLE public.printeroutputsubunits (
ciid bigint NOT NULL,
outputindex citext NOT NULL,
outputname citext,
outputtype citext,
outputvendorname citext,
outputcapacity citext,
outputcurrentlevel citext,
CONSTRAINT printeroutputsubunits_1337597009_c CHECK ((length((outputindex)::text) <= 100)),
CONSTRAINT printeroutputsubunits_1378296532_c CHECK ((length((outputcurrentlevel)::text) <= 100)),
CONSTRAINT printeroutputsubunits_534347589_c CHECK ((length((outputcapacity)::text) <= 100)),
CONSTRAINT printeroutputsubunits_787797061_c CHECK ((length((outputtype)::text) <= 100)),
CONSTRAINT printeroutputsubunits_787998964_c CHECK ((length((outputname)::text) <= 100)),
CONSTRAINT printeroutputsubunits_957044844_c CHECK ((length((outputvendorname)::text) <= 100))
);
CREATE TABLE public.prioritydefinition (
priorityid bigint NOT NULL,
priorityname citext NOT NULL,
prioritycolor citext,
priorityorder bigint NOT NULL,
prioritydescription citext,
isdeleted boolean DEFAULT false,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT prioritydefinition_1929210415_c CHECK ((length((priorityname)::text) <= 100)),
CONSTRAINT prioritydefinition_305987512_c CHECK ((length((prioritydescription)::text) <= 250)),
CONSTRAINT prioritydefinition_333761505_c CHECK ((length((prioritycolor)::text) <= 100))
);
CREATE TABLE public.prioritymatrix (
pmid bigint NOT NULL,
impactid bigint NOT NULL,
urgencyid bigint NOT NULL,
priorityid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.privacyglobalconfig (
privacyglobalconfigid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
category citext NOT NULL,
parameter citext NOT NULL,
paramvalue citext NOT NULL,
description citext,
password_value bytea,
CONSTRAINT privacyglobalconfig_428414940_c CHECK ((length((description)::text) <= 200)),
CONSTRAINT privacyglobalconfig_446088073_c CHECK ((length((parameter)::text) <= 100)),
CONSTRAINT privacyglobalconfig_833137918_c CHECK ((length((category)::text) <= 100)),
CONSTRAINT privacyglobalconfig_958969092_c CHECK ((length((paramvalue)::text) <= 500))
);
CREATE TABLE public.problem (
problemid bigint NOT NULL,
originatorid bigint,
ownerid bigint,
statusid bigint,
priorityid bigint,
categoryid bigint,
subcategoryid bigint,
itemid bigint,
urgencyid bigint,
title citext NOT NULL,
description citext,
reportedtime bigint NOT NULL,
updatedtime bigint DEFAULT '0' NOT NULL,
duebytime bigint DEFAULT '0' NOT NULL,
closedtime bigint DEFAULT '0' NOT NULL,
isread boolean DEFAULT false NOT NULL,
notespresent boolean DEFAULT false NOT NULL,
siteid bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT problem_428414940_c CHECK ((length((description)::text) <= 500)),
CONSTRAINT problem_79833656_c CHECK ((length((title)::text) <= 250))
);
CREATE TABLE public.problem_fields (
problemid bigint NOT NULL,
udf_long1 bigint,
udf_long2 bigint,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
udf_char5 citext,
udf_char6 citext,
udf_date1 bigint,
udf_date2 bigint,
udf_long3 bigint,
udf_long4 bigint,
udf_char7 citext,
udf_char8 citext,
udf_char9 citext,
udf_char10 citext,
udf_char11 citext,
udf_char12 citext,
udf_date3 bigint,
udf_date4 bigint,
CONSTRAINT problem_fields_278184709_c CHECK ((length((udf_char9)::text) <= 3500)),
CONSTRAINT problem_fields_278184710_c CHECK ((length((udf_char8)::text) <= 3500)),
CONSTRAINT problem_fields_278184711_c CHECK ((length((udf_char7)::text) <= 3500)),
CONSTRAINT problem_fields_278184712_c CHECK ((length((udf_char6)::text) <= 3500)),
CONSTRAINT problem_fields_278184713_c CHECK ((length((udf_char5)::text) <= 3500)),
CONSTRAINT problem_fields_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT problem_fields_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT problem_fields_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT problem_fields_278184717_c CHECK ((length((udf_char1)::text) <= 3500)),
CONSTRAINT problem_fields_33791585_c CHECK ((length((udf_char12)::text) <= 3500)),
CONSTRAINT problem_fields_33791586_c CHECK ((length((udf_char11)::text) <= 3500)),
CONSTRAINT problem_fields_33791587_c CHECK ((length((udf_char10)::text) <= 3500))
);
CREATE TABLE public.problemfileattachment (
attachmentid bigint NOT NULL,
problemid bigint NOT NULL
);
CREATE TABLE public.problemhistory (
historyid bigint NOT NULL,
problemid bigint NOT NULL,
operationownerid bigint NOT NULL,
operationtime bigint NOT NULL,
description citext,
operation citext DEFAULT 'CREATE',
CONSTRAINT problemhistory_154330439_c CHECK ((length((operation)::text) <= 50))
);
CREATE TABLE public.problemhistorydiff (
historydiffid bigint NOT NULL,
historyid bigint NOT NULL,
columnname citext NOT NULL,
prev_value citext,
current_value citext,
CONSTRAINT problemhistorydiff_1619616031_c CHECK ((length((columnname)::text) <= 30))
);
CREATE TABLE public.problemimages (
problemid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.problemnotes (
notesid bigint NOT NULL,
userid bigint NOT NULL,
recordeddate bigint NOT NULL,
description citext NOT NULL,
hasattachment boolean DEFAULT false NOT NULL,
updatedby bigint,
updatedtime bigint,
ispublic boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.problemnotesattachment (
attachmentid bigint NOT NULL,
notesid bigint NOT NULL
);
CREATE TABLE public.problemresolution (
problemid bigint NOT NULL,
resolution_by bigint,
resolution_on bigint DEFAULT '0' NOT NULL,
resolution citext,
workaround citext,
workaround_by bigint,
workaround_on bigint DEFAULT '0' NOT NULL,
knownerror boolean DEFAULT false NOT NULL,
knownerror_by bigint,
knownerror_on bigint DEFAULT '0' NOT NULL,
knownerror_comments citext,
impactid bigint
);
CREATE TABLE public.problemri (
itemid bigint NOT NULL,
problemid bigint NOT NULL
);
CREATE TABLE public.problemtoasset (
problemid bigint NOT NULL,
assetid bigint NOT NULL
);
CREATE TABLE public.problemtochangemapping (
problemid bigint NOT NULL,
changeid bigint NOT NULL
);
CREATE TABLE public.problemtocharge (
problemid bigint NOT NULL,
chargeid bigint NOT NULL
);
CREATE TABLE public.problemtodescription (
problemid bigint NOT NULL,
full_description citext
);
CREATE TABLE public.problemtoincidentmapping (
problemid bigint NOT NULL,
workorderid bigint NOT NULL
);
CREATE TABLE public.problemtonotes (
problemid bigint NOT NULL,
notesid bigint NOT NULL
);
CREATE TABLE public.problemtoqueue (
problemid bigint NOT NULL,
queueid bigint NOT NULL,
assignedtime bigint
);
CREATE TABLE public.problemtoservice (
problemid bigint NOT NULL,
serviceid bigint NOT NULL
);
CREATE TABLE public.problemtotaskdetails (
problemid bigint NOT NULL,
taskid bigint NOT NULL
);
CREATE TABLE public.problemtotasktable (
problemid bigint NOT NULL,
taskid bigint NOT NULL
);
CREATE TABLE public.processorinfo (
processorid bigint NOT NULL,
workstationid bigint NOT NULL,
processorcount bigint DEFAULT '1' NOT NULL,
cpuname citext DEFAULT '-' NOT NULL,
speed double DEFAULT '0' NOT NULL,
vendor citext DEFAULT '-' NOT NULL,
cpumodel citext DEFAULT '-' NOT NULL,
cpustepping citext DEFAULT '-' NOT NULL,
cpufamily citext DEFAULT '-' NOT NULL,
cpuserialnumber citext DEFAULT '-' NOT NULL,
cpuvendorinfo citext DEFAULT '-' NOT NULL,
numberofcores bigint,
CONSTRAINT processorinfo_1297035905_c CHECK ((length((cpumodel)::text) <= 50)),
CONSTRAINT processorinfo_1340346092_c CHECK ((length((cpufamily)::text) <= 50)),
CONSTRAINT processorinfo_1704424467_c CHECK ((length((cpuname)::text) <= 100)),
CONSTRAINT processorinfo_1766745784_c CHECK ((length((vendor)::text) <= 50)),
CONSTRAINT processorinfo_1978413698_c CHECK ((length((cpuvendorinfo)::text) <= 100)),
CONSTRAINT processorinfo_224341958_c CHECK ((length((cpustepping)::text) <= 50)),
CONSTRAINT processorinfo_284521413_c CHECK ((length((cpuserialnumber)::text) <= 50))
);
CREATE TABLE public.producttypetosnmpmapping (
producttypetosnmpid bigint NOT NULL,
componenttypeid bigint NOT NULL,
tablename citext NOT NULL,
CONSTRAINT producttypetosnmpmapping_798830393_c CHECK ((length((tablename)::text) <= 100))
);
CREATE TABLE public.proj_operationalinfo (
projectid bigint NOT NULL,
starttime citext,
endtime citext,
is24x7 boolean DEFAULT false NOT NULL,
emp_hoursperday integer,
CONSTRAINT proj_operationalinfo_658253327_c CHECK ((length((starttime)::text) <= 25)),
CONSTRAINT proj_operationalinfo_888307192_c CHECK ((length((endtime)::text) <= 25))
);
CREATE TABLE public.proj_roletopermission (
roleid bigint NOT NULL,
permissionid bigint NOT NULL
);
CREATE TABLE public.project_fields (
projectid bigint NOT NULL
);
CREATE TABLE public.projectattachments (
attachmentid bigint NOT NULL,
projectid bigint NOT NULL
);
CREATE TABLE public.projectdescription (
projectid bigint NOT NULL,
description citext
);
CREATE TABLE public.projectdetails (
projectid bigint NOT NULL,
projectcode citext,
title citext NOT NULL,
projecttypeid bigint,
ownerid bigint,
priorityid bigint,
duration citext,
statusid bigint NOT NULL,
createdby bigint NOT NULL,
createdtime bigint NOT NULL,
scheduledstarttime bigint,
scheduledendtime bigint,
actualstarttime bigint,
actualendtime bigint,
projectedend bigint,
siteid bigint,
projecttemplateid bigint,
requestedby bigint,
departmentid bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT projectdetails_1209385580_c CHECK ((length((duration)::text) <= 50)),
CONSTRAINT projectdetails_1213552742_c CHECK ((length((projectcode)::text) <= 50)),
CONSTRAINT projectdetails_79833656_c CHECK ((length((title)::text) <= 250))
);
CREATE TABLE public.projectestimations (
projectid bigint NOT NULL,
inc_emp_cost boolean DEFAULT false,
inc_task_cost boolean DEFAULT false,
inc_worklog_cost boolean DEFAULT false,
estimatedhours bigint,
scheduledtaskhours bigint,
actualtaskhours bigint,
estimatedcost double DEFAULT '0',
basecost_perhour double DEFAULT '0',
tot_worklog_cost double DEFAULT '0',
tot_taskhours_cost double DEFAULT '0'
);
CREATE TABLE public.projecthistory (
historyid bigint NOT NULL,
operationownerid bigint NOT NULL,
operationtime bigint NOT NULL,
operation citext,
projectid bigint NOT NULL,
milestoneid bigint,
taskid bigint,
CONSTRAINT projecthistory_154330439_c CHECK ((length((operation)::text) <= 50))
);
CREATE TABLE public.projecthistorydiff (
historydiffid bigint NOT NULL,
historyid bigint NOT NULL,
columnname citext NOT NULL,
prev_value citext,
current_value citext,
CONSTRAINT projecthistorydiff_1619616031_c CHECK ((length((columnname)::text) <= 30))
);
CREATE TABLE public.projectimages (
projectid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.projectmembers (
memberid bigint NOT NULL,
projectid bigint NOT NULL,
userid bigint NOT NULL,
projectroleid bigint NOT NULL,
isactive boolean DEFAULT true NOT NULL
);
CREATE TABLE public.projectorci (
ciid bigint NOT NULL
);
CREATE TABLE public.projectpermission (
permissionid bigint NOT NULL,
permissionname citext NOT NULL,
description citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT projectpermission_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT projectpermission_676898010_c CHECK ((length((permissionname)::text) <= 50))
);
CREATE TABLE public.projectroles (
roleid bigint NOT NULL,
rolename citext NOT NULL,
description citext,
isdeleted boolean DEFAULT false,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT projectroles_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT projectroles_516800513_c CHECK ((length((rolename)::text) <= 50))
);
CREATE TABLE public.projectstatus (
statusid bigint NOT NULL,
statusname citext NOT NULL,
statusdescription citext,
isdeleted boolean DEFAULT false,
iscompleted boolean DEFAULT false,
internalname citext DEFAULT 'false' NOT NULL,
statuscolor citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT projectstatus_1265310353_c CHECK ((length((statuscolor)::text) <= 100)),
CONSTRAINT projectstatus_2056879416_c CHECK ((length((internalname)::text) <= 100)),
CONSTRAINT projectstatus_502347606_c CHECK ((length((statusdescription)::text) <= 250)),
CONSTRAINT projectstatus_733867389_c CHECK ((length((statusname)::text) <= 100))
);
CREATE TABLE public.projecttasktemplate (
templateid bigint NOT NULL,
mappingid bigint NOT NULL,
milestonetemplateid bigint,
projecttemplateid bigint NOT NULL,
taskindex bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.projecttemplate (
projecttemplateid bigint NOT NULL,
templatename citext NOT NULL,
title citext NOT NULL,
description citext,
comments citext,
statusid bigint,
createdby bigint NOT NULL,
priorityid bigint,
estimatedhours bigint,
siteid bigint,
projecttypeid bigint,
estimatedcost double DEFAULT '0',
createdtime bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT projecttemplate_1342071301_c CHECK ((length((templatename)::text) <= 100)),
CONSTRAINT projecttemplate_79833656_c CHECK ((length((title)::text) <= 250))
);
CREATE TABLE public.projecttemplate_fields (
projecttemplateid bigint NOT NULL
);
CREATE TABLE public.projecttemplateimages (
projecttemplateid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.projecttemplatemembers (
memberid bigint NOT NULL,
projecttemplateid bigint NOT NULL,
userid bigint NOT NULL,
projectroleid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.projecttocomment (
commentid bigint NOT NULL,
projectid bigint NOT NULL
);
CREATE TABLE public.projecttypedefinition (
projecttypeid bigint NOT NULL,
projecttypename citext NOT NULL,
projecttypecolor citext,
description citext,
isdeleted boolean DEFAULT false,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT projecttypedefinition_15230274_c CHECK ((length((projecttypename)::text) <= 50)),
CONSTRAINT projecttypedefinition_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT projecttypedefinition_481880720_c CHECK ((length((projecttypecolor)::text) <= 25))
);
CREATE TABLE public.protocols (
protocolid bigint NOT NULL,
protocolname citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT protocols_1815878365_c CHECK ((length((protocolname)::text) <= 250))
);
CREATE TABLE public.prpoassociation (
uid bigint NOT NULL,
requestid bigint NOT NULL,
purchaseorderid bigint NOT NULL
);
CREATE TABLE public.prpriority (
priorityid bigint NOT NULL,
name citext NOT NULL,
CONSTRAINT prpriority_2388619_c CHECK ((length((name)::text) <= 100))
);
CREATE TABLE public.prrequesteditems (
itemid bigint NOT NULL,
requestid bigint NOT NULL,
categoryid bigint,
componentid bigint,
serviceinfoid bigint,
itemname citext NOT NULL,
description citext,
quantity double DEFAULT '0' NOT NULL,
received double DEFAULT '0' NOT NULL,
estimated_cost double DEFAULT '0' NOT NULL,
componenttypeid bigint,
partno citext DEFAULT '-',
CONSTRAINT prrequesteditems_1942080268_c CHECK ((length((partno)::text) <= 100)),
CONSTRAINT prrequesteditems_1960911902_c CHECK ((length((itemname)::text) <= 150))
);
CREATE TABLE public.prsettings (
settingid bigint NOT NULL,
prid_start_from bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.prstatusnotification (
prnotificationid bigint NOT NULL,
statusid bigint NOT NULL,
notificationcontentid bigint NOT NULL,
mailids citext,
CONSTRAINT prstatusnotification_1548955009_c CHECK ((length((mailids)::text) <= 1000))
);
CREATE TABLE public.purchase_approvallevel (
id bigint NOT NULL,
entityid bigint NOT NULL,
levelid bigint NOT NULL
);
CREATE TABLE public.purchasecategory (
categoryid bigint NOT NULL,
categoryname citext NOT NULL,
categorydescription citext,
CONSTRAINT purchasecategory_1550684023_c CHECK ((length((categoryname)::text) <= 100)),
CONSTRAINT purchasecategory_868286434_c CHECK ((length((categorydescription)::text) <= 250))
);
CREATE TABLE public.purchaseccdepartment (
ccid bigint NOT NULL,
deptid bigint NOT NULL
);
CREATE TABLE public.purchaseconfigvalue (
purchaseconfigid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
custompoid bigint DEFAULT '1' NOT NULL,
terms citext,
remarks citext,
signauthority citext,
taxrate double DEFAULT '0',
taxshipping boolean DEFAULT false NOT NULL,
shipaddress bigint,
billaddress bigint,
costcenter bigint,
approverid citext,
currency citext,
canownerapprove boolean DEFAULT true NOT NULL,
ismultiapproval boolean DEFAULT false NOT NULL,
CONSTRAINT purchaseconfigvalue_1040016902_c CHECK ((length((signauthority)::text) <= 50)),
CONSTRAINT purchaseconfigvalue_1339081376_c CHECK ((length((approverid)::text) <= 250)),
CONSTRAINT purchaseconfigvalue_1358028817_c CHECK ((length((currency)::text) <= 25)),
CONSTRAINT purchaseconfigvalue_1809397971_c CHECK ((length((remarks)::text) <= 3500)),
CONSTRAINT purchaseconfigvalue_79712615_c CHECK ((length((terms)::text) <= 3500))
);
CREATE TABLE public.purchasecostcenter (
ccid bigint NOT NULL,
code citext NOT NULL,
name citext NOT NULL,
description citext,
ownerid bigint,
budgetamount double DEFAULT '0' NOT NULL,
status boolean DEFAULT true NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT purchasecostcenter_2074093_c CHECK ((length((code)::text) <= 250)),
CONSTRAINT purchasecostcenter_2388619_c CHECK ((length((name)::text) <= 250)),
CONSTRAINT purchasecostcenter_428414940_c CHECK ((length((description)::text) <= 3500))
);
CREATE TABLE public.purchaseglcodes (
glcodeid bigint NOT NULL,
glcode citext NOT NULL,
description citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT purchaseglcodes_2104931410_c CHECK ((length((glcode)::text) <= 250)),
CONSTRAINT purchaseglcodes_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.purchaselot (
purchaselotid bigint NOT NULL,
purchaseorderitemid bigint NOT NULL,
datereceived bigint NOT NULL,
quantityreceived double DEFAULT '0',
warrantyexpiry bigint DEFAULT '0' NOT NULL,
leaseexpiry bigint DEFAULT '0' NOT NULL
);
CREATE TABLE public.purchaselotext (
purchaselotextid bigint NOT NULL,
purchaselotid bigint NOT NULL,
purchaseorderitemid bigint NOT NULL,
datereceived bigint NOT NULL,
quantityreceived double DEFAULT '0'
);
CREATE TABLE public.purchaseorder (
purchaseorderid bigint NOT NULL,
requesterid bigint NOT NULL,
vendorid bigint NOT NULL,
statusid bigint NOT NULL,
dateordered bigint DEFAULT '0' NOT NULL,
daterequired bigint,
datereceived bigint DEFAULT '0' NOT NULL,
shippingprice double DEFAULT '0' NOT NULL,
salestax double DEFAULT '0' NOT NULL,
priceadjust double DEFAULT '0' NOT NULL,
totalprice double DEFAULT '0' NOT NULL,
paymentterms citext,
shippinginfo citext,
comments citext,
shipto citext,
billto citext,
ispurchase boolean DEFAULT false NOT NULL,
pocustomid citext NOT NULL,
poname citext NOT NULL,
includeshipping boolean DEFAULT false NOT NULL,
terms citext,
remarks citext,
glcode bigint,
costcenter bigint,
ownerid bigint,
salestaxpercent double DEFAULT '0',
additionaltax double DEFAULT '0' NOT NULL,
additionaltaxpercent double DEFAULT '0',
discount double DEFAULT '0' NOT NULL,
discountpercent double DEFAULT '0',
signauthority citext,
multiapproval_status boolean DEFAULT false NOT NULL,
isoverduenotified boolean DEFAULT false NOT NULL,
isapprovalenabled boolean DEFAULT true NOT NULL,
ordereddate bigint,
receiveddate bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT purchaseorder_1040016902_c CHECK ((length((signauthority)::text) <= 50)),
CONSTRAINT purchaseorder_1792609099_c CHECK ((length((pocustomid)::text) <= 50)),
CONSTRAINT purchaseorder_1839289153_c CHECK ((length((paymentterms)::text) <= 100)),
CONSTRAINT purchaseorder_1849999945_c CHECK ((length((shipto)::text) <= 250)),
CONSTRAINT purchaseorder_1919460188_c CHECK ((length((shippinginfo)::text) <= 100)),
CONSTRAINT purchaseorder_1929288438_c CHECK ((length((poname)::text) <= 100)),
CONSTRAINT purchaseorder_1959280834_c CHECK ((length((billto)::text) <= 250))
);
CREATE TABLE public.purchaseorder_fields (
purchaseorderid bigint NOT NULL,
udf_long1 bigint,
udf_long2 bigint,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
udf_char5 citext,
udf_char6 citext,
udf_date1 bigint,
udf_date2 bigint,
udf_long3 bigint,
udf_long4 bigint,
udf_char7 citext,
udf_char8 citext,
udf_char9 citext,
udf_char10 citext,
udf_char11 citext,
udf_char12 citext,
udf_date3 bigint,
udf_date4 bigint,
udf_cost1 double DEFAULT '0' NOT NULL,
udf_cost2 double DEFAULT '0' NOT NULL,
udf_cost3 double DEFAULT '0' NOT NULL,
udf_cost4 double DEFAULT '0' NOT NULL,
CONSTRAINT purchaseorder_fields_278184709_c CHECK ((length((udf_char9)::text) <= 3500)),
CONSTRAINT purchaseorder_fields_278184710_c CHECK ((length((udf_char8)::text) <= 3500)),
CONSTRAINT purchaseorder_fields_278184711_c CHECK ((length((udf_char7)::text) <= 3500)),
CONSTRAINT purchaseorder_fields_278184712_c CHECK ((length((udf_char6)::text) <= 3500)),
CONSTRAINT purchaseorder_fields_278184713_c CHECK ((length((udf_char5)::text) <= 3500)),
CONSTRAINT purchaseorder_fields_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT purchaseorder_fields_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT purchaseorder_fields_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT purchaseorder_fields_278184717_c CHECK ((length((udf_char1)::text) <= 3500)),
CONSTRAINT purchaseorder_fields_33791585_c CHECK ((length((udf_char12)::text) <= 3500)),
CONSTRAINT purchaseorder_fields_33791586_c CHECK ((length((udf_char11)::text) <= 3500)),
CONSTRAINT purchaseorder_fields_33791587_c CHECK ((length((udf_char10)::text) <= 3500))
);
CREATE TABLE public.purchaseorderattachment (
attachmentid bigint NOT NULL,
poid bigint NOT NULL
);
CREATE TABLE public.purchaseorderitem (
purchaseorderitemid bigint NOT NULL,
serialno bigint NOT NULL,
purchaseorderid bigint NOT NULL,
categoryid bigint NOT NULL,
itemname citext NOT NULL,
description citext,
componentid bigint,
serviceinfoid bigint,
componenttypeid bigint,
partno citext DEFAULT '-',
quantityordered double DEFAULT '0' NOT NULL,
price double DEFAULT '0' NOT NULL,
taxrate double DEFAULT '0' NOT NULL,
CONSTRAINT purchaseorderitem_1942080268_c CHECK ((length((partno)::text) <= 100)),
CONSTRAINT purchaseorderitem_1960911902_c CHECK ((length((itemname)::text) <= 150))
);
CREATE TABLE public.purchaseorderri (
itemid bigint NOT NULL,
purchaseorderid bigint NOT NULL
);
CREATE TABLE public.purchasequote_fields (
quoteid bigint NOT NULL,
udf_long1 bigint,
udf_long2 bigint,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
udf_char5 citext,
udf_char6 citext,
udf_date1 bigint,
udf_date2 bigint,
udf_long3 bigint,
udf_long4 bigint,
udf_char7 citext,
udf_char8 citext,
udf_char9 citext,
udf_char10 citext,
udf_char11 citext,
udf_char12 citext,
udf_date3 bigint,
udf_date4 bigint,
CONSTRAINT purchasequote_fields_278184709_c CHECK ((length((udf_char9)::text) <= 3500)),
CONSTRAINT purchasequote_fields_278184710_c CHECK ((length((udf_char8)::text) <= 3500)),
CONSTRAINT purchasequote_fields_278184711_c CHECK ((length((udf_char7)::text) <= 3500)),
CONSTRAINT purchasequote_fields_278184712_c CHECK ((length((udf_char6)::text) <= 3500)),
CONSTRAINT purchasequote_fields_278184713_c CHECK ((length((udf_char5)::text) <= 3500)),
CONSTRAINT purchasequote_fields_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT purchasequote_fields_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT purchasequote_fields_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT purchasequote_fields_278184717_c CHECK ((length((udf_char1)::text) <= 3500)),
CONSTRAINT purchasequote_fields_33791585_c CHECK ((length((udf_char12)::text) <= 3500)),
CONSTRAINT purchasequote_fields_33791586_c CHECK ((length((udf_char11)::text) <= 3500)),
CONSTRAINT purchasequote_fields_33791587_c CHECK ((length((udf_char10)::text) <= 3500))
);
CREATE TABLE public.purchasequotes (
quoteid bigint NOT NULL,
quotenumber citext NOT NULL,
quotedate bigint NOT NULL,
vendorid bigint NOT NULL,
statusid bigint NOT NULL,
purchasereqid bigint NOT NULL,
quotationtypeid bigint,
taxamount double DEFAULT '0' NOT NULL,
discount double DEFAULT '0' NOT NULL,
totalcost double DEFAULT '0' NOT NULL,
quotevalidity bigint,
comments citext,
terms citext,
shipping_date bigint,
createdby bigint NOT NULL,
createddate bigint NOT NULL,
purchaseorderid bigint,
is_marked_to_create_po boolean DEFAULT false NOT NULL,
CONSTRAINT purchasequotes_608575323_c CHECK ((length((quotenumber)::text) <= 100))
);
CREATE TABLE public.purchaserequest (
requestid bigint NOT NULL,
subject citext NOT NULL,
description citext,
requesteddate bigint,
daterequired bigint,
shipping_details citext,
comments citext,
createdby bigint NOT NULL,
requestedby bigint,
technicianid bigint,
costcenterid bigint,
vendorid bigint,
priorityid bigint,
siteid bigint,
statusid bigint NOT NULL,
typeid bigint,
createddate bigint NOT NULL,
isoverduenotified boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT purchaserequest_1149902580_c CHECK ((length((subject)::text) <= 250)),
CONSTRAINT purchaserequest_180211188_c CHECK ((length((comments)::text) <= 3500)),
CONSTRAINT purchaserequest_428414940_c CHECK ((length((description)::text) <= 3500)),
CONSTRAINT purchaserequest_679779183_c CHECK ((length((shipping_details)::text) <= 250))
);
CREATE TABLE public.purchaserequest_fields (
requestid bigint NOT NULL,
udf_long1 bigint,
udf_long2 bigint,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
udf_char5 citext,
udf_char6 citext,
udf_date1 bigint,
udf_date2 bigint,
udf_long3 bigint,
udf_long4 bigint,
udf_char7 citext,
udf_char8 citext,
udf_char9 citext,
udf_char10 citext,
udf_char11 citext,
udf_char12 citext,
udf_date3 bigint,
udf_date4 bigint,
CONSTRAINT purchaserequest_fields_278184709_c CHECK ((length((udf_char9)::text) <= 3500)),
CONSTRAINT purchaserequest_fields_278184710_c CHECK ((length((udf_char8)::text) <= 3500)),
CONSTRAINT purchaserequest_fields_278184711_c CHECK ((length((udf_char7)::text) <= 3500)),
CONSTRAINT purchaserequest_fields_278184712_c CHECK ((length((udf_char6)::text) <= 3500)),
CONSTRAINT purchaserequest_fields_278184713_c CHECK ((length((udf_char5)::text) <= 3500)),
CONSTRAINT purchaserequest_fields_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT purchaserequest_fields_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT purchaserequest_fields_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT purchaserequest_fields_278184717_c CHECK ((length((udf_char1)::text) <= 3500)),
CONSTRAINT purchaserequest_fields_33791585_c CHECK ((length((udf_char12)::text) <= 3500)),
CONSTRAINT purchaserequest_fields_33791586_c CHECK ((length((udf_char11)::text) <= 3500)),
CONSTRAINT purchaserequest_fields_33791587_c CHECK ((length((udf_char10)::text) <= 3500))
);
CREATE TABLE public.purchaserequestri (
requestid bigint NOT NULL,
itemid bigint NOT NULL
);
CREATE TABLE public.purchasetype (
typeid bigint NOT NULL,
name citext NOT NULL,
CONSTRAINT purchasetype_2388619_c CHECK ((length((name)::text) <= 100))
);
CREATE TABLE public.queryfiltercolumn (
column_id bigint NOT NULL,
name citext NOT NULL,
alias citext NOT NULL,
queryid bigint,
subqueryid bigint,
type_id bigint NOT NULL,
pickupquery citext,
CONSTRAINT queryfiltercolumn_1965240404_c CHECK ((length((pickupquery)::text) <= 300)),
CONSTRAINT queryfiltercolumn_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT queryfiltercolumn_62365232_c CHECK ((length((alias)::text) <= 100))
);
CREATE TABLE public.queryreport (
queryid bigint NOT NULL,
query citext NOT NULL,
paramcolumn bigint,
headercolumn bigint NOT NULL,
title citext NOT NULL,
icon_file citext,
CONSTRAINT queryreport_1425298818_c CHECK ((length((icon_file)::text) <= 100)),
CONSTRAINT queryreport_79833656_c CHECK ((length((title)::text) <= 100))
);
CREATE TABLE public.queryreport_datefilter (
reportid bigint NOT NULL,
column_id bigint NOT NULL,
time_choice bigint,
datefiltertype citext NOT NULL,
from_date bigint,
to_date bigint,
CONSTRAINT queryreport_datefilter_159158048_c CHECK ((length((datefiltertype)::text) <= 100))
);
CREATE TABLE public.queryreportmapping (
reportid bigint NOT NULL,
queryid bigint NOT NULL
);
CREATE TABLE public.question_component_options (
uid bigint NOT NULL,
questionid bigint NOT NULL,
productid bigint NOT NULL,
sortindex integer DEFAULT 0 NOT NULL
);
CREATE TABLE public.question_options (
uid bigint NOT NULL,
questionid bigint NOT NULL,
options citext,
description citext,
sortindex integer DEFAULT 0 NOT NULL,
optionscost double DEFAULT '0',
images citext,
CONSTRAINT question_options_531492226_c CHECK ((length((options)::text) <= 250))
);
CREATE TABLE public.question_software_options (
uid bigint NOT NULL,
questionid bigint NOT NULL,
softwareid bigint NOT NULL,
sortindex integer DEFAULT 0 NOT NULL
);
CREATE TABLE public.questions (
questionid bigint NOT NULL,
question citext NOT NULL,
fieldname citext NOT NULL,
type citext NOT NULL,
isdeleted boolean DEFAULT false NOT NULL,
category citext,
referenced bigint DEFAULT '0' NOT NULL,
is_cost_enabled boolean DEFAULT false NOT NULL,
has_images boolean DEFAULT false NOT NULL,
is_pii boolean DEFAULT false NOT NULL,
to_delete boolean DEFAULT false NOT NULL,
is_encrypted boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT questions_242409883_c CHECK ((length((fieldname)::text) <= 50)),
CONSTRAINT questions_2590522_c CHECK ((length((type)::text) <= 50)),
CONSTRAINT questions_383243290_c CHECK ((length((question)::text) <= 250)),
CONSTRAINT questions_833137918_c CHECK ((length((category)::text) <= 100))
);
CREATE TABLE public.queue_email (
queueemailid bigint NOT NULL,
queueid bigint NOT NULL,
email citext,
CONSTRAINT queue_email_66081660_c CHECK ((length((email)::text) <= 250))
);
CREATE TABLE public.queue_technician (
queueid bigint NOT NULL,
technicianid bigint NOT NULL,
technicianid_autoid bigint NOT NULL
);
CREATE TABLE public.queuedefinition (
queueid bigint NOT NULL,
queuename citext NOT NULL,
queuedescription citext,
siteid bigint,
sendername citext,
replyaddress citext,
ciid bigint,
isdeleted boolean DEFAULT false,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT queuedefinition_1047900924_c CHECK ((length((queuename)::text) <= 250)),
CONSTRAINT queuedefinition_142920246_c CHECK ((length((replyaddress)::text) <= 250)),
CONSTRAINT queuedefinition_1483431488_c CHECK ((length((sendername)::text) <= 250)),
CONSTRAINT queuedefinition_1941218891_c CHECK ((length((queuedescription)::text) <= 250))
);
CREATE TABLE public.queueescalation (
escalationid bigint NOT NULL,
queueid bigint NOT NULL,
category citext NOT NULL,
escalatetoid bigint,
escafterdays bigint DEFAULT '0' NOT NULL,
escafterhours bigint DEFAULT '0' NOT NULL,
escafterminutes bigint DEFAULT '0' NOT NULL,
CONSTRAINT queueescalation_833137918_c CHECK ((length((category)::text) <= 50))
);
CREATE TABLE public.queueroletousermapping (
mappingid bigint NOT NULL,
orgroleid bigint NOT NULL,
userid bigint NOT NULL,
queueid bigint NOT NULL,
helpdeskid bigint NOT NULL
);
CREATE TABLE public.quotationtypes (
typeid bigint NOT NULL,
name citext NOT NULL,
description citext,
CONSTRAINT quotationtypes_2388619_c CHECK ((length((name)::text) <= 100))
);
CREATE TABLE public.quoteattachment (
uid bigint NOT NULL,
attachmentid bigint NOT NULL,
quoteid bigint NOT NULL
);
CREATE TABLE public.quoteproductdetails (
uid bigint NOT NULL,
quoteid bigint NOT NULL,
itemname citext NOT NULL,
description citext,
quantity integer DEFAULT 1 NOT NULL,
price double DEFAULT '0' NOT NULL,
discount double DEFAULT '0' NOT NULL,
CONSTRAINT quoteproductdetails_1960911902_c CHECK ((length((itemname)::text) <= 250))
);
CREATE TABLE public.quotestatus (
statusid bigint NOT NULL,
statusname citext NOT NULL,
ispending boolean DEFAULT true NOT NULL,
statusdescription citext,
CONSTRAINT quotestatus_502347606_c CHECK ((length((statusdescription)::text) <= 250)),
CONSTRAINT quotestatus_733867389_c CHECK ((length((statusname)::text) <= 100))
);
CREATE TABLE public.rack (
ciid bigint NOT NULL,
assignedto bigint,
footprint citext,
powerconsumption citext,
rackunits citext,
rackunitsinuse citext,
CONSTRAINT rack_145220982_c CHECK ((length((powerconsumption)::text) <= 250)),
CONSTRAINT rack_1620520522_c CHECK ((length((rackunitsinuse)::text) <= 250)),
CONSTRAINT rack_2145105185_c CHECK ((length((footprint)::text) <= 250)),
CONSTRAINT rack_992430808_c CHECK ((length((rackunits)::text) <= 250))
);
CREATE TABLE public.rack_datacenter (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.rack_server (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.rangevalues (
column_id bigint NOT NULL,
range_from citext,
range_to citext,
CONSTRAINT rangevalues_1035517149_c CHECK ((length((range_to)::text) <= 50)),
CONSTRAINT rangevalues_1300844148_c CHECK ((length((range_from)::text) <= 50))
);
CREATE TABLE public.rdpsessionrecordinfo (
rdpsessionrecordid bigint NOT NULL,
summaryid bigint NOT NULL,
filename citext,
numericid bigint NOT NULL,
sessionid citext NOT NULL,
protocol citext NOT NULL,
CONSTRAINT rdpsessionrecordinfo_206537064_c CHECK ((length((protocol)::text) <= 100)),
CONSTRAINT rdpsessionrecordinfo_47858183_c CHECK ((length((filename)::text) <= 250)),
CONSTRAINT rdpsessionrecordinfo_900574703_c CHECK ((length((sessionid)::text) <= 250))
);
CREATE TABLE public.rdscommands (
rdscommandid bigint NOT NULL,
rdsid bigint NOT NULL,
ostypeid bigint NOT NULL,
commandid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.rdscredentials (
credentialid bigint NOT NULL,
domainname citext,
CONSTRAINT rdscredentials_758040241_c CHECK ((length((domainname)::text) <= 250))
);
CREATE TABLE public.rdsmethods (
rdsid bigint NOT NULL,
name citext NOT NULL,
description citext,
isenabled boolean DEFAULT true NOT NULL,
canedit boolean DEFAULT true NOT NULL,
candelete boolean DEFAULT true NOT NULL,
isjrepluginrequired boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT rdsmethods_2388619_c CHECK ((length((name)::text) <= 250))
);
CREATE TABLE public.rdssummary (
summaryid bigint NOT NULL,
rdsid bigint NOT NULL,
workstationid bigint NOT NULL,
remotefrom citext,
userid bigint NOT NULL,
starttime bigint NOT NULL,
endtime bigint,
issuccess boolean DEFAULT false NOT NULL,
comments citext,
usercomment citext,
CONSTRAINT rdssummary_1526950128_c CHECK ((length((remotefrom)::text) <= 250)),
CONSTRAINT rdssummary_180211188_c CHECK ((length((comments)::text) <= 250))
);
CREATE TABLE public.rdstargetos (
targetid bigint NOT NULL,
rdscommandid bigint NOT NULL,
ostypeid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.rdtdefinition (
type_id bigint NOT NULL,
type_name citext NOT NULL,
CONSTRAINT rdtdefinition_959637392_c CHECK ((length((type_name)::text) <= 100))
);
CREATE TABLE public.reasonforchangedetails (
id bigint NOT NULL,
name citext NOT NULL,
description citext,
isdeleted boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT reasonforchangedetails_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT reasonforchangedetails_428414940_c CHECK ((length((description)::text) <= 500))
);
CREATE TABLE public.recentitems (
itemid bigint NOT NULL,
url citext NOT NULL,
displaystr citext NOT NULL,
userid bigint NOT NULL,
date bigint NOT NULL,
modulename citext NOT NULL,
image citext,
detailid bigint DEFAULT '0' NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT recentitems_384305417_c CHECK ((length((modulename)::text) <= 50)),
CONSTRAINT recentitems_429407697_c CHECK ((length((displaystr)::text) <= 250)),
CONSTRAINT recentitems_69775675_c CHECK ((length((image)::text) <= 50)),
CONSTRAINT recentitems_84303_c CHECK ((length((url)::text) <= 250))
);
CREATE TABLE public.reconciledsw (
reconcileid bigint NOT NULL,
softwarename citext NOT NULL,
softwareid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT reconciledsw_797874354_c CHECK ((length((softwarename)::text) <= 250))
);
CREATE TABLE public.regiondefinition (
regionid bigint NOT NULL,
regionname citext NOT NULL,
regiondesc citext,
isdeleted boolean DEFAULT false,
CONSTRAINT regiondefinition_1504644225_c CHECK ((length((regionname)::text) <= 100)),
CONSTRAINT regiondefinition_1504938107_c CHECK ((length((regiondesc)::text) <= 250))
);
CREATE TABLE public.regionroletousermapping (
mappingid bigint NOT NULL,
orgroleid bigint NOT NULL,
userid bigint NOT NULL,
regionid bigint NOT NULL,
helpdeskid bigint
);
CREATE TABLE public.relatedsolutions (
solutionid bigint NOT NULL,
othersolution bigint NOT NULL
);
CREATE TABLE public.relationalcriteria (
queryid bigint NOT NULL,
criteriaid bigint NOT NULL,
relationalcriteriaid bigint NOT NULL,
tablealias citext,
columnname citext,
comparator integer,
value citext,
casesensitive boolean DEFAULT true NOT NULL,
value_datatype citext,
CONSTRAINT relationalcriteria_1017743550_c CHECK ((length((tablealias)::text) <= 50)),
CONSTRAINT relationalcriteria_1619616031_c CHECK ((length((columnname)::text) <= 50)),
CONSTRAINT relationalcriteria_1627714286_c CHECK ((length((value_datatype)::text) <= 30)),
CONSTRAINT relationalcriteria_81434961_c CHECK ((length((value)::text) <= 3500))
);
CREATE TABLE public.relationship (
relationshipid bigint NOT NULL,
citypeid1 bigint NOT NULL,
citypeid2 bigint NOT NULL,
relationshiptypeid bigint NOT NULL,
cardinality citext NOT NULL,
relattributetablename citext,
relattributecolumnname citext,
viewname citext,
isdefault boolean DEFAULT false NOT NULL,
isvisible boolean DEFAULT true NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT relationship_1296793234_c CHECK ((length((cardinality)::text) <= 50)),
CONSTRAINT relationship_160690294_c CHECK ((length((relattributetablename)::text) <= 100)),
CONSTRAINT relationship_1979239088_c CHECK ((length((viewname)::text) <= 100)),
CONSTRAINT relationship_72877380_c CHECK ((length((relattributecolumnname)::text) <= 100))
);
CREATE TABLE public.relationshipattributes (
primarykeyid bigint NOT NULL,
relationshipid bigint NOT NULL,
relationshipid2 bigint NOT NULL,
attributeid bigint NOT NULL
);
CREATE TABLE public.relationshiphierarchy (
primarykeyid bigint NOT NULL,
parentrid bigint NOT NULL,
childrid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.relationshiptype (
relationshiptypeid bigint NOT NULL,
description citext,
relationship citext,
isdefault boolean DEFAULT false NOT NULL,
iseditable boolean DEFAULT true NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT relationshiptype_2055429688_c CHECK ((length((relationship)::text) <= 250)),
CONSTRAINT relationshiptype_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.relationshiptypehierarchy (
parentrtid bigint NOT NULL,
childrtid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.relationshipview (
id bigint NOT NULL,
name citext NOT NULL,
baseciid bigint NOT NULL,
description citext NOT NULL,
createdby bigint NOT NULL,
visibility citext NOT NULL,
iseditable boolean DEFAULT false,
lasteditedby bigint,
lasteditedat bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT relationshipview_1868542190_c CHECK ((length((visibility)::text) <= 20)),
CONSTRAINT relationshipview_2388619_c CHECK ((length((name)::text) <= 200)),
CONSTRAINT relationshipview_428414940_c CHECK ((length((description)::text) <= 2000))
);
CREATE TABLE public.relationshipviewdata (
id bigint NOT NULL,
viewid bigint NOT NULL,
ciid bigint NOT NULL,
data citext,
isexpanded boolean DEFAULT false,
parentciid bigint NOT NULL,
relationshipid bigint
);
CREATE TABLE public.relationshipviewpermittedsites (
id bigint NOT NULL,
viewid bigint NOT NULL,
siteid bigint NOT NULL
);
CREATE TABLE public.relcri_expression (
queryid bigint NOT NULL,
criteriaid bigint NOT NULL,
relationalcriteriaid bigint NOT NULL,
expression_id bigint NOT NULL
);
CREATE TABLE public.releaseadditionalfields (
releaseid bigint NOT NULL
);
CREATE TABLE public.releaseapprovallevel (
entityid bigint NOT NULL,
levelid bigint NOT NULL,
stageid bigint NOT NULL
);
CREATE TABLE public.releaseattachmentfield (
id bigint NOT NULL,
name citext NOT NULL,
internal_name citext NOT NULL,
releaseid bigint NOT NULL,
stageid bigint NOT NULL,
updated_by bigint,
updated_on bigint,
hasattachment boolean DEFAULT false NOT NULL,
CONSTRAINT releaseattachmentfield_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT releaseattachmentfield_677323469_c CHECK ((length((internal_name)::text) <= 100))
);
CREATE TABLE public.releaseattachmentfieldtoattachments (
attachmentid bigint NOT NULL,
attachment_fieldid bigint NOT NULL
);
CREATE TABLE public.releaseattachments (
attachmentid bigint NOT NULL,
releaseid bigint NOT NULL
);
CREATE TABLE public.releaseclosurerules (
closureid bigint NOT NULL,
stageid bigint NOT NULL,
columnname citext NOT NULL,
displayname citext NOT NULL,
mandatory boolean DEFAULT false NOT NULL,
CONSTRAINT releaseclosurerules_1619616031_c CHECK ((length((columnname)::text) <= 250)),
CONSTRAINT releaseclosurerules_426904019_c CHECK ((length((displayname)::text) <= 250))
);
CREATE TABLE public.releaseconfigurations (
config_id bigint NOT NULL,
category citext NOT NULL,
parameter citext NOT NULL,
paramvalue citext DEFAULT 'false' NOT NULL,
description citext DEFAULT '-' NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT releaseconfigurations_428414940_c CHECK ((length((description)::text) <= 200)),
CONSTRAINT releaseconfigurations_446088073_c CHECK ((length((parameter)::text) <= 100)),
CONSTRAINT releaseconfigurations_833137918_c CHECK ((length((category)::text) <= 100)),
CONSTRAINT releaseconfigurations_958969092_c CHECK ((length((paramvalue)::text) <= 100))
);
CREATE TABLE public.releasedescfieldstoattachments (
attachmentid bigint NOT NULL,
descriptionid bigint NOT NULL
);
CREATE TABLE public.releasedescriptivefield (
id bigint NOT NULL,
name citext NOT NULL,
internal_name citext NOT NULL,
content citext,
releaseid bigint NOT NULL,
stageid bigint NOT NULL,
updated_by bigint,
updated_on bigint,
CONSTRAINT releasedescriptivefield_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT releasedescriptivefield_677323469_c CHECK ((length((internal_name)::text) <= 100))
);
CREATE TABLE public.releasedescriptiveimages (
id bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.releasedetails (
releaseid bigint NOT NULL,
stageid bigint NOT NULL,
priorityid bigint,
categoryid bigint,
subcategoryid bigint,
itemid bigint,
releasetypeid bigint,
urgencyid bigint,
title citext NOT NULL,
description citext,
createdtime bigint NOT NULL,
scheduledstarttime bigint,
scheduledendtime bigint,
completedtime bigint,
notespresent boolean DEFAULT false NOT NULL,
siteid bigint,
groupid bigint,
templateid bigint,
wfid bigint,
statusid bigint NOT NULL,
isemergency boolean DEFAULT false NOT NULL,
riskid bigint,
impactid bigint,
deletedtime bigint,
hasdraft boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
next_review_on bigint,
initiatorid bigint,
technicianid bigint,
releasemanagerid bigint,
CONSTRAINT releasedetails_428414940_c CHECK ((length((description)::text) <= 500)),
CONSTRAINT releasedetails_79833656_c CHECK ((length((title)::text) <= 250))
);
CREATE TABLE public.releasedowntimedetails (
dtid bigint NOT NULL,
releaseid bigint NOT NULL,
description citext NOT NULL,
starttime bigint,
endtime bigint,
actualstarttime bigint,
actualendtime bigint,
time_type citext,
typeid bigint,
CONSTRAINT releasedowntimedetails_1442140820_c CHECK ((length((time_type)::text) <= 50))
);
CREATE TABLE public.releasedowntimetocis (
dtid bigint NOT NULL,
ciid bigint NOT NULL
);
CREATE TABLE public.releasedowntimetoservices (
dtid bigint NOT NULL,
serviceid bigint NOT NULL
);
CREATE TABLE public.releasehistory (
historyid bigint NOT NULL,
releaseid bigint NOT NULL,
operationownerid bigint NOT NULL,
operationtime bigint NOT NULL,
description citext,
operation citext DEFAULT 'CREATE',
CONSTRAINT releasehistory_154330439_c CHECK ((length((operation)::text) <= 50))
);
CREATE TABLE public.releasehistorydiff (
historydiffid bigint NOT NULL,
historyid bigint NOT NULL,
columnname citext NOT NULL,
prev_value citext,
current_value citext,
CONSTRAINT releasehistorydiff_1619616031_c CHECK ((length((columnname)::text) <= 30))
);
CREATE TABLE public.releaseimages (
releaseid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.releasemultiselectfields (
id bigint NOT NULL,
releaseid bigint NOT NULL
);
CREATE TABLE public.releasenotes (
notesid bigint NOT NULL,
createdby bigint NOT NULL,
createdtime bigint NOT NULL,
notestext citext NOT NULL,
hasattachment boolean DEFAULT false NOT NULL,
updatedby bigint,
updatedtime bigint,
notestype citext DEFAULT 'notes',
releaseid bigint NOT NULL,
stageid bigint,
CONSTRAINT releasenotes_291087707_c CHECK ((length((notestype)::text) <= 50))
);
CREATE TABLE public.releasenotesattachment (
attachmentid bigint NOT NULL,
notesid bigint NOT NULL
);
CREATE TABLE public.releasenotesimages (
notesid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.releasenotification (
notificationid bigint NOT NULL,
notificationtitle citext,
notificationdate bigint NOT NULL,
senderid bigint NOT NULL,
recipientid bigint,
messageid citext NOT NULL,
notificationtype citext,
ispublic boolean DEFAULT true NOT NULL,
hasattachment boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT releasenotification_1346582338_c CHECK ((length((messageid)::text) <= 250)),
CONSTRAINT releasenotification_1634626515_c CHECK ((length((notificationtitle)::text) <= 500)),
CONSTRAINT releasenotification_1886948005_c CHECK ((length((notificationtype)::text) <= 50))
);
CREATE TABLE public.releasenotification_recipients (
notificationid bigint NOT NULL,
recipient_email citext NOT NULL,
to_cc_bcc citext,
CONSTRAINT releasenotification_recipients_370219446_c CHECK ((length((recipient_email)::text) <= 250)),
CONSTRAINT releasenotification_recipients_862828025_c CHECK ((length((to_cc_bcc)::text) <= 250))
);
CREATE TABLE public.releasenotificationimages (
notificationid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.releasenotificationtodesc (
notificationid bigint NOT NULL,
description citext NOT NULL,
attachmentid bigint
);
CREATE TABLE public.releasenotify_attachments (
attachmentid bigint NOT NULL,
notificationid bigint NOT NULL
);
CREATE TABLE public.releaserolepermissionsvsstages (
permissionid bigint NOT NULL,
roleid bigint NOT NULL,
stageid bigint NOT NULL,
viewpermission boolean DEFAULT false NOT NULL,
editpermission boolean DEFAULT false NOT NULL,
approvalpermission boolean DEFAULT false NOT NULL,
deletepermission boolean DEFAULT false NOT NULL
);
CREATE TABLE public.releaseroles (
roleid bigint NOT NULL,
internalname citext NOT NULL,
displayname citext NOT NULL,
description citext,
isprominent boolean DEFAULT false NOT NULL,
isdeleted boolean DEFAULT false NOT NULL,
usertype citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT releaseroles_2056879416_c CHECK ((length((internalname)::text) <= 100)),
CONSTRAINT releaseroles_426904019_c CHECK ((length((displayname)::text) <= 100)),
CONSTRAINT releaseroles_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT releaseroles_517115269_c CHECK ((length((usertype)::text) <= 20))
);
CREATE TABLE public.releaseroleusermapping (
roletousermappingid bigint NOT NULL,
releaseid bigint NOT NULL,
roleid bigint,
userid bigint NOT NULL
);
CREATE TABLE public.releasestagebasedstatus (
statusid bigint NOT NULL,
statusname citext NOT NULL,
internalname citext,
description citext,
isdeleted boolean DEFAULT false,
stageid bigint NOT NULL,
isprominentaction boolean DEFAULT false,
notificationcontentid bigint,
statustype citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT releasestagebasedstatus_2056879416_c CHECK ((length((internalname)::text) <= 100)),
CONSTRAINT releasestagebasedstatus_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT releasestagebasedstatus_733867389_c CHECK ((length((statusname)::text) <= 100)),
CONSTRAINT releasestagebasedstatus_734069292_c CHECK ((length((statustype)::text) <= 20))
);
CREATE TABLE public.releasestagedata (
stagedataid bigint NOT NULL,
releaseid bigint NOT NULL,
stageid bigint NOT NULL,
scheduledstarttime bigint,
scheduledendtime bigint,
actualstarttime bigint,
actualendtime bigint,
updated_by bigint,
updated_on bigint
);
CREATE TABLE public.releasestagedatadescription (
stagedataid bigint NOT NULL,
stage_data_description citext
);
CREATE TABLE public.releasestagedatadescriptionimages (
stagedataid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.releasestagedefinition (
stageid bigint NOT NULL,
name citext NOT NULL,
internalname citext NOT NULL,
description citext,
stageindex integer DEFAULT '-1' NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT releasestagedefinition_2056879416_c CHECK ((length((internalname)::text) <= 50)),
CONSTRAINT releasestagedefinition_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT releasestagedefinition_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.releasestatuscomments (
commentid bigint NOT NULL,
releaseid bigint NOT NULL,
stageid bigint NOT NULL,
statusid bigint NOT NULL,
comments citext,
commentedon bigint NOT NULL,
commentedby bigint NOT NULL
);
CREATE TABLE public.releasetemplatedetails (
templateid bigint NOT NULL,
workflowid bigint,
isemergency boolean DEFAULT false NOT NULL
);
CREATE TABLE public.releasetemplateimages (
template_id bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.releasetemplatelayout (
releasetemplatelayoutid bigint NOT NULL,
layoutid bigint NOT NULL,
stageid bigint
);
CREATE TABLE public.releasetoasset (
releaseid bigint NOT NULL,
assetid bigint NOT NULL
);
CREATE TABLE public.releasetochanges (
associationid bigint NOT NULL,
releaseid bigint NOT NULL,
changeid bigint NOT NULL,
initiated_by citext NOT NULL,
CONSTRAINT releasetochanges_2141905995_c CHECK ((length((initiated_by)::text) <= 50))
);
CREATE TABLE public.releasetocharge (
releaseid bigint NOT NULL,
chargeid bigint NOT NULL,
stageid bigint
);
CREATE TABLE public.releasetoclosurecode (
releaseid bigint NOT NULL,
closureid bigint NOT NULL
);
CREATE TABLE public.releasetodefaultdescfields (
releaseid bigint NOT NULL,
rolloutplan bigint,
backoutplan bigint,
impactdesc bigint,
checklist bigint,
closedesc bigint
);
CREATE TABLE public.releasetodescription (
releaseid bigint NOT NULL,
full_description citext
);
CREATE TABLE public.releasetoprojects (
associationid bigint NOT NULL,
releaseid bigint NOT NULL,
projectid bigint NOT NULL,
initiated_by citext NOT NULL,
CONSTRAINT releasetoprojects_2141905995_c CHECK ((length((initiated_by)::text) <= 50))
);
CREATE TABLE public.releasetoservice (
releaseid bigint NOT NULL,
serviceid bigint NOT NULL
);
CREATE TABLE public.releasetotasks (
releaseid bigint NOT NULL,
stageid bigint NOT NULL,
taskid bigint NOT NULL
);
CREATE TABLE public.releasetotaskstable (
releaseid bigint NOT NULL,
taskid bigint NOT NULL
);
CREATE TABLE public.releaseworkflowstatement (
releaseid bigint NOT NULL,
statementid bigint,
approvalid bigint
);
CREATE TABLE public.remembermedetails (
remembermeid bigint NOT NULL,
userid bigint NOT NULL,
useruniqueid citext NOT NULL,
authtokenid citext NOT NULL,
authtoken citext NOT NULL,
createdtime bigint NOT NULL,
lastauthenticatedtime bigint NOT NULL,
ipaddress citext NOT NULL,
useragent citext NOT NULL,
isvalid boolean DEFAULT true NOT NULL,
authentication_type citext,
CONSTRAINT remembermedetails_1167389190_c CHECK ((length((useragent)::text) <= 200)),
CONSTRAINT remembermedetails_1190248823_c CHECK ((length((useruniqueid)::text) <= 250)),
CONSTRAINT remembermedetails_1361529332_c CHECK ((length((authtokenid)::text) <= 50)),
CONSTRAINT remembermedetails_1538992947_c CHECK ((length((ipaddress)::text) <= 100)),
CONSTRAINT remembermedetails_28232399_c CHECK ((length((authtoken)::text) <= 250)),
CONSTRAINT remembermedetails_92718241_c CHECK ((length((authentication_type)::text) <= 50))
);
CREATE TABLE public.reminder_audit (
audit_id bigint NOT NULL,
task_input_id bigint,
schedule_id bigint,
task_id bigint,
scheduled_time timestamp without time zone NOT NULL,
reminder_executed_time timestamp without time zone NOT NULL,
reschedule_time timestamp without time zone
);
CREATE TABLE public.remotedatainfo (
remotedataid bigint NOT NULL,
datapusheddate bigint NOT NULL,
datapushstatus citext NOT NULL,
datapushcomments citext,
CONSTRAINT remotedatainfo_1789326666_c CHECK ((length((datapushstatus)::text) <= 100)),
CONSTRAINT remotedatainfo_817853368_c CHECK ((length((datapushcomments)::text) <= 250))
);
CREATE TABLE public.renewedcontract (
renewedcontractid bigint NOT NULL,
newcontractid bigint NOT NULL,
oldcontractid bigint NOT NULL,
reneweddate bigint,
renewedby bigint
);
CREATE TABLE public.replytemplate (
templateid bigint NOT NULL,
templatename citext NOT NULL,
description citext NOT NULL,
createdby bigint NOT NULL,
createdtime bigint NOT NULL,
inactive boolean DEFAULT false NOT NULL,
ispublic boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT replytemplate_1342071301_c CHECK ((length((templatename)::text) <= 100))
);
CREATE TABLE public.replytemplateimages (
templateid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.report_customds (
report_id bigint NOT NULL,
sub_report_id bigint DEFAULT '19' NOT NULL,
class_name citext NOT NULL,
description citext NOT NULL,
CONSTRAINT report_customds_224170258_c CHECK ((length((class_name)::text) <= 250)),
CONSTRAINT report_customds_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.report_modules (
module_id bigint NOT NULL,
module_name citext NOT NULL,
parent_id bigint,
orderid bigint DEFAULT '999' NOT NULL,
helpdeskid bigint,
CONSTRAINT report_modules_987509886_c CHECK ((length((module_name)::text) <= 100))
);
CREATE TABLE public.reportcharttypes (
chart_id bigint NOT NULL,
chart_name citext NOT NULL,
CONSTRAINT reportcharttypes_1994821012_c CHECK ((length((chart_name)::text) <= 100))
);
CREATE TABLE public.reportcolumndetails (
column_id bigint NOT NULL,
submodule_id bigint NOT NULL,
column_name citext NOT NULL,
column_alias citext,
display_name citext NOT NULL,
apidisplay_name citext,
apidisplay_status boolean DEFAULT false,
display_status boolean DEFAULT false NOT NULL,
map2submodule bigint,
data_type bigint NOT NULL,
orderid bigint DEFAULT '999' NOT NULL,
pickstatus boolean DEFAULT false NOT NULL,
hrefid bigint,
helpdeskid bigint,
CONSTRAINT reportcolumndetails_1186172921_c CHECK ((length((column_alias)::text) <= 100)),
CONSTRAINT reportcolumndetails_1347586516_c CHECK ((length((column_name)::text) <= 100)),
CONSTRAINT reportcolumndetails_1434972930_c CHECK ((length((apidisplay_name)::text) <= 100)),
CONSTRAINT reportcolumndetails_333046776_c CHECK ((length((display_name)::text) <= 250))
);
CREATE TABLE public.reportcriteria (
criteria_id bigint NOT NULL,
criteria_typeid bigint NOT NULL,
criteria_name citext NOT NULL,
CONSTRAINT reportcriteria_1191518059_c CHECK ((length((criteria_name)::text) <= 100))
);
CREATE TABLE public.reportcriteriatype (
criteria_typeid bigint NOT NULL,
criteria_type citext NOT NULL,
CONSTRAINT reportcriteriatype_1191719962_c CHECK ((length((criteria_type)::text) <= 30))
);
CREATE TABLE public.reportdisplayformat (
format_id bigint NOT NULL,
format_name citext NOT NULL,
CONSTRAINT reportdisplayformat_654040621_c CHECK ((length((format_name)::text) <= 100))
);
CREATE TABLE public.reportmoduleconfiguration (
id bigint NOT NULL,
category citext NOT NULL,
parameter citext NOT NULL,
paramvalue citext NOT NULL,
helpdeskid bigint,
CONSTRAINT reportmoduleconfiguration_446088073_c CHECK ((length((parameter)::text) <= 50)),
CONSTRAINT reportmoduleconfiguration_833137918_c CHECK ((length((category)::text) <= 50)),
CONSTRAINT reportmoduleconfiguration_958969092_c CHECK ((length((paramvalue)::text) <= 50))
);
CREATE TABLE public.reportmodulemapping (
type_id bigint NOT NULL,
module_id bigint NOT NULL,
helpdeskid bigint
);
CREATE TABLE public.reportri (
itemid bigint NOT NULL,
workorderid bigint NOT NULL
);
CREATE TABLE public.reportschedulemapping (
taskid bigint NOT NULL,
reportid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.reportscheduletask (
taskid bigint NOT NULL,
instance_id bigint NOT NULL,
schedulename citext,
mailid citext,
subject citext,
message citext,
ownerid bigint NOT NULL,
report_type citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT reportscheduletask_1149902580_c CHECK ((length((subject)::text) <= 250)),
CONSTRAINT reportscheduletask_1935972197_c CHECK ((length((report_type)::text) <= 20)),
CONSTRAINT reportscheduletask_814755422_c CHECK ((length((schedulename)::text) <= 200))
);
CREATE TABLE public.reportsubmodule_mapping (
id bigint NOT NULL,
module_id bigint NOT NULL,
base_smid bigint
);
CREATE TABLE public.reportsubmodules (
submodule_id bigint NOT NULL,
module_id bigint NOT NULL,
submodule_name citext NOT NULL,
table_name citext NOT NULL,
table_alias citext NOT NULL,
criteria citext NOT NULL,
join_type citext NOT NULL,
one2manyrelation boolean DEFAULT false NOT NULL,
custom_criteria citext,
ismultivalue boolean DEFAULT false,
helpdeskid bigint,
CONSTRAINT reportsubmodules_1559077282_c CHECK ((length((submodule_name)::text) <= 100)),
CONSTRAINT reportsubmodules_1560293537_c CHECK ((length((criteria)::text) <= 250)),
CONSTRAINT reportsubmodules_1927630957_c CHECK ((length((custom_criteria)::text) <= 250)),
CONSTRAINT reportsubmodules_1972890321_c CHECK ((length((join_type)::text) <= 100)),
CONSTRAINT reportsubmodules_636466593_c CHECK ((length((table_alias)::text) <= 100)),
CONSTRAINT reportsubmodules_989985668_c CHECK ((length((table_name)::text) <= 100))
);
CREATE TABLE public.reportwidget (
widgetid bigint NOT NULL,
reportid bigint NOT NULL,
dashboardtab integer DEFAULT 1 NOT NULL,
ispublic boolean DEFAULT false NOT NULL,
createdby bigint NOT NULL,
createdtime bigint NOT NULL,
lastupdatedby bigint,
lastupdatedtime bigint
);
CREATE TABLE public.reqdefaultprops (
field_id bigint NOT NULL,
field_key citext NOT NULL,
field_name citext NOT NULL,
CONSTRAINT reqdefaultprops_1091304144_c CHECK ((length((field_name)::text) <= 200)),
CONSTRAINT reqdefaultprops_241894054_c CHECK ((length((field_key)::text) <= 200))
);
CREATE TABLE public.request_approvallevel (
id bigint NOT NULL,
entityid bigint NOT NULL,
levelid bigint NOT NULL
);
CREATE TABLE public.requestclosurecode (
closurecodeid bigint NOT NULL,
name citext NOT NULL,
description citext,
isdeleted boolean DEFAULT false,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT requestclosurecode_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT requestclosurecode_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.requestcustomfiltermigrationlog (
id bigint NOT NULL,
old_filterid bigint NOT NULL,
is_conversion_completed boolean DEFAULT false,
error_message citext,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.requesteremailids (
maillistid bigint NOT NULL,
userid bigint NOT NULL,
emailid citext NOT NULL,
CONSTRAINT requesteremailids_920031849_c CHECK ((length((emailid)::text) <= 200))
);
CREATE TABLE public.requestnotification (
notificationid bigint NOT NULL,
notificationtitle citext,
notificationdate bigint NOT NULL,
senderid bigint NOT NULL,
recipientid bigint,
messageid citext NOT NULL,
notificationtype citext,
ispublic boolean DEFAULT true NOT NULL,
hasattachment boolean DEFAULT false NOT NULL,
is_draft boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
old_conv_id bigint,
CONSTRAINT requestnotification_1346582338_c CHECK ((length((messageid)::text) <= 250)),
CONSTRAINT requestnotification_1634626515_c CHECK ((length((notificationtitle)::text) <= 500)),
CONSTRAINT requestnotification_1886948005_c CHECK ((length((notificationtype)::text) <= 50))
);
CREATE TABLE public.requestnotification_recipients (
notificationid bigint NOT NULL,
recipient_email citext NOT NULL,
to_cc_bcc citext,
CONSTRAINT requestnotification_recipients_370219446_c CHECK ((length((recipient_email)::text) <= 250)),
CONSTRAINT requestnotification_recipients_862828025_c CHECK ((length((to_cc_bcc)::text) <= 250))
);
CREATE TABLE public.requestnotificationhistory (
historyid bigint NOT NULL,
conversationid bigint NOT NULL,
operationownerid bigint NOT NULL,
operationtime bigint NOT NULL,
description citext,
operation citext DEFAULT 'CREATE',
CONSTRAINT requestnotificationhistory_154330439_c CHECK ((length((operation)::text) <= 50))
);
CREATE TABLE public.requestnotificationimages (
notificationid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.requestnotificationtodesc (
notificationid bigint NOT NULL,
description citext NOT NULL,
attachmentid bigint
);
CREATE TABLE public.requestnotify_attachments (
attachmentid bigint NOT NULL,
notificationid bigint NOT NULL
);
CREATE TABLE public.requestonhold (
holdid bigint NOT NULL,
workorderid bigint NOT NULL,
starttime bigint DEFAULT '0' NOT NULL,
endtime bigint DEFAULT '0' NOT NULL,
isafteroverdue boolean
);
CREATE TABLE public.requestresolution (
requestid bigint NOT NULL,
resolution citext,
lastupdatedtime bigint NOT NULL,
attachmentid bigint
);
CREATE TABLE public.requestresolver (
requestid bigint NOT NULL,
technicianid bigint NOT NULL
);
CREATE TABLE public.requestri (
itemid bigint NOT NULL,
workorderid bigint NOT NULL
);
CREATE TABLE public.requestslaescalations (
id bigint NOT NULL,
itemid bigint NOT NULL,
escalationid bigint NOT NULL,
alreadysent boolean NOT NULL,
escalationtime bigint NOT NULL
);
CREATE TABLE public.requesttasktemplate (
reqtemplateid bigint NOT NULL,
mappingid bigint NOT NULL,
hasproperties boolean DEFAULT false NOT NULL,
templateid bigint NOT NULL,
taskindex bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.requesttemplate_checklist (
templatechecklistid bigint NOT NULL,
templateid bigint NOT NULL,
checklistid bigint NOT NULL,
checklistorder bigint NOT NULL
);
CREATE TABLE public.requesttemplate_fields (
templateid bigint NOT NULL,
statusid bigint,
modeid bigint,
levelid bigint,
groupid bigint,
technicianid bigint,
portaltechid_autoid bigint,
categoryid bigint,
subcategoryid bigint,
itemid bigint,
priorityid bigint,
title citext,
description citext,
resolution citext,
impactid bigint,
impactdetails citext,
urgencyid bigint,
requesttypeid bigint,
siteid bigint,
serviceid bigint,
emailcc citext,
editorid bigint,
CONSTRAINT requesttemplate_fields_1297707548_c CHECK ((length((impactdetails)::text) <= 250)),
CONSTRAINT requesttemplate_fields_79833656_c CHECK ((length((title)::text) <= 250)),
CONSTRAINT requesttemplate_fields_920032036_c CHECK ((length((emailcc)::text) <= 250))
);
CREATE TABLE public.requesttemplate_list (
templateid bigint NOT NULL,
templatename citext NOT NULL,
comments citext,
createdby bigint,
createdtime bigint NOT NULL,
showtorequester boolean DEFAULT false NOT NULL,
isdeleted boolean DEFAULT false NOT NULL,
parent_service bigint,
is_catalog_template boolean DEFAULT false NOT NULL,
status citext DEFAULT 'ACTIVE' NOT NULL,
sortindex bigint DEFAULT '0' NOT NULL,
assigntechifapproved boolean DEFAULT false NOT NULL,
autoapproval boolean DEFAULT false NOT NULL,
allshouldapprove boolean DEFAULT false NOT NULL,
firstresponse boolean DEFAULT false NOT NULL,
total_cost double,
cost_desription citext,
has_user_group boolean DEFAULT false NOT NULL,
has_group boolean DEFAULT false NOT NULL,
resource_view integer DEFAULT 1 NOT NULL,
triggertaskoncreate boolean DEFAULT false NOT NULL,
triggertaskonapprove boolean DEFAULT false NOT NULL,
create_after_approval boolean DEFAULT false NOT NULL,
can_requester_view_tasks boolean DEFAULT false NOT NULL,
help_text citext,
technician_help_text citext,
is_cost_enabled boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
image_mediaid bigint,
CONSTRAINT requesttemplate_list_1314300685_c CHECK ((length((cost_desription)::text) <= 250)),
CONSTRAINT requesttemplate_list_1342071301_c CHECK ((length((templatename)::text) <= 250)),
CONSTRAINT requesttemplate_list_180211188_c CHECK ((length((comments)::text) <= 1000)),
CONSTRAINT requesttemplate_list_1839152142_c CHECK ((length((status)::text) <= 20))
);
CREATE TABLE public.requesttemplate_scripts (
templateid bigint NOT NULL,
preinvoke_script citext NOT NULL,
postinvoke_script citext NOT NULL
);
CREATE TABLE public.requesttemplate_udf (
templateid bigint NOT NULL,
udf_long1 bigint,
udf_long2 bigint,
udf_long3 bigint,
udf_long4 bigint,
udf_long5 bigint,
udf_long6 bigint,
udf_long7 bigint,
udf_long8 bigint,
udf_date1 bigint,
udf_date2 bigint,
udf_date3 bigint,
udf_date4 bigint,
udf_date5 bigint,
udf_date6 bigint,
udf_date7 bigint,
udf_date8 bigint,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
udf_char5 citext,
udf_char6 citext,
udf_char7 citext,
udf_char8 citext,
udf_char9 citext,
udf_char10 citext,
udf_char11 citext,
udf_char12 citext,
udf_char13 citext,
udf_char14 citext,
udf_char15 citext,
udf_char16 citext,
udf_char17 citext,
udf_char18 citext,
udf_char19 citext,
udf_char20 citext,
udf_char21 citext,
udf_char22 citext,
udf_char23 citext,
udf_char24 citext,
CONSTRAINT requesttemplate_udf_278184709_c CHECK ((length((udf_char9)::text) <= 3500)),
CONSTRAINT requesttemplate_udf_278184710_c CHECK ((length((udf_char8)::text) <= 3500)),
CONSTRAINT requesttemplate_udf_278184711_c CHECK ((length((udf_char7)::text) <= 3500)),
CONSTRAINT requesttemplate_udf_278184712_c CHECK ((length((udf_char6)::text) <= 3500)),
CONSTRAINT requesttemplate_udf_278184713_c CHECK ((length((udf_char5)::text) <= 3500)),
CONSTRAINT requesttemplate_udf_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT requesttemplate_udf_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT requesttemplate_udf_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT requesttemplate_udf_278184717_c CHECK ((length((udf_char1)::text) <= 3500)),
CONSTRAINT requesttemplate_udf_33791552_c CHECK ((length((udf_char24)::text) <= 3500)),
CONSTRAINT requesttemplate_udf_33791553_c CHECK ((length((udf_char23)::text) <= 3500)),
CONSTRAINT requesttemplate_udf_33791554_c CHECK ((length((udf_char22)::text) <= 3500)),
CONSTRAINT requesttemplate_udf_33791555_c CHECK ((length((udf_char21)::text) <= 3500)),
CONSTRAINT requesttemplate_udf_33791556_c CHECK ((length((udf_char20)::text) <= 3500)),
CONSTRAINT requesttemplate_udf_33791578_c CHECK ((length((udf_char19)::text) <= 3500)),
CONSTRAINT requesttemplate_udf_33791579_c CHECK ((length((udf_char18)::text) <= 3500)),
CONSTRAINT requesttemplate_udf_33791580_c CHECK ((length((udf_char17)::text) <= 3500)),
CONSTRAINT requesttemplate_udf_33791581_c CHECK ((length((udf_char16)::text) <= 3500)),
CONSTRAINT requesttemplate_udf_33791582_c CHECK ((length((udf_char15)::text) <= 3500)),
CONSTRAINT requesttemplate_udf_33791583_c CHECK ((length((udf_char14)::text) <= 3500)),
CONSTRAINT requesttemplate_udf_33791584_c CHECK ((length((udf_char13)::text) <= 3500)),
CONSTRAINT requesttemplate_udf_33791585_c CHECK ((length((udf_char12)::text) <= 3500)),
CONSTRAINT requesttemplate_udf_33791586_c CHECK ((length((udf_char11)::text) <= 3500)),
CONSTRAINT requesttemplate_udf_33791587_c CHECK ((length((udf_char10)::text) <= 3500))
);
CREATE TABLE public.requesttemplateimages (
templateid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.requesttimeraction (
timerid bigint NOT NULL,
for_all_templates boolean DEFAULT true NOT NULL
);
CREATE TABLE public.requesttimertemplatemap (
id bigint NOT NULL,
timerid bigint NOT NULL,
templateid bigint NOT NULL
);
CREATE TABLE public.requesttypedefinition (
requesttypeid bigint NOT NULL,
name citext NOT NULL,
description citext,
colorcode citext,
isdeleted boolean DEFAULT false,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT requesttypedefinition_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT requesttypedefinition_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT requesttypedefinition_473007024_c CHECK ((length((colorcode)::text) <= 10))
);
CREATE TABLE public.resolutiontemplate (
templateid bigint NOT NULL,
templatename citext NOT NULL,
description citext NOT NULL,
createdby bigint NOT NULL,
createdtime bigint NOT NULL,
inactive boolean DEFAULT true NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT resolutiontemplate_1342071301_c CHECK ((length((templatename)::text) <= 100))
);
CREATE TABLE public.resource_fields (
resourceid bigint NOT NULL,
udf_long1 bigint,
udf_long2 bigint,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
udf_char5 citext,
udf_char6 citext,
udf_date1 bigint,
udf_date2 bigint,
udf_long3 bigint,
udf_long4 bigint,
udf_char7 citext,
udf_char8 citext,
udf_char9 citext,
udf_char10 citext,
udf_char11 citext,
udf_char12 citext,
udf_date3 bigint,
udf_date4 bigint,
udf_char13 citext,
udf_char14 citext,
udf_char15 citext,
udf_char16 citext,
udf_char17 citext,
udf_char18 citext,
udf_char19 citext,
udf_char20 citext,
udf_char21 citext,
udf_char22 citext,
udf_char23 citext,
udf_char24 citext,
udf_date5 bigint,
udf_date6 bigint,
udf_date7 bigint,
udf_date8 bigint,
udf_long5 bigint,
udf_long6 bigint,
udf_long7 bigint,
udf_long8 bigint,
udf_long9 bigint,
udf_long10 bigint,
udf_date9 bigint,
udf_date10 bigint,
CONSTRAINT resource_fields_278184709_c CHECK ((length((udf_char9)::text) <= 3500)),
CONSTRAINT resource_fields_278184710_c CHECK ((length((udf_char8)::text) <= 3500)),
CONSTRAINT resource_fields_278184711_c CHECK ((length((udf_char7)::text) <= 3500)),
CONSTRAINT resource_fields_278184712_c CHECK ((length((udf_char6)::text) <= 3500)),
CONSTRAINT resource_fields_278184713_c CHECK ((length((udf_char5)::text) <= 3500)),
CONSTRAINT resource_fields_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT resource_fields_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT resource_fields_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT resource_fields_278184717_c CHECK ((length((udf_char1)::text) <= 3500)),
CONSTRAINT resource_fields_33791552_c CHECK ((length((udf_char24)::text) <= 3500)),
CONSTRAINT resource_fields_33791553_c CHECK ((length((udf_char23)::text) <= 3500)),
CONSTRAINT resource_fields_33791554_c CHECK ((length((udf_char22)::text) <= 3500)),
CONSTRAINT resource_fields_33791555_c CHECK ((length((udf_char21)::text) <= 3500)),
CONSTRAINT resource_fields_33791556_c CHECK ((length((udf_char20)::text) <= 3500)),
CONSTRAINT resource_fields_33791578_c CHECK ((length((udf_char19)::text) <= 3500)),
CONSTRAINT resource_fields_33791579_c CHECK ((length((udf_char18)::text) <= 3500)),
CONSTRAINT resource_fields_33791580_c CHECK ((length((udf_char17)::text) <= 3500)),
CONSTRAINT resource_fields_33791581_c CHECK ((length((udf_char16)::text) <= 3500)),
CONSTRAINT resource_fields_33791582_c CHECK ((length((udf_char15)::text) <= 3500)),
CONSTRAINT resource_fields_33791583_c CHECK ((length((udf_char14)::text) <= 3500)),
CONSTRAINT resource_fields_33791584_c CHECK ((length((udf_char13)::text) <= 3500)),
CONSTRAINT resource_fields_33791585_c CHECK ((length((udf_char12)::text) <= 3500)),
CONSTRAINT resource_fields_33791586_c CHECK ((length((udf_char11)::text) <= 3500)),
CONSTRAINT resource_fields_33791587_c CHECK ((length((udf_char10)::text) <= 3500))
);
CREATE TABLE public.resource_question (
uid bigint NOT NULL,
catresid bigint NOT NULL,
questionid bigint NOT NULL,
mandatory boolean DEFAULT false NOT NULL,
question_column integer,
question_order integer,
is_deleted boolean DEFAULT false NOT NULL
);
CREATE TABLE public.resourceassociation (
resourceownerid bigint NOT NULL,
resourceid bigint NOT NULL,
assttoresourceid bigint NOT NULL
);
CREATE TABLE public.resourceassociationhistory (
resourceownerid bigint NOT NULL,
resourceid bigint NOT NULL,
assttoresourceid bigint NOT NULL,
comments citext,
CONSTRAINT resourceassociationhistory_180211188_c CHECK ((length((comments)::text) <= 250))
);
CREATE TABLE public.resourceattachment (
attachmentid bigint NOT NULL,
resourceid bigint NOT NULL
);
CREATE TABLE public.resourcecategory (
resourcecategoryid bigint NOT NULL,
category citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT resourcecategory_833137918_c CHECK ((length((category)::text) <= 30))
);
CREATE TABLE public.resourcecontract (
resourceid bigint NOT NULL,
contractid bigint NOT NULL
);
CREATE TABLE public.resourcecontracthistory (
resourceid bigint NOT NULL,
contractid bigint NOT NULL,
statehistoryid bigint NOT NULL
);
CREATE TABLE public.resourcecost (
resourcecostid bigint NOT NULL,
resourceid bigint NOT NULL,
resourcecostfactorid bigint NOT NULL,
cost double DEFAULT '0' NOT NULL,
description citext,
currency citext,
date bigint,
CONSTRAINT resourcecost_1358028817_c CHECK ((length((currency)::text) <= 25)),
CONSTRAINT resourcecost_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.resourcecostfactor (
resourcecostfactorid bigint NOT NULL,
costfactordesc citext NOT NULL,
CONSTRAINT resourcecostfactor_1719685139_c CHECK ((length((costfactordesc)::text) <= 30))
);
CREATE TABLE public.resourcedepreciation (
resourceid bigint NOT NULL,
depreciationid bigint NOT NULL
);
CREATE TABLE public.resourcedepreciationvalue (
depreciationvalueid bigint NOT NULL,
resourceid bigint NOT NULL,
month integer NOT NULL,
year integer NOT NULL,
depreciationvalue double DEFAULT '0' NOT NULL,
totaldepreciation double DEFAULT '0' NOT NULL,
bookvalue double DEFAULT '0' NOT NULL,
remaininglife integer NOT NULL,
depreciatedpercent double DEFAULT '0' NOT NULL
);
CREATE TABLE public.resourcegroup (
groupid bigint NOT NULL,
groupname citext NOT NULL,
groupdescription citext,
isstaticgroup boolean DEFAULT true NOT NULL,
createdby bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT resourcegroup_1111771107_c CHECK ((length((groupdescription)::text) <= 250)),
CONSTRAINT resourcegroup_1304373610_c CHECK ((length((groupname)::text) <= 100))
);
CREATE TABLE public.resourcelease (
resourceid bigint NOT NULL,
starttime bigint NOT NULL,
endtime bigint NOT NULL,
escalatebefore bigint,
escalatetoid bigint
);
CREATE TABLE public.resourcelocation (
resourceid bigint NOT NULL,
regionid bigint,
siteid bigint,
buildingid bigint,
floorid bigint,
roomid bigint,
location citext,
latitude double,
longitude double,
altitude double,
CONSTRAINT resourcelocation_1611296843_c CHECK ((length((location)::text) <= 250))
);
CREATE TABLE public.resourceowner (
resourceownerid bigint NOT NULL,
resourceid bigint NOT NULL,
userid bigint,
deptid bigint,
cirelationshipid bigint
);
CREATE TABLE public.resourceownerhistory (
resourceid bigint NOT NULL,
resourceownerid bigint NOT NULL,
statehistoryid bigint NOT NULL,
starttime bigint NOT NULL,
endtime bigint,
taskuserid bigint NOT NULL,
isleased boolean DEFAULT false NOT NULL,
userid bigint,
deptid bigint,
comments citext,
assignnotificationid bigint,
deassignnotificationid bigint,
CONSTRAINT resourceownerhistory_180211188_c CHECK ((length((comments)::text) <= 250))
);
CREATE TABLE public.resources (
resourceid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
resourcename citext NOT NULL,
acquisitiondate bigint,
warrantyexpiry bigint,
expirydate bigint,
componentid bigint NOT NULL,
assettag citext,
serialno citext,
barcodeid bigint,
purchaselotid bigint,
vendorid bigint,
resourcestateid bigint NOT NULL,
ciid bigint,
siteid bigint,
isdepreciationconfigured boolean DEFAULT false NOT NULL,
isdepreciationcalculated boolean DEFAULT false NOT NULL,
ispersonal boolean DEFAULT false NOT NULL,
description citext,
location citext,
uptime citext,
sysname citext,
scanserialnumber citext,
isloanable boolean DEFAULT false NOT NULL,
ipaddresses citext,
primaryipaddress citext,
macaddresses citext,
createdtime bigint,
modifiedtime bigint,
createdby bigint,
modifiedby bigint,
chassistypeid bigint,
CONSTRAINT resources_1019570504_c CHECK ((length((sysname)::text) <= 150)),
CONSTRAINT resources_1503470021_c CHECK ((length((ipaddresses)::text) <= 1500)),
CONSTRAINT resources_1565640405_c CHECK ((length((primaryipaddress)::text) <= 500)),
CONSTRAINT resources_1611296843_c CHECK ((length((location)::text) <= 50)),
CONSTRAINT resources_1785032728_c CHECK ((length((uptime)::text) <= 100)),
CONSTRAINT resources_1907123514_c CHECK ((length((scanserialnumber)::text) <= 150)),
CONSTRAINT resources_1933668249_c CHECK ((length((resourcename)::text) <= 200)),
CONSTRAINT resources_2145366347_c CHECK ((length((serialno)::text) <= 50)),
CONSTRAINT resources_403617997_c CHECK ((length((macaddresses)::text) <= 1500)),
CONSTRAINT resources_409444010_c CHECK ((length((assettag)::text) <= 50)),
CONSTRAINT resources_428414940_c CHECK ((length((description)::text) <= 500))
);
CREATE TABLE public.resources_otherappsmap (
mappingid bigint NOT NULL,
resourceid bigint NOT NULL,
otherappid bigint NOT NULL,
scantype bigint NOT NULL
);
CREATE TABLE public.resourcesqamapping (
uid bigint NOT NULL,
mappingid bigint NOT NULL,
questionid bigint NOT NULL,
answer citext,
answercost double DEFAULT '0' NOT NULL,
CONSTRAINT resourcesqamapping_1935487934_c CHECK ((length((answer)::text) <= 2000))
);
CREATE TABLE public.resourcestate (
resourcestateid bigint NOT NULL,
statedesc citext NOT NULL,
displaystate citext NOT NULL,
description citext,
createdby bigint DEFAULT '-1' NOT NULL,
isdisposed boolean DEFAULT true NOT NULL,
isscanenabled boolean DEFAULT true NOT NULL,
maintainownership boolean DEFAULT false NOT NULL,
isownershipmandatory boolean DEFAULT false NOT NULL,
maintainlicenseinfo boolean DEFAULT true NOT NULL,
maintaincontractinfo boolean DEFAULT true NOT NULL,
maintainleaseinfo boolean DEFAULT true NOT NULL,
maintainbusinessservices boolean DEFAULT true NOT NULL,
maintainattachassets boolean DEFAULT true NOT NULL,
maintainattachcomponents boolean DEFAULT true NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT resourcestate_343950065_c CHECK ((length((displaystate)::text) <= 30)),
CONSTRAINT resourcestate_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT resourcestate_701178498_c CHECK ((length((statedesc)::text) <= 30))
);
CREATE TABLE public.resourcestatehistory (
statehistoryid bigint NOT NULL,
resourceid bigint NOT NULL,
resourcestateid bigint NOT NULL,
prevresourcestateid bigint,
starttime bigint NOT NULL,
endtime bigint,
userid bigint,
comments citext,
CONSTRAINT resourcestatehistory_180211188_c CHECK ((length((comments)::text) <= 250))
);
CREATE TABLE public.resourcetemplatemapping (
mappingid bigint NOT NULL,
resourceid bigint NOT NULL,
templateid bigint NOT NULL,
resource_column integer,
resource_order integer,
isdeleted boolean DEFAULT false
);
CREATE TABLE public.resourcetocost (
resourceid bigint NOT NULL,
purchasecost double DEFAULT '0',
operationalcost double DEFAULT '0',
currentcost double DEFAULT '0',
totalcost double DEFAULT '0'
);
CREATE TABLE public.resourcetype (
resourcetypeid bigint NOT NULL,
type citext NOT NULL,
CONSTRAINT resourcetype_2590522_c CHECK ((length((type)::text) <= 30))
);
CREATE TABLE public.riskdefinition (
riskid bigint NOT NULL,
name citext NOT NULL,
description citext,
isdeleted boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT riskdefinition_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT riskdefinition_428414940_c CHECK ((length((description)::text) <= 500))
);
CREATE TABLE public.rlc_template_association (
id bigint NOT NULL,
lifecycleid bigint NOT NULL,
templateid bigint NOT NULL,
isdraft boolean DEFAULT true NOT NULL
);
CREATE TABLE public.robofailureoptions (
robotaskid bigint NOT NULL,
setstatusid bigint,
assigntoinvoker boolean DEFAULT false NOT NULL,
setgroupid bigint,
settechnicianid bigint,
adderrortonotes boolean DEFAULT true NOT NULL,
addnotes citext
);
CREATE TABLE public.robosuccessoptions (
robotaskid bigint NOT NULL,
autoclose boolean DEFAULT false NOT NULL,
setstatusid bigint,
addresolution citext
);
CREATE TABLE public.robotaskconfig (
uid bigint NOT NULL,
robotaskid bigint NOT NULL,
parameter citext NOT NULL,
paramvalue citext,
CONSTRAINT robotaskconfig_446088073_c CHECK ((length((parameter)::text) <= 100)),
CONSTRAINT robotaskconfig_958969092_c CHECK ((length((paramvalue)::text) <= 100))
);
CREATE TABLE public.robotasklist (
robotaskid bigint NOT NULL,
taskname citext NOT NULL,
enabled boolean DEFAULT true NOT NULL,
asynchronous boolean DEFAULT false NOT NULL,
taskclass citext NOT NULL,
CONSTRAINT robotasklist_1324011789_c CHECK ((length((taskclass)::text) <= 200)),
CONSTRAINT robotasklist_373249424_c CHECK ((length((taskname)::text) <= 100))
);
CREATE TABLE public.roledefinition (
roleid bigint NOT NULL,
rolename citext NOT NULL,
helpdeskid bigint,
CONSTRAINT roledefinition_516800513_c CHECK ((length((rolename)::text) <= 50))
);
CREATE TABLE public.roletousermapping (
rumid bigint NOT NULL,
roleid bigint NOT NULL,
userid bigint NOT NULL,
entityvalue bigint
);
CREATE TABLE public.roomcategory (
roomcategoryid bigint NOT NULL,
roomcategoryname citext NOT NULL,
roomcategorydesc citext,
CONSTRAINT roomcategory_265747690_c CHECK ((length((roomcategorydesc)::text) <= 100)),
CONSTRAINT roomcategory_266041572_c CHECK ((length((roomcategoryname)::text) <= 100))
);
CREATE TABLE public.roomdefinition (
roomid bigint NOT NULL,
floorid bigint NOT NULL,
roomname citext NOT NULL,
roomarea bigint,
roomcategoryid bigint,
roomtype bigint,
roomdesc citext,
isdeleted boolean DEFAULT false,
CONSTRAINT roomdefinition_609782252_c CHECK ((length((roomdesc)::text) <= 300)),
CONSTRAINT roomdefinition_610076134_c CHECK ((length((roomname)::text) <= 100))
);
CREATE TABLE public.roomlayoutdefinition (
layoutid bigint NOT NULL,
layoutname citext NOT NULL,
description citext,
mediaid bigint,
issystemconfig boolean DEFAULT false,
isdeleted boolean DEFAULT false,
createdby bigint,
helpdeskid bigint NOT NULL,
CONSTRAINT roomlayoutdefinition_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT roomlayoutdefinition_827505845_c CHECK ((length((layoutname)::text) <= 100))
);
CREATE TABLE public.roomlayoutmapping (
roomid bigint NOT NULL,
layoutid bigint NOT NULL,
capacity integer NOT NULL
);
CREATE TABLE public.roomsensor (
ciid bigint NOT NULL
);
CREATE TABLE public.roomsensorlist (
ciid bigint NOT NULL,
sensorname citext NOT NULL,
sensortype citext,
CONSTRAINT roomsensorlist_2097389068_c CHECK ((length((sensortype)::text) <= 200)),
CONSTRAINT roomsensorlist_2097590971_c CHECK ((length((sensorname)::text) <= 200))
);
CREATE TABLE public.roomtype (
roomtypeid bigint NOT NULL,
roomtypename citext NOT NULL,
roomtypedesc citext,
roomarea bigint,
employeecount bigint,
CONSTRAINT roomtype_1796652710_c CHECK ((length((roomtypedesc)::text) <= 100)),
CONSTRAINT roomtype_1796946592_c CHECK ((length((roomtypename)::text) <= 100))
);
CREATE TABLE public.rootcause (
rootcauseid bigint NOT NULL,
rootcause citext,
problemid bigint NOT NULL,
rc_updated_by bigint NOT NULL,
rc_updated_on bigint NOT NULL
);
CREATE TABLE public.rootcauseattachment (
attachmentid bigint NOT NULL,
rootcauseid bigint NOT NULL
);
CREATE TABLE public.rootcauseimages (
rootcauseid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.router_firewall (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.router_router (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.router_supportgroup (
primarykeyid bigint NOT NULL,
supportlevel citext,
CONSTRAINT router_supportgroup_784370965_c CHECK ((length((supportlevel)::text) <= 100))
);
CREATE TABLE public.router_switchport (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.router_technician (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.routerci (
ciid bigint NOT NULL,
estimatedbw citext,
ostype citext,
osversion citext,
firmwarerevision citext,
cpu citext,
cpurevision citext,
dramsize bigint,
nvramsize bigint,
flashsize bigint,
configregister citext,
model citext,
CONSTRAINT routerci_133627535_c CHECK ((length((estimatedbw)::text) <= 250)),
CONSTRAINT routerci_1361021356_c CHECK ((length((osversion)::text) <= 50)),
CONSTRAINT routerci_1465801373_c CHECK ((length((cpurevision)::text) <= 50)),
CONSTRAINT routerci_1819135003_c CHECK ((length((configregister)::text) <= 50)),
CONSTRAINT routerci_1954021602_c CHECK ((length((ostype)::text) <= 50)),
CONSTRAINT routerci_610985622_c CHECK ((length((firmwarerevision)::text) <= 150)),
CONSTRAINT routerci_66952_c CHECK ((length((cpu)::text) <= 50)),
CONSTRAINT routerci_73532169_c CHECK ((length((model)::text) <= 200))
);
CREATE TABLE public.routerinterfaces (
ciid bigint NOT NULL,
ifindex citext NOT NULL,
ifdescr citext,
iftype citext,
ifspeed citext,
ifphyaddr citext,
address citext,
netmask citext,
ifoperstatus citext,
ifadminstatus citext,
CONSTRAINT routerinterfaces_1210744156_c CHECK ((length((ifadminstatus)::text) <= 100)),
CONSTRAINT routerinterfaces_1226171115_c CHECK ((length((ifphyaddr)::text) <= 100)),
CONSTRAINT routerinterfaces_1733810711_c CHECK ((length((netmask)::text) <= 100)),
CONSTRAINT routerinterfaces_1848563414_c CHECK ((length((ifspeed)::text) <= 100)),
CONSTRAINT routerinterfaces_1857859147_c CHECK ((length((ifindex)::text) <= 100)),
CONSTRAINT routerinterfaces_1862730524_c CHECK ((length((ifdescr)::text) <= 100)),
CONSTRAINT routerinterfaces_2137802281_c CHECK ((length((iftype)::text) <= 100)),
CONSTRAINT routerinterfaces_429709356_c CHECK ((length((address)::text) <= 100)),
CONSTRAINT routerinterfaces_604928157_c CHECK ((length((ifoperstatus)::text) <= 100))
);
CREATE TABLE public.rule_actionsmap (
actionid bigint NOT NULL,
ruleid bigint NOT NULL,
actiontype citext NOT NULL,
CONSTRAINT rule_actionsmap_1957040528_c CHECK ((length((actiontype)::text) <= 50))
);
CREATE TABLE public.rule_externalaction (
scriptactionid bigint NOT NULL,
actionid bigint NOT NULL,
command citext NOT NULL,
CONSTRAINT rule_externalaction_1668377387_c CHECK ((length((command)::text) <= 500))
);
CREATE TABLE public.rule_selectquery (
rulesqid bigint NOT NULL,
ruleid bigint NOT NULL,
queryid bigint
);
CREATE TABLE public.ruleactionfieldsmap (
ruleactionfieldsmapid bigint NOT NULL,
ruleactionid bigint NOT NULL,
fieldid bigint,
fieldvalue citext
);
CREATE TABLE public.ruleactionsmap (
ruleactionid bigint NOT NULL,
ruleid bigint NOT NULL,
ruleactiontypeid bigint NOT NULL
);
CREATE TABLE public.ruleactiontypes (
ruleactiontypeid bigint NOT NULL,
actionname citext NOT NULL,
CONSTRAINT ruleactiontypes_1957242431_c CHECK ((length((actionname)::text) <= 100))
);
CREATE TABLE public.rulecfmapping (
wfactionid bigint NOT NULL,
cfdetailid bigint NOT NULL
);
CREATE TABLE public.rulecriteriafieldvalues (
rulecriteriafieldvaluesid bigint NOT NULL,
rulecriteriaid bigint NOT NULL,
fieldvalue citext
);
CREATE TABLE public.rulecriteriamap (
rulecriteriaid bigint NOT NULL,
ruleid bigint NOT NULL,
fieldid bigint,
condition_string citext NOT NULL,
operator_string citext NOT NULL,
CONSTRAINT rulecriteriamap_1098535893_c CHECK ((length((condition_string)::text) <= 100)),
CONSTRAINT rulecriteriamap_1098774540_c CHECK ((length((operator_string)::text) <= 100))
);
CREATE TABLE public.ruledata (
ruleid bigint NOT NULL,
rulename citext NOT NULL,
description citext,
usertype citext NOT NULL,
isenabled boolean DEFAULT true NOT NULL,
jscode citext,
formtype citext NOT NULL,
ruletypeid bigint NOT NULL,
fieldid bigint,
module citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
ruletype integer DEFAULT 1 NOT NULL,
CONSTRAINT ruledata_1257277950_c CHECK ((length((formtype)::text) <= 100)),
CONSTRAINT ruledata_1546855303_c CHECK ((length((rulename)::text) <= 250)),
CONSTRAINT ruledata_2015454612_c CHECK ((length((module)::text) <= 100)),
CONSTRAINT ruledata_428414940_c CHECK ((length((description)::text) <= 500)),
CONSTRAINT ruledata_517115269_c CHECK ((length((usertype)::text) <= 100))
);
CREATE TABLE public.ruledefinition (
ruleid bigint NOT NULL,
rulename citext NOT NULL,
comments citext,
orderid bigint NOT NULL,
siteid bigint,
isdeactivated boolean DEFAULT false NOT NULL,
iscascade boolean DEFAULT false NOT NULL,
overridevalues boolean DEFAULT false NOT NULL,
whentoexec integer DEFAULT 1 NOT NULL,
notifybyemail boolean DEFAULT false NOT NULL,
notifybysms boolean DEFAULT false NOT NULL,
timetoexecute integer DEFAULT 1 NOT NULL,
module citext DEFAULT 'Request' NOT NULL,
type citext DEFAULT 'PRE' NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
criteriajson citext,
CONSTRAINT ruledefinition_1546855303_c CHECK ((length((rulename)::text) <= 100)),
CONSTRAINT ruledefinition_2015454612_c CHECK ((length((module)::text) <= 20)),
CONSTRAINT ruledefinition_2590522_c CHECK ((length((type)::text) <= 50))
);
CREATE TABLE public.ruleeventtypes (
ruletypeid bigint NOT NULL,
ruletype citext NOT NULL,
CONSTRAINT ruleeventtypes_1547057206_c CHECK ((length((ruletype)::text) <= 100))
);
CREATE TABLE public.ruleformfield (
fieldid bigint NOT NULL,
fieldname citext NOT NULL,
listener citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT ruleformfield_2128786612_c CHECK ((length((listener)::text) <= 100)),
CONSTRAINT ruleformfield_242409883_c CHECK ((length((fieldname)::text) <= 100))
);
CREATE TABLE public.ruletemplatesmap (
ruletemplateid bigint NOT NULL,
ruleid bigint NOT NULL,
templateid bigint NOT NULL
);
CREATE TABLE public.samlidp (
id bigint NOT NULL,
domain citext,
sso_url citext NOT NULL,
slo_url citext,
slo_response_url citext,
signed boolean DEFAULT false,
validate_signature boolean DEFAULT true,
certificate bytea NOT NULL,
algorithm citext,
enabled boolean DEFAULT false,
name_id_format citext DEFAULT 'urn:oasis:names:tc:SAML:2.0:nameid-format:transient' NOT NULL,
name_id citext,
CONSTRAINT samlidp_1194513665_c CHECK ((length((sso_url)::text) <= 255)),
CONSTRAINT samlidp_1282882481_c CHECK ((length((algorithm)::text) <= 50)),
CONSTRAINT samlidp_1394917722_c CHECK ((length((slo_url)::text) <= 255)),
CONSTRAINT samlidp_1855001777_c CHECK ((length((name_id)::text) <= 100)),
CONSTRAINT samlidp_1994553063_c CHECK ((length((name_id_format)::text) <= 100)),
CONSTRAINT samlidp_2022099140_c CHECK ((length((domain)::text) <= 100)),
CONSTRAINT samlidp_444952358_c CHECK ((length((slo_response_url)::text) <= 255))
);
CREATE TABLE public.samlsp (
id bigint NOT NULL,
entity_id citext DEFAULT 'me.com' NOT NULL,
acs_url citext NOT NULL,
sls_url citext,
certificate bytea,
private_key bytea,
auth_request_signed boolean DEFAULT false,
CONSTRAINT samlsp_1391223638_c CHECK ((length((sls_url)::text) <= 255)),
CONSTRAINT samlsp_2046060279_c CHECK ((length((entity_id)::text) <= 100)),
CONSTRAINT samlsp_444083071_c CHECK ((length((acs_url)::text) <= 255))
);
CREATE TABLE public.sapprovaldetails (
approvalid bigint NOT NULL,
woid bigint NOT NULL,
userid bigint,
orgroleid bigint
);
CREATE TABLE public.sb_applications (
appl_id bigint NOT NULL,
appl_name citext NOT NULL,
appl_desc citext,
template_meta_handler citext,
dc_type citext,
CONSTRAINT sb_applications_2065780998_c CHECK ((length((dc_type)::text) <= 250)),
CONSTRAINT sb_applications_313853589_c CHECK ((length((template_meta_handler)::text) <= 250)),
CONSTRAINT sb_applications_716945381_c CHECK ((length((appl_desc)::text) <= 1000)),
CONSTRAINT sb_applications_717239263_c CHECK ((length((appl_name)::text) <= 200))
);
CREATE TABLE public.sc_templateslaassn_ug (
id bigint NOT NULL,
association bigint NOT NULL,
usergroup bigint NOT NULL
);
CREATE TABLE public.sc_templateslaassociation (
id bigint NOT NULL,
template bigint NOT NULL,
sla bigint NOT NULL,
info citext,
isdefault boolean DEFAULT false NOT NULL,
deleted boolean DEFAULT false,
CONSTRAINT sc_templateslaassociation_2251950_c CHECK ((length((info)::text) <= 2000))
);
CREATE TABLE public.scanjobstatuses (
statusid bigint NOT NULL,
status citext NOT NULL,
isfinalstate boolean DEFAULT false,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT scanjobstatuses_1839152142_c CHECK ((length((status)::text) <= 100))
);
CREATE TABLE public.scannerci (
ciid bigint NOT NULL
);
CREATE TABLE public.sccmconfiginfo (
sccmid bigint NOT NULL,
name citext NOT NULL,
description citext,
hostname citext NOT NULL,
port bigint NOT NULL,
dbname citext NOT NULL,
credentialid bigint,
schedule_id bigint,
associatedtosite bigint,
CONSTRAINT sccmconfiginfo_2010123273_c CHECK ((length((dbname)::text) <= 250)),
CONSTRAINT sccmconfiginfo_2388619_c CHECK ((length((name)::text) <= 250)),
CONSTRAINT sccmconfiginfo_428414940_c CHECK ((length((description)::text) <= 1000)),
CONSTRAINT sccmconfiginfo_482823219_c CHECK ((length((hostname)::text) <= 250))
);
CREATE TABLE public.sccmcredentials (
credentialid bigint NOT NULL,
domain citext,
authmode citext NOT NULL,
CONSTRAINT sccmcredentials_2022099140_c CHECK ((length((domain)::text) <= 250)),
CONSTRAINT sccmcredentials_2079329461_c CHECK ((length((authmode)::text) <= 250))
);
CREATE TABLE public.sccmlastscanmap (
sccmid bigint NOT NULL,
auditid bigint
);
CREATE TABLE public.sccmscanaudit (
auditid bigint NOT NULL,
sccmid bigint,
sccmname citext NOT NULL,
scanstatus boolean,
isrunning boolean,
audittoken citext,
starttime timestamp without time zone,
stoptime timestamp without time zone,
devicescannedcount bigint,
devicesuccesscount bigint,
newdevicecount bigint,
removeddevicecount bigint,
lastscanadded citext,
lastscanremoved citext,
isfirstscan boolean DEFAULT false NOT NULL,
comment citext,
CONSTRAINT sccmscanaudit_2098119938_c CHECK ((length((audittoken)::text) <= 250)),
CONSTRAINT sccmscanaudit_50772923_c CHECK ((length((sccmname)::text) <= 250))
);
CREATE TABLE public.schedule (
schedule_id bigint NOT NULL,
schedule_name citext NOT NULL,
description citext DEFAULT 'No Description' NOT NULL,
CONSTRAINT schedule_428414940_c CHECK ((length((description)::text) <= 150)),
CONSTRAINT schedule_528461619_c CHECK ((length((schedule_name)::text) <= 150))
);
CREATE TABLE public.schedule_audit (
audit_id bigint NOT NULL,
schedule_id bigint,
schedule_name citext NOT NULL,
task_input_id bigint,
schedule_start_time timestamp without time zone NOT NULL,
schedule_finish_time timestamp without time zone NOT NULL,
task_id bigint,
task_name citext NOT NULL,
task_execution_status citext NOT NULL,
status_message citext,
scheduled_time timestamp without time zone,
CONSTRAINT schedule_audit_1298093819_c CHECK ((length((task_name)::text) <= 150)),
CONSTRAINT schedule_audit_1810162842_c CHECK ((length((status_message)::text) <= 255)),
CONSTRAINT schedule_audit_528461619_c CHECK ((length((schedule_name)::text) <= 150)),
CONSTRAINT schedule_audit_794939757_c CHECK ((length((task_execution_status)::text) <= 20))
);
CREATE TABLE public.schedule_view (
id bigint NOT NULL,
schedule_name citext NOT NULL,
viewname citext NOT NULL,
CONSTRAINT schedule_view_1979239088_c CHECK ((length((viewname)::text) <= 50)),
CONSTRAINT schedule_view_528461619_c CHECK ((length((schedule_name)::text) <= 50))
);
CREATE TABLE public.scheduled_task (
schedule_id bigint NOT NULL,
task_id bigint NOT NULL,
offset_ms integer DEFAULT 100 NOT NULL,
schedule_mode integer DEFAULT 2 NOT NULL,
admin_status integer DEFAULT 3 NOT NULL,
audit_flag boolean DEFAULT false NOT NULL,
transaction_time integer DEFAULT 0 NOT NULL,
retry_schedule_id bigint,
skip_missed_schedule boolean DEFAULT false NOT NULL,
remove_on_expiry boolean DEFAULT false NOT NULL,
retry_handler citext,
remind_before integer DEFAULT '-1' NOT NULL,
max_reminder_count integer DEFAULT '-1' NOT NULL,
reminded_count integer DEFAULT 0 NOT NULL,
execute_within integer DEFAULT '-1' NOT NULL,
CONSTRAINT scheduled_task_2380685_c CHECK ((length((retry_handler)::text) <= 250))
);
CREATE TABLE public.scheduledetails (
schedule_id bigint NOT NULL,
starttime bigint NOT NULL,
duration bigint,
frequency citext NOT NULL,
isadvanced boolean NOT NULL,
afteroccurrences integer,
endson bigint,
repetitionscompleted integer DEFAULT 0,
CONSTRAINT scheduledetails_1578396356_c CHECK ((length((frequency)::text) <= 7))
);
CREATE TABLE public.scheduledreports (
sch_id bigint NOT NULL,
format citext DEFAULT 'pdf' NOT NULL,
send_type citext DEFAULT 'mail' NOT NULL,
subject citext,
message citext,
attachment_name citext,
parameter_names citext,
parameter_values citext,
mail_context_name citext,
toaddress citext,
scheduleinfo citext,
maxfilesize integer,
CONSTRAINT scheduledreports_1149902580_c CHECK ((length((subject)::text) <= 50)),
CONSTRAINT scheduledreports_1161916056_c CHECK ((length((parameter_values)::text) <= 500)),
CONSTRAINT scheduledreports_1452085871_c CHECK ((length((send_type)::text) <= 50)),
CONSTRAINT scheduledreports_1493927182_c CHECK ((length((parameter_names)::text) <= 500)),
CONSTRAINT scheduledreports_1672907751_c CHECK ((length((message)::text) <= 500)),
CONSTRAINT scheduledreports_1688965895_c CHECK ((length((toaddress)::text) <= 500)),
CONSTRAINT scheduledreports_2019837757_c CHECK ((length((mail_context_name)::text) <= 50)),
CONSTRAINT scheduledreports_2079517687_c CHECK ((length((format)::text) <= 50)),
CONSTRAINT scheduledreports_473605159_c CHECK ((length((attachment_name)::text) <= 500)),
CONSTRAINT scheduledreports_814892091_c CHECK ((length((scheduleinfo)::text) <= 50))
);
CREATE TABLE public.scheduledtask_retry (
schedule_id bigint NOT NULL,
task_id bigint NOT NULL,
retry_count integer DEFAULT 0 NOT NULL,
retry_time_period bigint DEFAULT '5' NOT NULL,
retry_unit_of_time citext DEFAULT 'minutes' NOT NULL,
retry_factor integer DEFAULT 1 NOT NULL,
retried_count integer DEFAULT 0 NOT NULL,
CONSTRAINT scheduledtask_retry_551803089_c CHECK ((length((retry_unit_of_time)::text) <= 50))
);
CREATE TABLE public.sd_swins (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.sd_technician (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.sdactivedirectoryinfo (
ad_id bigint NOT NULL,
domain_id bigint NOT NULL,
server_name citext NOT NULL,
user_name citext,
user_password citext,
CONSTRAINT sdactivedirectoryinfo_1139478913_c CHECK ((length((user_name)::text) <= 100)),
CONSTRAINT sdactivedirectoryinfo_1423743495_c CHECK ((length((server_name)::text) <= 100)),
CONSTRAINT sdactivedirectoryinfo_1915155313_c CHECK ((length((user_password)::text) <= 100))
);
CREATE TABLE public.sdadfieldmap (
id bigint NOT NULL,
domain_id bigint,
sdfieldname citext NOT NULL,
adfieldname citext NOT NULL,
CONSTRAINT sdadfieldmap_1953239490_c CHECK ((length((adfieldname)::text) <= 250)),
CONSTRAINT sdadfieldmap_327113900_c CHECK ((length((sdfieldname)::text) <= 250))
);
CREATE TABLE public.sdauthorizedrole (
sdroleid bigint NOT NULL,
account_id bigint NOT NULL,
role_id bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.sdeskattachment (
attachmentid bigint NOT NULL,
attachmentname citext NOT NULL,
attachmentpath citext NOT NULL,
attachmentsize bigint NOT NULL,
attachmentkey citext,
description citext,
isdeleted boolean DEFAULT false NOT NULL,
attachedby bigint,
attachedon bigint,
module citext DEFAULT 'undefined' NOT NULL,
is_entity_associated boolean DEFAULT false NOT NULL,
contenttype citext DEFAULT '-' NOT NULL,
authenticationid bigint,
helpdeskid bigint,
CONSTRAINT sdeskattachment_1609410108_c CHECK ((length((attachmentkey)::text) <= 250)),
CONSTRAINT sdeskattachment_1764782867_c CHECK ((length((contenttype)::text) <= 250)),
CONSTRAINT sdeskattachment_2015454612_c CHECK ((length((module)::text) <= 250)),
CONSTRAINT sdeskattachment_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.sdldapfieldmap (
id bigint NOT NULL,
ldap_id bigint,
sdfieldname citext NOT NULL,
ldapfieldname citext NOT NULL,
import boolean DEFAULT true NOT NULL,
CONSTRAINT sdldapfieldmap_257444194_c CHECK ((length((ldapfieldname)::text) <= 250)),
CONSTRAINT sdldapfieldmap_456466228_c CHECK ((length((sdfieldname)::text) <= 250))
);
CREATE TABLE public.sdorganization (
org_id bigint NOT NULL,
name citext NOT NULL,
createdtime bigint NOT NULL,
description citext,
CONSTRAINT sdorganization_2388619_c CHECK ((length((name)::text) <= 250)),
CONSTRAINT sdorganization_428414940_c CHECK ((length((description)::text) <= 2500))
);
CREATE TABLE public.sdorganizationimages (
org_id bigint NOT NULL,
mediaid bigint,
helpdeskid bigint
);
CREATE TABLE public.sdorgcontactinfo (
org_id bigint NOT NULL,
contactinfo_id bigint NOT NULL
);
CREATE TABLE public.sdorgcontactuser (
org_id bigint NOT NULL,
user_id bigint NOT NULL
);
CREATE TABLE public.sdorgdetail (
org_id bigint NOT NULL,
legalname citext,
alias citext,
emp_count bigint DEFAULT '1' NOT NULL,
displaylogoinpo boolean DEFAULT false NOT NULL,
CONSTRAINT sdorgdetail_588966052_c CHECK ((length((legalname)::text) <= 100)),
CONSTRAINT sdorgdetail_62365232_c CHECK ((length((alias)::text) <= 50))
);
CREATE TABLE public.sdorgpostaladdr (
org_id bigint NOT NULL,
postaladdr_id bigint NOT NULL
);
CREATE TABLE public.sdorgstatus (
org_id bigint NOT NULL,
status citext DEFAULT 'ACTIVE' NOT NULL,
updatedtime bigint NOT NULL,
CONSTRAINT sdorgstatus_1839152142_c CHECK ((length((status)::text) <= 20))
);
CREATE TABLE public.sdorguser (
org_id bigint NOT NULL,
user_id bigint NOT NULL,
type citext DEFAULT 'CONSULTANT' NOT NULL,
CONSTRAINT sdorguser_2590522_c CHECK ((length((type)::text) <= 30))
);
CREATE TABLE public.sdpamconf (
pammodule_id bigint NOT NULL,
execorder integer DEFAULT 0 NOT NULL
);
CREATE TABLE public.sdpdctechniciansyncbacklog (
entryid bigint NOT NULL,
userid bigint NOT NULL,
operation citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT sdpdctechniciansyncbacklog_154330439_c CHECK ((length((operation)::text) <= 250))
);
CREATE TABLE public.sdpjobsinfo (
sdpjobid bigint NOT NULL,
resourceid bigint,
resourcename citext NOT NULL,
dcresourceid bigint,
dcjobid bigint,
audittokenid bigint,
statusid bigint,
auditid bigint,
dcerrorcode citext,
dcerrormessage citext,
dckblink citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT sdpjobsinfo_1933668249_c CHECK ((length((resourcename)::text) <= 200)),
CONSTRAINT sdpjobsinfo_204301552_c CHECK ((length((dckblink)::text) <= 500)),
CONSTRAINT sdpjobsinfo_640516354_c CHECK ((length((dcerrormessage)::text) <= 100)),
CONSTRAINT sdpjobsinfo_901472822_c CHECK ((length((dcerrorcode)::text) <= 20))
);
CREATE TABLE public.sdpnotes (
notesid bigint NOT NULL,
userid bigint NOT NULL,
recordeddate bigint NOT NULL,
description citext NOT NULL,
ispublic boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.sdpod_entity (
id bigint NOT NULL,
name citext NOT NULL,
display_name citext NOT NULL,
display_name_plural citext,
description citext,
category citext,
api_plural_name citext,
icon_name citext,
created_time bigint,
created_by bigint,
last_modified_time bigint,
last_modified_by bigint,
CONSTRAINT sdpod_entity_1263948699_c CHECK ((length((display_name_plural)::text) <= 250)),
CONSTRAINT sdpod_entity_1425529489_c CHECK ((length((icon_name)::text) <= 250)),
CONSTRAINT sdpod_entity_2388619_c CHECK ((length((name)::text) <= 250)),
CONSTRAINT sdpod_entity_333046776_c CHECK ((length((display_name)::text) <= 250)),
CONSTRAINT sdpod_entity_428414940_c CHECK ((length((description)::text) <= 500)),
CONSTRAINT sdpod_entity_833137918_c CHECK ((length((category)::text) <= 100)),
CONSTRAINT sdpod_entity_940480607_c CHECK ((length((api_plural_name)::text) <= 250))
);
CREATE TABLE public.sdroles (
id bigint NOT NULL,
role_id bigint NOT NULL,
helpdeskid bigint
);
CREATE TABLE public.sdsamlfieldmap (
id bigint NOT NULL,
samlidp bigint NOT NULL,
sdfieldname citext NOT NULL,
samlfieldname citext NOT NULL,
import boolean DEFAULT true NOT NULL,
CONSTRAINT sdsamlfieldmap_2001039208_c CHECK ((length((samlfieldname)::text) <= 500)),
CONSTRAINT sdsamlfieldmap_456466228_c CHECK ((length((sdfieldname)::text) <= 250))
);
CREATE TABLE public.sdseqgenstate (
seqid bigint NOT NULL,
seqname citext NOT NULL,
currentbatchend bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.sduser (
userid bigint NOT NULL,
employeeid citext,
jobtitle citext,
status citext DEFAULT 'ACTIVE',
smsmailid citext,
domain_id bigint,
secondemailid citext,
ldap_id bigint,
user_dn citext,
reportingto bigint,
isvipuser boolean DEFAULT false NOT NULL,
firstname citext,
middlename citext,
lastname citext,
is_in_ad citext,
deleted_by bigint,
deleted_time bigint,
file_protect_password bytea,
typeid bigint NOT NULL,
created_by bigint,
extension citext,
enabletelephony boolean DEFAULT false NOT NULL,
sipuser citext,
CONSTRAINT sduser_1337232035_c CHECK ((length((secondemailid)::text) <= 200)),
CONSTRAINT sduser_1374583525_c CHECK ((length((firstname)::text) <= 150)),
CONSTRAINT sduser_1480181883_c CHECK ((length((sipuser)::text) <= 250)),
CONSTRAINT sduser_1814100520_c CHECK ((length((is_in_ad)::text) <= 50)),
CONSTRAINT sduser_1839152142_c CHECK ((length((status)::text) <= 50)),
CONSTRAINT sduser_2120930273_c CHECK ((length((extension)::text) <= 50)),
CONSTRAINT sduser_22337653_c CHECK ((length((smsmailid)::text) <= 150)),
CONSTRAINT sduser_332173920_c CHECK ((length((middlename)::text) <= 150)),
CONSTRAINT sduser_570880382_c CHECK ((length((user_dn)::text) <= 300)),
CONSTRAINT sduser_653126729_c CHECK ((length((employeeid)::text) <= 50)),
CONSTRAINT sduser_676019679_c CHECK ((length((lastname)::text) <= 150)),
CONSTRAINT sduser_813349701_c CHECK ((length((jobtitle)::text) <= 150))
);
CREATE TABLE public.sduserprofile (
userid bigint NOT NULL,
timezoneid bigint,
date_format citext,
time_format citext,
signature citext,
kbshortcuts boolean DEFAULT true,
mediaid bigint,
CONSTRAINT sduserprofile_1458413992_c CHECK ((length((date_format)::text) <= 250)),
CONSTRAINT sduserprofile_434788200_c CHECK ((length((signature)::text) <= 10000)),
CONSTRAINT sduserprofile_967134633_c CHECK ((length((time_format)::text) <= 250))
);
CREATE TABLE public.sduserprojectroles (
id bigint NOT NULL,
userid bigint NOT NULL,
projectroleid bigint,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.sdusertype (
typeid bigint NOT NULL,
type citext NOT NULL,
description citext,
CONSTRAINT sdusertype_2590522_c CHECK ((length((type)::text) <= 100)),
CONSTRAINT sdusertype_428414940_c CHECK ((length((description)::text) <= 2500))
);
CREATE TABLE public.searchmodule (
moduleid bigint NOT NULL,
name citext NOT NULL,
basetable citext NOT NULL,
indexbyfield boolean DEFAULT false NOT NULL,
CONSTRAINT searchmodule_2388619_c CHECK ((length((name)::text) <= 50)),
CONSTRAINT searchmodule_988995453_c CHECK ((length((basetable)::text) <= 50))
);
CREATE TABLE public.searchtable (
columnid bigint NOT NULL,
searchgroup citext NOT NULL,
tablename citext NOT NULL,
columnname citext NOT NULL,
displayname citext NOT NULL,
datatype citext NOT NULL,
sortorder bigint NOT NULL,
related_table citext,
related_idcol citext,
related_namecol citext,
CONSTRAINT searchtable_1619616031_c CHECK ((length((columnname)::text) <= 100)),
CONSTRAINT searchtable_1621061047_c CHECK ((length((searchgroup)::text) <= 20)),
CONSTRAINT searchtable_1626204479_c CHECK ((length((related_namecol)::text) <= 100)),
CONSTRAINT searchtable_1722316316_c CHECK ((length((datatype)::text) <= 20)),
CONSTRAINT searchtable_217233713_c CHECK ((length((related_idcol)::text) <= 100)),
CONSTRAINT searchtable_227302010_c CHECK ((length((related_table)::text) <= 100)),
CONSTRAINT searchtable_426904019_c CHECK ((length((displayname)::text) <= 100)),
CONSTRAINT searchtable_798830393_c CHECK ((length((tablename)::text) <= 100))
);
CREATE TABLE public.sectionconfig (
section_id bigint NOT NULL,
name citext NOT NULL,
fieldattributes citext NOT NULL,
sectionattributes citext,
style_properties citext,
columncount citext,
helptext citext,
is_common boolean DEFAULT false NOT NULL,
entity_id bigint NOT NULL,
CONSTRAINT sectionconfig_1321776985_c CHECK ((length((columncount)::text) <= 2)),
CONSTRAINT sectionconfig_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT sectionconfig_6194194_c CHECK ((length((helptext)::text) <= 250))
);
CREATE TABLE public.selcol_expression (
queryid bigint NOT NULL,
tablealias citext NOT NULL,
columnindex integer NOT NULL,
expression_id bigint NOT NULL,
CONSTRAINT selcol_expression_1017743550_c CHECK ((length((tablealias)::text) <= 50))
);
CREATE TABLE public.selectcolumn (
queryid bigint NOT NULL,
columnindex integer NOT NULL,
columnalias citext,
columnname citext,
tablealias citext NOT NULL,
CONSTRAINT selectcolumn_1017743550_c CHECK ((length((tablealias)::text) <= 50)),
CONSTRAINT selectcolumn_1319828634_c CHECK ((length((columnalias)::text) <= 300)),
CONSTRAINT selectcolumn_1619616031_c CHECK ((length((columnname)::text) <= 50))
);
CREATE TABLE public.selectquery (
queryid bigint NOT NULL,
startindex integer,
numofobjects integer
);
CREATE TABLE public.selectsqlstring (
query_id bigint NOT NULL,
query_key citext NOT NULL,
select_sql citext NOT NULL,
CONSTRAINT selectsqlstring_1169572885_c CHECK ((length((select_sql)::text) <= 4000)),
CONSTRAINT selectsqlstring_980999720_c CHECK ((length((query_key)::text) <= 100))
);
CREATE TABLE public.selecttable (
queryid bigint NOT NULL,
tablealias citext NOT NULL,
tablename citext NOT NULL,
CONSTRAINT selecttable_1017743550_c CHECK ((length((tablealias)::text) <= 50)),
CONSTRAINT selecttable_798830393_c CHECK ((length((tablename)::text) <= 50))
);
CREATE TABLE public.seqgenstate (
seqname citext NOT NULL,
currentbatchend bigint NOT NULL,
CONSTRAINT seqgenstate_1594000566_c CHECK ((length((seqname)::text) <= 100))
);
CREATE TABLE public.server (
ciid bigint NOT NULL
);
CREATE TABLE public.server_dc (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.server_router (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.server_sd (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.server_server (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.server_supportgroup (
primarykeyid bigint NOT NULL,
supportlevel citext,
CONSTRAINT server_supportgroup_784370965_c CHECK ((length((supportlevel)::text) <= 100))
);
CREATE TABLE public.server_technician (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.servercalinfo (
servercalid bigint NOT NULL,
softwareinfoid bigint NOT NULL,
licenseid bigint NOT NULL
);
CREATE TABLE public.serverconfiguration (
serverconfigid bigint NOT NULL,
serverparameter citext NOT NULL,
value citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT serverconfiguration_2052168614_c CHECK ((length((serverparameter)::text) <= 100)),
CONSTRAINT serverconfiguration_81434961_c CHECK ((length((value)::text) <= 150))
);
CREATE TABLE public.serverdetails (
serverid bigint NOT NULL,
poolname citext NOT NULL,
servername citext NOT NULL,
weight integer DEFAULT 1 NOT NULL,
serverorder integer NOT NULL,
CONSTRAINT serverdetails_1340064690_c CHECK ((length((servername)::text) <= 50)),
CONSTRAINT serverdetails_1418499239_c CHECK ((length((poolname)::text) <= 50))
);
CREATE TABLE public.serverserviceproviders (
cvtypeid bigint NOT NULL,
comm_mode integer NOT NULL,
spindex integer NOT NULL,
serviceprovider citext NOT NULL,
CONSTRAINT serverserviceproviders_1295770502_c CHECK ((length((serviceprovider)::text) <= 96))
);
CREATE TABLE public.serverstatus (
serverid bigint NOT NULL,
servername citext NOT NULL,
status integer,
CONSTRAINT serverstatus_1340064690_c CHECK ((length((servername)::text) <= 100))
);
CREATE TABLE public.service (
service_id bigint NOT NULL,
order_id integer,
module_id bigint NOT NULL,
service_name citext NOT NULL,
classname citext NOT NULL,
CONSTRAINT service_1517307933_c CHECK ((length((classname)::text) <= 250)),
CONSTRAINT service_1588253195_c CHECK ((length((service_name)::text) <= 100))
);
CREATE TABLE public.serviceaction (
serviceactionid bigint NOT NULL,
serviceid bigint NOT NULL,
actionname citext NOT NULL,
description citext,
isenabled boolean DEFAULT true,
prefunction bigint,
postfunction bigint,
module citext,
CONSTRAINT serviceaction_1957242431_c CHECK ((length((actionname)::text) <= 250)),
CONSTRAINT serviceaction_2015454612_c CHECK ((length((module)::text) <= 250)),
CONSTRAINT serviceaction_428414940_c CHECK ((length((description)::text) <= 500))
);
CREATE TABLE public.serviceactionconfig (
serviceactionconfigid bigint NOT NULL,
serviceactionid bigint NOT NULL,
param_key citext NOT NULL,
param_value citext NOT NULL,
param_type citext NOT NULL,
is_encrypted boolean DEFAULT false NOT NULL,
CONSTRAINT serviceactionconfig_446853997_c CHECK ((length((param_key)::text) <= 500)),
CONSTRAINT serviceactionconfig_967859148_c CHECK ((length((param_type)::text) <= 250))
);
CREATE TABLE public.serviceactionfields (
serviceactionfieldid bigint NOT NULL,
serviceactionid bigint NOT NULL,
fieldlabel citext NOT NULL,
defaultvalue citext,
index bigint NOT NULL,
iseditable boolean DEFAULT true NOT NULL,
fieldtype citext,
isresponsefield boolean DEFAULT true NOT NULL,
CONSTRAINT serviceactionfields_1073370682_c CHECK ((length((fieldlabel)::text) <= 500)),
CONSTRAINT serviceactionfields_1687708624_c CHECK ((length((defaultvalue)::text) <= 500)),
CONSTRAINT serviceactionfields_242207980_c CHECK ((length((fieldtype)::text) <= 250))
);
CREATE TABLE public.serviceactionfieldsdata (
serviceactionfieldsdataid bigint NOT NULL,
serviceactionfieldid bigint,
serviceid bigint,
module citext NOT NULL,
moduleid citext NOT NULL,
value citext,
CONSTRAINT serviceactionfieldsdata_2015454612_c CHECK ((length((module)::text) <= 100))
);
CREATE TABLE public.serviceapprovermapping (
serviceapproverid bigint NOT NULL,
servicetemplateid bigint NOT NULL,
notificationid bigint NOT NULL,
escalatetoid bigint NOT NULL,
stageid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.servicecatalog_fields (
workorderid bigint NOT NULL
);
CREATE TABLE public.servicedefext (
serviceid bigint NOT NULL,
groupid bigint
);
CREATE TABLE public.servicedefinition (
serviceid bigint NOT NULL,
name citext NOT NULL,
description citext,
ownerid bigint,
ownerid_autoid bigint,
status citext DEFAULT 'ACTIVE' NOT NULL,
isdeleted boolean DEFAULT false,
imagename citext,
ciid bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT servicedefinition_1839152142_c CHECK ((length((status)::text) <= 20)),
CONSTRAINT servicedefinition_1909198406_c CHECK ((length((imagename)::text) <= 200)),
CONSTRAINT servicedefinition_2388619_c CHECK ((length((name)::text) <= 100))
);
CREATE TABLE public.servicedefinitionsort (
uid bigint NOT NULL,
serviceid bigint,
sortindex bigint NOT NULL
);
CREATE TABLE public.servicedesktableview (
viewname citext,
columnalias citext NOT NULL,
viewname_no bigint NOT NULL,
CONSTRAINT servicedesktableview_1319828634_c CHECK ((length((columnalias)::text) <= 50)),
CONSTRAINT servicedesktableview_1979239088_c CHECK ((length((viewname)::text) <= 50))
);
CREATE TABLE public.serviceinfo (
serviceinfoid bigint NOT NULL,
servicename citext NOT NULL,
vendorservicestypeid bigint NOT NULL,
glcodeid bigint,
partno citext DEFAULT '-',
description citext,
isdeleted boolean DEFAULT false,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT serviceinfo_1942080268_c CHECK ((length((partno)::text) <= 100)),
CONSTRAINT serviceinfo_225342112_c CHECK ((length((servicename)::text) <= 150))
);
CREATE TABLE public.serviceintegaudit (
serviceintegauditid bigint NOT NULL,
module citext,
moduleid bigint,
serviceactionid bigint NOT NULL,
userid bigint,
"timestamp" bigint,
requestdata citext,
responsedata citext,
CONSTRAINT serviceintegaudit_2015454612_c CHECK ((length((module)::text) <= 100))
);
CREATE TABLE public.servicemetatable (
meta_id bigint NOT NULL,
serviceid bigint NOT NULL,
table_id bigint NOT NULL,
first_table boolean DEFAULT true NOT NULL,
next_table bigint,
is_archive_table boolean DEFAULT false NOT NULL,
is_pmtask_table boolean DEFAULT false NOT NULL
);
CREATE TABLE public.serviceproperties (
serviceprop_id bigint NOT NULL,
service_id bigint NOT NULL,
property citext NOT NULL,
value citext NOT NULL,
CONSTRAINT serviceproperties_210514475_c CHECK ((length((property)::text) <= 100)),
CONSTRAINT serviceproperties_81434961_c CHECK ((length((value)::text) <= 100))
);
CREATE TABLE public.servicereq_app (
workorderid bigint NOT NULL,
udf_char1 citext,
CONSTRAINT servicereq_app_278184717_c CHECK ((length((udf_char1)::text) <= 3500))
);
CREATE TABLE public.servicereq_comm (
workorderid bigint NOT NULL
);
CREATE TABLE public.servicereq_data (
workorderid bigint NOT NULL
);
CREATE TABLE public.servicereq_email (
workorderid bigint NOT NULL,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
udf_char5 citext,
udf_char6 citext,
udf_char7 citext,
CONSTRAINT servicereq_email_278184711_c CHECK ((length((udf_char7)::text) <= 3500)),
CONSTRAINT servicereq_email_278184712_c CHECK ((length((udf_char6)::text) <= 3500)),
CONSTRAINT servicereq_email_278184713_c CHECK ((length((udf_char5)::text) <= 3500)),
CONSTRAINT servicereq_email_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT servicereq_email_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT servicereq_email_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT servicereq_email_278184717_c CHECK ((length((udf_char1)::text) <= 3500))
);
CREATE TABLE public.servicereq_hw (
workorderid bigint NOT NULL,
udf_char1 citext,
CONSTRAINT servicereq_hw_278184717_c CHECK ((length((udf_char1)::text) <= 3500))
);
CREATE TABLE public.servicereq_net (
workorderid bigint NOT NULL,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
udf_date1 bigint,
udf_char5 citext,
CONSTRAINT servicereq_net_278184713_c CHECK ((length((udf_char5)::text) <= 3500)),
CONSTRAINT servicereq_net_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT servicereq_net_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT servicereq_net_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT servicereq_net_278184717_c CHECK ((length((udf_char1)::text) <= 3500))
);
CREATE TABLE public.servicereq_sw (
workorderid bigint NOT NULL,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
CONSTRAINT servicereq_sw_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT servicereq_sw_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT servicereq_sw_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT servicereq_sw_278184717_c CHECK ((length((udf_char1)::text) <= 3500))
);
CREATE TABLE public.servicereq_user (
workorderid bigint NOT NULL,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
udf_char5 citext,
udf_char6 citext,
udf_char7 citext,
CONSTRAINT servicereq_user_278184711_c CHECK ((length((udf_char7)::text) <= 3500)),
CONSTRAINT servicereq_user_278184712_c CHECK ((length((udf_char6)::text) <= 3500)),
CONSTRAINT servicereq_user_278184713_c CHECK ((length((udf_char5)::text) <= 3500)),
CONSTRAINT servicereq_user_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT servicereq_user_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT servicereq_user_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT servicereq_user_278184717_c CHECK ((length((udf_char1)::text) <= 3500))
);
CREATE TABLE public.servicerequestdata (
servicerequestdataid bigint NOT NULL,
serviceactionid bigint NOT NULL,
data citext
);
CREATE TABLE public.serviceresponsescript (
id bigint NOT NULL,
serviceactionid bigint NOT NULL,
script citext
);
CREATE TABLE public.services (
serviceid bigint NOT NULL,
servicename citext NOT NULL,
description citext,
configuration bytea,
isenabled boolean DEFAULT true,
CONSTRAINT services_225342112_c CHECK ((length((servicename)::text) <= 250)),
CONSTRAINT services_428414940_c CHECK ((length((description)::text) <= 500))
);
CREATE TABLE public.servicetemplate_cost (
templateid bigint NOT NULL,
templatecost double DEFAULT '0',
additionalcomments citext,
CONSTRAINT servicetemplate_cost_741237989_c CHECK ((length((additionalcomments)::text) <= 2000))
);
CREATE TABLE public.serviceusergroupmapping (
mappingid bigint NOT NULL,
usergroupid bigint NOT NULL,
servicetemplateid bigint NOT NULL
);
CREATE TABLE public.servicevendor (
servicevendorid bigint NOT NULL,
serviceinfoid bigint NOT NULL,
vendorid bigint NOT NULL,
servicecost double DEFAULT '0' NOT NULL,
taxrate double DEFAULT '0' NOT NULL,
serviceperiodyears bigint DEFAULT '0' NOT NULL,
serviceperiodmonths bigint DEFAULT '0' NOT NULL,
supportvendorid bigint,
comments citext
);
CREATE TABLE public.showagentupgrade (
user_id bigint NOT NULL
);
CREATE TABLE public.site_share_list (
shareid bigint NOT NULL,
siteid bigint
);
CREATE TABLE public.siteassociation (
associated_siteid bigint NOT NULL,
helpdeskid bigint NOT NULL
);
CREATE TABLE public.siteconfigsettings (
siteconfigid bigint NOT NULL,
siteid bigint NOT NULL,
configid integer NOT NULL,
settingdetail citext NOT NULL,
refer_to_site_id bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT siteconfigsettings_2088190593_c CHECK ((length((settingdetail)::text) <= 20))
);
CREATE TABLE public.sitedefinition (
siteid bigint NOT NULL,
regionid bigint,
isdeleted boolean DEFAULT false,
timezoneid bigint
);
CREATE TABLE public.siteipmapping (
id bigint NOT NULL,
siteid bigint NOT NULL,
ipaddress citext NOT NULL,
updatedby bigint,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.siteroletousermapping (
mappingid bigint NOT NULL,
orgroleid bigint NOT NULL,
userid bigint NOT NULL,
siteid bigint,
helpdeskid bigint
);
CREATE TABLE public.sla_selectquery (
slasqid bigint NOT NULL,
slaid bigint NOT NULL,
queryid bigint NOT NULL
);
CREATE TABLE public.sla_wostates (
escalationid bigint NOT NULL,
technicianid bigint,
portaltechid_autoid bigint,
queueid bigint,
priorityid bigint,
levelid bigint
);
CREATE TABLE public.sladefinition (
slaid bigint NOT NULL,
slaname citext NOT NULL,
from_date bigint DEFAULT '0' NOT NULL,
to_date bigint DEFAULT '0' NOT NULL,
expirystatus citext DEFAULT 'Enabled' NOT NULL,
duebydays bigint DEFAULT '0' NOT NULL,
duebyhours bigint DEFAULT '0' NOT NULL,
duebyminutes bigint DEFAULT '0' NOT NULL,
overrideoh boolean DEFAULT false NOT NULL,
overrideholidays boolean DEFAULT false NOT NULL,
overrideweekends boolean DEFAULT false NOT NULL,
comments citext,
orderid bigint NOT NULL,
siteid bigint,
isdeleted boolean DEFAULT false,
isservicesla boolean DEFAULT false NOT NULL,
is_fr_enabled boolean DEFAULT false NOT NULL,
fr_duebydays bigint DEFAULT '0' NOT NULL,
fr_duebyhours bigint DEFAULT '0' NOT NULL,
fr_duebyminutes bigint DEFAULT '0' NOT NULL,
is_ola_configured boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT sladefinition_1408372845_c CHECK ((length((slaname)::text) <= 100)),
CONSTRAINT sladefinition_478266085_c CHECK ((length((expirystatus)::text) <= 20))
);
CREATE TABLE public.slaescalation (
escalationid bigint NOT NULL,
slaid bigint NOT NULL,
level bigint NOT NULL,
status boolean DEFAULT false NOT NULL,
escalatetoid bigint,
escafterdays bigint DEFAULT '0' NOT NULL,
escafterhours bigint DEFAULT '0' NOT NULL,
escafterminutes bigint DEFAULT '0' NOT NULL,
esctoticketowner boolean DEFAULT false,
escalation_type citext DEFAULT 'SLA' NOT NULL,
CONSTRAINT slaescalation_825179812_c CHECK ((length((escalation_type)::text) <= 50))
);
CREATE TABLE public.slide_details (
slideid bigint NOT NULL,
tourid bigint NOT NULL,
orderid bigint DEFAULT '0',
roles citext,
name citext NOT NULL,
title citext NOT NULL,
description citext,
link citext,
type citext,
alignment citext,
isenabled boolean DEFAULT true NOT NULL,
isdraft boolean DEFAULT true NOT NULL,
CONSTRAINT slide_details_2336762_c CHECK ((length((link)::text) <= 1000)),
CONSTRAINT slide_details_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT slide_details_2590522_c CHECK ((length((type)::text) <= 500)),
CONSTRAINT slide_details_259502531_c CHECK ((length((alignment)::text) <= 500)),
CONSTRAINT slide_details_428414940_c CHECK ((length((description)::text) <= 500)),
CONSTRAINT slide_details_79833656_c CHECK ((length((title)::text) <= 100))
);
CREATE TABLE public.smartphone (
ciid bigint NOT NULL
);
CREATE TABLE public.smsconfig (
smsconfigid bigint NOT NULL,
smsmail boolean DEFAULT false,
serviceactionid bigint,
unicode_type citext,
CONSTRAINT smsconfig_112597124_c CHECK ((length((unicode_type)::text) <= 500))
);
CREATE TABLE public.smtpauthlogininfo (
serverid bigint NOT NULL,
loginname citext NOT NULL,
passwordid bigint,
CONSTRAINT smtpauthlogininfo_1068080468_c CHECK ((length((loginname)::text) <= 100))
);
CREATE TABLE public.snmpallowedvalues (
snmpallowedvalueid bigint NOT NULL,
snmpinventoryoiddataid bigint NOT NULL,
devicevalue citext NOT NULL,
displayvalue citext NOT NULL,
CONSTRAINT snmpallowedvalues_341734929_c CHECK ((length((displayvalue)::text) <= 200)),
CONSTRAINT snmpallowedvalues_630754491_c CHECK ((length((devicevalue)::text) <= 200))
);
CREATE TABLE public.snmpcredentials (
credentialid bigint NOT NULL,
communitystringid bigint,
portnumber bigint DEFAULT '161' NOT NULL,
timeout bigint DEFAULT '10' NOT NULL,
retries bigint DEFAULT '5' NOT NULL
);
CREATE TABLE public.snmpinventoryoiddata (
snmpinventoryoiddataid bigint NOT NULL,
snmpinventorydataid bigint NOT NULL,
oid citext NOT NULL,
label citext,
mib_file citext,
units citext,
tablename citext,
columnname citext,
oidtype citext,
attributeid bigint,
additionalfieldid bigint,
dividedby bigint,
isvalueinhex boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT snmpinventoryoiddata_1619616031_c CHECK ((length((columnname)::text) <= 200)),
CONSTRAINT snmpinventoryoiddata_72189652_c CHECK ((length((label)::text) <= 200)),
CONSTRAINT snmpinventoryoiddata_746335260_c CHECK ((length((oidtype)::text) <= 200)),
CONSTRAINT snmpinventoryoiddata_78250_c CHECK ((length((oid)::text) <= 200)),
CONSTRAINT snmpinventoryoiddata_798830393_c CHECK ((length((tablename)::text) <= 200)),
CONSTRAINT snmpinventoryoiddata_80895823_c CHECK ((length((units)::text) <= 200)),
CONSTRAINT snmpinventoryoiddata_899881995_c CHECK ((length((mib_file)::text) <= 100))
);
CREATE TABLE public.snmpinventorytype (
snmpinventorytypeid bigint NOT NULL,
inventorytype citext NOT NULL,
componenttypeid bigint,
vendorid bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT snmpinventorytype_1591784054_c CHECK ((length((inventorytype)::text) <= 100))
);
CREATE TABLE public.snmpinventorytypedata (
snmpinventorydataid bigint NOT NULL,
snmpinventorytypeid bigint NOT NULL,
type citext NOT NULL,
tablename citext,
label citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT snmpinventorytypedata_2590522_c CHECK ((length((type)::text) <= 200)),
CONSTRAINT snmpinventorytypedata_72189652_c CHECK ((length((label)::text) <= 200)),
CONSTRAINT snmpinventorytypedata_798830393_c CHECK ((length((tablename)::text) <= 200))
);
CREATE TABLE public.snmpinventorytypehierarchy (
snmpinvtypehierarchyid bigint NOT NULL,
snmpinventorytypeid bigint NOT NULL,
parentsnmpinventorytypeid bigint NOT NULL
);
CREATE TABLE public.snmpv3credentials (
credentialid bigint NOT NULL,
username citext NOT NULL,
contextname citext,
authenticationprotocol citext,
authenticationpwd bigint,
encryptionprotocol citext,
encryptionpwd bigint,
portnumber bigint NOT NULL,
timeout bigint NOT NULL,
retries bigint NOT NULL,
CONSTRAINT snmpv3credentials_1924444912_c CHECK ((length((authenticationprotocol)::text) <= 250)),
CONSTRAINT snmpv3credentials_2050872474_c CHECK ((length((contextname)::text) <= 250)),
CONSTRAINT snmpv3credentials_297056485_c CHECK ((length((encryptionprotocol)::text) <= 250)),
CONSTRAINT snmpv3credentials_516913366_c CHECK ((length((username)::text) <= 250))
);
CREATE TABLE public.softwareattachment (
attachmentid bigint NOT NULL,
softwareid bigint NOT NULL
);
CREATE TABLE public.softwarecategory (
softwarecategoryid bigint NOT NULL,
softwarecategory citext NOT NULL,
createdby bigint DEFAULT '-1' NOT NULL,
description citext DEFAULT '-' NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT softwarecategory_1246402651_c CHECK ((length((softwarecategory)::text) <= 50)),
CONSTRAINT softwarecategory_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.softwarecompliancetracking (
trackbyid bigint NOT NULL,
trackby citext NOT NULL,
description citext DEFAULT 'No Description' NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT softwarecompliancetracking_349412670_c CHECK ((length((trackby)::text) <= 50)),
CONSTRAINT softwarecompliancetracking_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.softwareimages (
softwareid bigint NOT NULL,
mediaid bigint NOT NULL,
"PRIMARY" boolean DEFAULT false NOT NULL
);
CREATE TABLE public.softwareinfo (
softwareinfoid bigint NOT NULL,
workstationid bigint NOT NULL,
softwareid bigint NOT NULL,
licenseid bigint,
software citext DEFAULT '-' NOT NULL,
location citext DEFAULT '-' NOT NULL,
filesize citext DEFAULT '-' NOT NULL,
fileversion citext DEFAULT '-',
filecreatedtime bigint,
addedby bigint,
ciid bigint,
issuiteinstallation boolean DEFAULT false NOT NULL,
CONSTRAINT softwareinfo_1556293700_c CHECK ((length((fileversion)::text) <= 100)),
CONSTRAINT softwareinfo_1611296843_c CHECK ((length((location)::text) <= 250)),
CONSTRAINT softwareinfo_2101957031_c CHECK ((length((software)::text) <= 100)),
CONSTRAINT softwareinfo_48015229_c CHECK ((length((filesize)::text) <= 20))
);
CREATE TABLE public.softwareinstallation (
ciid bigint NOT NULL,
primarykeyid bigint NOT NULL
);
CREATE TABLE public.softwareinstallationtypes (
installationtypeid bigint NOT NULL,
name citext NOT NULL,
displayname citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT softwareinstallationtypes_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT softwareinstallationtypes_426904019_c CHECK ((length((displayname)::text) <= 100))
);
CREATE TABLE public.softwarelicense_fields (
licenseid bigint NOT NULL,
udf_long1 bigint,
udf_long2 bigint,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
udf_char5 citext,
udf_char6 citext,
udf_date1 bigint,
udf_date2 bigint,
udf_long3 bigint,
udf_long4 bigint,
udf_char7 citext,
udf_char8 citext,
udf_char9 citext,
udf_char10 citext,
udf_char11 citext,
udf_char12 citext,
udf_date3 bigint,
udf_date4 bigint,
udf_cost1 double DEFAULT '0' NOT NULL,
udf_cost2 double DEFAULT '0' NOT NULL,
udf_cost3 double DEFAULT '0' NOT NULL,
udf_cost4 double DEFAULT '0' NOT NULL,
CONSTRAINT softwarelicense_fields_278184709_c CHECK ((length((udf_char9)::text) <= 3500)),
CONSTRAINT softwarelicense_fields_278184710_c CHECK ((length((udf_char8)::text) <= 3500)),
CONSTRAINT softwarelicense_fields_278184711_c CHECK ((length((udf_char7)::text) <= 3500)),
CONSTRAINT softwarelicense_fields_278184712_c CHECK ((length((udf_char6)::text) <= 3500)),
CONSTRAINT softwarelicense_fields_278184713_c CHECK ((length((udf_char5)::text) <= 3500)),
CONSTRAINT softwarelicense_fields_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT softwarelicense_fields_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT softwarelicense_fields_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT softwarelicense_fields_278184717_c CHECK ((length((udf_char1)::text) <= 3500)),
CONSTRAINT softwarelicense_fields_33791585_c CHECK ((length((udf_char12)::text) <= 3500)),
CONSTRAINT softwarelicense_fields_33791586_c CHECK ((length((udf_char11)::text) <= 3500)),
CONSTRAINT softwarelicense_fields_33791587_c CHECK ((length((udf_char10)::text) <= 3500))
);
CREATE TABLE public.softwarelicenseoptions (
licenseoptionid bigint NOT NULL,
licensetypeid bigint NOT NULL,
trackbyid bigint,
optionname citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT softwarelicenseoptions_1859431552_c CHECK ((length((optionname)::text) <= 250))
);
CREATE TABLE public.softwarelicenses (
resourceid bigint NOT NULL,
licensekey citext,
licensetypeid bigint DEFAULT '1' NOT NULL,
licenseoptionid bigint,
deptid bigint,
productid citext,
installationscount bigint,
upgradedcount bigint DEFAULT '0' NOT NULL,
isupgradelicense boolean DEFAULT false NOT NULL,
isdowngradelicense boolean DEFAULT false NOT NULL,
ispartialupgrade boolean DEFAULT false NOT NULL,
isrenewed boolean DEFAULT false NOT NULL,
allocated bigint DEFAULT '0' NOT NULL,
statusid bigint NOT NULL,
description citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT softwarelicenses_1734765098_c CHECK ((length((productid)::text) <= 100)),
CONSTRAINT softwarelicenses_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT softwarelicenses_921038210_c CHECK ((length((licensekey)::text) <= 250))
);
CREATE TABLE public.softwarelicensetypes (
licensetypeid bigint NOT NULL,
licensetype citext NOT NULL,
displayname citext DEFAULT '-' NOT NULL,
swmanufacturerid bigint,
trackbyid bigint,
installationtypeid bigint,
useraccesstypeid bigint,
createdby bigint,
isperpetual boolean DEFAULT false NOT NULL,
isfreelicense boolean DEFAULT false NOT NULL,
isfreesupport boolean DEFAULT false NOT NULL,
iscompanywide boolean DEFAULT false NOT NULL,
isnodelocked boolean DEFAULT false NOT NULL,
licenseorder bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT softwarelicensetypes_1512873691_c CHECK ((length((licensetype)::text) <= 100)),
CONSTRAINT softwarelicensetypes_426904019_c CHECK ((length((displayname)::text) <= 100))
);
CREATE TABLE public.softwarelist (
softwareid bigint NOT NULL,
softwarename citext NOT NULL,
swmanufacturerid bigint,
fileversion citext DEFAULT '-' NOT NULL,
productname citext DEFAULT '-' NOT NULL,
productversion citext DEFAULT '-' NOT NULL,
companyname citext DEFAULT '-' NOT NULL,
softwaretypeid bigint,
softwarecategoryid bigint NOT NULL,
currentlymetered boolean DEFAULT false NOT NULL,
description citext,
citypeid bigint,
cost double DEFAULT '0' NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT softwarelist_1556293700_c CHECK ((length((fileversion)::text) <= 100)),
CONSTRAINT softwarelist_1645331560_c CHECK ((length((companyname)::text) <= 250)),
CONSTRAINT softwarelist_428414940_c CHECK ((length((description)::text) <= 3500)),
CONSTRAINT softwarelist_662096858_c CHECK ((length((productname)::text) <= 100)),
CONSTRAINT softwarelist_667392265_c CHECK ((length((productversion)::text) <= 50)),
CONSTRAINT softwarelist_797874354_c CHECK ((length((softwarename)::text) <= 250))
);
CREATE TABLE public.softwaremanufacturer (
swmanufacturerid bigint NOT NULL,
name citext NOT NULL,
createdby bigint,
supportdeflicensetypes boolean DEFAULT true NOT NULL,
logo citext DEFAULT 'sw-nologo.png' NOT NULL,
description citext DEFAULT 'No Description' NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT softwaremanufacturer_2342315_c CHECK ((length((logo)::text) <= 50)),
CONSTRAINT softwaremanufacturer_2388619_c CHECK ((length((name)::text) <= 150)),
CONSTRAINT softwaremanufacturer_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.softwarenotification (
softwareinfoid bigint NOT NULL,
notificationid bigint,
description citext,
CONSTRAINT softwarenotification_428414940_c CHECK ((length((description)::text) <= 100))
);
CREATE TABLE public.softwaretype (
softwaretypeid bigint NOT NULL,
softwaretype citext NOT NULL,
createdby bigint DEFAULT '-1' NOT NULL,
description citext DEFAULT '-' NOT NULL,
enablesoftwarecompliance boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT softwaretype_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT softwaretype_798076257_c CHECK ((length((softwaretype)::text) <= 50))
);
CREATE TABLE public.softwareuseraccesstypes (
useraccesstypeid bigint NOT NULL,
name citext NOT NULL,
displayname citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT softwareuseraccesstypes_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT softwareuseraccesstypes_426904019_c CHECK ((length((displayname)::text) <= 100))
);
CREATE TABLE public.sol_statusdefinition (
statusid bigint NOT NULL,
statusname citext NOT NULL,
statusdescription citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT sol_statusdefinition_502347606_c CHECK ((length((statusdescription)::text) <= 250)),
CONSTRAINT sol_statusdefinition_733867389_c CHECK ((length((statusname)::text) <= 100))
);
CREATE TABLE public.solarisserver (
ciid bigint NOT NULL
);
CREATE TABLE public.solarisworkstation (
ciid bigint NOT NULL
);
CREATE TABLE public.solarwindsscanaudit (
auditid bigint NOT NULL,
scanstatus boolean,
isrunning boolean NOT NULL,
audittoken citext NOT NULL,
starttime timestamp without time zone NOT NULL,
stoptime timestamp without time zone,
devicescannedcount bigint,
devicesuccesscount bigint,
systemsuccesscount bigint,
networkdevicessuccesscount bigint,
systemfailedcount bigint,
networkdevicesfailedcount bigint,
newdevicecount bigint,
removeddevicecount bigint,
lastscanadded citext,
lastscanremoved citext,
unknownoidcount bigint,
isfirstscan boolean DEFAULT false NOT NULL,
comment citext,
helpdeskid bigint NOT NULL,
CONSTRAINT solarwindsscanaudit_2098119938_c CHECK ((length((audittoken)::text) <= 100))
);
CREATE TABLE public.solution (
solutionid bigint NOT NULL,
title citext NOT NULL,
description citext NOT NULL,
topicid bigint NOT NULL,
solutiontype citext DEFAULT 'Solution' NOT NULL,
statusid bigint,
attachments boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT solution_394436557_c CHECK ((length((solutiontype)::text) <= 100)),
CONSTRAINT solution_79833656_c CHECK ((length((title)::text) <= 3000))
);
CREATE TABLE public.solution_approvers (
solutionid bigint NOT NULL,
approverid bigint NOT NULL
);
CREATE TABLE public.solution_fields (
solutionid bigint NOT NULL,
udf_long1 bigint,
udf_long2 bigint,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
udf_char5 citext,
udf_char6 citext,
udf_date1 bigint,
udf_date2 bigint,
udf_long3 bigint,
udf_long4 bigint,
udf_char7 citext,
udf_char8 citext,
udf_char9 citext,
udf_char10 citext,
udf_char11 citext,
udf_char12 citext,
udf_date3 bigint,
udf_date4 bigint,
CONSTRAINT solution_fields_278184709_c CHECK ((length((udf_char9)::text) <= 3500)),
CONSTRAINT solution_fields_278184710_c CHECK ((length((udf_char8)::text) <= 3500)),
CONSTRAINT solution_fields_278184711_c CHECK ((length((udf_char7)::text) <= 3500)),
CONSTRAINT solution_fields_278184712_c CHECK ((length((udf_char6)::text) <= 3500)),
CONSTRAINT solution_fields_278184713_c CHECK ((length((udf_char5)::text) <= 3500)),
CONSTRAINT solution_fields_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT solution_fields_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT solution_fields_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT solution_fields_278184717_c CHECK ((length((udf_char1)::text) <= 3500)),
CONSTRAINT solution_fields_33791585_c CHECK ((length((udf_char12)::text) <= 3500)),
CONSTRAINT solution_fields_33791586_c CHECK ((length((udf_char11)::text) <= 3500)),
CONSTRAINT solution_fields_33791587_c CHECK ((length((udf_char10)::text) <= 3500))
);
CREATE TABLE public.solution_keywords (
keywordid bigint NOT NULL,
solutionid bigint NOT NULL,
keyword citext,
CONSTRAINT solution_keywords_96425527_c CHECK ((length((keyword)::text) <= 3500))
);
CREATE TABLE public.solutionglobalconfig (
globalconfigid bigint NOT NULL,
category citext NOT NULL,
parameter citext NOT NULL,
paramvalue citext NOT NULL,
description citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT solutionglobalconfig_428414940_c CHECK ((length((description)::text) <= 500)),
CONSTRAINT solutionglobalconfig_446088073_c CHECK ((length((parameter)::text) <= 500)),
CONSTRAINT solutionglobalconfig_833137918_c CHECK ((length((category)::text) <= 500)),
CONSTRAINT solutionglobalconfig_958969092_c CHECK ((length((paramvalue)::text) <= 500))
);
CREATE TABLE public.solutionhistory (
historyid bigint NOT NULL,
solutionid bigint NOT NULL,
operationownerid bigint NOT NULL,
description citext,
operationtime bigint NOT NULL,
operation citext NOT NULL,
statusid bigint NOT NULL,
CONSTRAINT solutionhistory_154330439_c CHECK ((length((operation)::text) <= 100))
);
CREATE TABLE public.solutionhistorydiff (
historydiffid bigint NOT NULL,
historyid bigint NOT NULL,
columnname citext NOT NULL,
prev_value citext,
current_value citext,
CONSTRAINT solutionhistorydiff_1619616031_c CHECK ((length((columnname)::text) <= 30))
);
CREATE TABLE public.solutioninfo (
solutionid bigint NOT NULL,
noofhits bigint DEFAULT '0' NOT NULL,
ispublic boolean DEFAULT false NOT NULL,
createdtime bigint NOT NULL,
createdby bigint NOT NULL,
lastupdatedtime bigint DEFAULT '-1' NOT NULL,
lastupdatedby bigint NOT NULL,
review_date bigint DEFAULT '-1' NOT NULL,
expiry_date bigint DEFAULT '-1' NOT NULL,
review_notified boolean DEFAULT false NOT NULL,
expiry_notified boolean DEFAULT false NOT NULL,
reviewdate_elapsed boolean DEFAULT false NOT NULL,
expirydate_elapsed boolean DEFAULT false NOT NULL,
has_user_group boolean DEFAULT false NOT NULL
);
CREATE TABLE public.solutionmedia (
solutionid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.solutionownerdefinition (
solutionid bigint NOT NULL,
ownerid bigint NOT NULL
);
CREATE TABLE public.solutionri (
itemid bigint NOT NULL,
solutionid bigint NOT NULL
);
CREATE TABLE public.solutionsattachment (
attachmentid bigint NOT NULL,
solutionid bigint NOT NULL
);
CREATE TABLE public.solutionsitemapping (
solutionid bigint NOT NULL,
siteid bigint NOT NULL
);
CREATE TABLE public.solutiontorequest (
mappingid bigint NOT NULL,
requestid bigint NOT NULL,
solutionid bigint NOT NULL,
associationtype citext NOT NULL,
comments citext,
associatedby bigint NOT NULL,
associatedtime bigint,
CONSTRAINT solutiontorequest_1125982437_c CHECK ((length((associationtype)::text) <= 100)),
CONSTRAINT solutiontorequest_180211188_c CHECK ((length((comments)::text) <= 3000))
);
CREATE TABLE public.solutiontoresolution (
problemid bigint NOT NULL,
solutionid bigint NOT NULL
);
CREATE TABLE public.solutiontoworkaround (
problemid bigint NOT NULL,
solutionid bigint NOT NULL
);
CREATE TABLE public.solutionugmapping (
mappingid bigint NOT NULL,
usergroupid bigint NOT NULL,
solutionid bigint NOT NULL
);
CREATE TABLE public.sortcol_expression (
queryid bigint NOT NULL,
tablealias citext NOT NULL,
sortindex integer NOT NULL,
expression_id bigint NOT NULL,
CONSTRAINT sortcol_expression_1017743550_c CHECK ((length((tablealias)::text) <= 50))
);
CREATE TABLE public.sortcolumn (
queryid bigint NOT NULL,
tablealias citext NOT NULL,
sortindex integer NOT NULL,
columnname citext,
columnalias citext,
ascending_order boolean,
isnullsfirst boolean,
CONSTRAINT sortcolumn_1017743550_c CHECK ((length((tablealias)::text) <= 50)),
CONSTRAINT sortcolumn_1319828634_c CHECK ((length((columnalias)::text) <= 50)),
CONSTRAINT sortcolumn_1619616031_c CHECK ((length((columnname)::text) <= 50))
);
CREATE TABLE public.sortcolumndetails (
sortcolumnid bigint NOT NULL,
viewid bigint NOT NULL,
userid bigint NOT NULL,
columnid bigint NOT NULL,
isascending boolean DEFAULT true NOT NULL,
helpdeskid bigint
);
CREATE TABLE public.soundcardinfo (
workstationid bigint NOT NULL,
soundcardname citext NOT NULL,
CONSTRAINT soundcardinfo_587091850_c CHECK ((length((soundcardname)::text) <= 100))
);
CREATE TABLE public.sourcefields (
sourcefieldid bigint NOT NULL,
componenttypeid bigint,
othermaptos citext,
displayname citext NOT NULL,
tablename citext NOT NULL,
columnname citext NOT NULL,
helpdeskid bigint,
CONSTRAINT sourcefields_1182422380_c CHECK ((length((othermaptos)::text) <= 250)),
CONSTRAINT sourcefields_1619616031_c CHECK ((length((columnname)::text) <= 250)),
CONSTRAINT sourcefields_426904019_c CHECK ((length((displayname)::text) <= 250)),
CONSTRAINT sourcefields_798830393_c CHECK ((length((tablename)::text) <= 250))
);
CREATE TABLE public.spaceamenitiesdefinition (
amenitiesid bigint NOT NULL,
amenitiesname citext NOT NULL,
description citext,
mediaid bigint,
createdby bigint,
isdeleted boolean DEFAULT false,
helpdeskid bigint NOT NULL,
CONSTRAINT spaceamenitiesdefinition_1564066818_c CHECK ((length((amenitiesname)::text) <= 100)),
CONSTRAINT spaceamenitiesdefinition_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.spacecriticalitiesdefinition (
criticalitiesid bigint NOT NULL,
criticalitiesname citext NOT NULL,
description citext,
mediaid bigint,
issystemconfig boolean DEFAULT false,
createdby bigint,
isdeleted boolean DEFAULT false,
helpdeskid bigint NOT NULL,
CONSTRAINT spacecriticalitiesdefinition_1640068472_c CHECK ((length((criticalitiesname)::text) <= 100)),
CONSTRAINT spacecriticalitiesdefinition_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.spacedocumentattachment (
attachmentid bigint NOT NULL,
documentid bigint NOT NULL
);
CREATE TABLE public.spacedocuments (
documentid bigint NOT NULL,
name citext NOT NULL,
description citext,
iconname citext,
createdtime bigint,
modifiedtime bigint,
createdby bigint,
modifiedby bigint,
spaceid bigint NOT NULL,
CONSTRAINT spacedocuments_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT spacedocuments_428414940_c CHECK ((length((description)::text) <= 100)),
CONSTRAINT spacedocuments_45466244_c CHECK ((length((iconname)::text) <= 100))
);
CREATE TABLE public.spaceparent (
spaceid bigint NOT NULL,
siteid bigint,
campusid bigint,
structureid bigint,
floorid bigint,
roomid bigint
);
CREATE TABLE public.spaceri (
itemid bigint NOT NULL,
spaceid bigint NOT NULL
);
CREATE TABLE public.spacestatusdefinition (
statusid bigint NOT NULL,
statusname citext NOT NULL,
description citext,
statuscolor citext,
issystemconfig boolean DEFAULT false,
isdeleted boolean DEFAULT false,
createdby bigint,
helpdeskid bigint NOT NULL,
internalname citext DEFAULT 'false' NOT NULL,
CONSTRAINT spacestatusdefinition_1265310353_c CHECK ((length((statuscolor)::text) <= 100)),
CONSTRAINT spacestatusdefinition_2056879416_c CHECK ((length((internalname)::text) <= 100)),
CONSTRAINT spacestatusdefinition_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT spacestatusdefinition_733867389_c CHECK ((length((statusname)::text) <= 100))
);
CREATE TABLE public.spacetoamenities (
spaceid bigint NOT NULL,
amenitiesid bigint NOT NULL
);
CREATE TABLE public.spacetoassetmapping (
mappingid bigint NOT NULL,
spaceid bigint NOT NULL,
resourceid bigint NOT NULL
);
CREATE TABLE public.spacetocriticalities (
spaceid bigint NOT NULL,
criticalitiesid bigint NOT NULL
);
CREATE TABLE public.spacetofacilityservicemapping (
mappingid bigint NOT NULL,
spaceid bigint NOT NULL,
serviceid bigint NOT NULL
);
CREATE TABLE public.spacetomaintenancemapping (
mappingid bigint NOT NULL,
spaceid bigint NOT NULL,
workorderid bigint NOT NULL
);
CREATE TABLE public.spacetosupervisormapping (
spaceid bigint NOT NULL,
supervisorid bigint NOT NULL
);
CREATE TABLE public.spacetousermapping (
mappingid bigint NOT NULL,
spaceid bigint NOT NULL,
userid bigint NOT NULL
);
CREATE TABLE public.spacetoworkordermapping (
mappingid bigint NOT NULL,
spaceid bigint NOT NULL,
workorderid bigint NOT NULL
);
CREATE TABLE public.spaceunitdefinition (
unitid bigint NOT NULL,
unitname citext NOT NULL,
unitgroup citext NOT NULL,
isdefault boolean DEFAULT false,
isdeleted boolean DEFAULT false,
createdby bigint,
issystemconfig boolean DEFAULT false,
helpdeskid bigint NOT NULL,
CONSTRAINT spaceunitdefinition_1973321893_c CHECK ((length((unitgroup)::text) <= 100)),
CONSTRAINT spaceunitdefinition_490725903_c CHECK ((length((unitname)::text) <= 100))
);
CREATE TABLE public.sqintreequery (
tqueryid bigint NOT NULL,
queryid bigint,
tablename citext,
CONSTRAINT sqintreequery_798830393_c CHECK ((length((tablename)::text) <= 50))
);
CREATE TABLE public.srapproverdetails (
id bigint NOT NULL,
approver bigint NOT NULL,
costlimitupto double DEFAULT '0',
ccid bigint,
approverstatus boolean DEFAULT true NOT NULL,
description citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT srapproverdetails_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.srcolumnsettings (
id bigint NOT NULL,
display_name citext NOT NULL,
width integer DEFAULT 100 NOT NULL,
CONSTRAINT srcolumnsettings_333046776_c CHECK ((length((display_name)::text) <= 250))
);
CREATE TABLE public.sreqtask_input (
instance_id bigint NOT NULL,
workorderid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.sresourcesqamapping (
uid bigint NOT NULL,
mappingid bigint NOT NULL,
questionid bigint NOT NULL,
answer citext,
CONSTRAINT sresourcesqamapping_1935487934_c CHECK ((length((answer)::text) <= 2000))
);
CREATE TABLE public.sservicecatalog_fields (
workorderid bigint NOT NULL
);
CREATE TABLE public.sservicereq_app (
workorderid bigint NOT NULL,
udf_char1 citext,
CONSTRAINT sservicereq_app_278184717_c CHECK ((length((udf_char1)::text) <= 3500))
);
CREATE TABLE public.sservicereq_comm (
workorderid bigint NOT NULL
);
CREATE TABLE public.sservicereq_data (
workorderid bigint NOT NULL
);
CREATE TABLE public.sservicereq_email (
workorderid bigint NOT NULL,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
udf_char5 citext,
udf_char6 citext,
udf_char7 citext,
CONSTRAINT sservicereq_email_278184711_c CHECK ((length((udf_char7)::text) <= 3500)),
CONSTRAINT sservicereq_email_278184712_c CHECK ((length((udf_char6)::text) <= 3500)),
CONSTRAINT sservicereq_email_278184713_c CHECK ((length((udf_char5)::text) <= 3500)),
CONSTRAINT sservicereq_email_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT sservicereq_email_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT sservicereq_email_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT sservicereq_email_278184717_c CHECK ((length((udf_char1)::text) <= 3500))
);
CREATE TABLE public.sservicereq_hw (
workorderid bigint NOT NULL,
udf_char1 citext,
CONSTRAINT sservicereq_hw_278184717_c CHECK ((length((udf_char1)::text) <= 3500))
);
CREATE TABLE public.sservicereq_net (
workorderid bigint NOT NULL,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
udf_date1 bigint,
udf_char5 citext,
CONSTRAINT sservicereq_net_278184713_c CHECK ((length((udf_char5)::text) <= 3500)),
CONSTRAINT sservicereq_net_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT sservicereq_net_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT sservicereq_net_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT sservicereq_net_278184717_c CHECK ((length((udf_char1)::text) <= 3500))
);
CREATE TABLE public.sservicereq_sw (
workorderid bigint NOT NULL,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
CONSTRAINT sservicereq_sw_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT sservicereq_sw_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT sservicereq_sw_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT sservicereq_sw_278184717_c CHECK ((length((udf_char1)::text) <= 3500))
);
CREATE TABLE public.sservicereq_user (
workorderid bigint NOT NULL,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
udf_char5 citext,
udf_char6 citext,
udf_char7 citext,
CONSTRAINT sservicereq_user_278184711_c CHECK ((length((udf_char7)::text) <= 3500)),
CONSTRAINT sservicereq_user_278184712_c CHECK ((length((udf_char6)::text) <= 3500)),
CONSTRAINT sservicereq_user_278184713_c CHECK ((length((udf_char5)::text) <= 3500)),
CONSTRAINT sservicereq_user_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT sservicereq_user_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT sservicereq_user_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT sservicereq_user_278184717_c CHECK ((length((udf_char1)::text) <= 3500))
);
CREATE TABLE public.sshtelnetcredentials (
credentialid bigint NOT NULL,
istelnet boolean DEFAULT false NOT NULL,
portnumber citext DEFAULT '23' NOT NULL,
connectiontimeout bigint DEFAULT '120000' NOT NULL,
privatekey bytea,
issudodisabled boolean DEFAULT false NOT NULL,
CONSTRAINT sshtelnetcredentials_1135164170_c CHECK ((length((portnumber)::text) <= 250))
);
CREATE TABLE public.stabilityglobalconfig (
stabilityglobalconfigid bigint NOT NULL,
category citext NOT NULL,
parameter citext NOT NULL,
paramvalue citext NOT NULL,
description citext DEFAULT '-' NOT NULL,
helpdeskid bigint,
CONSTRAINT stabilityglobalconfig_428414940_c CHECK ((length((description)::text) <= 200)),
CONSTRAINT stabilityglobalconfig_446088073_c CHECK ((length((parameter)::text) <= 100)),
CONSTRAINT stabilityglobalconfig_833137918_c CHECK ((length((category)::text) <= 100)),
CONSTRAINT stabilityglobalconfig_958969092_c CHECK ((length((paramvalue)::text) <= 100))
);
CREATE TABLE public.stagedefinition (
stageid bigint NOT NULL,
name citext NOT NULL,
description citext,
isdeleted boolean DEFAULT false,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT stagedefinition_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT stagedefinition_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.statement (
statementid bigint NOT NULL,
statementtypeid bigint NOT NULL,
key citext NOT NULL,
name citext NOT NULL,
description citext,
moduleid bigint NOT NULL,
actionid bigint,
workflowid bigint,
CONSTRAINT statement_2388619_c CHECK ((length((name)::text) <= 150)),
CONSTRAINT statement_428414940_c CHECK ((length((description)::text) <= 2000)),
CONSTRAINT statement_74303_c CHECK ((length((key)::text) <= 250))
);
CREATE TABLE public.statement_attribute (
attributeid bigint NOT NULL,
statementid bigint,
attribute_key citext NOT NULL,
attribute_value citext NOT NULL,
CONSTRAINT statement_attribute_1361570254_c CHECK ((length((attribute_value)::text) <= 5000)),
CONSTRAINT statement_attribute_1668443644_c CHECK ((length((attribute_key)::text) <= 250))
);
CREATE TABLE public.statement_connector (
connectorid bigint NOT NULL,
workflowid bigint,
source_statementid bigint,
source_port citext NOT NULL,
target_statementid bigint,
target_port citext NOT NULL,
CONSTRAINT statement_connector_2097759781_c CHECK ((length((source_port)::text) <= 250)),
CONSTRAINT statement_connector_97826415_c CHECK ((length((target_port)::text) <= 250))
);
CREATE TABLE public.statement_connector_attribute (
attributeid bigint NOT NULL,
connectorid bigint,
attribute_key citext NOT NULL,
attribute_value citext NOT NULL,
CONSTRAINT statement_connector_attribute_1361570254_c CHECK ((length((attribute_value)::text) <= 5000)),
CONSTRAINT statement_connector_attribute_1668443644_c CHECK ((length((attribute_key)::text) <= 250))
);
CREATE TABLE public.statement_type (
statementtypeid bigint NOT NULL,
statementtype citext NOT NULL,
description citext,
isaction boolean DEFAULT false NOT NULL,
CONSTRAINT statement_type_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT statement_type_770998007_c CHECK ((length((statementtype)::text) <= 100))
);
CREATE TABLE public.staticgroup (
groupid bigint NOT NULL,
resourceid bigint NOT NULL
);
CREATE TABLE public.statusdefinition (
statusid bigint NOT NULL,
statusname citext NOT NULL,
ispending boolean DEFAULT true NOT NULL,
statusstopclock boolean DEFAULT false NOT NULL,
statusdescription citext,
isdeleted boolean DEFAULT false,
internalname citext DEFAULT 'false' NOT NULL,
statuscolor citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT statusdefinition_1265310353_c CHECK ((length((statuscolor)::text) <= 100)),
CONSTRAINT statusdefinition_2056879416_c CHECK ((length((internalname)::text) <= 100)),
CONSTRAINT statusdefinition_502347606_c CHECK ((length((statusdescription)::text) <= 250)),
CONSTRAINT statusdefinition_733867389_c CHECK ((length((statusname)::text) <= 100))
);
CREATE TABLE public.sticky_notes (
stickyid bigint NOT NULL,
title citext,
content citext,
createdby bigint NOT NULL,
createdtime bigint NOT NULL,
lastupdatedtime bigint,
properties citext NOT NULL,
CONSTRAINT sticky_notes_79833656_c CHECK ((length((title)::text) <= 500))
);
CREATE TABLE public.storagedevice (
ciid bigint NOT NULL,
manufacturer citext,
modelnumber citext,
devicetype citext,
noofdrives citext,
capacity citext,
firmware citext,
osversion citext,
totaldisks citext,
allocateddisks citext,
sparedisks citext,
faileddisks citext,
volumes citext,
aggregates citext,
CONSTRAINT storagedevice_1267236496_c CHECK ((length((devicetype)::text) <= 250)),
CONSTRAINT storagedevice_1350404217_c CHECK ((length((volumes)::text) <= 250)),
CONSTRAINT storagedevice_1361021356_c CHECK ((length((osversion)::text) <= 250)),
CONSTRAINT storagedevice_1421659647_c CHECK ((length((sparedisks)::text) <= 250)),
CONSTRAINT storagedevice_1620616852_c CHECK ((length((aggregates)::text) <= 250)),
CONSTRAINT storagedevice_1786526663_c CHECK ((length((faileddisks)::text) <= 250)),
CONSTRAINT storagedevice_215998030_c CHECK ((length((totaldisks)::text) <= 250)),
CONSTRAINT storagedevice_227289531_c CHECK ((length((firmware)::text) <= 250)),
CONSTRAINT storagedevice_347933649_c CHECK ((length((manufacturer)::text) <= 250)),
CONSTRAINT storagedevice_714802362_c CHECK ((length((capacity)::text) <= 250)),
CONSTRAINT storagedevice_765415809_c CHECK ((length((noofdrives)::text) <= 250)),
CONSTRAINT storagedevice_879253614_c CHECK ((length((modelnumber)::text) <= 250)),
CONSTRAINT storagedevice_939911665_c CHECK ((length((allocateddisks)::text) <= 250))
);
CREATE TABLE public.subactionname (
uid bigint NOT NULL,
subactionname citext NOT NULL,
actionid bigint NOT NULL,
description citext NOT NULL,
CONSTRAINT subactionname_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT subactionname_792464415_c CHECK ((length((subactionname)::text) <= 200))
);
CREATE TABLE public.subcategorydefinition (
subcategoryid bigint NOT NULL,
categoryid bigint NOT NULL,
name citext NOT NULL,
description citext,
isdeleted boolean DEFAULT false,
CONSTRAINT subcategorydefinition_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT subcategorydefinition_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.subcontract (
parentcontractid bigint NOT NULL,
childcontractid bigint NOT NULL
);
CREATE TABLE public.subqueryreport (
subqueryid bigint NOT NULL,
queryid bigint NOT NULL,
query citext NOT NULL,
map2 bigint,
groupby citext,
orderby bigint,
title citext NOT NULL,
CONSTRAINT subqueryreport_1011411702_c CHECK ((length((groupby)::text) <= 100)),
CONSTRAINT subqueryreport_79833656_c CHECK ((length((title)::text) <= 100))
);
CREATE TABLE public.subreportcolumns (
subreport_id bigint NOT NULL,
column_id bigint NOT NULL
);
CREATE TABLE public.subreportdisplayitems (
reportid bigint NOT NULL,
subreport_id bigint NOT NULL,
display_order bigint NOT NULL
);
CREATE TABLE public.subreportmapping (
report_id bigint NOT NULL,
subreport_id bigint NOT NULL,
report_title citext NOT NULL,
icon_file citext NOT NULL,
map2 bigint NOT NULL,
CONSTRAINT subreportmapping_1425298818_c CHECK ((length((icon_file)::text) <= 100))
);
CREATE TABLE public.subscriptionaction (
subscriptionactionid bigint NOT NULL,
serviceactionid bigint NOT NULL,
isenabled boolean DEFAULT true NOT NULL,
event citext,
name citext NOT NULL,
description citext,
override_payload boolean DEFAULT true NOT NULL,
CONSTRAINT subscriptionaction_2388619_c CHECK ((length((name)::text) <= 250))
);
CREATE TABLE public.suitescanrule (
softwareid bigint NOT NULL,
rulevalue bigint NOT NULL
);
CREATE TABLE public.suitesoftwares (
swsuiteid bigint NOT NULL,
suitesoftwareid bigint NOT NULL,
softwareid bigint NOT NULL
);
CREATE TABLE public.summarymainreportcolumns (
reportid bigint NOT NULL,
column_id bigint NOT NULL
);
CREATE TABLE public.summarymainreportdetails (
reportid bigint NOT NULL,
report_title citext NOT NULL,
param_column bigint NOT NULL,
module_id bigint NOT NULL,
header_column bigint NOT NULL,
icon_file citext NOT NULL,
helpdeskid bigint,
CONSTRAINT summarymainreportdetails_1425298818_c CHECK ((length((icon_file)::text) <= 100))
);
CREATE TABLE public.supportgroup (
ciid bigint NOT NULL,
ownedby bigint
);
CREATE TABLE public.survey_config_comment (
commentid bigint NOT NULL,
surveyid bigint NOT NULL,
userid bigint NOT NULL,
commenttext citext NOT NULL,
commenttime bigint NOT NULL,
CONSTRAINT survey_config_comment_37519380_c CHECK ((length((commenttext)::text) <= 500))
);
CREATE TABLE public.survey_details (
surveyid bigint NOT NULL,
description citext,
CONSTRAINT survey_details_428414940_c CHECK ((length((description)::text) <= 500))
);
CREATE TABLE public.survey_history (
historyid bigint NOT NULL,
surveyid bigint NOT NULL,
userid bigint NOT NULL,
action citext NOT NULL,
operationtime bigint NOT NULL
);
CREATE TABLE public.survey_i18n_answers (
answerid bigint NOT NULL,
languageid bigint NOT NULL,
answer citext,
CONSTRAINT survey_i18n_answers_1935487934_c CHECK ((length((answer)::text) <= 1000))
);
CREATE TABLE public.survey_i18n_questions (
questionid bigint NOT NULL,
languageid bigint NOT NULL,
question citext,
CONSTRAINT survey_i18n_questions_383243290_c CHECK ((length((question)::text) <= 1000))
);
CREATE TABLE public.survey_mail (
configid bigint NOT NULL,
languageid bigint,
typeid bigint NOT NULL,
statusid integer NOT NULL,
createdby bigint,
message citext NOT NULL,
sender citext,
thanksmessage citext,
successmessage citext,
failuremessage citext,
description citext,
CONSTRAINT survey_mail_1255357635_c CHECK ((length((failuremessage)::text) <= 250)),
CONSTRAINT survey_mail_1668688548_c CHECK ((length((successmessage)::text) <= 250)),
CONSTRAINT survey_mail_1672907751_c CHECK ((length((message)::text) <= 250)),
CONSTRAINT survey_mail_1852633547_c CHECK ((length((sender)::text) <= 100)),
CONSTRAINT survey_mail_724245758_c CHECK ((length((thanksmessage)::text) <= 250))
);
CREATE TABLE public.survey_main (
surveyid bigint NOT NULL,
surveyname citext NOT NULL,
queryid bigint,
ownerid bigint NOT NULL,
statusid bigint NOT NULL,
typeid bigint NOT NULL,
starttime bigint,
endtime bigint,
lastsurveytime bigint,
loopinterval integer,
surveymode integer,
pctuser integer,
valid_responses integer,
createdtime bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT survey_main_188100379_c CHECK ((length((surveyname)::text) <= 250))
);
CREATE TABLE public.survey_order (
orderid bigint NOT NULL,
rank citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT survey_order_2507820_c CHECK ((length((rank)::text) <= 1000))
);
CREATE TABLE public.survey_question (
quesid bigint NOT NULL,
questext citext NOT NULL,
questype citext NOT NULL,
ismandatory boolean DEFAULT true NOT NULL,
question_order integer NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT survey_question_383227892_c CHECK ((length((questype)::text) <= 100)),
CONSTRAINT survey_question_383246849_c CHECK ((length((questext)::text) <= 500))
);
CREATE TABLE public.survey_question_i18n_main (
quesid bigint NOT NULL,
translationid bigint NOT NULL,
questext citext NOT NULL,
CONSTRAINT survey_question_i18n_main_383246849_c CHECK ((length((questext)::text) <= 500))
);
CREATE TABLE public.survey_radio_i18n_option (
optionid bigint NOT NULL,
quesid bigint NOT NULL,
translationid bigint NOT NULL,
optiontext citext NOT NULL,
CONSTRAINT survey_radio_i18n_option_1859614498_c CHECK ((length((optiontext)::text) <= 500))
);
CREATE TABLE public.survey_radio_option (
optionid bigint NOT NULL,
quesid bigint NOT NULL,
optiontext citext NOT NULL,
multiplier integer NOT NULL,
CONSTRAINT survey_radio_option_1859614498_c CHECK ((length((optiontext)::text) <= 500))
);
CREATE TABLE public.survey_rating_i18n_option (
ratingid bigint NOT NULL,
translationid bigint NOT NULL,
quesid bigint NOT NULL,
least_label citext NOT NULL,
max_label citext NOT NULL,
mid_label citext,
CONSTRAINT survey_rating_i18n_option_1627891038_c CHECK ((length((least_label)::text) <= 100)),
CONSTRAINT survey_rating_i18n_option_346237443_c CHECK ((length((mid_label)::text) <= 100)),
CONSTRAINT survey_rating_i18n_option_833613799_c CHECK ((length((max_label)::text) <= 100))
);
CREATE TABLE public.survey_rating_option (
ratingid bigint NOT NULL,
quesid bigint NOT NULL,
least_label citext NOT NULL,
max_label citext NOT NULL,
mid_label citext,
least_val integer NOT NULL,
max_val integer NOT NULL,
CONSTRAINT survey_rating_option_1627891038_c CHECK ((length((least_label)::text) <= 100)),
CONSTRAINT survey_rating_option_346237443_c CHECK ((length((mid_label)::text) <= 100)),
CONSTRAINT survey_rating_option_833613799_c CHECK ((length((max_label)::text) <= 100))
);
CREATE TABLE public.survey_response_answer (
answerid bigint NOT NULL,
responseid bigint NOT NULL,
quesid bigint NOT NULL,
type citext,
value bigint NOT NULL,
answer citext NOT NULL,
max_val integer NOT NULL,
CONSTRAINT survey_response_answer_1935487934_c CHECK ((length((answer)::text) <= 500)),
CONSTRAINT survey_response_answer_2590522_c CHECK ((length((type)::text) <= 100))
);
CREATE TABLE public.survey_response_comment (
responseid bigint NOT NULL,
commenttext citext
);
CREATE TABLE public.survey_response_main (
responseid bigint NOT NULL,
surveyid bigint NOT NULL,
userid bigint,
typeid bigint NOT NULL,
responsetime bigint,
sendtime bigint,
result integer,
responsetype integer,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.survey_templates (
templateid bigint NOT NULL,
name citext NOT NULL,
queryid bigint NOT NULL,
typeid bigint NOT NULL,
ownerid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT survey_templates_2388619_c CHECK ((length((name)::text) <= 250))
);
CREATE TABLE public.survey_translation (
translationid bigint NOT NULL,
surveyid bigint NOT NULL,
languageid bigint NOT NULL,
ownerid bigint NOT NULL,
createtime bigint NOT NULL,
statusid bigint NOT NULL
);
CREATE TABLE public.survey_types (
typeid bigint NOT NULL,
typename citext,
CONSTRAINT survey_types_107072709_c CHECK ((length((typename)::text) <= 250))
);
CREATE TABLE public.surveyanswers (
suransid bigint NOT NULL,
ansvalues citext NOT NULL,
rating double NOT NULL,
ansorder bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT surveyanswers_152674920_c CHECK ((length((ansvalues)::text) <= 50))
);
CREATE TABLE public.surveycommentquestion (
surveyid bigint NOT NULL,
commentquestext citext NOT NULL,
ismandatory boolean DEFAULT false NOT NULL,
CONSTRAINT surveycommentquestion_1700194622_c CHECK ((length((commentquestext)::text) <= 500))
);
CREATE TABLE public.surveyconfigvalue (
configid bigint NOT NULL,
issurveyenabled boolean DEFAULT false NOT NULL,
surveymode citext DEFAULT 'EVERYREQ' NOT NULL,
frequency bigint DEFAULT '-1' NOT NULL,
message citext,
sender citext,
successmessage citext,
failuremessage citext,
thankyoumessage citext,
description citext,
excludetechnician boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT surveyconfigvalue_1255357635_c CHECK ((length((failuremessage)::text) <= 250)),
CONSTRAINT surveyconfigvalue_1668688548_c CHECK ((length((successmessage)::text) <= 250)),
CONSTRAINT surveyconfigvalue_1672907751_c CHECK ((length((message)::text) <= 250)),
CONSTRAINT surveyconfigvalue_1852633547_c CHECK ((length((sender)::text) <= 250)),
CONSTRAINT surveyconfigvalue_188116995_c CHECK ((length((surveymode)::text) <= 25)),
CONSTRAINT surveyconfigvalue_417726802_c CHECK ((length((thankyoumessage)::text) <= 250))
);
CREATE TABLE public.surveydetails (
surveyid bigint NOT NULL,
surquesid bigint NOT NULL,
suransid bigint
);
CREATE TABLE public.surveyescalation (
surveyescid bigint NOT NULL,
overallrating bigint NOT NULL,
mailids citext NOT NULL,
escalatetoid bigint,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.surveylanguages (
languageid bigint NOT NULL,
locale citext NOT NULL,
language citext NOT NULL,
message citext,
thankumessage citext,
description citext,
successmessage citext,
failuremessage citext,
isactive boolean DEFAULT false NOT NULL,
createdby bigint,
createdon bigint DEFAULT '0' NOT NULL,
updatedby bigint,
updatedon bigint DEFAULT '0' NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT surveylanguages_1255357635_c CHECK ((length((failuremessage)::text) <= 1000)),
CONSTRAINT surveylanguages_1668688548_c CHECK ((length((successmessage)::text) <= 1000)),
CONSTRAINT surveylanguages_1672907751_c CHECK ((length((message)::text) <= 1000)),
CONSTRAINT surveylanguages_2044132774_c CHECK ((length((locale)::text) <= 20)),
CONSTRAINT surveylanguages_428414940_c CHECK ((length((description)::text) <= 3000)),
CONSTRAINT surveylanguages_830962856_c CHECK ((length((language)::text) <= 50)),
CONSTRAINT surveylanguages_85100868_c CHECK ((length((thankumessage)::text) <= 1000))
);
CREATE TABLE public.surveyperrequest (
surveyid bigint NOT NULL,
workorderid bigint NOT NULL,
urlencryptionid bigint
);
CREATE TABLE public.surveyperrequestext (
surveyid bigint NOT NULL,
comments citext,
overallrating double,
createdtime bigint NOT NULL,
isescalated boolean DEFAULT false NOT NULL
);
CREATE TABLE public.surveyquestions (
surquesid bigint NOT NULL,
question citext NOT NULL,
quesorder bigint NOT NULL,
ismandatory boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT surveyquestions_383243290_c CHECK ((length((question)::text) <= 250))
);
CREATE TABLE public.surveyresponserequestmapping (
responseid bigint NOT NULL,
workorderid bigint NOT NULL
);
CREATE TABLE public.surveytemplatetoquestionmap (
mapid bigint NOT NULL,
templateid bigint NOT NULL,
quesid bigint NOT NULL
);
CREATE TABLE public.surveytoquestionmapping (
mapid bigint NOT NULL,
surveyid bigint NOT NULL,
quesid bigint NOT NULL
);
CREATE TABLE public.swaudithistory (
swauditid bigint NOT NULL,
auditid bigint NOT NULL,
softwareid bigint NOT NULL,
location citext DEFAULT '-' NOT NULL,
filesize citext DEFAULT '-' NOT NULL,
filecreatedtime citext DEFAULT '-' NOT NULL,
operation bigint NOT NULL,
CONSTRAINT swaudithistory_1060355737_c CHECK ((length((filecreatedtime)::text) <= 100)),
CONSTRAINT swaudithistory_1611296843_c CHECK ((length((location)::text) <= 100)),
CONSTRAINT swaudithistory_48015229_c CHECK ((length((filesize)::text) <= 20))
);
CREATE TABLE public.swcompliancebysite (
swcompid bigint NOT NULL,
softwareid bigint NOT NULL,
siteid bigint,
totalsitelicenses bigint DEFAULT '0' NOT NULL,
installed bigint DEFAULT '0' NOT NULL,
allocated bigint DEFAULT '0' NOT NULL,
allocatedtodowngradesw bigint DEFAULT '0' NOT NULL,
available bigint DEFAULT '0' NOT NULL,
frequentlyused bigint DEFAULT '0' NOT NULL,
rarelyused bigint DEFAULT '0' NOT NULL,
occasionallyused bigint DEFAULT '0' NOT NULL,
calcount bigint DEFAULT '0' NOT NULL,
swcompliancetypeid bigint
);
CREATE TABLE public.swcompliancedetails (
softwareid bigint NOT NULL,
installed bigint DEFAULT '0' NOT NULL,
purchased bigint DEFAULT '0' NOT NULL,
allocatedtodowngradesw bigint DEFAULT '0' NOT NULL,
allocated bigint DEFAULT '0' NOT NULL,
available bigint DEFAULT '0' NOT NULL,
frequentlyused bigint DEFAULT '0' NOT NULL,
rarelyused bigint DEFAULT '0' NOT NULL,
occasionallyused bigint DEFAULT '0' NOT NULL,
calcount bigint DEFAULT '0' NOT NULL,
swcompliancetypeid bigint
);
CREATE TABLE public.swcompliancetype (
swcompliancetypeid bigint NOT NULL,
compliancetype citext NOT NULL,
description citext DEFAULT '-' NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT swcompliancetype_1364041173_c CHECK ((length((compliancetype)::text) <= 50)),
CONSTRAINT swcompliancetype_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.swins_swins (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.swins_technician (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.swinstallationkeyinfo (
softwareinfoid bigint NOT NULL,
productid citext DEFAULT '-' NOT NULL,
productkey citext DEFAULT '-' NOT NULL,
CONSTRAINT swinstallationkeyinfo_1734765098_c CHECK ((length((productid)::text) <= 100)),
CONSTRAINT swinstallationkeyinfo_2056854768_c CHECK ((length((productkey)::text) <= 250))
);
CREATE TABLE public.switch_supportgroup (
primarykeyid bigint NOT NULL,
supportlevel citext,
CONSTRAINT switch_supportgroup_784370965_c CHECK ((length((supportlevel)::text) <= 100))
);
CREATE TABLE public.switch_switch (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.switch_switchport (
primarykeyid bigint NOT NULL,
reldid1 bigint NOT NULL,
reldid2 bigint NOT NULL
);
CREATE TABLE public.switch_technician (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.switchci (
ciid bigint NOT NULL,
estimatedbw citext,
numports bigint,
ostype citext,
osversion citext,
cpu citext,
cputype citext,
dramsize bigint,
nvramsize bigint,
flashsize bigint,
configregister citext,
processorboardid citext,
firmwarerevision citext,
CONSTRAINT switchci_133627535_c CHECK ((length((estimatedbw)::text) <= 250)),
CONSTRAINT switchci_1361021356_c CHECK ((length((osversion)::text) <= 50)),
CONSTRAINT switchci_1704626370_c CHECK ((length((cputype)::text) <= 30)),
CONSTRAINT switchci_1819135003_c CHECK ((length((configregister)::text) <= 50)),
CONSTRAINT switchci_1954021602_c CHECK ((length((ostype)::text) <= 50)),
CONSTRAINT switchci_610985622_c CHECK ((length((firmwarerevision)::text) <= 150)),
CONSTRAINT switchci_663979439_c CHECK ((length((processorboardid)::text) <= 50)),
CONSTRAINT switchci_66952_c CHECK ((length((cpu)::text) <= 50))
);
CREATE TABLE public.switchport (
ciid bigint NOT NULL,
portifindex bigint NOT NULL,
portifdescr citext,
portoperstate citext,
portadminstate citext,
portifspeed bigint,
portiftype citext,
CONSTRAINT switchport_250153283_c CHECK ((length((portifdescr)::text) <= 100)),
CONSTRAINT switchport_867246206_c CHECK ((length((portoperstate)::text) <= 100)),
CONSTRAINT switchport_927528477_c CHECK ((length((portadminstate)::text) <= 100)),
CONSTRAINT switchport_978396568_c CHECK ((length((portiftype)::text) <= 100))
);
CREATE TABLE public.switchport_firewall (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.switchport_server (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.switchportci (
ciid bigint NOT NULL,
adminstate citext,
operationalstate citext,
speed bigint,
CONSTRAINT switchportci_1191667362_c CHECK ((length((adminstate)::text) <= 250)),
CONSTRAINT switchportci_872213505_c CHECK ((length((operationalstate)::text) <= 250))
);
CREATE TABLE public.swmeter (
swmeterid bigint NOT NULL,
softwareid bigint NOT NULL,
workstationid bigint,
swmeter bigint NOT NULL
);
CREATE TABLE public.swmeterhistory (
swhistoryid bigint NOT NULL,
softwareid bigint NOT NULL,
workstationid bigint,
swstarttime bigint NOT NULL,
swendtime bigint NOT NULL
);
CREATE TABLE public.swo_resources (
uid bigint NOT NULL,
woid bigint NOT NULL,
resourceid bigint NOT NULL,
resource_association_id bigint NOT NULL
);
CREATE TABLE public.sworkorder (
workorderid bigint NOT NULL,
requesterid bigint NOT NULL,
createdtime bigint NOT NULL,
title citext,
description citext,
resolution citext,
modeid bigint,
templateid bigint,
siteid bigint,
serviceid bigint,
servicesla_association bigint,
is_catalog_template boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT sworkorder_79833656_c CHECK ((length((title)::text) <= 250))
);
CREATE TABLE public.sworkorder_fields (
workorderid bigint NOT NULL
);
CREATE TABLE public.sworkorder_multi_fields (
workorderid bigint NOT NULL
);
CREATE TABLE public.sworkorderattachment (
attachmentid bigint NOT NULL,
workorderid bigint NOT NULL
);
CREATE TABLE public.sworkorderimages (
workorderid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.sworkorderstates (
workorderid bigint NOT NULL,
categoryid bigint,
subcategoryid bigint,
itemid bigint,
ownerid bigint,
queueid bigint,
statusid bigint,
priorityid bigint,
levelid bigint,
impactid bigint,
impactdetails citext,
urgencyid bigint,
requesttypeid bigint,
email_cc bytea,
editorid bigint,
CONSTRAINT sworkorderstates_1297707548_c CHECK ((length((impactdetails)::text) <= 250))
);
CREATE TABLE public.sworkordertasks (
sworkorderid bigint NOT NULL,
tasktemplateid bigint NOT NULL
);
CREATE TABLE public.sworkordertoasset (
wotoassetid bigint NOT NULL,
workorderid bigint NOT NULL,
assetid bigint NOT NULL
);
CREATE TABLE public.sworkordertoci (
wotociid bigint NOT NULL,
workorderid bigint NOT NULL,
ciid bigint NOT NULL
);
CREATE TABLE public.swpkgtocustomerrel (
package_id bigint NOT NULL,
customer_id bigint NOT NULL
);
CREATE TABLE public.sybase (
ciid bigint NOT NULL
);
CREATE TABLE public.symptom (
symptomid bigint NOT NULL,
symptom citext,
problemid bigint NOT NULL,
sym_updated_by bigint NOT NULL,
sym_updated_on bigint NOT NULL
);
CREATE TABLE public.symptomattachment (
attachmentid bigint NOT NULL,
symptomid bigint NOT NULL
);
CREATE TABLE public.symptomimages (
symptomid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.sysdescridentification (
sysdescrid bigint NOT NULL,
sysdescrparsestring citext NOT NULL,
type citext NOT NULL,
componenttypeid bigint NOT NULL,
snmpinventorytypeid bigint,
modeloid citext,
CONSTRAINT sysdescridentification_163603969_c CHECK ((length((modeloid)::text) <= 100)),
CONSTRAINT sysdescridentification_2590522_c CHECK ((length((type)::text) <= 200)),
CONSTRAINT sysdescridentification_75111792_c CHECK ((length((sysdescrparsestring)::text) <= 200))
);
CREATE TABLE public.systemadouinfo (
workstationid bigint NOT NULL,
ouid bigint NOT NULL
);
CREATE TABLE public.systemhotfixinfo (
systemhotfixinfoid bigint NOT NULL,
workstationid bigint NOT NULL,
hotfixid bigint NOT NULL,
installedby citext DEFAULT '-' NOT NULL,
installedon citext DEFAULT '-' NOT NULL,
CONSTRAINT systemhotfixinfo_2023729_c CHECK ((length((installedby)::text) <= 50)),
CONSTRAINT systemhotfixinfo_2024121_c CHECK ((length((installedon)::text) <= 50))
);
CREATE TABLE public.systeminfo (
workstationid bigint NOT NULL,
workstationname citext NOT NULL,
manufacturer citext DEFAULT '-' NOT NULL,
model citext DEFAULT '-' NOT NULL,
servicetag citext DEFAULT '-' NOT NULL,
biosname citext DEFAULT '-' NOT NULL,
biosmanufacturer citext,
biosversion citext DEFAULT '-' NOT NULL,
smbiosversion citext,
biosdate citext DEFAULT '-' NOT NULL,
loggeduser citext DEFAULT '-' NOT NULL,
ramslotscount citext DEFAULT '-' NOT NULL,
logicalcpucount bigint,
isserver boolean DEFAULT false NOT NULL,
isagentinstalled boolean DEFAULT false NOT NULL,
agentid citext,
lastagentscantime citext,
agentport bigint,
agentversion citext,
agentinstalledtime citext,
remoteoffice citext,
lastcontacttime citext,
loggedonuser citext,
lastboottime citext,
ismanuallyupdated boolean DEFAULT false NOT NULL,
scanscriptversion citext,
processor citext,
diskspace bigint,
processorcount bigint,
processorcorecount bigint,
freeslots bigint,
CONSTRAINT systeminfo_1004420173_c CHECK ((length((loggeduser)::text) <= 100)),
CONSTRAINT systeminfo_101426786_c CHECK ((length((agentinstalledtime)::text) <= 500)),
CONSTRAINT systeminfo_1161310739_c CHECK ((length((biosversion)::text) <= 100)),
CONSTRAINT systeminfo_1233431934_c CHECK ((length((remoteoffice)::text) <= 500)),
CONSTRAINT systeminfo_1239651131_c CHECK ((length((servicetag)::text) <= 100)),
CONSTRAINT systeminfo_1295768020_c CHECK ((length((loggedonuser)::text) <= 500)),
CONSTRAINT systeminfo_1368575506_c CHECK ((length((workstationname)::text) <= 200)),
CONSTRAINT systeminfo_1451054712_c CHECK ((length((ramslotscount)::text) <= 5)),
CONSTRAINT systeminfo_1493430745_c CHECK ((length((lastagentscantime)::text) <= 250)),
CONSTRAINT systeminfo_1605478227_c CHECK ((length((smbiosversion)::text) <= 100)),
CONSTRAINT systeminfo_1678448247_c CHECK ((length((lastcontacttime)::text) <= 500)),
CONSTRAINT systeminfo_1691835506_c CHECK ((length((processor)::text) <= 2000)),
CONSTRAINT systeminfo_1714339277_c CHECK ((length((agentversion)::text) <= 500)),
CONSTRAINT systeminfo_1748874923_c CHECK ((length((lastboottime)::text) <= 500)),
CONSTRAINT systeminfo_1765070489_c CHECK ((length((biosdate)::text) <= 100)),
CONSTRAINT systeminfo_1765368182_c CHECK ((length((biosname)::text) <= 100)),
CONSTRAINT systeminfo_343003456_c CHECK ((length((agentid)::text) <= 250)),
CONSTRAINT systeminfo_347933649_c CHECK ((length((manufacturer)::text) <= 100)),
CONSTRAINT systeminfo_472522820_c CHECK ((length((biosmanufacturer)::text) <= 100)),
CONSTRAINT systeminfo_73532169_c CHECK ((length((model)::text) <= 100)),
CONSTRAINT systeminfo_800812592_c CHECK ((length((scanscriptversion)::text) <= 250))
);
CREATE TABLE public.systeminfodomain (
workstationid bigint NOT NULL,
domainid bigint NOT NULL
);
CREATE TABLE public.systeminfonetwork (
workstationid bigint NOT NULL,
networkid bigint NOT NULL
);
CREATE TABLE public.systemtemplatehandler (
handler_id bigint NOT NULL,
handler_name citext NOT NULL,
class_name citext DEFAULT 'NULL' NOT NULL,
CONSTRAINT systemtemplatehandler_1925821056_c CHECK ((length((handler_name)::text) <= 100)),
CONSTRAINT systemtemplatehandler_224170258_c CHECK ((length((class_name)::text) <= 250))
);
CREATE TABLE public.systemuserinfo (
workstationid bigint NOT NULL,
location citext DEFAULT '-' NOT NULL,
comments citext DEFAULT '-',
CONSTRAINT systemuserinfo_1611296843_c CHECK ((length((location)::text) <= 100)),
CONSTRAINT systemuserinfo_180211188_c CHECK ((length((comments)::text) <= 250))
);
CREATE TABLE public.table_module_mapping (
id bigint NOT NULL,
tablename_pattern citext NOT NULL,
module_name citext NOT NULL,
description citext,
CONSTRAINT table_module_mapping_1584333930_c CHECK ((length((tablename_pattern)::text) <= 250)),
CONSTRAINT table_module_mapping_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT table_module_mapping_987509886_c CHECK ((length((module_name)::text) <= 250))
);
CREATE TABLE public.tabledetails (
table_id bigint NOT NULL,
appl_id bigint NOT NULL,
table_name citext NOT NULL,
table_desc citext,
display_name citext,
system boolean DEFAULT false NOT NULL,
table_order bigint,
createtable boolean DEFAULT true NOT NULL,
istemplate boolean DEFAULT false NOT NULL,
dc_type citext,
dirtywritecheckcols citext,
tip citext,
CONSTRAINT tabledetails_1860168914_c CHECK ((length((dirtywritecheckcols)::text) <= 250)),
CONSTRAINT tabledetails_2065780998_c CHECK ((length((dc_type)::text) <= 250)),
CONSTRAINT tabledetails_333046776_c CHECK ((length((display_name)::text) <= 255)),
CONSTRAINT tabledetails_83067_c CHECK ((length((tip)::text) <= 80)),
CONSTRAINT tabledetails_989985668_c CHECK ((length((table_name)::text) <= 60)),
CONSTRAINT tabledetails_990279550_c CHECK ((length((table_desc)::text) <= 1000))
);
CREATE TABLE public.tabledsmap (
tablename citext NOT NULL,
dsname citext NOT NULL,
CONSTRAINT tabledsmap_2025823130_c CHECK ((length((dsname)::text) <= 50)),
CONSTRAINT tabledsmap_798830393_c CHECK ((length((tablename)::text) <= 50))
);
CREATE TABLE public.tablesintree (
treeid bigint NOT NULL,
treenodetable citext NOT NULL,
tablename citext NOT NULL,
CONSTRAINT tablesintree_1984943374_c CHECK ((length((treenodetable)::text) <= 100)),
CONSTRAINT tablesintree_798830393_c CHECK ((length((tablename)::text) <= 50))
);
CREATE TABLE public.tablet (
ciid bigint NOT NULL
);
CREATE TABLE public.tabletemplatefiles (
file_no bigint NOT NULL,
file_name citext NOT NULL,
CONSTRAINT tabletemplatefiles_1499679598_c CHECK ((length((file_name)::text) <= 255))
);
CREATE TABLE public.tableviewsortcolumn (
cvid bigint NOT NULL,
tablealias citext NOT NULL,
columnname citext NOT NULL,
ascending_order boolean,
sortindex integer NOT NULL,
CONSTRAINT tableviewsortcolumn_1017743550_c CHECK ((length((tablealias)::text) <= 100)),
CONSTRAINT tableviewsortcolumn_1619616031_c CHECK ((length((columnname)::text) <= 100))
);
CREATE TABLE public.tags (
tagid bigint NOT NULL,
tagname citext NOT NULL,
createdby bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT tags_830248699_c CHECK ((length((tagname)::text) <= 250))
);
CREATE TABLE public.task_dependencies (
dependency_index bigint NOT NULL,
taskid bigint NOT NULL,
child_taskid bigint NOT NULL
);
CREATE TABLE public.task_input (
instance_id bigint NOT NULL,
schedule_id bigint NOT NULL,
schedule_time timestamp without time zone DEFAULT '1970-01-01 01:00:00',
admin_status integer DEFAULT 3 NOT NULL,
task_id bigint NOT NULL,
pool_id bigint,
execution_start_time timestamp without time zone DEFAULT '1970-01-01 01:00:00',
execution_finish_time timestamp without time zone DEFAULT '1970-01-01 01:00:00',
actual_scheduled_time timestamp without time zone,
last_reminder_status integer DEFAULT '-1' NOT NULL
);
CREATE TABLE public.task_reqcustomprops (
mappingid bigint NOT NULL,
id bigint NOT NULL,
columnaliasesid bigint NOT NULL
);
CREATE TABLE public.task_reqdefaultprops (
mappingid bigint NOT NULL,
id bigint NOT NULL,
field_id bigint NOT NULL
);
CREATE TABLE public.task_reqresourceprops (
mappingid bigint NOT NULL,
id bigint NOT NULL,
uid bigint NOT NULL
);
CREATE TABLE public.taskattachments (
attachmentid bigint NOT NULL,
taskid bigint
);
CREATE TABLE public.taskdescription (
taskid bigint NOT NULL,
description citext
);
CREATE TABLE public.taskdetails (
taskid bigint NOT NULL,
taskindex bigint DEFAULT '-1' NOT NULL,
createdby bigint,
siteid bigint,
groupid bigint,
ownerid bigint,
createddate bigint NOT NULL,
scheduledstarttime bigint,
scheduledendtime bigint,
actualstarttime bigint,
actualendtime bigint,
title citext NOT NULL,
module citext NOT NULL,
statusid bigint NOT NULL,
priorityid bigint,
tasktypeid bigint,
per_of_completion integer,
addtional_cost double DEFAULT '0',
isparent boolean DEFAULT false,
remindbefore bigint,
issitevisit boolean DEFAULT false,
isescalated boolean DEFAULT false NOT NULL,
isoverdue boolean DEFAULT false NOT NULL,
estimatedeffortdays bigint DEFAULT '0',
estimatedefforthours bigint DEFAULT '0',
estimatedeffortminutes bigint DEFAULT '0',
estimatedeffort bigint DEFAULT '0',
markedgroup bigint,
markedtechnician bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
templateid bigint,
duebytime bigint,
CONSTRAINT taskdetails_2015454612_c CHECK ((length((module)::text) <= 50)),
CONSTRAINT taskdetails_79833656_c CHECK ((length((title)::text) <= 250))
);
CREATE TABLE public.taskdetailshistory (
historyid bigint NOT NULL,
taskid bigint NOT NULL,
operationownerid bigint NOT NULL,
operationtime bigint NOT NULL,
operation citext,
CONSTRAINT taskdetailshistory_154330439_c CHECK ((length((operation)::text) <= 50))
);
CREATE TABLE public.taskdetailshistorydiff (
historydiffid bigint NOT NULL,
historyid bigint NOT NULL,
columnname citext NOT NULL,
prev_value citext,
current_value citext,
CONSTRAINT taskdetailshistorydiff_1619616031_c CHECK ((length((columnname)::text) <= 30))
);
CREATE TABLE public.taskdetailsreminder (
taskid bigint NOT NULL,
instance_id bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.taskengine_task (
task_id bigint NOT NULL,
task_name citext NOT NULL,
class_name citext NOT NULL,
CONSTRAINT taskengine_task_1298093819_c CHECK ((length((task_name)::text) <= 250)),
CONSTRAINT taskengine_task_224170258_c CHECK ((length((class_name)::text) <= 250))
);
CREATE TABLE public.taskimages (
taskid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.taskmandatoryfields (
fieldid bigint NOT NULL,
fieldname citext NOT NULL,
isenabled boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT taskmandatoryfields_242409883_c CHECK ((length((fieldname)::text) <= 50))
);
CREATE TABLE public.taskschedulereminder (
taskid bigint NOT NULL,
instance_id bigint NOT NULL
);
CREATE TABLE public.tasktable (
taskid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
taskdate bigint NOT NULL,
tasktext citext NOT NULL,
userid bigint NOT NULL,
taskstatus citext NOT NULL,
module citext DEFAULT 'General' NOT NULL,
remindbefore bigint DEFAULT '0',
CONSTRAINT tasktable_1924204105_c CHECK ((length((taskstatus)::text) <= 50)),
CONSTRAINT tasktable_2015454612_c CHECK ((length((module)::text) <= 50)),
CONSTRAINT tasktable_373432370_c CHECK ((length((tasktext)::text) <= 250))
);
CREATE TABLE public.tasktemplatedetailimages (
templateid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.tasktemplatedetails (
templateid bigint NOT NULL,
templatename citext,
entity citext NOT NULL,
inactive boolean DEFAULT false NOT NULL,
title citext NOT NULL,
description citext,
comments citext,
groupid bigint,
ownerid bigint,
statusid bigint,
createdby bigint NOT NULL,
createdtime bigint NOT NULL,
priorityid bigint,
tasktypeid bigint,
addtional_cost double DEFAULT '0',
issitevisit boolean DEFAULT false,
estimatedeffortdays bigint DEFAULT '0',
estimatedefforthours bigint DEFAULT '0',
estimatedeffortminutes bigint DEFAULT '0',
estimatedeffort bigint DEFAULT '0',
markedgroup bigint,
markedtechnician bigint,
taskindex bigint DEFAULT '1' NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT tasktemplatedetails_1342071301_c CHECK ((length((templatename)::text) <= 255)),
CONSTRAINT tasktemplatedetails_2050021347_c CHECK ((length((entity)::text) <= 100)),
CONSTRAINT tasktemplatedetails_79833656_c CHECK ((length((title)::text) <= 250))
);
CREATE TABLE public.tasktocharge (
taskid bigint NOT NULL,
chargeid bigint NOT NULL
);
CREATE TABLE public.tasktocomment (
commentid bigint NOT NULL,
taskid bigint NOT NULL
);
CREATE TABLE public.tasktoprojects (
taskid bigint NOT NULL,
milestoneid bigint,
projectid bigint NOT NULL
);
CREATE TABLE public.tasktypedefinition (
tasktypeid bigint NOT NULL,
tasktypename citext NOT NULL,
tasktypecolor citext,
description citext,
isdeleted boolean DEFAULT false,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT tasktypedefinition_23485110_c CHECK ((length((tasktypename)::text) <= 50)),
CONSTRAINT tasktypedefinition_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT tasktypedefinition_737780636_c CHECK ((length((tasktypecolor)::text) <= 25))
);
CREATE TABLE public.tech_last_assign_time (
technicianid bigint NOT NULL,
portaltechid_autoid bigint NOT NULL,
lastreqassignedtime bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.technician_share_list (
shareid bigint NOT NULL,
techid bigint NOT NULL
);
CREATE TABLE public.technician_supportgroup (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.techniciankeydefinition (
login_id bigint NOT NULL,
techniciankey citext NOT NULL,
validity bigint DEFAULT '-1' NOT NULL,
status citext DEFAULT 'active' NOT NULL,
read_operation boolean DEFAULT true NOT NULL,
add_operation boolean DEFAULT false NOT NULL,
update_operation boolean DEFAULT false NOT NULL,
delete_operation boolean DEFAULT false NOT NULL,
createdtime bigint NOT NULL,
CONSTRAINT techniciankeydefinition_1839152142_c CHECK ((length((status)::text) <= 20)),
CONSTRAINT techniciankeydefinition_654164571_c CHECK ((length((techniciankey)::text) <= 250))
);
CREATE TABLE public.technicianmarking (
markingid bigint NOT NULL,
workorderid bigint NOT NULL,
ownerid bigint NOT NULL,
comment citext,
starttime bigint NOT NULL,
CONSTRAINT technicianmarking_1668381247_c CHECK ((length((comment)::text) <= 1500))
);
CREATE TABLE public.technicianstatus (
technicianid bigint NOT NULL,
status bigint NOT NULL,
comments citext,
executedtime bigint NOT NULL,
CONSTRAINT technicianstatus_180211188_c CHECK ((length((comments)::text) <= 250))
);
CREATE TABLE public.techstatusdefinition (
statusid bigint NOT NULL,
statusname citext NOT NULL,
colorcode citext NOT NULL,
description citext,
CONSTRAINT techstatusdefinition_428414940_c CHECK ((length((description)::text) <= 500)),
CONSTRAINT techstatusdefinition_473007024_c CHECK ((length((colorcode)::text) <= 50)),
CONSTRAINT techstatusdefinition_733867389_c CHECK ((length((statusname)::text) <= 50))
);
CREATE TABLE public.techunavailability (
leaveid bigint NOT NULL,
createdby bigint,
createddate bigint NOT NULL,
technicianid bigint,
leavetypeid bigint,
backuptechnicianid bigint,
backupgrouproleid bigint,
comments citext,
technicianid_autoid bigint NOT NULL,
backuptechnicianid_autoid bigint
);
CREATE TABLE public.telephonyserver (
serverid bigint NOT NULL,
serviceid bigint NOT NULL,
hostname citext NOT NULL,
tlink citext,
username citext NOT NULL,
userpwd citext NOT NULL,
CONSTRAINT telephonyserver_482823219_c CHECK ((length((hostname)::text) <= 100)),
CONSTRAINT telephonyserver_516913366_c CHECK ((length((username)::text) <= 100)),
CONSTRAINT telephonyserver_570866546_c CHECK ((length((userpwd)::text) <= 100)),
CONSTRAINT telephonyserver_79912526_c CHECK ((length((tlink)::text) <= 250))
);
CREATE TABLE public.telephonyservice (
serviceid bigint NOT NULL,
servicename citext NOT NULL,
port bigint NOT NULL,
enableservice boolean DEFAULT false NOT NULL,
CONSTRAINT telephonyservice_225342112_c CHECK ((length((servicename)::text) <= 100))
);
CREATE TABLE public.temp_taskdependencies (
dependency_index bigint NOT NULL,
taskid bigint NOT NULL,
child_taskid bigint NOT NULL
);
CREATE TABLE public.template_customization (
templateid bigint NOT NULL,
custom_json citext NOT NULL,
style_properties citext
);
CREATE TABLE public.templateactions (
actionid bigint NOT NULL,
templateid bigint NOT NULL,
actionname citext,
CONSTRAINT templateactions_1957242431_c CHECK ((length((actionname)::text) <= 250))
);
CREATE TABLE public.templateapprovalleveldefinition (
id bigint NOT NULL,
templateid bigint NOT NULL,
level bigint NOT NULL,
displayname citext NOT NULL,
CONSTRAINT templateapprovalleveldefinition_426904019_c CHECK ((length((displayname)::text) <= 100))
);
CREATE TABLE public.templatedefinition (
template_id bigint NOT NULL,
entity_id bigint NOT NULL,
name citext NOT NULL,
description citext,
is_default boolean DEFAULT false NOT NULL,
is_deleted boolean DEFAULT false NOT NULL,
createdby bigint,
createdtime bigint,
updatedby bigint,
updatedtime bigint,
style citext,
draft boolean DEFAULT false NOT NULL,
icon_name citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT templatedefinition_1425529489_c CHECK ((length((icon_name)::text) <= 250)),
CONSTRAINT templatedefinition_2388619_c CHECK ((length((name)::text) <= 100))
);
CREATE TABLE public.templatefieldvalues (
id bigint NOT NULL,
template_id bigint NOT NULL,
field_id bigint NOT NULL,
default_value citext
);
CREATE TABLE public.templatefiles (
file_no bigint NOT NULL,
file_name citext NOT NULL,
CONSTRAINT templatefiles_1499679598_c CHECK ((length((file_name)::text) <= 255))
);
CREATE TABLE public.templatestatistics (
templateid bigint NOT NULL,
usedcount bigint
);
CREATE TABLE public.templatetogroupmapping (
mappingid bigint NOT NULL,
queuename citext NOT NULL,
templateid bigint NOT NULL,
CONSTRAINT templatetogroupmapping_1047900924_c CHECK ((length((queuename)::text) <= 250))
);
CREATE TABLE public.templateugmapping (
mappingid bigint NOT NULL,
usergroupid bigint NOT NULL,
templateid bigint NOT NULL
);
CREATE TABLE public.templateviewparams (
viewname bigint NOT NULL,
paramname citext NOT NULL,
mandatory boolean DEFAULT false NOT NULL,
CONSTRAINT templateviewparams_446338168_c CHECK ((length((paramname)::text) <= 100))
);
CREATE TABLE public.theme (
themename_no bigint NOT NULL,
themename citext NOT NULL,
icon citext,
theme_dir citext NOT NULL,
pdftheme_class citext DEFAULT 'com.adventnet.client.view.pdf.DefaultPDFTheme' NOT NULL,
CONSTRAINT theme_1215503568_c CHECK ((length((pdftheme_class)::text) <= 200)),
CONSTRAINT theme_1489717033_c CHECK ((length((theme_dir)::text) <= 100)),
CONSTRAINT theme_1490226252_c CHECK ((length((themename)::text) <= 50)),
CONSTRAINT theme_2241657_c CHECK ((length((icon)::text) <= 50))
);
CREATE TABLE public.themeattributesmapping (
themename bigint NOT NULL,
attributename citext NOT NULL,
attributevalue citext NOT NULL,
CONSTRAINT themeattributesmapping_1667927815_c CHECK ((length((attributename)::text) <= 50)),
CONSTRAINT themeattributesmapping_173542485_c CHECK ((length((attributevalue)::text) <= 50))
);
CREATE TABLE public.threadpool (
threadpool_id bigint NOT NULL,
threadpool_name citext NOT NULL,
threadpool_size integer DEFAULT 3 NOT NULL,
active boolean DEFAULT true NOT NULL,
CONSTRAINT threadpool_1791489540_c CHECK ((length((threadpool_name)::text) <= 150))
);
CREATE TABLE public.throttleexceedinghistory (
log_id bigint NOT NULL,
url citext NOT NULL,
ip citext NOT NULL,
operationtime bigint NOT NULL,
userid bigint,
threshold bigint NOT NULL,
duration bigint NOT NULL,
violation_type citext NOT NULL,
http_method citext,
operation_value citext,
CONSTRAINT throttleexceedinghistory_1309055096_c CHECK ((length((http_method)::text) <= 10)),
CONSTRAINT throttleexceedinghistory_1586615756_c CHECK ((length((violation_type)::text) <= 100)),
CONSTRAINT throttleexceedinghistory_2343_c CHECK ((length((ip)::text) <= 50)),
CONSTRAINT throttleexceedinghistory_562335833_c CHECK ((length((operation_value)::text) <= 100)),
CONSTRAINT throttleexceedinghistory_84303_c CHECK ((length((url)::text) <= 500))
);
CREATE TABLE public.tiledview (
viewname bigint NOT NULL,
tilename citext NOT NULL,
tiledviewname bigint NOT NULL,
CONSTRAINT tiledview_1322600903_c CHECK ((length((tilename)::text) <= 100))
);
CREATE TABLE public.timechartproperties (
reportid bigint NOT NULL,
timexdate bigint NOT NULL,
timexgroup bigint NOT NULL,
timeycountcoulmn bigint NOT NULL,
dateformat citext NOT NULL,
timeytargetfrom bigint,
timeytargetto bigint,
CONSTRAINT timechartproperties_1556470053_c CHECK ((length((dateformat)::text) <= 20))
);
CREATE TABLE public.timeraction (
timerid bigint NOT NULL,
name citext,
description citext,
moduleid bigint NOT NULL,
init_criteria citext,
is_simple_timer boolean DEFAULT true,
isactive boolean DEFAULT true,
createdtime bigint NOT NULL,
lastupdatedtime bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT timeraction_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT timeraction_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.timerschedule (
schedule_id bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
timer_id bigint NOT NULL,
stage_id bigint NOT NULL,
module_id bigint NOT NULL,
workflow_type integer,
created_on bigint,
schedule_time bigint,
stage_executed_count integer DEFAULT 0,
running_status integer DEFAULT 1 NOT NULL,
paused_on bigint,
total_hold_duration bigint,
execution_start_time bigint,
is_entity_trashed boolean DEFAULT false NOT NULL
);
CREATE TABLE public.timerstageafterrulemap (
mapid bigint NOT NULL,
ruleid bigint NOT NULL,
stageid bigint NOT NULL,
is_cascade boolean DEFAULT false NOT NULL,
orderid bigint NOT NULL
);
CREATE TABLE public.timerstageduringrulemap (
mapid bigint NOT NULL,
ruleid bigint NOT NULL,
stageid bigint NOT NULL,
is_cascade boolean DEFAULT false NOT NULL,
orderid bigint NOT NULL
);
CREATE TABLE public.timerstages (
id bigint NOT NULL,
timerid bigint NOT NULL,
name citext,
stage_no bigint NOT NULL,
initial_delay_config citext NOT NULL,
repeat_config citext,
apply_during citext NOT NULL,
CONSTRAINT timerstages_2388619_c CHECK ((length((name)::text) <= 50)),
CONSTRAINT timerstages_242055250_c CHECK ((length((apply_during)::text) <= 100))
);
CREATE TABLE public.timezonedefinition (
timezoneid bigint NOT NULL,
gmtoffset integer NOT NULL,
displayname citext NOT NULL,
timezonecode citext,
CONSTRAINT timezonedefinition_426904019_c CHECK ((length((displayname)::text) <= 100)),
CONSTRAINT timezonedefinition_851035802_c CHECK ((length((timezonecode)::text) <= 100))
);
CREATE TABLE public.tmpcolumnrenderer (
columnid bigint NOT NULL,
propertyname citext NOT NULL,
propertyvalue citext,
CONSTRAINT tmpcolumnrenderer_1453542880_c CHECK ((length((propertyname)::text) <= 50)),
CONSTRAINT tmpcolumnrenderer_2117544092_c CHECK ((length((propertyvalue)::text) <= 50))
);
CREATE TABLE public.tmpviewcolumn (
columnid bigint NOT NULL,
viewname citext NOT NULL,
tablename citext NOT NULL,
columnname citext NOT NULL,
columnalias citext NOT NULL,
columnindex integer NOT NULL,
displayname citext,
visible boolean DEFAULT true,
sortenabled boolean DEFAULT true,
searchenabled boolean DEFAULT false,
actionname citext,
creatorconfig citext DEFAULT 'DefaultUICreator',
default_text citext,
date_format citext,
trim_length integer,
trim_msg_link boolean DEFAULT false,
prefix_text citext,
suffix_text citext,
suffix_icon citext,
icon citext,
tablealias citext,
linkviewname citext,
static_text citext,
isnullable boolean,
cssclass citext,
menuid citext,
isheadervisible boolean DEFAULT true NOT NULL,
CONSTRAINT tmpviewcolumn_100625575_c CHECK ((length((suffix_icon)::text) <= 100)),
CONSTRAINT tmpviewcolumn_100955483_c CHECK ((length((suffix_text)::text) <= 75)),
CONSTRAINT tmpviewcolumn_1017743550_c CHECK ((length((tablealias)::text) <= 50)),
CONSTRAINT tmpviewcolumn_1226864546_c CHECK ((length((static_text)::text) <= 100)),
CONSTRAINT tmpviewcolumn_1319828634_c CHECK ((length((columnalias)::text) <= 50)),
CONSTRAINT tmpviewcolumn_1458413992_c CHECK ((length((date_format)::text) <= 100)),
CONSTRAINT tmpviewcolumn_1619616031_c CHECK ((length((columnname)::text) <= 50)),
CONSTRAINT tmpviewcolumn_1696579723_c CHECK ((length((default_text)::text) <= 100)),
CONSTRAINT tmpviewcolumn_1957242431_c CHECK ((length((actionname)::text) <= 100)),
CONSTRAINT tmpviewcolumn_1979239088_c CHECK ((length((viewname)::text) <= 50)),
CONSTRAINT tmpviewcolumn_2024392006_c CHECK ((length((menuid)::text) <= 100)),
CONSTRAINT tmpviewcolumn_2241657_c CHECK ((length((icon)::text) <= 100)),
CONSTRAINT tmpviewcolumn_307878058_c CHECK ((length((linkviewname)::text) <= 100)),
CONSTRAINT tmpviewcolumn_402005675_c CHECK ((length((cssclass)::text) <= 50)),
CONSTRAINT tmpviewcolumn_426904019_c CHECK ((length((displayname)::text) <= 50)),
CONSTRAINT tmpviewcolumn_687753806_c CHECK ((length((creatorconfig)::text) <= 50)),
CONSTRAINT tmpviewcolumn_701130054_c CHECK ((length((prefix_text)::text) <= 75)),
CONSTRAINT tmpviewcolumn_798830393_c CHECK ((length((tablename)::text) <= 100))
);
CREATE TABLE public.tmpviewcriteria (
viewcriteria_id_no bigint NOT NULL,
viewname bigint NOT NULL,
tablename citext NOT NULL,
columnname citext NOT NULL,
operator citext NOT NULL,
value citext,
CONSTRAINT tmpviewcriteria_1619616031_c CHECK ((length((columnname)::text) <= 50)),
CONSTRAINT tmpviewcriteria_282073252_c CHECK ((length((operator)::text) <= 50)),
CONSTRAINT tmpviewcriteria_798830393_c CHECK ((length((tablename)::text) <= 100)),
CONSTRAINT tmpviewcriteria_81434961_c CHECK ((length((value)::text) <= 50))
);
CREATE TABLE public.tmpviewdetails (
viewname_no bigint NOT NULL,
viewname citext NOT NULL,
title citext,
icon citext,
image citext,
description citext,
displaytype citext,
empty_table_message citext,
columnchoosermenuitem citext,
enablerowselection citext DEFAULT 'CHECKBOX',
operator citext,
navigation citext,
componentname citext,
menuname citext,
CONSTRAINT tmpviewdetails_1020909321_c CHECK ((length((columnchoosermenuitem)::text) <= 100)),
CONSTRAINT tmpviewdetails_179615850_c CHECK ((length((menuname)::text) <= 100)),
CONSTRAINT tmpviewdetails_1947208172_c CHECK ((length((navigation)::text) <= 100)),
CONSTRAINT tmpviewdetails_1979239088_c CHECK ((length((viewname)::text) <= 50)),
CONSTRAINT tmpviewdetails_2241657_c CHECK ((length((icon)::text) <= 100)),
CONSTRAINT tmpviewdetails_282073252_c CHECK ((length((operator)::text) <= 100)),
CONSTRAINT tmpviewdetails_426702116_c CHECK ((length((displaytype)::text) <= 100)),
CONSTRAINT tmpviewdetails_428414940_c CHECK ((length((description)::text) <= 100)),
CONSTRAINT tmpviewdetails_528476392_c CHECK ((length((componentname)::text) <= 100)),
CONSTRAINT tmpviewdetails_588630844_c CHECK ((length((empty_table_message)::text) <= 100)),
CONSTRAINT tmpviewdetails_69775675_c CHECK ((length((image)::text) <= 100)),
CONSTRAINT tmpviewdetails_79833656_c CHECK ((length((title)::text) <= 100)),
CONSTRAINT tmpviewdetails_85393909_c CHECK ((length((enablerowselection)::text) <= 20))
);
CREATE TABLE public.topichierarchy (
topicid bigint NOT NULL,
parentid bigint NOT NULL
);
CREATE TABLE public.tour_details (
tourid bigint NOT NULL,
tour_name citext NOT NULL,
description citext NOT NULL,
roles citext,
language citext NOT NULL,
module citext NOT NULL,
tour_settings citext,
isenabled boolean DEFAULT true NOT NULL,
ispublished boolean DEFAULT false NOT NULL,
hasdraft boolean DEFAULT true NOT NULL,
createdby bigint DEFAULT '1' NOT NULL,
createdtime bigint,
lastupdatedby bigint,
lastupdatedtime bigint,
publishedby bigint,
publishedtime bigint,
helpdeskid bigint,
views bigint DEFAULT '0',
isdefault boolean DEFAULT false NOT NULL,
CONSTRAINT tour_details_2015454612_c CHECK ((length((module)::text) <= 100)),
CONSTRAINT tour_details_428414940_c CHECK ((length((description)::text) <= 500)),
CONSTRAINT tour_details_693141486_c CHECK ((length((tour_name)::text) <= 250)),
CONSTRAINT tour_details_830962856_c CHECK ((length((language)::text) <= 100))
);
CREATE TABLE public.tour_progress (
progressid bigint NOT NULL,
userid bigint NOT NULL,
tourid bigint NOT NULL,
last_slideid bigint,
viewed_time bigint,
duration bigint,
tour_state citext NOT NULL,
CONSTRAINT tour_progress_7376950_c CHECK ((length((tour_state)::text) <= 50))
);
CREATE TABLE public.transition (
transitionid bigint NOT NULL,
name citext,
description citext,
help_text citext,
uiattributes citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT transition_181432469_c CHECK ((length((help_text)::text) <= 250)),
CONSTRAINT transition_2388619_c CHECK ((length((name)::text) <= 50)),
CONSTRAINT transition_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.transition_beforerule (
id bigint NOT NULL,
transitionid bigint NOT NULL,
ruleid bigint NOT NULL
);
CREATE TABLE public.transition_mandatefields (
transitionid bigint NOT NULL,
mandatory_fields citext,
optional_fields citext
);
CREATE TABLE public.transition_node_map (
id bigint NOT NULL,
source_node bigint NOT NULL,
target_node bigint NOT NULL,
transitionid bigint NOT NULL
);
CREATE TABLE public.transition_placeholder (
id bigint NOT NULL,
transitionid bigint NOT NULL,
placeholderid bigint NOT NULL
);
CREATE TABLE public.transition_postrule (
id bigint NOT NULL,
transitionid bigint NOT NULL,
ruleid bigint NOT NULL
);
CREATE TABLE public.transition_prerule (
id bigint NOT NULL,
transitionid bigint NOT NULL,
ruleid bigint NOT NULL
);
CREATE TABLE public.treedefinition (
treeid bigint NOT NULL,
treetype citext NOT NULL,
basetreenodetable citext NOT NULL,
treeinfotable citext NOT NULL,
siblingordered boolean NOT NULL,
CONSTRAINT treedefinition_1544197662_c CHECK ((length((treeinfotable)::text) <= 100)),
CONSTRAINT treedefinition_1961938467_c CHECK ((length((basetreenodetable)::text) <= 100)),
CONSTRAINT treedefinition_2125204520_c CHECK ((length((treetype)::text) <= 47))
);
CREATE TABLE public.treeidentifiercolumns (
treeid bigint NOT NULL,
columnname citext NOT NULL,
CONSTRAINT treeidentifiercolumns_1619616031_c CHECK ((length((columnname)::text) <= 50))
);
CREATE TABLE public.treequery (
queryid bigint NOT NULL,
treetype citext,
depth integer,
CONSTRAINT treequery_2125204520_c CHECK ((length((treetype)::text) <= 50))
);
CREATE TABLE public.treequeryidentifiercolumns (
queryid bigint NOT NULL,
tablename citext,
columnname citext NOT NULL,
columnvalue citext,
CONSTRAINT treequeryidentifiercolumns_1338898363_c CHECK ((length((columnvalue)::text) <= 50)),
CONSTRAINT treequeryidentifiercolumns_1619616031_c CHECK ((length((columnname)::text) <= 50)),
CONSTRAINT treequeryidentifiercolumns_798830393_c CHECK ((length((tablename)::text) <= 50))
);
CREATE TABLE public.udf_picklistimages (
picklistid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.udf_picklistvalues (
picklistid bigint NOT NULL,
tablename citext NOT NULL,
columnname citext NOT NULL,
field_id bigint,
value citext NOT NULL,
value_index integer NOT NULL,
is_deleted boolean DEFAULT false NOT NULL,
images citext,
helpdeskid bigint,
CONSTRAINT udf_picklistvalues_1619616031_c CHECK ((length((columnname)::text) <= 100)),
CONSTRAINT udf_picklistvalues_798830393_c CHECK ((length((tablename)::text) <= 100))
);
CREATE TABLE public.udfoption_additional_attribute (
attr_id bigint NOT NULL,
picklist_id bigint NOT NULL,
attr_name citext NOT NULL,
attr_value citext,
helpdeskid bigint,
CONSTRAINT udfoption_additional_attribute_1474631655_c CHECK ((length((attr_name)::text) <= 50)),
CONSTRAINT udfoption_additional_attribute_1538446723_c CHECK ((length((attr_value)::text) <= 500))
);
CREATE TABLE public.uicomponent (
name_no bigint NOT NULL,
name citext NOT NULL,
description citext,
state citext,
CONSTRAINT uicomponent_2388619_c CHECK ((length((name)::text) <= 50)),
CONSTRAINT uicomponent_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT uicomponent_79219825_c CHECK ((length((state)::text) <= 250))
);
CREATE TABLE public.uicomponent_pidx (
name_no bigint NOT NULL,
table_name citext NOT NULL,
CONSTRAINT uicomponent_pidx_989985668_c CHECK ((length((table_name)::text) <= 40))
);
CREATE TABLE public.uinavigationconfig (
viewname bigint NOT NULL,
contentareaname citext,
addtolist boolean DEFAULT false NOT NULL,
defaultselectedview bigint,
cleardefaultcontentarea boolean DEFAULT false NOT NULL,
refreshlevel integer DEFAULT '-1' NOT NULL,
tablealias citext,
CONSTRAINT uinavigationconfig_1017743550_c CHECK ((length((tablealias)::text) <= 50)),
CONSTRAINT uinavigationconfig_1810858993_c CHECK ((length((contentareaname)::text) <= 250))
);
CREATE TABLE public.uninssoftwareinfo (
softwareid bigint NOT NULL,
workstationid bigint NOT NULL,
softwarename citext DEFAULT '-' NOT NULL,
version citext DEFAULT '-' NOT NULL,
description citext DEFAULT '-' NOT NULL,
CONSTRAINT uninssoftwareinfo_1069590712_c CHECK ((length((version)::text) <= 100)),
CONSTRAINT uninssoftwareinfo_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT uninssoftwareinfo_797874354_c CHECK ((length((softwarename)::text) <= 250))
);
CREATE TABLE public.uniquekeydefinition (
unique_cons_id bigint NOT NULL,
column_id bigint NOT NULL,
"position" integer NOT NULL
);
CREATE TABLE public.unixserver (
ciid bigint NOT NULL
);
CREATE TABLE public.unixworkstation (
ciid bigint NOT NULL
);
CREATE TABLE public.unknowntypeoid (
unknowntypeoidid bigint NOT NULL,
oid citext,
sysdescr citext,
devicename citext,
modeloid citext,
vendorid bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT unknowntypeoid_1267034593_c CHECK ((length((devicename)::text) <= 200)),
CONSTRAINT unknowntypeoid_1551024812_c CHECK ((length((sysdescr)::text) <= 500)),
CONSTRAINT unknowntypeoid_163603969_c CHECK ((length((modeloid)::text) <= 100)),
CONSTRAINT unknowntypeoid_78250_c CHECK ((length((oid)::text) <= 200))
);
CREATE TABLE public.upgradehistory (
upgradeid bigint NOT NULL,
build_from citext NOT NULL,
build_to citext NOT NULL,
patch_name citext,
updated_on bigint NOT NULL,
CONSTRAINT upgradehistory_1790172226_c CHECK ((length((patch_name)::text) <= 200)),
CONSTRAINT upgradehistory_43825915_c CHECK ((length((build_from)::text) <= 50)),
CONSTRAINT upgradehistory_647997940_c CHECK ((length((build_to)::text) <= 50))
);
CREATE TABLE public.upgradelicenses (
ulid bigint NOT NULL,
baselicenseid bigint,
upgradedlicenseid bigint NOT NULL,
upgradedfrom bigint,
upgradedto bigint
);
CREATE TABLE public.uploadedmib (
mibfileid bigint NOT NULL,
mibname citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT uploadedmib_1771575729_c CHECK ((length((mibname)::text) <= 200))
);
CREATE TABLE public.ups (
ciid bigint NOT NULL,
firmwareversion citext,
batterytimeremaining bigint,
batteryvoltage bigint,
batterycurrent bigint,
batterycapacity bigint,
CONSTRAINT ups_241182365_c CHECK ((length((firmwareversion)::text) <= 250))
);
CREATE TABLE public.urgencydefinition (
urgencyid bigint NOT NULL,
name citext NOT NULL,
description citext,
isdeleted boolean DEFAULT false,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT urgencydefinition_2388619_c CHECK ((length((name)::text) <= 100))
);
CREATE TABLE public.urlencryptiondetails (
urlid bigint NOT NULL,
encryptedurl citext NOT NULL,
encryptedkey citext NOT NULL,
createdtime bigint,
createdby bigint NOT NULL,
validity bigint DEFAULT '30' NOT NULL,
CONSTRAINT urlencryptiondetails_372426267_c CHECK ((length((encryptedkey)::text) <= 250)),
CONSTRAINT urlencryptiondetails_372436267_c CHECK ((length((encryptedurl)::text) <= 250))
);
CREATE TABLE public.usbinfo (
usbid bigint NOT NULL,
workstationid bigint NOT NULL,
usbname citext NOT NULL,
CONSTRAINT usbinfo_567962095_c CHECK ((length((usbname)::text) <= 100))
);
CREATE TABLE public.user_share_list (
shareid bigint NOT NULL,
userid bigint NOT NULL
);
CREATE TABLE public.useradditionalfields (
instance_id bigint NOT NULL
);
CREATE TABLE public.userattachments (
attachmentid bigint NOT NULL,
userid bigint NOT NULL,
helpdeskid bigint
);
CREATE TABLE public.usercriteriadepartmentvalues (
id bigint NOT NULL,
criteriaid bigint NOT NULL,
valueid bigint NOT NULL
);
CREATE TABLE public.usercriteriafields (
id bigint NOT NULL,
name citext NOT NULL,
tablename citext NOT NULL,
columnname citext NOT NULL,
CONSTRAINT usercriteriafields_1619616031_c CHECK ((length((columnname)::text) <= 200)),
CONSTRAINT usercriteriafields_2388619_c CHECK ((length((name)::text) <= 200)),
CONSTRAINT usercriteriafields_798830393_c CHECK ((length((tablename)::text) <= 200))
);
CREATE TABLE public.usercriteriasitevalues (
id bigint NOT NULL,
criteriaid bigint NOT NULL,
valueid bigint
);
CREATE TABLE public.usercriteriatype (
id bigint NOT NULL,
name citext NOT NULL,
CONSTRAINT usercriteriatype_2388619_c CHECK ((length((name)::text) <= 200))
);
CREATE TABLE public.userdefaulthelpdesk (
userid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.userdeletionproperties (
id bigint NOT NULL,
userid bigint NOT NULL,
is_righttoforget boolean DEFAULT false NOT NULL,
anonymize_email_references boolean DEFAULT false NOT NULL,
delete_status citext,
anonymized_by bigint,
anonymized_time bigint,
CONSTRAINT userdeletionproperties_1398153478_c CHECK ((length((delete_status)::text) <= 10))
);
CREATE TABLE public.userdepartment (
userid bigint NOT NULL,
deptid bigint NOT NULL
);
CREATE TABLE public.userdepthistory (
historyid bigint NOT NULL,
userid bigint,
deptid bigint,
editmode citext NOT NULL,
operationtime bigint NOT NULL,
updatedby bigint,
helpdeskid bigint,
CONSTRAINT userdepthistory_1909554515_c CHECK ((length((editmode)::text) <= 100))
);
CREATE TABLE public.userdepthistorydetails (
udhistoryid bigint NOT NULL,
historyid bigint NOT NULL,
tablename citext NOT NULL,
attribute citext,
conversiontype citext,
newvalue citext,
oldvalue citext,
primarykey citext,
operation bigint NOT NULL,
additionalinfo citext,
helpdeskid bigint,
CONSTRAINT userdepthistorydetails_1002083242_c CHECK ((length((oldvalue)::text) <= 3500)),
CONSTRAINT userdepthistorydetails_1190118064_c CHECK ((length((conversiontype)::text) <= 100)),
CONSTRAINT userdepthistorydetails_1495287172_c CHECK ((length((attribute)::text) <= 500)),
CONSTRAINT userdepthistorydetails_2114331695_c CHECK ((length((newvalue)::text) <= 3500)),
CONSTRAINT userdepthistorydetails_789797603_c CHECK ((length((primarykey)::text) <= 100)),
CONSTRAINT userdepthistorydetails_798830393_c CHECK ((length((tablename)::text) <= 100))
);
CREATE TABLE public.userfieldsettings (
id bigint NOT NULL,
restricted_fields citext,
search_fields citext,
display_fields citext,
user_type citext NOT NULL,
restricted_type citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT userfieldsettings_1139277010_c CHECK ((length((user_type)::text) <= 20)),
CONSTRAINT userfieldsettings_1149366045_c CHECK ((length((restricted_fields)::text) <= 10000)),
CONSTRAINT userfieldsettings_1757779664_c CHECK ((length((search_fields)::text) <= 10000)),
CONSTRAINT userfieldsettings_1842721014_c CHECK ((length((display_fields)::text) <= 10000)),
CONSTRAINT userfieldsettings_2102185118_c CHECK ((length((restricted_type)::text) <= 10))
);
CREATE TABLE public.usergroups (
id bigint NOT NULL,
queryid bigint NOT NULL,
name citext NOT NULL,
criteria citext,
description citext NOT NULL,
mickeycriteria citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT usergroups_1560293537_c CHECK ((length((criteria)::text) <= 50000)),
CONSTRAINT usergroups_1675163113_c CHECK ((length((mickeycriteria)::text) <= 50000)),
CONSTRAINT usergroups_2388619_c CHECK ((length((name)::text) <= 250)),
CONSTRAINT usergroups_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.userlicenses (
licenseid bigint NOT NULL,
noofusers bigint NOT NULL
);
CREATE TABLE public.userlicenseusageinfo (
usageinfoid bigint NOT NULL,
licenseid bigint NOT NULL,
userid bigint NOT NULL,
workstationid bigint
);
CREATE TABLE public.usermanager (
usermanagerid bigint NOT NULL,
userid bigint NOT NULL,
managerrole integer DEFAULT 0 NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.usermergedetails (
mergeid bigint NOT NULL,
status citext NOT NULL,
initiator bigint NOT NULL,
initiation_time bigint NOT NULL,
errorlogid bigint,
mergedata citext,
helpdeskid bigint,
CONSTRAINT usermergedetails_1839152142_c CHECK ((length((status)::text) <= 10))
);
CREATE TABLE public.usernotifications (
dynamicnotificationid bigint NOT NULL,
userid bigint NOT NULL,
isread boolean DEFAULT false NOT NULL
);
CREATE TABLE public.useropnotification (
useropnotificationid bigint NOT NULL,
errorlogid bigint,
domainid bigint,
notifytype citext,
messageid bigint,
helpdeskid bigint,
CONSTRAINT useropnotification_678869501_c CHECK ((length((notifytype)::text) <= 25))
);
CREATE TABLE public.userpersonalize (
personalizeid bigint NOT NULL,
personalizekey citext,
personalizeddata citext,
createdby bigint NOT NULL,
helpdeskid bigint,
CONSTRAINT userpersonalize_1050874165_c CHECK ((length((personalizekey)::text) <= 250))
);
CREATE TABLE public.userprofile (
userid bigint NOT NULL,
timezoneid bigint,
dateformat citext NOT NULL,
CONSTRAINT userprofile_1556470053_c CHECK ((length((dateformat)::text) <= 100))
);
CREATE TABLE public.usersaccountinfo (
userid bigint NOT NULL,
workstationid bigint NOT NULL,
username citext NOT NULL,
domainname citext DEFAULT '-' NOT NULL,
fullname citext DEFAULT '-' NOT NULL,
description citext DEFAULT '-' NOT NULL,
status citext DEFAULT '-' NOT NULL,
localaccount boolean DEFAULT true NOT NULL,
sid citext,
CONSTRAINT usersaccountinfo_1839152142_c CHECK ((length((status)::text) <= 250)),
CONSTRAINT usersaccountinfo_2114432410_c CHECK ((length((fullname)::text) <= 250)),
CONSTRAINT usersaccountinfo_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT usersaccountinfo_516913366_c CHECK ((length((username)::text) <= 250)),
CONSTRAINT usersaccountinfo_758040241_c CHECK ((length((domainname)::text) <= 250)),
CONSTRAINT usersaccountinfo_82094_c CHECK ((length((sid)::text) <= 250))
);
CREATE TABLE public.usersitemapping (
usersitemappingid bigint NOT NULL,
userid bigint NOT NULL,
siteid bigint,
isadmin boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.usertoview (
userid bigint NOT NULL,
viewid bigint NOT NULL,
index_id bigint NOT NULL
);
CREATE TABLE public.userviewtime (
userid bigint NOT NULL,
notificationtime bigint NOT NULL
);
CREATE TABLE public.uvhvalues (
uvhid bigint NOT NULL,
fileid bigint NOT NULL,
pattern citext NOT NULL,
genvalues bigint NOT NULL,
table_name citext,
column_name citext,
CONSTRAINT uvhvalues_1347586516_c CHECK ((length((column_name)::text) <= 150)),
CONSTRAINT uvhvalues_73107600_c CHECK ((length((pattern)::text) <= 100)),
CONSTRAINT uvhvalues_989985668_c CHECK ((length((table_name)::text) <= 100))
);
CREATE TABLE public.validationfiles (
file_no bigint NOT NULL,
file_name citext NOT NULL,
CONSTRAINT validationfiles_1499679598_c CHECK ((length((file_name)::text) <= 255))
);
CREATE TABLE public.vendordefinition (
vendorid bigint NOT NULL,
jobtitle citext DEFAULT '-',
currencyid bigint NOT NULL,
contactperson citext DEFAULT '-',
CONSTRAINT vendordefinition_255147861_c CHECK ((length((contactperson)::text) <= 250)),
CONSTRAINT vendordefinition_813349701_c CHECK ((length((jobtitle)::text) <= 50))
);
CREATE TABLE public.vendorservicestype (
vendorservicestypeid bigint NOT NULL,
vendorservicestypename citext NOT NULL,
description citext,
isdefault boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT vendorservicestype_931371115_c CHECK ((length((vendorservicestypename)::text) <= 200))
);
CREATE TABLE public.verifyusers (
id bigint NOT NULL,
userid bigint NOT NULL,
createdby bigint NOT NULL,
createdtime bigint NOT NULL
);
CREATE TABLE public.videoencoder (
ciid bigint NOT NULL,
firmware citext,
CONSTRAINT videoencoder_227289531_c CHECK ((length((firmware)::text) <= 250))
);
CREATE TABLE public.videoencodercameras (
ciid bigint NOT NULL,
cameraname citext NOT NULL,
CONSTRAINT videoencodercameras_1526264016_c CHECK ((length((cameraname)::text) <= 200))
);
CREATE TABLE public.viewconfiguration (
viewname_no bigint NOT NULL,
viewname citext NOT NULL,
componentname bigint,
iconfile citext,
imagefile citext,
title citext,
description citext,
rolename citext,
menuid citext,
customizetype citext DEFAULT 'NO',
boxconfig citext,
cssclass citext,
account_id bigint,
childbox citext,
toolbarid citext,
handler citext,
templatename citext,
state citext,
properties citext,
CONSTRAINT viewconfiguration_1342071301_c CHECK ((length((templatename)::text) <= 250)),
CONSTRAINT viewconfiguration_1410786090_c CHECK ((length((handler)::text) <= 250)),
CONSTRAINT viewconfiguration_1852828881_c CHECK ((length((childbox)::text) <= 100)),
CONSTRAINT viewconfiguration_1908967735_c CHECK ((length((imagefile)::text) <= 100)),
CONSTRAINT viewconfiguration_1922124362_c CHECK ((length((toolbarid)::text) <= 50)),
CONSTRAINT viewconfiguration_1979239088_c CHECK ((length((viewname)::text) <= 100)),
CONSTRAINT viewconfiguration_2024392006_c CHECK ((length((menuid)::text) <= 50)),
CONSTRAINT viewconfiguration_300397395_c CHECK ((length((boxconfig)::text) <= 100)),
CONSTRAINT viewconfiguration_402005675_c CHECK ((length((cssclass)::text) <= 50)),
CONSTRAINT viewconfiguration_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT viewconfiguration_45235573_c CHECK ((length((iconfile)::text) <= 100)),
CONSTRAINT viewconfiguration_462248413_c CHECK ((length((customizetype)::text) <= 20)),
CONSTRAINT viewconfiguration_516800513_c CHECK ((length((rolename)::text) <= 100)),
CONSTRAINT viewconfiguration_79219825_c CHECK ((length((state)::text) <= 250)),
CONSTRAINT viewconfiguration_79833656_c CHECK ((length((title)::text) <= 100))
);
CREATE TABLE public.viewconfiguration_pidx (
viewname_no bigint NOT NULL,
table_name citext NOT NULL,
CONSTRAINT viewconfiguration_pidx_989985668_c CHECK ((length((table_name)::text) <= 40))
);
CREATE TABLE public.viewdatatablemapping (
viewname bigint NOT NULL,
tablename citext NOT NULL,
CONSTRAINT viewdatatablemapping_798830393_c CHECK ((length((tablename)::text) <= 100))
);
CREATE TABLE public.viewtoopen (
menuitemid bigint NOT NULL,
viewname bigint NOT NULL
);
CREATE TABLE public.vmhosts (
workstationid bigint NOT NULL,
servertypeid bigint NOT NULL,
allowedvms bigint,
installedvms bigint
);
CREATE TABLE public.vminfo (
workstationid bigint NOT NULL,
hostid bigint,
vmname citext,
vmipaddress citext,
instanceuuid citext,
memoryreservation bigint,
memorylimit bigint,
memoryshares integer,
memoryshareslevel citext,
memoryconfigured citext,
cpureservation bigint,
cpulimit bigint,
cpureservationinpercentage integer,
cpulimitinpercentage integer,
cpushares integer,
cpushareslevel citext,
cpuconfigured citext,
CONSTRAINT vminfo_1580604880_c CHECK ((length((instanceuuid)::text) <= 250)),
CONSTRAINT vminfo_1759360574_c CHECK ((length((vmname)::text) <= 200)),
CONSTRAINT vminfo_1763606577_c CHECK ((length((memoryshareslevel)::text) <= 100)),
CONSTRAINT vminfo_1840864826_c CHECK ((length((cpuconfigured)::text) <= 100)),
CONSTRAINT vminfo_297279256_c CHECK ((length((cpushareslevel)::text) <= 100)),
CONSTRAINT vminfo_590342134_c CHECK ((length((vmipaddress)::text) <= 200)),
CONSTRAINT vminfo_605686271_c CHECK ((length((memoryconfigured)::text) <= 100))
);
CREATE TABLE public.vmserveridentification (
identificationid bigint NOT NULL,
criteriatable citext NOT NULL,
criteriacolumn citext NOT NULL,
criteriavalue citext NOT NULL,
servertypeid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT vmserveridentification_1180972975_c CHECK ((length((criteriatable)::text) <= 100)),
CONSTRAINT vmserveridentification_1182829906_c CHECK ((length((criteriavalue)::text) <= 100)),
CONSTRAINT vmserveridentification_1776964469_c CHECK ((length((criteriacolumn)::text) <= 100))
);
CREATE TABLE public.vmservertypes (
typeid bigint NOT NULL,
servertype citext NOT NULL,
usage_order bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT vmservertypes_1339862787_c CHECK ((length((servertype)::text) <= 100))
);
CREATE TABLE public.webmenuitem (
menuitemid bigint NOT NULL,
actionlink citext,
target citext DEFAULT '_self' NOT NULL,
winparams citext,
is_scriptgenerated boolean DEFAULT false NOT NULL,
actiontype citext DEFAULT 'GET' NOT NULL,
CONSTRAINT webmenuitem_1394900926_c CHECK ((length((winparams)::text) <= 250)),
CONSTRAINT webmenuitem_1827576431_c CHECK ((length((target)::text) <= 250)),
CONSTRAINT webmenuitem_1957040528_c CHECK ((length((actiontype)::text) <= 50)),
CONSTRAINT webmenuitem_1957294288_c CHECK ((length((actionlink)::text) <= 100))
);
CREATE TABLE public.webserver (
ciid bigint NOT NULL
);
CREATE TABLE public.webuicomponent (
name bigint NOT NULL,
url citext,
viewcontroller citext,
templatename citext,
iscsrcomponent boolean DEFAULT false,
CONSTRAINT webuicomponent_1342071301_c CHECK ((length((templatename)::text) <= 250)),
CONSTRAINT webuicomponent_748603391_c CHECK ((length((viewcontroller)::text) <= 250)),
CONSTRAINT webuicomponent_84303_c CHECK ((length((url)::text) <= 250))
);
CREATE TABLE public.webviewconfig (
viewname bigint NOT NULL,
url citext,
viewcontroller citext,
is_scriptgenerated boolean DEFAULT false NOT NULL,
CONSTRAINT webviewconfig_748603391_c CHECK ((length((viewcontroller)::text) <= 250)),
CONSTRAINT webviewconfig_84303_c CHECK ((length((url)::text) <= 250))
);
CREATE TABLE public.wf_notify_org_roles (
wfnotifyorgrolesid bigint NOT NULL,
notificationactionid bigint NOT NULL,
org_roleid bigint NOT NULL,
type citext NOT NULL,
CONSTRAINT wf_notify_org_roles_2590522_c CHECK ((length((type)::text) <= 10))
);
CREATE TABLE public.wf_notify_placeholders (
wfnotifyplaceholdersid bigint NOT NULL,
notificationactionid bigint NOT NULL,
placeholderid bigint NOT NULL,
type citext NOT NULL,
CONSTRAINT wf_notify_placeholders_2590522_c CHECK ((length((type)::text) <= 10))
);
CREATE TABLE public.wf_notify_users (
wfnotifyusersid bigint NOT NULL,
notificationactionid bigint NOT NULL,
userid bigint NOT NULL,
type citext NOT NULL,
CONSTRAINT wf_notify_users_2590522_c CHECK ((length((type)::text) <= 10))
);
CREATE TABLE public.wfaction (
actionid bigint NOT NULL,
name citext,
description citext,
type citext NOT NULL,
moduleid bigint NOT NULL,
extended_moduleid bigint,
isactive boolean DEFAULT true,
is_system boolean DEFAULT false NOT NULL,
is_override boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
subaction_type citext DEFAULT 'action' NOT NULL,
CONSTRAINT wfaction_1219684739_c CHECK ((length((subaction_type)::text) <= 100)),
CONSTRAINT wfaction_2388619_c CHECK ((length((name)::text) <= 250)),
CONSTRAINT wfaction_2590522_c CHECK ((length((type)::text) <= 100)),
CONSTRAINT wfaction_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.wfactionsubrule (
id bigint NOT NULL,
actionid bigint NOT NULL,
subruleid bigint NOT NULL
);
CREATE TABLE public.wfevent (
id bigint NOT NULL,
name citext NOT NULL,
display_name citext NOT NULL,
entity_operation citext NOT NULL,
convenience_operation_name citext,
CONSTRAINT wfevent_1200519147_c CHECK ((length((entity_operation)::text) <= 20)),
CONSTRAINT wfevent_2388619_c CHECK ((length((name)::text) <= 50)),
CONSTRAINT wfevent_333046776_c CHECK ((length((display_name)::text) <= 100)),
CONSTRAINT wfevent_526069269_c CHECK ((length((convenience_operation_name)::text) <= 20))
);
CREATE TABLE public.wfexternalaction (
external_action_id bigint NOT NULL,
actionid bigint NOT NULL,
command citext NOT NULL,
CONSTRAINT wfexternalaction_1668377387_c CHECK ((length((command)::text) <= 200))
);
CREATE TABLE public.wffieldupdate (
wffieldupdateid bigint NOT NULL,
wfactionid bigint NOT NULL,
fieldname citext NOT NULL,
fieldvalue citext,
CONSTRAINT wffieldupdate_1082615991_c CHECK ((length((fieldvalue)::text) <= 5000)),
CONSTRAINT wffieldupdate_242409883_c CHECK ((length((fieldname)::text) <= 50))
);
CREATE TABLE public.wffieldupdateaction (
field_update_id bigint NOT NULL,
actionid bigint NOT NULL,
field_name citext NOT NULL,
field_value citext,
orderid bigint NOT NULL,
CONSTRAINT wffieldupdateaction_1091304144_c CHECK ((length((field_name)::text) <= 100))
);
CREATE TABLE public.wfgroup (
id bigint NOT NULL,
name citext NOT NULL,
description citext,
moduleid bigint NOT NULL,
extended_moduleid bigint,
module_type citext,
type citext NOT NULL,
orderid bigint NOT NULL,
createdtime bigint,
lastupdatedtime bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT wfgroup_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT wfgroup_2590522_c CHECK ((length((type)::text) <= 100)),
CONSTRAINT wfgroup_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT wfgroup_987711789_c CHECK ((length((module_type)::text) <= 50))
);
CREATE TABLE public.wfnegateaction (
negateid bigint NOT NULL,
actionid bigint NOT NULL,
comments citext NOT NULL,
CONSTRAINT wfnegateaction_180211188_c CHECK ((length((comments)::text) <= 200))
);
CREATE TABLE public.wfnotification (
wfnotificationid bigint NOT NULL,
wfactionid bigint NOT NULL,
notifymode citext NOT NULL,
CONSTRAINT wfnotification_679088020_c CHECK ((length((notifymode)::text) <= 50))
);
CREATE TABLE public.wfnotificationaction (
notificationactionid bigint NOT NULL,
actionid bigint NOT NULL,
notificationcontentid bigint NOT NULL,
mode citext DEFAULT 'E-Mail' NOT NULL,
CONSTRAINT wfnotificationaction_2372003_c CHECK ((length((mode)::text) <= 10))
);
CREATE TABLE public.wfrule (
ruleid bigint NOT NULL,
name citext NOT NULL,
description citext,
moduleid bigint NOT NULL,
extended_moduleid bigint,
module_type citext,
is_cascade boolean DEFAULT false NOT NULL,
cascade_to_next_group boolean DEFAULT false NOT NULL,
is_enabled boolean DEFAULT true NOT NULL,
orderid bigint NOT NULL,
groupid bigint,
time_to_execute citext NOT NULL,
execute_on_first_match boolean DEFAULT false NOT NULL,
rule_type citext NOT NULL,
rule_sub_type citext,
criteriajson citext,
cfcondactionid bigint,
createdtime bigint NOT NULL,
lastupdatedtime bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
is_subrule boolean DEFAULT false NOT NULL,
CONSTRAINT wfrule_1182855204_c CHECK ((length((rule_sub_type)::text) <= 100)),
CONSTRAINT wfrule_1196540483_c CHECK ((length((time_to_execute)::text) <= 50)),
CONSTRAINT wfrule_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT wfrule_724151965_c CHECK ((length((rule_type)::text) <= 100)),
CONSTRAINT wfrule_987711789_c CHECK ((length((module_type)::text) <= 50))
);
CREATE TABLE public.wfrule_action_map (
mapid bigint NOT NULL,
actionid bigint NOT NULL,
ruleid bigint NOT NULL,
orderid bigint NOT NULL
);
CREATE TABLE public.wfrule_event_map (
mapid bigint NOT NULL,
ruleid bigint NOT NULL,
eventid bigint NOT NULL
);
CREATE TABLE public.wfrulecfmapping (
wfrulecfmappingid bigint NOT NULL,
wfruleactionid bigint NOT NULL,
cfdetailid bigint NOT NULL
);
CREATE TABLE public.wfrulesitetogroupmapping (
sgmappingid bigint NOT NULL,
groupid bigint NOT NULL,
siteid bigint,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.wfruletoqueryidmapping (
id bigint NOT NULL,
ruleid bigint NOT NULL,
queryid bigint,
is_conversion_completed boolean DEFAULT false,
error_message citext,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.wfwebhookmapping (
wfwebhookmappingid bigint NOT NULL,
wfruleactionid bigint NOT NULL,
webhookactionid bigint NOT NULL
);
CREATE TABLE public.widgetdefinition (
widgetid bigint NOT NULL,
widgetname citext NOT NULL,
module citext NOT NULL,
createdby bigint NOT NULL,
ispublic boolean DEFAULT false NOT NULL,
graphtype bigint NOT NULL,
displayname citext DEFAULT '-' NOT NULL,
description citext,
helpdeskid bigint,
CONSTRAINT widgetdefinition_178650831_c CHECK ((length((widgetname)::text) <= 100)),
CONSTRAINT widgetdefinition_2015454612_c CHECK ((length((module)::text) <= 100)),
CONSTRAINT widgetdefinition_426904019_c CHECK ((length((displayname)::text) <= 250)),
CONSTRAINT widgetdefinition_428414940_c CHECK ((length((description)::text) <= 4000))
);
CREATE TABLE public.widgetdimensiondetail (
wddid bigint NOT NULL,
userid bigint NOT NULL,
viewname citext NOT NULL,
diminfo citext NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT widgetdimensiondetail_1910968042_c CHECK ((length((diminfo)::text) <= 4000)),
CONSTRAINT widgetdimensiondetail_1979239088_c CHECK ((length((viewname)::text) <= 50))
);
CREATE TABLE public.widgetproperties (
propertyid bigint NOT NULL,
widgetid bigint NOT NULL,
propertyname citext NOT NULL,
propertyvalue citext NOT NULL,
description citext,
CONSTRAINT widgetproperties_1453542880_c CHECK ((length((propertyname)::text) <= 100)),
CONSTRAINT widgetproperties_2117544092_c CHECK ((length((propertyvalue)::text) <= 100)),
CONSTRAINT widgetproperties_428414940_c CHECK ((length((description)::text) <= 300))
);
CREATE TABLE public.widgets (
widgetid bigint NOT NULL,
widgetname citext NOT NULL,
type citext NOT NULL,
description citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT widgets_178650831_c CHECK ((length((widgetname)::text) <= 100)),
CONSTRAINT widgets_2590522_c CHECK ((length((type)::text) <= 100)),
CONSTRAINT widgets_428414940_c CHECK ((length((description)::text) <= 4000))
);
CREATE TABLE public.widgettocriteriamapping (
criteriaid bigint NOT NULL,
widgetid bigint NOT NULL,
queryid bigint NOT NULL
);
CREATE TABLE public.widgettogroupbycolumn (
mappingid bigint NOT NULL,
widgetid bigint NOT NULL,
groupbytable citext NOT NULL,
groupbycolumn citext NOT NULL,
groupbyorder bigint NOT NULL,
CONSTRAINT widgettogroupbycolumn_1535106612_c CHECK ((length((groupbycolumn)::text) <= 100)),
CONSTRAINT widgettogroupbycolumn_658489976_c CHECK ((length((groupbytable)::text) <= 100))
);
CREATE TABLE public.windowsserver (
ciid bigint NOT NULL
);
CREATE TABLE public.windowsworkstation (
ciid bigint NOT NULL
);
CREATE TABLE public.wmierrorcode (
errorid bigint NOT NULL,
hexacode citext NOT NULL,
errorcode integer NOT NULL,
CONSTRAINT wmierrorcode_323005331_c CHECK ((length((hexacode)::text) <= 100))
);
CREATE TABLE public.wmiswusageinfo (
softwareinfoid bigint NOT NULL,
softwareusage citext NOT NULL,
CONSTRAINT wmiswusageinfo_1028709318_c CHECK ((length((softwareusage)::text) <= 100))
);
CREATE TABLE public.wo_assessment (
assessmentid bigint NOT NULL,
workorderid bigint NOT NULL,
executedtime bigint NOT NULL
);
CREATE TABLE public.wo_group_info (
assessmentid bigint NOT NULL,
groupid bigint,
nextgroupid bigint,
endtime bigint,
timespent bigint,
operationownerid bigint
);
CREATE TABLE public.wo_group_ola_info (
wotogroupid bigint NOT NULL,
workorderid bigint NOT NULL,
queueid bigint NOT NULL,
is_current_group boolean DEFAULT false,
assigned_time bigint NOT NULL,
violation_time bigint NOT NULL,
completed_time bigint,
is_violated boolean DEFAULT false,
timespent bigint DEFAULT '0' NOT NULL,
allowed_time bigint DEFAULT '0' NOT NULL
);
CREATE TABLE public.wo_marktechnician (
workorderid bigint NOT NULL,
techid bigint NOT NULL
);
CREATE TABLE public.wo_resources (
uid bigint NOT NULL,
woid bigint NOT NULL,
resourceid bigint NOT NULL,
resource_association_id bigint NOT NULL,
requested boolean DEFAULT false NOT NULL
);
CREATE TABLE public.wo_share_comments (
workorderid bigint NOT NULL,
technician_comments citext,
user_comments citext,
CONSTRAINT wo_share_comments_1202316689_c CHECK ((length((technician_comments)::text) <= 150)),
CONSTRAINT wo_share_comments_560410600_c CHECK ((length((user_comments)::text) <= 150))
);
CREATE TABLE public.wo_share_list (
shareid bigint NOT NULL,
workorderid bigint NOT NULL,
shared_by bigint NOT NULL,
shared_time bigint NOT NULL
);
CREATE TABLE public.wo_sla_group_info (
sla_group_id bigint NOT NULL,
assessmentid bigint NOT NULL,
starttime bigint,
endtime bigint,
timespent bigint
);
CREATE TABLE public.wo_sla_status_info (
sla_status_id bigint NOT NULL,
assessmentid bigint NOT NULL,
starttime bigint,
endtime bigint,
timespent bigint
);
CREATE TABLE public.wo_sla_tech_info (
sla_tech_id bigint NOT NULL,
assessmentid bigint NOT NULL,
starttime bigint,
endtime bigint,
timespent bigint
);
CREATE TABLE public.wo_status_info (
assessmentid bigint NOT NULL,
statusid bigint NOT NULL,
nextstatusid bigint,
endtime bigint,
timespent bigint,
comments citext,
operationownerid bigint
);
CREATE TABLE public.wo_tech_info (
assessmentid bigint NOT NULL,
technicianid bigint,
nexttechnicianid bigint,
endtime bigint,
timespent bigint,
operationownerid bigint
);
CREATE TABLE public.wo_template_tasks (
workorderid bigint NOT NULL,
wo_templateid bigint NOT NULL,
template_taskid bigint NOT NULL,
taskid bigint
);
CREATE TABLE public.wo_to_messageid (
id bigint NOT NULL,
messageid citext NOT NULL,
workorderid bigint NOT NULL,
CONSTRAINT wo_to_messageid_1346582338_c CHECK ((length((messageid)::text) <= 250))
);
CREATE TABLE public.wodependency (
workorderid bigint NOT NULL,
reqdependencyid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.wodependencymarking (
dependency_index bigint NOT NULL,
reqdependencyid bigint NOT NULL,
dependsonid bigint NOT NULL,
dependentid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL
);
CREATE TABLE public.woresolutionattachment (
attachmentid bigint NOT NULL,
workorderid bigint NOT NULL
);
CREATE TABLE public.workflow (
workflowid bigint NOT NULL,
workflowname citext NOT NULL,
type citext,
createdtime bigint NOT NULL,
createdby bigint,
description citext,
isdeleted boolean DEFAULT false NOT NULL,
isdefault boolean DEFAULT false,
moduleid bigint NOT NULL,
isvalidated boolean DEFAULT false NOT NULL,
lastupdatedtime bigint,
lastupdateby bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
attachmentid bigint,
CONSTRAINT workflow_2590522_c CHECK ((length((type)::text) <= 100)),
CONSTRAINT workflow_416398646_c CHECK ((length((workflowname)::text) <= 100)),
CONSTRAINT workflow_428414940_c CHECK ((length((description)::text) <= 250))
);
CREATE TABLE public.workflowaction (
wfactionid bigint NOT NULL,
name citext NOT NULL,
description citext,
typeid bigint NOT NULL,
moduleid bigint,
siteid bigint,
isactive boolean DEFAULT true,
is_system boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT workflowaction_2388619_c CHECK ((length((name)::text) <= 150)),
CONSTRAINT workflowaction_428414940_c CHECK ((length((description)::text) <= 2000))
);
CREATE TABLE public.workflowhistory (
historyid bigint NOT NULL,
workflowid bigint NOT NULL,
operationownerid bigint NOT NULL,
operationtime bigint NOT NULL,
description citext,
operation citext DEFAULT 'CREATE',
CONSTRAINT workflowhistory_154330439_c CHECK ((length((operation)::text) <= 50)),
CONSTRAINT workflowhistory_428414940_c CHECK ((length((description)::text) <= 5000))
);
CREATE TABLE public.workflowhistorydiff (
historydiffid bigint NOT NULL,
historyid bigint NOT NULL,
columnname citext NOT NULL,
prev_value citext,
current_value citext,
isencrypted boolean,
CONSTRAINT workflowhistorydiff_1088349253_c CHECK ((length((prev_value)::text) <= 5000)),
CONSTRAINT workflowhistorydiff_1619616031_c CHECK ((length((columnname)::text) <= 30)),
CONSTRAINT workflowhistorydiff_1969348885_c CHECK ((length((current_value)::text) <= 5000))
);
CREATE TABLE public.working_hours (
working_hours_id bigint NOT NULL,
working_hours_name citext NOT NULL,
start_time bigint NOT NULL,
unit_of_start_time citext NOT NULL,
end_time bigint NOT NULL,
unit_of_end_time citext NOT NULL,
CONSTRAINT working_hours_667027198_c CHECK ((length((unit_of_end_time)::text) <= 20)),
CONSTRAINT working_hours_786418839_c CHECK ((length((unit_of_start_time)::text) <= 20)),
CONSTRAINT working_hours_899191753_c CHECK ((length((working_hours_name)::text) <= 150))
);
CREATE TABLE public.worklog_fields (
worklogid bigint NOT NULL
);
CREATE TABLE public.worklogtypedefinition (
worklogtypeid bigint NOT NULL,
name citext NOT NULL,
description citext,
colorcode citext,
isdeleted boolean DEFAULT false,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT worklogtypedefinition_2388619_c CHECK ((length((name)::text) <= 100)),
CONSTRAINT worklogtypedefinition_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT worklogtypedefinition_473007024_c CHECK ((length((colorcode)::text) <= 10))
);
CREATE TABLE public.workorder (
workorderid bigint NOT NULL,
requesterid bigint NOT NULL,
oboid bigint,
createdbyid bigint,
createdtime bigint NOT NULL,
respondedtime bigint DEFAULT '0' NOT NULL,
duebytime bigint NOT NULL,
completedtime bigint DEFAULT '0' NOT NULL,
timespentonreq bigint DEFAULT '0' NOT NULL,
totalunassignedtime bigint DEFAULT '0',
onholdtime bigint DEFAULT '0',
ageafterviolation bigint DEFAULT '0',
ageafterslaresponseviolation bigint DEFAULT '0',
title citext,
description citext,
modeid bigint,
slaid bigint,
servicesla_association bigint,
olaid bigint,
ciid bigint,
assetid bigint,
deptid bigint,
siteid bigint,
autoclosetime bigint,
closedbydenial boolean DEFAULT false NOT NULL,
closeauthkey bigint,
isparent boolean DEFAULT true NOT NULL,
templateid bigint,
serviceid bigint,
is_catalog_template boolean DEFAULT false NOT NULL,
recommend_templateid bigint,
fr_duetime bigint DEFAULT '0' NOT NULL,
haschange boolean DEFAULT false NOT NULL,
hascausedbychange boolean DEFAULT false NOT NULL,
hasproblem boolean DEFAULT false NOT NULL,
hasdependency boolean DEFAULT false NOT NULL,
surveystatus integer DEFAULT 0 NOT NULL,
hasdraft boolean DEFAULT false NOT NULL,
resolvedtime bigint DEFAULT '0' NOT NULL,
reopenedtime bigint DEFAULT '0' NOT NULL,
ola_duetime bigint DEFAULT '0' NOT NULL,
hasproject boolean DEFAULT false NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
isshared boolean DEFAULT false NOT NULL,
service_cost double,
total_cost double DEFAULT '0' NOT NULL,
hasresolutionattachment boolean DEFAULT false NOT NULL,
haspo boolean DEFAULT false NOT NULL,
haspr boolean DEFAULT false NOT NULL,
scheduledstarttime bigint,
scheduledendtime bigint,
encryptedurlid bigint,
response_timespent bigint DEFAULT '0' NOT NULL,
outside_operational_hour boolean DEFAULT false,
actual_sla_resolution_time bigint DEFAULT '0' NOT NULL,
actual_sla_response_time bigint DEFAULT '0' NOT NULL,
CONSTRAINT workorder_79833656_c CHECK ((length((title)::text) <= 250))
);
CREATE TABLE public.workorder_callback (
workorderid bigint NOT NULL,
callbackurl citext,
CONSTRAINT workorder_callback_272328982_c CHECK ((length((callbackurl)::text) <= 500))
);
CREATE TABLE public.workorder_fields (
workorderid bigint NOT NULL
);
CREATE TABLE public.workorder_multi_fields (
workorderid bigint NOT NULL
);
CREATE TABLE public.workorder_queue (
workorderid bigint NOT NULL,
queueid bigint NOT NULL,
createdtime bigint NOT NULL,
isescalated boolean DEFAULT false NOT NULL
);
CREATE TABLE public.workorder_recipients (
workorderid bigint NOT NULL,
recipient_name citext,
recipient_email citext NOT NULL,
to_cc_bcc citext,
CONSTRAINT workorder_recipients_1813314833_c CHECK ((length((recipient_name)::text) <= 250)),
CONSTRAINT workorder_recipients_370219446_c CHECK ((length((recipient_email)::text) <= 250)),
CONSTRAINT workorder_recipients_862828025_c CHECK ((length((to_cc_bcc)::text) <= 250))
);
CREATE TABLE public.workorder_tags (
workorder_tagid bigint NOT NULL,
tagid bigint NOT NULL,
workorderid bigint NOT NULL
);
CREATE TABLE public.workorderattachment (
attachmentid bigint NOT NULL,
workorderid bigint NOT NULL
);
CREATE TABLE public.workorderdeletehistory (
workorderid bigint DEFAULT '0' NOT NULL,
deleteddate bigint,
deletedby citext,
CONSTRAINT workorderdeletehistory_1867077104_c CHECK ((length((deletedby)::text) <= 100))
);
CREATE TABLE public.workorderhistory (
historyid bigint NOT NULL,
workorderid bigint NOT NULL,
operationownerid bigint NOT NULL,
operationtime bigint NOT NULL,
description citext,
operation citext DEFAULT 'CREATE',
CONSTRAINT workorderhistory_154330439_c CHECK ((length((operation)::text) <= 50))
);
CREATE TABLE public.workorderhistorydiff (
historydiffid bigint NOT NULL,
historyid bigint NOT NULL,
columnname citext NOT NULL,
prev_value citext,
current_value citext,
prev_encrypted_value bytea,
current_encrypted_value bytea
);
CREATE TABLE public.workorderimages (
workorderid bigint NOT NULL,
mediaid bigint NOT NULL
);
CREATE TABLE public.workordernotes (
notesid bigint NOT NULL,
workorderid bigint NOT NULL,
ispublic boolean DEFAULT false NOT NULL
);
CREATE TABLE public.workordernotestordssummary (
wotordsid bigint NOT NULL,
notesid bigint NOT NULL,
summaryid bigint NOT NULL
);
CREATE TABLE public.workordersignoff (
signoffid bigint NOT NULL,
workorderid bigint NOT NULL,
requestername citext NOT NULL,
comments citext,
attachmentid bigint NOT NULL,
signofftime bigint NOT NULL
);
CREATE TABLE public.workorderstates (
workorderid bigint NOT NULL,
categoryid bigint,
subcategoryid bigint,
itemid bigint,
ownerid bigint,
assignedtime bigint,
statusid bigint,
priorityid bigint,
levelid bigint,
isoverdue boolean DEFAULT false NOT NULL,
ola_status bigint,
isescalated boolean DEFAULT false NOT NULL,
isread boolean DEFAULT false NOT NULL,
shownotestotech boolean DEFAULT false NOT NULL,
notificationstatus citext,
unrepliedcount integer,
reqapproval boolean DEFAULT false NOT NULL,
appr_statusid bigint,
impactid bigint,
impactdetails citext,
urgencyid bigint,
requesttypeid bigint,
reopened boolean DEFAULT false NOT NULL,
closeaccepted citext,
close_comments citext,
hasattachment boolean DEFAULT false NOT NULL,
is_fr_overdue boolean DEFAULT false NOT NULL,
haslinkedrequest boolean DEFAULT false NOT NULL,
linkcomments citext,
linkedworkorderid bigint,
closurecodeid bigint,
closurecomments citext,
email_cc bytea,
editorid bigint,
editing_status integer DEFAULT 0 NOT NULL,
last_tech_update bigint DEFAULT '0' NOT NULL,
isfcr boolean DEFAULT false NOT NULL,
is_cancel_requested boolean DEFAULT false NOT NULL,
cancel_requested_by bigint,
cancel_requested_reason citext,
cancel_requested_time bigint DEFAULT '0' NOT NULL,
req_chat_type integer DEFAULT 0 NOT NULL,
slaviolatedtechnician bigint,
slaviolatedgroup bigint,
CONSTRAINT workorderstates_1297707548_c CHECK ((length((impactdetails)::text) <= 250)),
CONSTRAINT workorderstates_1491149842_c CHECK ((length((linkcomments)::text) <= 250)),
CONSTRAINT workorderstates_1542560015_c CHECK ((length((closurecomments)::text) <= 1000)),
CONSTRAINT workorderstates_2044210299_c CHECK ((length((close_comments)::text) <= 1000)),
CONSTRAINT workorderstates_2137973377_c CHECK ((length((closeaccepted)::text) <= 250)),
CONSTRAINT workorderstates_610265978_c CHECK ((length((cancel_requested_reason)::text) <= 500)),
CONSTRAINT workorderstates_847157405_c CHECK ((length((notificationstatus)::text) <= 250))
);
CREATE TABLE public.workordertoasset (
wotoassetid bigint NOT NULL,
workorderid bigint NOT NULL,
assetid bigint
);
CREATE TABLE public.workordertocharge (
workorderid bigint NOT NULL,
chargeid bigint NOT NULL
);
CREATE TABLE public.workordertochecklist (
workorderid bigint NOT NULL,
checklistid bigint NOT NULL
);
CREATE TABLE public.workordertoci (
wotociid bigint NOT NULL,
workorderid bigint NOT NULL,
ciid bigint
);
CREATE TABLE public.workordertodescription (
workorderid bigint NOT NULL,
fulldescription citext,
attachmentid bigint
);
CREATE TABLE public.workordertoexternaltasks (
taskid bigint NOT NULL,
workorderid bigint NOT NULL,
is_close boolean DEFAULT false NOT NULL
);
CREATE TABLE public.workordertolifecycle (
workorderid bigint NOT NULL,
lifecycleid bigint,
current_transition_id bigint
);
CREATE TABLE public.workordertomenuactionstatusmapper (
action_status_id bigint NOT NULL,
workorder_id bigint NOT NULL
);
CREATE TABLE public.workordertopurchaseorder (
workorderid bigint NOT NULL,
purchaseorderid bigint NOT NULL
);
CREATE TABLE public.workordertotaskdetails (
workorderid bigint NOT NULL,
taskid bigint NOT NULL
);
CREATE TABLE public.workordertotasktable (
workorderid bigint NOT NULL,
taskid bigint NOT NULL
);
CREATE TABLE public.workordertotimerschedule (
entity_id bigint NOT NULL,
schedule_id bigint NOT NULL
);
CREATE TABLE public.workstation_fields (
workstationid bigint NOT NULL,
udf_long1 bigint,
udf_long2 bigint,
udf_char1 citext,
udf_char2 citext,
udf_char3 citext,
udf_char4 citext,
udf_char5 citext,
udf_char6 citext,
udf_date1 bigint,
udf_date2 bigint,
udf_long3 bigint,
udf_long4 bigint,
udf_char7 citext,
udf_char8 citext,
udf_char9 citext,
udf_char10 citext,
udf_char11 citext,
udf_char12 citext,
udf_date3 bigint,
udf_date4 bigint,
udf_char13 citext,
udf_char14 citext,
udf_char15 citext,
udf_char16 citext,
udf_char17 citext,
udf_char18 citext,
udf_char19 citext,
udf_char20 citext,
udf_char21 citext,
udf_char22 citext,
udf_char23 citext,
udf_char24 citext,
udf_date5 bigint,
udf_date6 bigint,
udf_date7 bigint,
udf_date8 bigint,
udf_long5 bigint,
udf_long6 bigint,
udf_long7 bigint,
udf_long8 bigint,
udf_long9 bigint,
udf_long10 bigint,
udf_date9 bigint,
udf_date10 bigint,
CONSTRAINT workstation_fields_278184709_c CHECK ((length((udf_char9)::text) <= 3500)),
CONSTRAINT workstation_fields_278184710_c CHECK ((length((udf_char8)::text) <= 3500)),
CONSTRAINT workstation_fields_278184711_c CHECK ((length((udf_char7)::text) <= 3500)),
CONSTRAINT workstation_fields_278184712_c CHECK ((length((udf_char6)::text) <= 3500)),
CONSTRAINT workstation_fields_278184713_c CHECK ((length((udf_char5)::text) <= 3500)),
CONSTRAINT workstation_fields_278184714_c CHECK ((length((udf_char4)::text) <= 3500)),
CONSTRAINT workstation_fields_278184715_c CHECK ((length((udf_char3)::text) <= 3500)),
CONSTRAINT workstation_fields_278184716_c CHECK ((length((udf_char2)::text) <= 3500)),
CONSTRAINT workstation_fields_278184717_c CHECK ((length((udf_char1)::text) <= 3500)),
CONSTRAINT workstation_fields_33791552_c CHECK ((length((udf_char24)::text) <= 3500)),
CONSTRAINT workstation_fields_33791553_c CHECK ((length((udf_char23)::text) <= 3500)),
CONSTRAINT workstation_fields_33791554_c CHECK ((length((udf_char22)::text) <= 3500)),
CONSTRAINT workstation_fields_33791555_c CHECK ((length((udf_char21)::text) <= 3500)),
CONSTRAINT workstation_fields_33791556_c CHECK ((length((udf_char20)::text) <= 3500)),
CONSTRAINT workstation_fields_33791578_c CHECK ((length((udf_char19)::text) <= 3500)),
CONSTRAINT workstation_fields_33791579_c CHECK ((length((udf_char18)::text) <= 3500)),
CONSTRAINT workstation_fields_33791580_c CHECK ((length((udf_char17)::text) <= 3500)),
CONSTRAINT workstation_fields_33791581_c CHECK ((length((udf_char16)::text) <= 3500)),
CONSTRAINT workstation_fields_33791582_c CHECK ((length((udf_char15)::text) <= 3500)),
CONSTRAINT workstation_fields_33791583_c CHECK ((length((udf_char14)::text) <= 3500)),
CONSTRAINT workstation_fields_33791584_c CHECK ((length((udf_char13)::text) <= 3500)),
CONSTRAINT workstation_fields_33791585_c CHECK ((length((udf_char12)::text) <= 3500)),
CONSTRAINT workstation_fields_33791586_c CHECK ((length((udf_char11)::text) <= 3500)),
CONSTRAINT workstation_fields_33791587_c CHECK ((length((udf_char10)::text) <= 3500))
);
CREATE TABLE public.workstation_printer (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.workstation_sd (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.workstation_technician (
primarykeyid bigint NOT NULL
);
CREATE TABLE public.workstationci (
ciid bigint NOT NULL
);
CREATE TABLE public.workstationmodeltype (
model citext NOT NULL,
componenttypeid bigint NOT NULL,
CONSTRAINT workstationmodeltype_73532169_c CHECK ((length((model)::text) <= 80))
);
CREATE TABLE public.workstationri (
itemid bigint NOT NULL,
workstationid bigint NOT NULL
);
CREATE TABLE public.wotodeletedasset (
wotoasset bigint NOT NULL,
workorderid bigint NOT NULL,
assetname citext,
CONSTRAINT wotodeletedasset_192316069_c CHECK ((length((assetname)::text) <= 256))
);
CREATE TABLE public.wotodeletedci (
wotoci bigint NOT NULL,
workorderid bigint NOT NULL,
ciname citext,
CONSTRAINT wotodeletedci_1987958769_c CHECK ((length((ciname)::text) <= 256))
);
CREATE TABLE public.wotoprojects (
associationid bigint NOT NULL,
workorderid bigint NOT NULL,
projectid bigint NOT NULL
);
CREATE TABLE public.wotopurchaserequests (
uid bigint NOT NULL,
workorderid bigint NOT NULL,
requestid bigint NOT NULL
);
CREATE TABLE public.wotordssummary (
summaryid bigint NOT NULL,
workorderid bigint NOT NULL
);
CREATE TABLE public.wsrdscredentials (
resourceid bigint NOT NULL,
credentialid bigint NOT NULL
);
CREATE TABLE public.yseriescolumn (
viewname bigint NOT NULL,
datacolumn citext NOT NULL,
colorinhex citext,
CONSTRAINT yseriescolumn_1783831123_c CHECK ((length((colorinhex)::text) <= 6)),
CONSTRAINT yseriescolumn_2079602816_c CHECK ((length((datacolumn)::text) <= 50))
);
CREATE TABLE public.zia_approvaldata (
id bigint NOT NULL,
content citext NOT NULL,
action citext NOT NULL,
isread boolean DEFAULT true NOT NULL,
isbalanced boolean DEFAULT true NOT NULL,
CONSTRAINT zia_approvaldata_1669513305_c CHECK ((length((content)::text) <= 250)),
CONSTRAINT zia_approvaldata_1925345846_c CHECK ((length((action)::text) <= 25))
);
CREATE TABLE public.zia_approvalprediction (
id bigint NOT NULL,
module citext NOT NULL,
workorderid bigint,
changeid bigint,
releaseid bigint,
purchaseorderid bigint,
purchaserequestid bigint,
approvalid bigint,
mailcontent citext NOT NULL,
prediction citext NOT NULL,
action_date bigint,
isvalid boolean DEFAULT true NOT NULL,
verifiedby bigint,
verifiedon bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT zia_approvalprediction_1364145858_c CHECK ((length((mailcontent)::text) <= 250)),
CONSTRAINT zia_approvalprediction_1646326927_c CHECK ((length((prediction)::text) <= 25)),
CONSTRAINT zia_approvalprediction_2015454612_c CHECK ((length((module)::text) <= 100))
);
CREATE TABLE public.zia_cumulativeaccuracy (
id bigint NOT NULL,
moduleid bigint NOT NULL,
accuracy integer NOT NULL,
accuracy_on bigint NOT NULL
);
CREATE TABLE public.zia_reopenprediction (
id bigint NOT NULL,
workorderid bigint NOT NULL,
senderid bigint NOT NULL,
mailcontent citext NOT NULL,
prediction citext NOT NULL,
action_date bigint NOT NULL,
isvalid boolean DEFAULT true NOT NULL,
verifiedby bigint,
verifiedon bigint,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT zia_reopenprediction_1364145858_c CHECK ((length((mailcontent)::text) <= 250)),
CONSTRAINT zia_reopenprediction_1646326927_c CHECK ((length((prediction)::text) <= 25))
);
CREATE TABLE public.ziabot_action_hitcount (
id bigint NOT NULL,
user_id bigint NOT NULL,
user_type citext NOT NULL,
action_id bigint NOT NULL,
no_of_hits bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT ziabot_action_hitcount_1139277010_c CHECK ((length((user_type)::text) <= 100))
);
CREATE TABLE public.ziabot_actiondetails (
id bigint NOT NULL,
action_name citext NOT NULL,
bot_id bigint NOT NULL,
internal_name citext NOT NULL,
description citext,
customfunction_id bigint,
bot_command_id bigint NOT NULL,
isenabled boolean DEFAULT true NOT NULL,
CONSTRAINT ziabot_actiondetails_428414940_c CHECK ((length((description)::text) <= 500)),
CONSTRAINT ziabot_actiondetails_528897292_c CHECK ((length((action_name)::text) <= 250)),
CONSTRAINT ziabot_actiondetails_677323469_c CHECK ((length((internal_name)::text) <= 250))
);
CREATE TABLE public.ziabot_details (
bot_id bigint NOT NULL,
start_node bigint DEFAULT '1' NOT NULL,
retry bigint DEFAULT '3' NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
is_enabled boolean DEFAULT true NOT NULL
);
CREATE TABLE public.ziabot_node_hitcount (
id bigint NOT NULL,
user_id bigint NOT NULL,
user_type citext NOT NULL,
node_id bigint NOT NULL,
no_of_hits bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT ziabot_node_hitcount_1139277010_c CHECK ((length((user_type)::text) <= 100))
);
CREATE TABLE public.ziabot_node_metrics (
id bigint NOT NULL,
userid bigint NOT NULL,
chatid bigint NOT NULL,
chat_infoid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
node_id bigint NOT NULL,
status bigint NOT NULL,
ratings bigint
);
CREATE TABLE public.ziabot_nodedetails (
id bigint NOT NULL,
bot_id bigint NOT NULL,
node_id bigint NOT NULL,
name citext NOT NULL,
internal_name citext NOT NULL,
type bigint NOT NULL,
optional_params citext,
sections citext,
validations citext,
isenabled boolean DEFAULT true NOT NULL,
CONSTRAINT ziabot_nodedetails_2388619_c CHECK ((length((name)::text) <= 250)),
CONSTRAINT ziabot_nodedetails_677323469_c CHECK ((length((internal_name)::text) <= 250))
);
CREATE TABLE public.ziabot_nodetype (
id bigint NOT NULL,
type citext NOT NULL,
CONSTRAINT ziabot_nodetype_2590522_c CHECK ((length((type)::text) <= 100))
);
CREATE TABLE public.ziabot_properties (
id bigint NOT NULL,
name citext NOT NULL,
value citext NOT NULL,
description citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT ziabot_properties_2388619_c CHECK ((length((name)::text) <= 250)),
CONSTRAINT ziabot_properties_428414940_c CHECK ((length((description)::text) <= 250)),
CONSTRAINT ziabot_properties_81434961_c CHECK ((length((value)::text) <= 250))
);
CREATE TABLE public.ziabot_ratings (
id bigint NOT NULL,
ratings citext NOT NULL,
ratings_value bigint NOT NULL,
CONSTRAINT ziabot_ratings_1701580374_c CHECK ((length((ratings)::text) <= 100))
);
CREATE TABLE public.ziabot_status (
id bigint NOT NULL,
status_name citext NOT NULL,
CONSTRAINT ziabot_status_1291128504_c CHECK ((length((status_name)::text) <= 100))
);
CREATE TABLE public.zohoreportsconfiguration (
id bigint NOT NULL,
category citext NOT NULL,
param_name citext NOT NULL,
param_value citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT zohoreportsconfiguration_60008705_c CHECK ((length((param_value)::text) <= 250)),
CONSTRAINT zohoreportsconfiguration_833137918_c CHECK ((length((category)::text) <= 50)),
CONSTRAINT zohoreportsconfiguration_967657245_c CHECK ((length((param_name)::text) <= 20))
);
CREATE TABLE public.zonecountrymappingdefinition (
mappingid bigint NOT NULL,
rawoffset integer NOT NULL,
zonename citext NOT NULL,
countryname citext NOT NULL,
CONSTRAINT zonecountrymappingdefinition_1631639607_c CHECK ((length((zonename)::text) <= 100)),
CONSTRAINT zonecountrymappingdefinition_677161729_c CHECK ((length((countryname)::text) <= 100))
);
CREATE TABLE public.zrdynamicvaluesinfo (
id bigint NOT NULL,
category citext NOT NULL,
param_name citext NOT NULL,
param_value citext,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT zrdynamicvaluesinfo_833137918_c CHECK ((length((category)::text) <= 50)),
CONSTRAINT zrdynamicvaluesinfo_967657245_c CHECK ((length((param_name)::text) <= 20))
);
CREATE TABLE public.zrscheduleinfo (
instanceid bigint NOT NULL,
helpdeskid bigint NOT NULL
);
CREATE TABLE public.zrsharedusers (
id bigint NOT NULL,
emailid citext NOT NULL,
userid bigint,
usertypeid bigint NOT NULL,
helpdeskid bigint DEFAULT '1' NOT NULL,
CONSTRAINT zrsharedusers_920031849_c CHECK ((length((emailid)::text) <= 200))
);
CREATE TABLE public.zrsharedusertype (
usertypeid bigint NOT NULL,
name citext NOT NULL,
CONSTRAINT zrsharedusertype_2388619_c CHECK ((length((name)::text) <= 100))
);