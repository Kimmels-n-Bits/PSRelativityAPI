function Get-RelativityField
{
    <#
        .SYNOPSIS
            Returns a Relativity RelativityObjectModelV1FieldModelsResponse Object
        .DESCRIPTION
            Get-RelativityField returns the properties of a Relativity [RelativityObjectModelV1FieldModelsResponse] object using Relativity's REST API.
        .PARAMETER WorkspaceID
            {WorkspaceID} variable to the Artifact ID of a workspace, or use -1 to indicate the admin-level context.
        .PARAMETER FieldArtifactID
            {fieldArtifactID} variable to the Artifact ID of the field that you want to delete.
        .PARAMETER IncludeMetadata
            Determines whether to include extended metadata for the returned FieldResponse object.
        .PARAMETER IncludeActions
            Determines whether to include actions associated with the returned FieldResponse object.
        .EXAMPLE
            Get-RelativityField -WorkspaceID 1234567 -FieldArtifactID 100000 -IncludeMetadata -IncludeActions
            This returns a Relativity RelativityObjectModelV1FieldModelsResponse with the -WorkspaceID value 1234567 and includes extended metadata and
            actions.
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [ValidateScript({ $_ -is [Int32] })]
        [Int32] $WorkspaceID,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [ValidateRange(1, [Int32]::MaxValue)]
        [Int32] $FieldArtifactID,
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
            [String[]] $Resources = @("workspaces", $WorkspaceID.ToString(), "fields", $FieldArtifactID.ToString())

            [String] $QueryString = ""
            if ($IncludeMetadata -or $IncludeActions)
            {
                $QueryString += "?"
                if ($IncludeMetadata) { $QueryString += "includeMetadata=true" }
                if ($IncludeMetadata -and $IncludeActions) { $QueryString += "&" }
                if ($IncludeActions) { $QueryString += "includeActions=true" }
            }

            $ApiEndpoint = Get-RelativityApiEndpoint `
                -BusinessDomain "relativity-object-model" `
                -Version "v1" `
                -Resources $Resources `
                -QueryString $QueryString

            Write-Debug "Preparing to invoke GET method at Relativity API endpoint '$($ApiEndpoint)'"
            Write-Verbose "Invoking GET method at Relativity API endpoint: $($ApiEndpoint)"
            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Get"
            Write-Debug "ApiResponse`n$($ApiResponse)"

            $Response = [RelativityObjectModelV1FieldModelsResponse]::New($ApiResponse)

            Write-Verbose "REST call details retrieved successfully."
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