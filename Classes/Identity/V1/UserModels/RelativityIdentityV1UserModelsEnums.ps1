enum RelativityIdentityV1UserModelsDocumentViewerFileType 
{
    Default = 0
    Image = 2
    LongText = 3
    Native = 4
    Production = 5
    Viewer = 1
}

enum RelativityIdentityV1UserModelsDocumentViewer
{
    ActiveX = 2
    Default = 0
    HTML = 1
    RelativityReview = 3
}

enum RelativityIdentityV1UserModelsEmailPreference
{
    <#
        .SYNOPSIS
            Enum of all the possible email preferences for the user's email preference.
        .PARAMETER All
            Receive all emails
        .PARAMETER Default
            Use default value for EmailPreference property
        .PARAMETER ErrorOnly
            Receive emails on errors only
        .PARAMETER None
            Receive no emails
    #>
    All = 1
    Default = 0
    ErrorOnly = 2
    None = 3
}