function Get-RelativityParentObjectType
{
    <#
        .SYNOPSIS
            Returns a Relativity RelativityObjectModelV1ObjectTypeModelsResponse Object
        .DESCRIPTION
            Get-RelativityParentObjectType returns the properties of a Relativity [RelativityObjectModelV1ObjectTypeModelsResponse] object using Relativity's REST API.
        .PARAMETER WorkspaceID
            {WorkspaceID} variable to the Artifact ID of a workspace, or use -1 to indicate the admin-level context.
        .PARAMETER ObjectTypeID
            {objectTypeArtifactID} to the Artifact ID of the object type.
        .PARAMETER IncludeMetadata
            Determines whether to include extended metadata for the returned ParentObjectType object.
        .PARAMETER IncludeActions
            Determines whether to include actions associated with the returned ParentObjectType object.
        .EXAMPLE
            Get-RelativityParentObjectType -WorkspaceID 1234567 -ObjectTypeID 100 -IncludeMetadata -IncludeActions
            This returns a Relativity RelativityObjectModelV1ObjectTypeModelsResponse with the -WorkspaceID value 1234567 and includes extended metadata and
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
        [Int32] $ObjectTypeID,
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
            [String[]] $Resources = @("workspaces", $WorkspaceID.ToString(), "object-types", $ObjectTypeID.ToString())

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

            $Response = [RelativityObjectModelV1ObjectTypeModelsResponse]::New($ApiResponse)

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