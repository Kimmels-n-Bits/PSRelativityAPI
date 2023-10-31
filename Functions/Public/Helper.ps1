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
    [CmdletBinding(SupportsShouldProcess)]
    Param
    (
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $RelativityBaseUri
    )

    [System.Uri]$ParsedRelativityBaseUri = [System.Uri]::new($RelativityBaseUri)

    $script:RelativityBaseUri = "$($ParsedRelativityBaseUri.Scheme)://$($ParsedRelativityBaseUri.Host)"
}

<#
.SYNOPSIS
Sets the credentials for authenticating with Relativity.

.DESCRIPTION
The function sets the authentication credentials required for all subsequent interactions with the Relativity system.
These credentials are used to authenticate API calls or other HTTP requests to Relativity.
If no credentials are provided, the function will prompt the user to enter them.

.PARAMETER RelativityCredential
A PSCredential object containing the username and password for Relativity authentication. If not provided, the user will be prompted to input the credentials.

.EXAMPLE
$creds = Get-Credential
Set-RelativityCredential -RelativityCredential $creds

This example prompts the user for their Relativity credentials using `Get-Credential` and then sets them using `Set-RelativityCredential`.

.EXAMPLE
Set-RelativityCredential

In this example, the function will prompt the user to enter their Relativity credentials directly.

.NOTES
Ensure the provided credentials are valid and have the necessary permissions in Relativity to avoid authentication issues during subsequent operations.
Always handle credentials securely and avoid hardcoding them in scripts.
#>
function Set-RelativityCredential
{
    [CmdletBinding(SupportsShouldProcess)]
    Param
    (
        [Parameter(Mandatory = $false, Position = 0)]
        [ValidateScript({
            if (-not $_.UserName) {
                throw "The PSCredential object must have a UserName."
            }

            $password = $_.GetNetworkCredential().Password
            if (-not $password) {
                throw "The PSCredential object must have a Password."
            }

            return $true
        })]
        [PSCredential] $RelativityCredential
    )

    if ($RelativityCredential -eq $null)
    {
        $RelativityCredential = Get-Credential -Message "Enter your Relativity credentials."
    }

    $script:RelativityCredential = $RelativityCredential
}