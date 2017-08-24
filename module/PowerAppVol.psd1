#PowerAppVol - a PowerShell module for interacting with the App Volumes API
#Requires 2.12.1.103
#Jason Kyzer
#jkyzer@vmware.com

$hash=@{"username" = "administrator";"password" = "VMware123!"}
irm -method post -uri https://appvolapi/cv_api/sessions -sess cookie -body
 $hash -Verbose
 

function open-avsession ($avm,$user,$pass)


{

	$uri="https://$($avm)/cv_api/sessions"
	"using uri $($uri)"
	$cred=@{username="$($user)"
	password="$($pass)"}
	irm -sess cookie `
		-meth post `
		-uri $uri `
		-bod $cred `
		-con "application/json"
	return $cookie


}



