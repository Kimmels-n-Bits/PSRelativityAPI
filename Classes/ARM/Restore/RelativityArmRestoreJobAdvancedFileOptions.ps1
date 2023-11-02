class RelativityArmRestoreJobAdvancedFileOptions
{
    [ValidateNotNull()]
    [Boolean] $ReferenceFilesAsArchiveLinks
    [ValidateNotNull()]
    [Boolean] $UpdateRepositoryFilePaths
    [ValidateNotNull()]
    [Boolean] $UpdateLinkedFilePaths

    RelativityArmRestoreJobAdvancedFileOptions([Boolean] $referenceFilesAsArchiveLinks, [Boolean] $updateRepositoryFilePaths, [Boolean] $updateLinkedFilePaths)
    {
        $this.ReferenceFilesAsArchiveLinks = $referenceFilesAsArchiveLinks
        $this.UpdateRepositoryFilePaths = $updateRepositoryFilePaths
        $this.UpdateLinkedFilePaths = $updateLinkedFilePaths
    }

    [Hashtable] ToHashTable()
    {
        return @{
            ReferenceFilesAsArchiveLinks = $this.ReferenceFilesAsArchiveLinks
            UpdateRepositoryFilePaths = $this.UpdateRepositoryFilePaths
            UpdateLinkedFilePaths = $this.UpdateLinkedFilePaths
        }
    }
}

