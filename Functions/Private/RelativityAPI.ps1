<#
.SYNOPSIS
Makes an API request to the specified Relativity endpoint.

.DESCRIPTION
Constructs and sends an API request to the given Relativity endpoint, using the specified HTTP method and request body.

.PARAMETER RelativityBusinessDomain
The business domain for which the API request is intended.

.PARAMETER RelativityApiEndpointExtended
The specific API endpoint (excluding the base) to which the request is to be made.

.PARAMETER RelativityApiHttpMethod
The HTTP method to use for the API request. Currently, only "Post" is supported.

.PARAMETER RelativityApiRequestBody
A hashtable containing the request body to be sent with the API request.

.NOTES
This function is internal and is the primary method for making API calls to the Relativity system.
#>
function Invoke-RelativityApiRequest
{
    Param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet("AgentManager", "ARM")]
        [String] $RelativityBusinessDomain,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $RelativityApiEndpointExtended,
        [Parameter(Mandatory = $true)]
        [ValidateSet("Get", "Post", "Put")]
        [String] $RelativityApiHttpMethod,
        [Parameter(Mandatory = $false)]
        [Hashtable] $RelativityApiRequestBody
    )

    if ($null -eq $script:RelativityBaseUri)
    {
        throw "RelativityBaseUri is not set. Please run Set-RelativityBaseUri before proceeding."
    }

    if ($null -eq $script:RelativityCredential)
    {
        throw "RelativityCredential is not set. Please run Set-RelativityCredential before proceeding."
    }

    $RelativityApiEndpointBase = Get-RelativityApiEndpointBase -RelativityBusinessDomain $RelativityBusinessDomain
    $RelativityApiEndpoint = "$($RelativityApiEndpointBase)$($RelativityApiEndpointExtended)"

    $RelativityApiRequestHeader = Get-RelativityApiRequestHeader

    try
    {
        switch ($RelativityApiHttpMethod)
        {
            "Get" { $RelativityApiResponse = Invoke-RestMethod -Uri $RelativityApiEndpoint -Method Get -Headers $RelativityApiRequestHeader }
            "Post" { $RelativityApiResponse = Invoke-RestMethod -Uri $RelativityApiEndpoint -Method Post -Headers $RelativityApiRequestHeader -Body ($RelativityApiRequestBody | ConvertTo-Json -Depth 3) -ContentType "application/json" }
            "Put" { $RelativityApiResponse = Invoke-RestMethod -Uri $RelativityApiEndpoint -Method Put -Headers $RelativityApiRequestHeader -Body ($RelativityApiRequestBody | ConvertTo-Json -Depth 3) -ContentType "application/json" }
        }
    }
    catch
    {
        throw "Error making API call: $($_).Exception.Message"
    }

    return $RelativityApiResponse
}