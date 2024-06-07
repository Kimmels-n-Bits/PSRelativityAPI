function New-RelativityUser
{
    <# TODO
        .SYNOPSIS
            Function creates a NEW Relativity cache-location.
        .DESCRIPTION
            This function constructs the required request, 
            calls Relativity's REST API, 
            creates a cache-location, 
            and returns a [RelativityInfrastructureV1CacheLocationServersNewResponse].

        .PARAMETER AllowSettingsChange
            notes
        .PARAMETER ClientID
            notes
        .PARAMETER ClientSecured
            notes
        .PARAMETER DV_DefaultFilterVisibility
            notes
        .PARAMETER DV_AllowDocumentSkipPreferenceChange
            notes
        .PARAMETER DV_AllowDocumentViewerChange
            notes
        .PARAMETER DV_AllowKeyboardShortcuts
            notes
        .PARAMETER DV_DefaultSelectedFileType
            notes
        .PARAMETER DV_DocumentViewer
            notes
        .PARAMETER DV_SkipDefaultPreference
            notes
        .PARAMETER DisableOnDate
            notes
        .PARAMETER Email
            notes
        .PARAMETER EmailPreference
            notes
        .PARAMETER FName
            notes
        .PARAMETER ItemListPageLength
            notes
        .PARAMETER Keywords
            notes
        .PARAMETER LName
            notes
        .PARAMETER Notes
            notes
        .PARAMETER RelativityAccess
            notes
        .PARAMETER SavedSearchDefaultsToPublic
            notes
        .PARAMETER TrustedIPs
            notes
        .PARAMETER TypeID
            notes

        .EXAMPLE
            New-RelativityUser -verbose -Name "myCacheLoc" -UncPath "\\HOST-FS001\DevRepo\013\" -IsVisible
                This example will CREATE a new cache-location named "myCacheLoc".

        .NOTES
            HTTP Response will be a [RelativityInfrastructureV1CacheLocationServersNewResponse] object.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    Param
    (
        [Switch] $AllowSettingsChange,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1, [Int32]::MaxValue)]
        [Int32] $ClientID,
        [Switch] $ClientSecured,
        [Switch] $DV_DefaultFilterVisibility,
        [Switch] $DV_AllowDocumentSkipPreferenceChange,
        [Switch] $DV_AllowDocumentViewerChange,
        [Switch] $DV_AllowKeyboardShortcuts,
        [String] $DV_DefaultSelectedFileType = "Default",
        [String] $DV_DocumentViewer,
        [Switch] $DV_SkipDefaultPreference,
        [Nullable[DateTime]] $DisableOnDate = $null,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [String] $Email,
        [String] $EmailPreference,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [String] $FName,
        [Nullable[Int32]] $ItemListPageLength,
        [String] $Keywords,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNull()]
        [String] $LName,
        [String] $Notes,
        [Switch] $RelativityAccessEnabled,
        [Switch] $SavedSearchDefaultsToPublic,
        [Collections.Generic.List[String]] $TrustedIPs,
        [ValidateScript({
                if ($null -ne $_) { $_ -ge 1 -and $_ -le [Int32]::MaxValue }
                else { $true }
            })]
        [Nullable[Int32]] $TypeID
    )

    Begin
    {
        Write-Verbose "Starting $($MyInvocation.MyCommand.Name)"
    }
    Process
    {
        try
        {
            $Request = [RelativityIdentityV1UserModelsUserRequest]::New(
                $AllowSettingsChange.IsPresent,
                $null,
                $DV_DefaultFilterVisibility.IsPresent,
                $DisableOnDate,
                $null,
                $Email,
                $EmailPreference,
                $FName,
                $ItemListPageLength,
                $Keywords,
                $LName,
                $Notes,
                $RelativityAccessEnabled.IsPresent,
                $SavedSearchDefaultsToPublic.IsPresent,
                $TrustedIPs,
                $TypeID)

            #region Client
            if ($ClientID -ne $null)
            {
                $Request.Client = [RelativityIdentityV1SharedSecurable]::New(
                    $ClientSecured.IsPresent,
                    [RelativityIdentityV1SharedObjectIdentifier]::New(
                        $ClientID
                    )
                )
            }
            else
            {
                $Request.Client = [RelativityIdentityV1SharedSecurable]::New($ClientSecured.IsPresent, $null)
            }
            #endregion Client

            #region DocumentViewerProperties
            $Request.DocumentViewerProperties = [RelativityIdentityV1UserModelsDocumentViewerProperties]::New(
                $DV_AllowDocumentSkipPreferenceChange.IsPresent,
                $DV_AllowDocumentViewerChange.IsPresent,
                $DV_AllowKeyboardShortcuts.IsPresent,
                $DV_DefaultSelectedFileType,
                $DV_DocumentViewer,
                $DV_SkipDefaultPreference.IsPresent
            )
            #endregion DocumentViewerProperties


            $RequestBody = $Request.ToHashTable()

            $Resources = @("users")

            $ApiEndpoint = Get-RelativityApiEndpoint `
                -BusinessDomain "Relativity-Identity" `
                -Version "v1" `
                -Resources $Resources

            Write-Debug "Preparing to invoke POST method at Relativity API endpoint '$($ApiEndpoint)' with RequestBody $($RequestBody.UserRequest)"
            Write-Debug "Preparing to invoke POST method at Relativity API endpoint '$($ApiEndpoint)' with RequestBody $($RequestBody | ConvertTo-Json -Depth 10)"
            Write-Verbose "Invoking POST method at Relativity API endpoint: $($ApiEndpoint)"

            $ApiResponse = Invoke-RelativityApiRequest -ApiEndpoint $ApiEndpoint -HttpMethod "Post" -RequestBody $RequestBody
            Write-Debug $ApiResponse

            $Response = [RelativityIdentityV1UserModelsUserResponse]::New($ApiResponse)
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