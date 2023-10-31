<#
.SYNOPSIS
Gets the base endpoint for a specified Relativity business domain.

.DESCRIPTION
Constructs and returns the base API endpoint URL for the provided business domain in the Relativity system.

.PARAMETER RelativityBusinessDomain
The business domain for which the base endpoint URL is to be constructed. Currently, only "ARM" is supported.

.NOTES
This function is internal and is used to construct full API endpoints for other operations.
#>
function Get-RelativityApiEndpointBase
{
    Param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet("AgentManager", "ARM")]
        [String] $RelativityBusinessDomain
    )

    switch ($RelativityBusinessDomain)
    {
        "AgentManager" { $RelativityBusinessDomainEndpoint = "relativity.agents/workspace/-1"}
        "ARM" { $RelativityBusinessDomainEndpoint = "relativity-arm/v1" }
    }

    return "$($RelativityBaseUri)/Relativity.REST/api/$($RelativityBusinessDomainEndpoint)/"
}

<#
.SYNOPSIS
Generates the headers required for Relativity API requests.

.DESCRIPTION
Constructs and returns a dictionary of headers necessary for making authenticated API requests to the Relativity system.

.NOTES
This function is internal and is used to ensure all API requests are correctly authenticated.
#>
function Get-RelativityApiRequestHeader
{
    $RelativityApiAuthorization = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($script:RelativityCredential.UserName):$($script:RelativityCredential.GetNetworkCredential().Password)"));

    $RelativityApiRequestHeader = New-Object "System.Collections.Generic.Dictionary[[String], [String]]";
    $RelativityApiRequestHeader.Add("X-CSRF-Header", "-");
    $RelativityApiRequestHeader.Add("Content-Type", "application/json");
    $RelativityApiRequestHeader.Add("Authorization", "Basic $($RelativityApiAuthorization)");

    return $RelativityApiRequestHeader
}