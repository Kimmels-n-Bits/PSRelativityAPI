function New-RelativityChoice
{
    <#
        .SYNOPSIS
            Function creates a NEW Relativity choice.


        .PARAMETER Color
            the highlight color for the choice.

        .PARAMETER FieldID
            an integer representing a unique identifier for a field.

        .PARAMETER FieldGUIDs
            an array of GUIDs used to identify a field.

        .PARAMETER Keywords
            noDescription

        .PARAMETER Name
            a string representing the user-friendly name of the choice.

        .PARAMETER Notes
            noDescription

        .PARAMETER Order
            an integer used to determine order in which multiple choices are listed in UI. Lower values are listed first.

        .PARAMETER ParentID
            noDescription

        .PARAMETER RelativityApplications
            noDescription

        .PARAMETER Shortcut
            NOT IMPLEMENTED

        .PARAMETER WorkspaceID
            Workspace to create choice.  Default is -1


        .EXAMPLE
            New-RelativityChoice -Color 3 -FieldID 1234567 -Name "myChoice" -Order 2
                This example will CREATE a new choice named "myChoice", and associate it with fieldID 1234567.

        .NOTES
            HTTP Response will be a [Int32] ArtifactID for the new Choice.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    Param
    (
        [Int32] $Color = 3,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1, [Int32]::MaxValue)]
        [Nullable[Int32]] $FieldID,
        [Collections.Generic.List[GUID]] $FieldGUIDs,
        [String] $Keywords,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [String] $Name,
        [String] $Notes,
        [Int32] $Order = 0,
        [Nullable[Int32]] $ParentID,
        [Collections.Generic.List[Int32]] $RelativityApplications,
        [PSCustomObject] $Shortcut = $null,
        [Int32] $WorkspaceID = -1
    )

    Begin
    {
        Write-Verbose "Starting $($MyInvocation.MyCommand.Name)"
    }
    Process
    {
        try
        {
            $Request = [RelativityObjectModelV1ChoiceModelsRequest]::New(
                $Color,
                $FieldID,
                $FieldGUIDs,
                $Keywords,
                $Name,
                $Notes,
                $Order,
                $ParentID,
                $RelativityApplications,
                $Shortcut)


            $RequestBody = $Request.ToHashTable()

            $Resources = @("workspaces", $WorkspaceID.ToString(), "choices")

            $ApiEndpoint = Get-RelativityApiEndpoint `
                -BusinessDomain "relativity-object-model" `
                -Version "v1" `
                -Resources $Resources

            Write-Debug "Preparing to invoke POST method at Relativity API endpoint '$($ApiEndpoint)' with RequestBody $($RequestBody | ConvertTo-Json -Depth 10)"
            Write-Verbose "Invoking POST method at Relativity API endpoint: $($ApiEndpoint)"

            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Post" -RequestBody $RequestBody
            Write-Debug $ApiResponse

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