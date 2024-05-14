class RelativityIdentityV1UserModelsUserResponse : RelativityIdentityV1SharedObjectIdentifier
{
    <#
        .SYNOPSIS
            Represents the results of a read operation on a user.
        .PARAMETER Actions { get; set; }
            Gets a list of RESTful operations that a user has permissions to perform on the artifact.
        .PARAMETER AllowSettingsChange { get; set; }
            Gets or sets a Boolean value indicating whether the user will be able to change a limited number of their settings.
        .PARAMETER Client { get; set; }
            Gets or sets the Securable<T> identifier for the client associated with the user.
        .PARAMETER CreatedBy { get; set; }
            Gets the Artifact ID and name of the user who created the artifact.
        .PARAMETER CreatedOn { get; set; }
            Gets the date and time when the artifact was added to Relativity.
        .PARAMETER DefaultFilterVisibility { get; set; }
            Gets or sets a Boolean value indicating whether filters on all columns are visible by default.
        .PARAMETER DisableOnDate { get; set; }
            Gets or sets the date when the user's Relativity access will be auto-disabled.
        .PARAMETER DocumentViewerProperties { get; set; }
            Gets or sets user properties that are related to the document viewer.
        .PARAMETER EmailAddress { get; set; }
            Gets or sets the user's email address in the format name@domain.extension.
        .PARAMETER EmailPreference { get; set; }
            Gets or sets the user's preference for email notifications when adding or deleting Users or Groups.
        .PARAMETER FirstName { get; set; }
            Gets or sets the user's first name.
        .PARAMETER ItemListPageLength { get; set; }
            Gets or sets the default list length for all view in Relativity for the user.
        .PARAMETER Keywords { get; set; }
            Gets or sets any keywords associated with the artifact.
        .PARAMETER LastLoginDate { get; set; }
            Gets or sets the date when the user last logged in.
        .PARAMETER LastModifiedBy { get; set; }
            Gets the Artifact ID and name of the user who recently updated the artifact.
        .PARAMETER LastModifiedOn { get; set; }
            Gets the date and time when the artifact was most recently updated.
        .PARAMETER LastName { get; set; }
            Gets or sets the user's last name.
        .PARAMETER Meta { get; set; }
            Gets a list of unsupported and read-only properties on the current artifact.
        .PARAMETER Notes { get; set; }
            Gets or sets an optional description or other information about the artifact.
        .PARAMETER RelativityAccess { get; set; }
            Gets or sets whether the user can to log in to Relativity and be considered for billing under your Relativity license.
        .PARAMETER SavedSearchDefaultsToPublic { get; set; }
            Gets or sets a Boolean value indicating whether saved searches are public or private by default.
        .PARAMETER TrustedIPs { get; set; }
            Gets or sets an IP address or addresses that are valid locations from which the user can log in from.
        .PARAMETER Type { get; set; }
            Gets or sets the user's type. Type is for reference purposes only and has no impact on access or billing.
    #>
    [Collections.Generic.List[RelativityIdentityV1SharedAction]] $Actions
    [Boolean] $AllowSettingsChange
    [RelativitySharedV1ModelsSecurable] $Client
    [RelativityIdentityV1SharedDisplayableObjectIdentifier] $CreatedBy
    [DateTime] $CreatedOn
    [Boolean] $DefaultFilterVisibility
    [Nullable[DateTime]] $DisableOnDate
    [RelativityIdentityV1UserModelsDocumentViewerProperties] $DocumentViewerProperties
    [String] $EmailAddress
    [RelativityIdentityV1UserModelsEmailPreference] $EmailPreference
    [String] $FirstName
    [Int32] $ItemListPageLength
    [String] $Keywords
    [Nullable[datetime]] $LastLoginDate
    [RelativityIdentityV1SharedDisplayableObjectIdentifier] $LastModifiedBy
    [DateTime] $LastModifiedOn
    [String] $LastName
    [RelativityIdentityV1SharedMeta] $Meta
    [String] $Notes
    [Boolean] $RelativityAccess
    [Boolean] $SavedSearchDefaultsToPublic
    [Collections.Generic.List[String]] $TrustedIPs
    [RelativityIdentityV1SharedDisplayableObjectIdentifier] $Type

    RelativityIdentityV1UserModelsUserResponse (
        [PSCustomObject] $ApiResponse
    ):base ($ApiResponse)
    {
        $this.Actions = $ApiResponse.Actions

        $this.AllowSettingsChange = $ApiResponse.AllowSettingsChange

        #region Client
        if ($ApiResponse.Client.Value -ne $null)
        {
            $this.Client = [RelativitySharedV1ModelsSecurable]::New(
                $ApiResponse.Client.Secured,
                [RelativitySharedV1ModelsDisplayableObjectIdentifier]::New(
                    $ApiResponse.Client.Value
                )
            )
        }
        else
        {
            $this.Client = [RelativitySharedV1ModelsSecurable]::New($ApiResponse.Client.Secured, $null)
        }
        #endregion Client

        $this.CreatedBy = $ApiResponse.CreatedBy

        $this.CreatedOn = $ApiResponse.CreatedOn

        $this.DefaultFilterVisibility = $ApiResponse.DefaultFilterVisibility

        if ($ApiResponse.DisableOnDate -ne $null)
        {
            $this.DisableOnDate = $ApiResponse.DisableOnDate
        }

        $this.DocumentViewerProperties = $ApiResponse.DocumentViewerProperties

        $this.EmailAddress = $ApiResponse.EmailAddress

        $this.EmailPreference = $ApiResponse.EmailPreference

        $this.FirstName = $ApiResponse.FirstName

        $this.ItemListPageLength = $ApiResponse.ItemListPageLength

        $this.Keywords = $ApiResponse.Keywords

        $this.LastLoginDate = $ApiResponse.LastLoginDate

        $this.LastModifiedBy = $ApiResponse.LastModifiedBy

        $this.LastModifiedOn = $ApiResponse.LastModifiedOn

        $this.LastName = $ApiResponse.LastName

        $this.Meta = $ApiResponse.Meta

        $this.Notes = $ApiResponse.Notes

        $this.RelativityAccess = $ApiResponse.RelativityAccess

        $this.SavedSearchDefaultsToPublic = $ApiResponse.SavedSearchDefaultsToPublic

        $this.TrustedIPs = $ApiResponse.TrustedIPs -split "`r`n"

        $this.Type = $ApiResponse.Type
    }
}