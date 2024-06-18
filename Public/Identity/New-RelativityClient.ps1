function New-RelativityClient
{
    <#
        .SYNOPSIS
            Function creates a NEW Relativity client.
        .DESCRIPTION
            This function constructs the required request, 
            calls Relativity's REST API, 
            creates a client, 
            and returns a [RelativityIdentityV1ClientModelsClientResponse].

        .PARAMETER Keywords
            optional words or phrase used to describe the client.
        .PARAMETER Name
            user-friendly name of the client.
        .PARAMETER Notes
            additional information about the client.
        .PARAMETER Number
            a [String] representing the number assigned to the client.
        .PARAMETER StatusID
            an [Int32] ArtifactID for the "Client Status" Field choices.
            Defaults to 662 "Active"
        .PARAMETER StatusGUIDs
            an array of GUIDs used to identify the object.


        .EXAMPLE
            New-RelativityClient -Name "myClient" -Number "Z999"
                This example will CREATE a new client named "myClient", and set default "Active".

        .NOTES
            HTTP Response will be a [RelativityIdentityV1ClientModelsClientResponse] object.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    Param
    (
        [String] $Keywords,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [String] $Name,
        [string] $Notes,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [String] $Number,
        [ValidateRange(1, [Int32]::MaxValue)]
        [Int32] $StatusID = 662,
        [String[]] $StatusGUIDs
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
                ClientRequest = @{
                    Name = $Name
                    Number = $Number
                    Status = @{
                        ArtifactID = $StatusID
                        Guids = $StatusGUIDs
                    }
                    Keywords = $Keywords
                    Notes = $Notes
                }
            }

            $Resources = @("workspaces", "-1", "clients")

            $ApiEndpoint = Get-RelativityApiEndpoint `
                -BusinessDomain "relativity-identity" `
                -Version "v1" `
                -Resources $Resources

            Write-Debug "Preparing to invoke POST method at Relativity API endpoint '$($ApiEndpoint)' with RequestBody $($RequestBody | ConvertTo-Json -Depth 10)"
            Write-Verbose "Invoking POST method at Relativity API endpoint: $($ApiEndpoint)"

            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Post" -RequestBody $RequestBody
            Write-Debug $ApiResponse

            $Response = [RelativityIdentityV1ClientModelsClientResponse]::New($ApiResponse)

            return $Response
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