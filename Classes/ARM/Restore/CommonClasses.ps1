class RelativityArmRestoreJobMigratorsDestinationOptions
{
    [Int32] $StructuredAnalyticsServerID
    [Int32] $ConceptualAnalyticsServerID
    [Int32] $DtSearchLocationID

    RelativityArmRestoreJobMigratorsDestinationOptions(
        [Int32] $structuredAnalyticsServerID,
        [Int32] $conceptualAnalyticsServerID,
        [Int32] $dtSearchLocationID
    )
    {
        $this.StructuredAnalyticsServerID = $structuredAnalyticsServerID
        $this.ConceptualAnalyticsServerID = $conceptualAnalyticsServerID
        $this.DtSearchLocationID = $dtSearchLocationID
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("StructuredAnalyticsServerID", $this.StructuredAnalyticsServerID)
        $ReturnValue.Add("ConceptualAnalyticsServerID", $this.ConceptualAnalyticsServerID)
        $ReturnValue.Add("DtSearchLocationID", $this.DtSearchLocationID)
        
        return $ReturnValue
    }
}

class RelativityArmRestoreJobAdvancedFileOptions
{
    [Boolean] $ReferenceFilesAsArchiveLinks
    [Boolean] $UpdateRepositoryFilePaths
    [Boolean] $UpdateLinkedFilePaths

    RelativityArmRestoreJobAdvancedFileOptions(
        [Boolean] $referenceFilesAsArchiveLinks,
        [Boolean] $updateRepositoryFilePaths,
        [Boolean] $updateLinkedFilePaths
    )
    {
        $this.ReferenceFilesAsArchiveLinks = $referenceFilesAsArchiveLinks
        $this.UpdateRepositoryFilePaths = $updateRepositoryFilePaths
        $this.UpdateLinkedFilePaths = $updateLinkedFilePaths
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("ReferenceFilesAsArchiveLinks", $this.ReferenceFilesAsArchiveLinks)
        $ReturnValue.Add("UpdateRepositoryFilePaths", $this.UpdateRepositoryFilePaths)
        $ReturnValue.Add("UpdateLinkedFilePaths", $this.UpdateLinkedFilePaths)

        return $ReturnValue
    }
}

class RelativityArmRestoreJobApplication
{
    [String] $Name
    [Guid] $Guid
    [Boolean] $ShouldRestore

    RelativityArmRestoreJobApplication(
        [String] $name,
        [Guid] $guid,
        [Boolean] $shouldRestore
    )
    {
        $this.Name = $name
        $this.Guid = $guid
        $this.ShouldRestore = $shouldRestore
    }

    RelativtyArmRestoreJobApplication(
        [Guid] $guid,
        [Boolean] $shouldRestore
    )
    {
        $this.Guid = $guid
        $this.ShouldRestore = $shouldRestore
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        if ($null -ne $this.Name)
        {
            $ReturnValue.Add("Name", $this.Name)
        }

        $ReturnValue.Add("Guid", $this.Guid)
        $ReturnValue.Add("ShouldRestore", $this.ShouldRestore)

        return $ReturnValue
    }
}