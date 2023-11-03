<#
.SYNOPSIS
Makes an API request to the specified Relativity endpoint.

.DESCRIPTION
Constructs and sends an API request to the given Relativity endpoint, using the specified HTTP method and request body.

.PARAMETER ApiEndpoint
The specific API endpoint to which the request is to be made.

.PARAMETER HttpMethod
The HTTP method to use for the API request. Currently, only "Post" is supported.

.PARAMETER RequestBody
A hashtable containing the request body to be sent with the API request.

.NOTES
This function is internal and is the primary method for making API calls to the Relativity system.
#>
function Invoke-RelativityApiRequest
{
    Param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $ApiEndpoint,
        [Parameter(Mandatory = $true)]
        [ValidateSet("Post", "Get", "Put", "Delete")]
        [String] $HttpMethod,
        [Parameter(Mandatory = $false)]
        [Hashtable] $RequestBody
    )

    if ($null -eq $script:RelativityBaseUri)
    {
        throw "RelativityBaseUri is not set. Please run Set-RelativityBaseUri before proceeding."
    }

    if ($null -eq $script:RelativityCredential)
    {
        throw "RelativityCredential is not set. Please run Set-RelativityCredential before proceeding."
    }

    $RequestHeader = Get-RelativityApiRequestHeader

    try
    {
        switch ($HttpMethod)
        {
            "Post" { $Response = Invoke-RestMethod -Uri $ApiEndpoint -Method Post -Headers $RequestHeader -Body ($RequestBody | ConvertTo-Json -Depth 3) -ContentType "application/json" }
            "Get" { $Response = Invoke-RestMethod -Uri $ApiEndpoint -Method Get -Headers $RequestHeader }
            "Put" { $Response = Invoke-RestMethod -Uri $ApiEndpoint -Method Put -Headers $RequestHeader -Body ($RequestBody | ConvertTo-Json -Depth 3) -ContentType "application/json" }
            "Delete" { $Response = Invoke-RestMethod -Uri $ApiEndpoint -Method Delete -Headers $RequestHeader }
        }
    }
    catch
    {
        throw "Error making API call: $($_).Exception.Message"
    }

    return $Response
}