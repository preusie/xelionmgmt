function Get-XelionTrunks {
	param (
        [Parameter(Mandatory = $true)]
        [string] $Serverfqdn,

        [Parameter(Mandatory = $true)]
        [string] $Xeliontenant,

        [Parameter(Mandatory = $false)]
        [string] $oid
	)
    if ($oid) {
        $uri = "https://$($Serverfqdn)/api/v1/$($Xeliontenant)/trunks/$($oid)"
    } else {
        $uri = "https://$($Serverfqdn)/api/v1/$($Xeliontenant)/trunks"
    }
	
    # Send the GET request
	try {
        if (-not $authtoken) {
            Write-Host "Authenticate to server by using Connect-Xelion to obtain authentication token"
        } else {
            $response = (Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization = "xelion $authtoken"} -ContentType "application/json")
            if ($oid) {
                $response = $response.object
            }
            else {
                $response = $response.data.object
            }
        }

	} catch {
		Write-Error "Error: Failed to authenticate to Xelion API: $_"
		return $null
	}
}