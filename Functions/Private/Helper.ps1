function Get-RelativityApiEndpointBase
{
    Param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet("ARM")]
        [String] $RelativityBusinessDomain
    )
    if ($script:RelativityBaseUri -eq $null)
    {
        throw "RelativityBaseUri is not set - make sure to run Set-RelativityBaseUri to a valid value before continuing."
    }

    if ($script:RelativityHttpSecure -eq $true)
    {
        $RelativityHttpProtocol = "https"
    }
    else
    {
        $RelativityHttpProtocol = "http"
    }

    switch ($RelativityBusinessDomain)
    {
        "ARM" { $RelativityBusinessDomainEndpoint = "relativity-arm/v1" }
    }

    return "$($RelativityHttpProtocol)://$($RelativityBaseUri)/Relativity.REST/api/$($RelativityBusinessDomainEndpoint)/"
}

function Get-RelativityApiRequestHeader
{
    $RelativityApiAuthorization = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($script:RelativityCredential.UserName):$($script:RelativityCredential.GetNetworkCredential().Password)"));

    $RelativityApiRequestHeader = New-Object "System.Collections.Generic.Dictionary[[String], [String]]";
    $RelativityApiRequestHeader.Add("X-CSRF-Header", "-");
    $RelativityApiRequestHeader.Add("Content-Type", "application/json");
    $RelativityApiRequestHeader.Add("Authorization", "Basic $($RelativityApiAuthorization)");

    return $RelativityApiRequestHeader
}