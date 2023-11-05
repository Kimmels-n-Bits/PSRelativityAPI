<#
.SYNOPSIS
Sets the base URI for Relativity interactions.

.DESCRIPTION
The function sets the base URI for all subsequent interactions with the Relativity system.
This is essential for forming the correct endpoints when making API calls or other HTTP requests
to the Relativity system.

.PARAMETER RelativityBaseUri
The base URI to set for Relativity. It should include the protocol (http/https) and the domain name.
The function will parse and store a formatted version of this URI for later use.

.EXAMPLE
Set-RelativityBaseUri -RelativityBaseUri "https://relativity.example.com"

This example sets the base URI for Relativity to "https://relativity.example.com".

.NOTES
Ensure the provided base URI is accessible and correct to avoid issues in subsequent operations.
#>
function Set-RelativityBaseUri
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String] $RelativityBaseUri
    )

    Begin
    {
        Write-Verbose "Starting Set-RelativityBaseUri"
    }
    Process
    {
        [System.Uri]$ParsedRelativityBaseUri = [System.Uri]::new($RelativityBaseUri)

        $script:RelativityBaseUri = "$($ParsedRelativityBaseUri.Scheme)://$($ParsedRelativityBaseUri.Host)"
    }
    End
    {
        Write-Verbose "Completed Set-RelativityBaseUri"
    }
}