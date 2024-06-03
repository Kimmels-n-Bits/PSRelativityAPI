function New-RelativityMatter
{
    <#
        .SYNOPSIS
            Function creates a NEW Relativity matter.
        .DESCRIPTION
            This function constructs the required request, 
            calls Relativity's REST API, 
            creates a matter, 
            and returns an [Int32] Artifact ID.

        .PARAMETER ClientID
            the client ArtifactrID to be associated with this matter.
        .PARAMETER ClientIDSecured
            [switch] indicates whether the current user has permission to view the setting in the Value field.
        .PARAMETER Keywords
            optional words or phrase used to describe the matter.
        .PARAMETER Name
            user-friendly name of the matter.
        .PARAMETER Notes
            additional information about the matter.
        .PARAMETER Number
            a [String] indicating the numbered ordering used to display this matter in a list of matters.
        .PARAMETER StatusID
            the status ArtifactID for the matter
            Defaults to 671 "Active"
        .PARAMETER StatusIDSecured
            [switch] indicates whether the current user has permission to view the setting in the Value field.
        


        .EXAMPLE
            New-RelativityMatter -verbose -Name "MyMatter" -Number "matter_Z68" -StatusID 671 -ClientID 1234567
                This example will CREATE a new client named "myClient", and set default "Active".

        .NOTES
            HTTP Response will be a [Int32] ArtifactID for the newly created matter.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [ValidateRange(1, [Int32]::MaxValue)]
        [String] $ClientID,
        [Switch] $ClientIDSecured,
        [String] $Keywords,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [String] $Name,
        [string] $Notes,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [String] $Number,
        [ValidateRange(1, [Int32]::MaxValue)]
        [Int32] $StatusID = 671,
        [Switch] $StatusIDSecured
    )

    Begin
    {
        Write-Verbose "Starting $($MyInvocation.MyCommand.Name)"
    }
    Process
    {
        try
        {
            [Hashtable]$RequestBody = @{
                MatterRequest = @{
                    Client = @{
                        Secured = $ClientIDSecured.IsPresent
                        Value = @{
                            ArtifactID = $ClientID
                        }
                    }
                    Status = @{
                        Secured = $StatusIDSecured.IsPresent
                        Value = @{
                            ArtifactID = $StatusID
                        }
                    }
                    Name = $Name
                    Number = $Number
                    Keywords = $Keywords
                    Notes = $Notes
                }
            }

            $Resources = @("workspaces", "-1", "matters")

            $ApiEndpoint = Get-RelativityApiEndpoint `
                -BusinessDomain "relativity-environment" `
                -Version "v1" `
                -Resources $Resources

            Write-Debug "Preparing to invoke POST method at Relativity API endpoint '$($ApiEndpoint)' with RequestBody $($RequestBody | ConvertTo-Json -Depth 10)"
            Write-Verbose "Invoking POST method at Relativity API endpoint: $($ApiEndpoint)"

            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Post" -RequestBody $RequestBody
            Write-Debug "ApiResponse:`n$ApiResponse"

            return $ApiResponse
        }
        catch
        {
            Write-Error "An error occurred: $($_.Exception) type: $($_.GetType().FullName)"
            Write-Verbose "Logging parameter values:"

            (Get-Command -Name $PSCmdlet.MyInvocation.InvocationName).Parameters | ForEach-Object {
                $_.Values | ForEach-Object {
                    $Parameter = Get-Variable -Name $_.Name -ErrorAction SilentlyContinue

                    if ($null -ne $Parameter)
                    {
                        Write-Verbose "$($Parameter.Name): $($Parameter.Value)"
                    }
                }
            }

            Write-Verbose "API Endpoint: $($ApiEndpoint)"
            throw
        }
    }
    End
    {
        Write-Verbose "Completed $($MyInvocation.MyCommand.Name)"
    }
}