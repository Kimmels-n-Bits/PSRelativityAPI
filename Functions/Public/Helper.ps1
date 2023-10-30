function Set-RelativityBaseUri
{
    Param 
    (
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $RelativityBaseUri
    )

    [System.Uri]$ParsedRelativityBaseUri = [System.Uri]::new($RelativityBaseUri)

    $script:RelativityBaseUri = "$($ParsedRelativityBaseUri.Scheme)://$($ParsedRelativityBaseUri.Host)"
}

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