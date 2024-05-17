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
    [CmdletBinding()]
    Param()

    Begin
    {
        Write-Verbose "Starting Get-RelativityApiRequestHeader"
    }
    Process
    {
        try
        {
            $UserName = $script:RelativityCredential.UserName
            $Password = $script:RelativityCredential.GetNetworkCredential().Password

            $RelativityApiAuthorization = [Convert]::ToBase64String(
                [Text.Encoding]::ASCII.GetBytes("$($UserName):$($Password)")
            )

            $RelativityApiRequestHeader = New-Object "System.Collections.Generic.Dictionary[[String], [String]]"
            $RelativityApiRequestHeader.Add("X-CSRF-Header", "-")
            $RelativityApiRequestHeader.Add("Content-Type", "application/json")
            $RelativityApiRequestHeader.Add("Authorization", "Basic $($RelativityApiAuthorization)")
        }
        catch
        {
            Write-Error "An error occurred: $($_.Exception) type: $($_.GetType().FullName)"
            Write-Verbose "Relativity UserName: $($UserName)"
            $RelativityApiRequestHeader | ForEach-Object { Write-Verbose "Key:$($_.Key) Value:$($_.Value)." }
        }

        return $RelativityApiRequestHeader
    }
    End
    {
        Write-Verbose "Completed Get-RelativityApiRequestHeader"
    }
}