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