class RelativityIdentityV1UserModelsUserRequest
{
    <#
        .SYNOPSIS
           Represents a DTO used as a request for creating or updating a user.


        .PARAMETER AllowSettingsChange
            Gets or sets a Boolean value indicating whether the user will be able to change a limited number of their settings.
        .PARAMETER Client
            Gets or sets the [RelativityIdentityV1SharedSecurable[T]] identifier for the client associated with the user
        .PARAMETER DefaultFilterVisibility
            Gets or sets a Boolean value indicating whether filters on all columns are visible by default.
        .PARAMETER DisableOnDate
            Gets or sets the date when the user's Relativity access will be auto-disabled.
        .PARAMETER DocumentViewerProperties
            Gets or sets user properties that are related to the document viewer.
        .PARAMETER EmailAddress
            Gets or sets the user's email address in the format name@domain.extension.
        .PARAMETER EmailPreference
            Gets or sets the user's preference for email notifications when adding or deleting Users or Groups.
        .PARAMETER FirstName
            Gets or sets the user's first name.
        .PARAMETER ItemListPageLength
            Gets or sets the default list length for all view in Relativity for the user.
        .PARAMETER Keywords
            Gets or sets any keywords associated with the user.
        .PARAMETER LastName
            Gets or sets the user's last name.
        .PARAMETER Notes
            Gets or sets an optional description or other information about the user.
        .PARAMETER RelativityAccess
            Gets or sets whether the user can to log in to Relativity and be considered for billing under your Relativity license.
        .PARAMETER SavedSearchDefaultsToPublic
            Gets or sets a Boolean value indicating whether saved searches are public or private by default.
        .PARAMETER TrustedIPs
            Gets or sets an IP address or addresses that are valid locations from which the user can log in from.
        .PARAMETER Type
            Gets or sets the user's type. Type is for reference purposes only and has no impact on access or billing.
    #>
    [Boolean] $AllowSettingsChange
    [RelativityIdentityV1SharedSecurable] $Client
    [Boolean] $DefaultFilterVisibility
    [Nullable[DateTime]] $DisableOnDate
    [RelativityIdentityV1UserModelsDocumentViewerProperties] $DocumentViewerProperties
    [String] $EmailAddress
    [RelativityIdentityV1UserModelsEmailPreference] $EmailPreference
    [String] $FirstName
    [Int32] $ItemListPageLength
    [String] $Keywords
    [String] $LastName
    [String] $Notes
    [Boolean] $RelativityAccess
    [Boolean] $SavedSearchDefaultsToPublic
    [String] $TrustedIPs
    [RelativityIdentityV1SharedObjectIdentifier] $Type
    
    RelativityIdentityV1UserModelsUserRequest()
    {

    }

    RelativityIdentityV1UserModelsUserRequest(
        [Boolean] $AllowSettingsChange,
        [RelativityIdentityV1SharedSecurable] $Client,
        [Boolean] $DefaultFilterVisibility,
        [Nullable[DateTime]] $DisableOnDate,
        [RelativityIdentityV1UserModelsDocumentViewerProperties] $DocumentViewerProperties,
        [String] $EmailAddress,
        [String] $EmailPreference,
        [String] $FirstName,
        [Nullable[Int32]] $ItemListPageLength,
        [String] $Keywords,
        [String] $LastName,
        [String] $Notes,
        [Boolean] $RelativityAccess,
        [Boolean] $SavedSearchDefaultsToPublic,
        [Collections.Generic.List[String]] $TrustedIPs,
        [Nullable[Int32]] $Type)
    {
        $this.AllowSettingsChange = $AllowSettingsChange
        $this.Client = $Client
        $this.DefaultFilterVisibility = $DefaultFilterVisibility
        $this.DisableOnDate = $DisableOnDate

        $this.DocumentViewerProperties = $DocumentViewerProperties

        if ($EmailAddress -match '^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$')
        {
            $this.EmailAddress = $EmailAddress
        }
        else
        {
            throw "Invalid email address = $($EmailAddress)"
        }
        

        if ([Enum]::IsDefined([RelativityIdentityV1UserModelsEmailPreference], $EmailPreference))
        {
            $this.EmailPreference = [Enum]::Parse([RelativityIdentityV1UserModelsEmailPreference], $EmailPreference)
        }
        else
        {
            throw "Invalid enum [RelativityIdentityV1UserModelsEmailPreference] = $($EmailPreference)"
        }

        $this.FirstName = $FirstName

        if ($ItemListPageLength -ne $null)
        {
            $this.ItemListPageLength = $ItemListPageLength
        }
        else
        {
            $this.ItemListPageLength = 50
        }

        $this.Keywords = $Keywords
        $this.LastName = $LastName
        $this.Notes = $Notes
        $this.RelativityAccess = $RelativityAccess
        $this.SavedSearchDefaultsToPublic = $SavedSearchDefaultsToPublic

        if ($TrustedIPs.Count -gt 0)
        {
            $this.TrustedIPs = [String]::Join("`r`n", $TrustedIPs)
            Write-Debug $this.TrustedIPs.
        }
        else
        {
            $this.TrustedIPs = ""
        }

        if ($Type -ne $null)
        {
            $this.Type = [RelativityIdentityV1SharedObjectIdentifier]::New($Type)
        }
        else
        {
            $this.Type = [RelativityIdentityV1SharedObjectIdentifier]::New(663)
        }
        
    }


    [Hashtable] ToHashTable()
    {
        $_clientValue = @{
            ArtifactID = $this.Client.Value.ArtifactID
        }

        $_client = @{
            Secured = $this.Client.Secured
            Value = $_clientValue
        }

        $_documentViewerProperties = @{
            AllowDocumentSkipPreferenceChange = $this.DocumentViewerProperties.AllowDocumentSkipPreferenceChange
            AllowDocumentViewerChange = $this.DocumentViewerProperties.AllowDocumentViewerChange
            AllowKeyboardShortcuts = $this.DocumentViewerProperties.AllowKeyboardShortcuts
            DefaultSelectedFileType = [String]$this.DocumentViewerProperties.DefaultSelectedFileType
            DocumentViewer = [String]$this.DocumentViewerProperties.DocumentViewer
            SkipDefaultPreference = $this.DocumentViewerProperties.SkipDefaultPreference
        }

        $_type = @{
            ArtifactID = $this.Type.ArtifactID
        }

        $UserRequest = @{
            AllowSettingsChange = $this.AllowSettingsChange
            Client = $_client
            DefaultFilterVisibility = $this.DefaultFilterVisibility
            DocumentViewerProperties = $_documentViewerProperties
            DisableOnDate = $this.DisableOnDate
            EmailAddress = $this.EmailAddress
            EmailPreference = [String]$this.EmailPreference
            FirstName = $this.FirstName
            ItemListPageLength = $this.ItemListPageLength
            LastName = $this.LastName
            RelativityAccess = $this.RelativityAccess
            SavedSearchDefaultsToPublic = $this.SavedSearchDefaultsToPublic
            TrustedIPs = $this.TrustedIPs
            Type = $_type
            Keywords = $this.Keywords
            Notes = $this.Notes
        }

        $hashtable = @{}
        $hashtable["UserRequest"] = $UserRequest
        return $hashtable
    }
}
