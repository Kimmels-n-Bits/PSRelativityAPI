function Set-RelativityBaseUri
{
    [CmdletBinding(SupportsShouldProcess)]
    Param 
    (
        [Parameter(Mandatory = $true, Position = 0)]
        [String] $RelativityBaseUri
    )

    $RelativityBaseUri = $RelativityBaseUri -replace '^.*?(\/{1,}|\\{1,})', ''
    $RelativityBaseUri = $RelativityBaseUri -replace '(\/|\\).*?$', ''

    if ((Test-NetConnection $RelativityBaseUri -Port 443).TcpTestSucceeded)
    {
        $script:RelativityHttpSecure = $true
    }
    elseif ((Test-NetConnection $RelativityBaseUri -Port 80).TcpTestSucceeded)
    {
        $script:RelativityHttpSecure = $false
    }
    else
    {
        throw "Relativity base uri ($($RelativityBaseUri) could not be reached."
    }

    $script:RelativityBaseUri = $RelativityBaseUri
}

function Get-RelativityBaseUri
{
    return $script:RelativityBaseUri
}

function Get-RelativityHttpSecure
{
    return $script:RelativityHttpSecure
}

function Set-RelativityCredential
{
    [CmdletBinding(SupportsShouldProcess)]
    Param
    (
        [Parameter(Mandatory = $false, Position = 0)]
        [PSCredential] $RelativityCredential
    )

    if ($RelativityCredential -eq $null)
    {
        $RelativityCredential = Get-Credential -Message "Enter your Relativity credentials."
    }

    $script:RelativityCredential = $RelativityCredential
}