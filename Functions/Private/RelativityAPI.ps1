function Invoke-RelativityApiRequest
{
    Param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet("ARM")]
        [String] $RelativityBusinessDomain,
        [Parameter(Mandatory = $true)]
        [String] $RelativityApiEndpointExtended,
        [Parameter(Mandatory = $true)]
        [ValidateSet("Post")]
        [String] $RelativityApiHttpMethod,
        [Parameter(Mandatory = $true)]
        [Hashtable] $RelativityApiRequestBody
    )

    $RelativityApiEndpointBase = Get-RelativityApiEndpointBase -RelativityBusinessDomain $RelativityBusinessDomain
    $RelativityApiEndpoint = "$($RelativityApiEndpointBase)$($RelativityApiEndpointExtended)"

    $RelativityApiRequestHeader = Get-RelativityApiRequestHeader

    Invoke-RestMethod -Uri $RelativityApiEndpoint -Method $RelativityApiHttpMethod -Headers $RelativityApiRequestHeader -Body ($RelativityApiRequestBody | ConvertTo-Json -Depth 3) -ContentType "application/json"
}