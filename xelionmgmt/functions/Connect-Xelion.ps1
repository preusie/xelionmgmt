function Connect-Xelion {
	param (
		[Parameter(Mandatory = $true)]
        [string] $Username,

		[Parameter(Mandatory = $true)]
		[String] $Password,

		[Parameter(Mandatory = $true)]
		[String] $Userspace,

		[Parameter(Mandatory = $true)]
		[String] $Appkey,

		[Parameter(Mandatory = $true)]
		[String] $Serverfqdn,

        [Parameter(Mandatory = $true)]
        [string] $Xeliontenant
	)
}

	# Create the request body
	$body = @{
		"userName"= $Username
		"password"=  $Password
        "userSpace"= $Userspace
        "appKey"= $Appkey
	} | ConvertTo-Json

	Write-Host $body

	Write-Host "https://$($Serverfqdn)/api/v1/$($Xeliontenant)/me/login" -Method Post -Body $body -ContentType "application/json"

	# Send the POST request
	try {
		$response = (Invoke-RestMethod -Uri "https://$($Serverfqdn)/api/v1/$($Xeliontenant)/me/login" -Method Post -Body $body -ContentType "application/json")
		$authtoken = $response.authentication
		return $authtoken
	} catch {
		Write-Error "Error: Failed to authenticate to Xelion API: $_"
		return $null
	}