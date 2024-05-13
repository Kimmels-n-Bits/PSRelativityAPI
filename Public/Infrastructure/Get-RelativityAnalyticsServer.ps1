function Get-RelativityAnalyticsServer
{
    <#
        .SYNOPSIS
            Returns a Relativity AnalyticsServerResponse Object
        .DESCRIPTION
            Get-RelativityAnalyticsServer returns the properties of a Relativity [AnalyticsServerResponse] object using Relativity's REST API.
        .PARAMETER ArtifactID
            The ArtifactID of the Relativity Analytics Server object.
        .PARAMETER IncludeMetadata
            Determines whether to include extended metadata for the returned AnalyticsServer object.
        .PARAMETER IncludeActions
            Determines whether to include actions associated with the returned AnalyticsServer object.
        .EXAMPLE
            Get-RelativityAnalyticsServer -ArtifactID 1234567 -IncludeMetadata -IncludeActions
            This returns a Relativity AnalyticsServerResponse with the ArtifactID value 1234567 and includes extended metadata and
            actions.
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [ValidateScript({ $_ -is [Int32] })]
        [Int32] $ArtifactID,
        [Parameter(Mandatory = $false)]
        [Switch] $IncludeMetadata,
        [Parameter(Mandatory = $false)]
        [Switch] $IncludeActions
    )

    Begin
    {
        Write-Verbose "Starting $($MyInvocation.MyCommand.Name)"
    }
    Process
    {
        try
        {
            [String[]] $Resources = @("workspaces", "-1", "analytics-servers", $ArtifactID.ToString())

            [String] $QueryString = ""
            if ($IncludeMetadata -or $IncludeActions)
            {
                $QueryString += "?"
                if ($IncludeMetadata) { $QueryString += "includeMetadata=true" }
                if ($IncludeMetadata -and $IncludeActions) { $QueryString += "&" }
                if ($IncludeActions) { $QueryString += "includeActions=true" }
            }

            $ApiEndpoint = Get-RelativityApiEndpoint `
                -BusinessDomain "relativity-infrastructure" `
                -Version "v1" `
                -Resources $Resources `
                -QueryString $QueryString

            Write-Debug "Preparing to invoke GET method at Relativity API endpoint '$($ApiEndpoint)'"
            Write-Verbose "Invoking GET method at Relativity API endpoint: $($ApiEndpoint)"
            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Get"

            $Response = [RelativityInfrastructureV1AnalyticsServerModelsResponse]::New($ApiResponse)

            Write-Verbose "Client details retrieved successfully."
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