class RelativityIdentityV1UserModelsUserRequest
{
    <# TODO
    .SYNOPSIS
        Request body for Get-RelativityResourcePoolResource

    .DESCRIPTION
        This function constructs the required request and returns a valid body.

    .PARAMETER Length
        Array length for number of rows returned by query.
    .PARAMETER ResourceType
        Identifies 1 of 8 ResourceTypes that can be queried.
            "agent-worker-servers"
            "analytics-servers"
            "cache-location-servers"
            "dt-search-index-locations"
            "file-repositories"
            "processing-source-locations"
            "sql-servers"
            "worker-manager-servers"
    .PARAMETER Start
        Array Index for query return.
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
        [String] $TrustedIPs,
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
        
        if ($TrustedIPs -ne $null)
        {
            $this.TrustedIPs = [String]::Join("`r`n", $TrustedIPs)
        }
        else
        {
            $this.TrustedIPs = ""
        }
        Write-Debug $this.TrustedIPs

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
