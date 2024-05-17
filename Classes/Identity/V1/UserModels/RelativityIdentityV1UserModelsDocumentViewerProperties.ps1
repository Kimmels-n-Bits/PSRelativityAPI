class RelativityIdentityV1UserModelsDocumentViewerProperties
{
    <#
        .SYNOPSIS
            Represents properties that are related to the document viewer.
        .PARAMETER AllowDocumentSkipPreferenceChange
            Gets or sets whether the user has the ability to change their preference to skip documents during review that no longer meet the original conditions of a view due to propagation.
        .PARAMETER AllowDocumentViewerChange
            Gets or sets a Boolean value indicating whether the user will be able to change the document viewer modes.
        .PARAMETER AllowKeyboardShortcuts
            Gets or sets a Boolean value indicating whether the user can see the keyboard shortcuts icon in the core reviewer interface.
        .PARAMETER DefaultSelectedFileType
            Gets or sets the default viewer mode.
        .PARAMETER DocumentViewer
            Gets or sets the which viewer the user can access when reviewing documents.
        .PARAMETER SkipDefaultPreference
            Gets or sets a Boolean value indicating whether the user advances to the next document in the queue that matches the defined view conditions when the user clicks Save and Next.
    #>
    [Boolean] $AllowDocumentSkipPreferenceChange
    [Boolean] $AllowDocumentViewerChange
    [Boolean] $AllowKeyboardShortcuts
    [RelativityIdentityV1UserModelsDocumentViewerFileType] $DefaultSelectedFileType
    [RelativityIdentityV1UserModelsDocumentViewer] $DocumentViewer
    [Boolean] $SkipDefaultPreference

    RelativityIdentityV1UserModelsDocumentViewerProperties()
    {
    }

    RelativityIdentityV1UserModelsDocumentViewerProperties(
        [Boolean] $AllowDocumentSkipPreferenceChange,
        [Boolean] $AllowDocumentViewerChange,
        [Boolean] $AllowKeyboardShortcuts,
        [RelativityIdentityV1UserModelsDocumentViewerFileType] $DefaultSelectedFileType,
        [RelativityIdentityV1UserModelsDocumentViewer] $DocumentViewer,
        [Boolean] $SkipDefaultPreference
    )
    {
        $this.AllowDocumentSkipPreferenceChange = $AllowDocumentSkipPreferenceChange
        $this.AllowDocumentViewerChange = $AllowDocumentViewerChange
        $this.AllowKeyboardShortcuts = $AllowKeyboardShortcuts
        $this.DefaultSelectedFileType = $DefaultSelectedFileType
        $this.DocumentViewer = $DocumentViewer
        $this.SkipDefaultPreference = $SkipDefaultPreference
    }

    RelativityIdentityV1UserModelsDocumentViewerProperties(
        [PSCustomObject] $ApiResponse
    )
    {
        if ([Enum]::IsDefined([RelativityIdentityV1UserModelsDocumentViewerFileType], $ApiResponse.DefaultSelectedFileType))
        {
            $this.DefaultSelectedFileType = [Enum]::Parse([RelativityIdentityV1UserModelsDocumentViewerFileType], $ApiResponse.DefaultSelectedFileType)
        }
        else
        {
            throw "Invalid enum [RelativityIdentityV1UserModelsDocumentViewerFileType] = $($ApiResponse.DefaultSelectedFileType)"
        }

        if ([Enum]::IsDefined([RelativityIdentityV1UserModelsDocumentViewer], $ApiResponse.DocumentViewer))
        {
            $this.DocumentViewer = [Enum]::Parse([RelativityIdentityV1UserModelsDocumentViewer], $ApiResponse.DocumentViewer)
        }
        else
        {
            throw "Invalid enum [RelativityIdentityV1UserModelsDocumentViewer] = $($ApiResponse.DocumentViewer)"
        }

        $this.AllowDocumentSkipPreferenceChange = $ApiResponse.AllowDocumentSkipPreferenceChange
        $this.AllowDocumentViewerChange = $ApiResponse.AllowDocumentViewerChange
        $this.AllowKeyboardShortcuts = $ApiResponse.AllowKeyboardShortcuts
        $this.SkipDefaultPreference = $ApiResponse.SkipDefaultPreference
    }
}