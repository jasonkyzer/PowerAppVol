#PowerAppVol - a PowerShell module for interacting with the App Volumes API
#Requires 2.12.1.103
#Jason Kyzer
#jkyzer@vmware.com



#$hash=@{"username" = "administrator";"password" = "VMware123!"}
#irm -method post -uri https://appvolapi/cv_api/sessions -sess cookie -body $hash -Verbose
#irm -method get -uri https://appvolapi/cv_api/version -webs $cookie -ContentType "application/json"

[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}

function open-avsession ($avm,$user,$pass)
{
	$uri="https://$($avm)/cv_api/sessions"
	"using uri $($uri)"
	$cred=@{"username" = "$($user)";"password" = "$($pass)"}
	irm -sess cookie `
		-meth post `
		-uri $uri `
		-bod $cred `
		-con "application/json"
	return $cookie
}

function query-avapi ($avm,$websession,$query)
{
	$uri="https://$($avm)/cv_api/$($query)"
	"using uri $($uri)"
	$out=irm -webs $websession `
		-meth GET `
		-uri $uri
	return $out
}

$session=open-avsession <avm fqdn> <plain text username> <plain text password>
$session=open-avsession avm.my.domain.ok administrator m2k3@p2ssok

query-avapi <avm fqdn> <session> <query>
query-avapi avm.my.domain.ok $session version
