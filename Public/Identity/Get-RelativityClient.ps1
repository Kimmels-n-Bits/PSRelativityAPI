function Get-RelativityClient
{
    <#
        .SYNOPSIS
            Returns a Relativity Client object.
        .DESCRIPTION
            Get-RelativityClient returns the properties of a Relativity Client object using Relativity's REST API.
        .PARAMETER ArtifactID
            The ArtifactID of the Relativity Client object.
        .PARAMETER IncludeMetadata
            Determines whether to include extended metadata for the returned Client object.
        .PARAMETER IncludeActions
            Determines whether to include actions associated with the returned Client object.
        .EXAMPLE
            Get-RelativityClient -ArtifactID 1234567 -IncludeMetadata -IncludeActions
            This returns the Relativity Client with the ArtifactID value 1234567 and includes extended metadata and
            actions.

    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [ValidateRange(1000000, [Int32]::MaxValue)]
        [Int32] $ArtifactID,
        [Parameter(Mandatory = $false)]
        [Switch] $IncludeMetadata,
        [Parameter(Mandatory = $false)]
        [Switch] $IncludeActions
    )

    Begin
    {
        Write-Verbose "Starting Get-RelativityClient"
    }
    Process
    {
        try
        {
            [String[]] $Resources = @("workspaces", "-1", "clients", $ArtifactID.ToString())

            [String] $QueryString = ""
            if ($IncludeMetadata -or $IncludeActions)
            {
                $QueryString += "?"
                if ($IncludeMetadata) { $QueryString += "includeMetadata=true" }
                if ($IncludeMetadata -and $IncludeActions) { $QueryString += "&" }
                if ($IncludeActions) { $QueryString += "includeActions=true" }
            }

            $ApiEndpoint = Get-RelativityApiEndpoint `
                -BusinessDomain "relativity-identity" `
                -Version "v1" `
                -Resources $Resources `
                -QueryString $QueryString

            Write-Debug "Preparing to invoke GET method at Relativity API endpoint '$($ApiEndpoint)'"
            Write-Verbose "Invoking GET method at Relativity API endpoint: $($ApiEndpoint)"
            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Get"

            $Response = [RelativityClientReadResponse]::New($ApiResponse)

            Write-Verbose "Client details retrieved successfully."
            return $Response
        }
        catch
        {
            Write-Error "An error occurred: $($_.Exception) type: $($_.GetType().FullName)"
            Write-Verbose "API Endpoint: $($ApiEndpoint)"
            Write-Verbose "ArtifactID: $($ArtifactID)"
            Write-Verbose "IncludeMetadata: $($IncludeMetadata)"
            Write-Verbose "IncludeActions: $($IncludeActions)"
            throw
        }
    }
    End
    {
        Write-Verbose "Completed Get-RelativityClient"
    }
}