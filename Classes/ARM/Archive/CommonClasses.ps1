class RelativityArmArchiveJobMigratorOptions
{
    [Boolean] $IncludeDatabaseBackup
    [Boolean] $IncludeDtSearch
    [Boolean] $IncludeConceptualAnalytics
    [Boolean] $IncludeStructuredAnalytics
    [Boolean] $IncludeDataGrid

    RelativityArmArchiveJobMigratorOptions(
        [Boolean] $includeDatabaseBackup,
        [Boolean] $includeDtSearch,
        [Boolean] $includeConceptualAnalytics,
        [Boolean] $includeStructuredAnalytics,
        [Boolean] $includeDataGrid
    )
    {
        $this.IncludeDatabaseBackup = $includeDatabaseBackup
        $this.IncludeDtSearch = $includeDtSearch
        $this.IncludeConceptualAnalytics = $includeConceptualAnalytics
        $this.IncludeStructuredAnalytics = $includeStructuredAnalytics
        $this.IncludeDataGrid = $includeDataGrid
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("IncludeDatabaseBackup", $this.IncludeDatabaseBackup)
        $ReturnValue.Add("IncludeDtSearch", $this.IncludeDtSearch)
        $ReturnValue.Add("IncludeConceptualAnalytics", $this.IncludeConceptualAnalytics)
        $ReturnValue.Add("IncludeStructuredAnalytics", $this.IncludeStructuredAnalytics)
        $ReturnValue.Add("IncludeDataGrid", $this.IncludeDataGrid)

        return $ReturnValue
    }
}

class RelativityArmArchiveJobFileOptions
{
    [Boolean] $IncludeRepositoryFiles
    [Boolean] $IncludeLinkedFiles
    [String] $MissingFileBehavior

    RelativityArmArchiveJobFileOptions(
        [Boolean] $includeRepositoryFiles,
        [Boolean] $includeLinkedFiles,
        [String] $missingFileBehavior
    )
    {
        $this.IncludeRepositoryFiles = $includeRepositoryFiles
        $this.IncludeLinkedFiles = $includeLinkedFiles
        $this.MissingFileBehavior = $missingFileBehavior
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("IncludeRepositoryFiles", $this.IncludeRepositoryFiles)
        $ReturnValue.Add("IncludeLinkedFiles", $this.IncludeLinkedFiles)
        $ReturnValue.Add("MissingFileBehavior", $this.MissingFileBehavior)

        return $ReturnValue
    }
}

class RelativityArmArchiveJobProcessingOptions
{
    [Boolean] $IncludeProcessing
    [Boolean] $IncludeProcessingFiles
    [String] $ProcessingMissingFileBehavior

    RelativityArmArchiveJobProcessingOptions(
        [Boolean] $includeProcessing,
        [Boolean] $includeProcessingFiles,
        [String] $processingMissingFileBehavior
    )
    {
        $this.IncludeProcessing = $includeProcessing
        $this.IncludeProcessingFiles = $includeProcessingFiles
        $this.ProcessingMissingFileBehavior = $processingMissingFileBehavior
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("IncludeProcessing", $this.IncludeProcessing)
        $ReturnValue.Add("IncludeProcessingFiles", $this.IncludeProcessingFiles)
        $ReturnValue.Add("ProcessingMissingFileBehavior", $this.ProcessingMissingFileBehavior)

        return $ReturnValue
    }
}

class RelativityArmArchiveJobExtendedWorkspaceDataOptions
{
    [Boolean] $IncludeExtendedWorkspaceData
    [String] $ApplicationErrorExportBehavior

    RelativityArmArchiveJobExtendedWorkspaceDataOptions(
        [Boolean] $includeExtendedWorkspaceData,
        [String] $applicationErrorExportBehavior
    )
    {
        $this.IncludeExtendedWorkspaceData = $includeExtendedWorkspaceData
        $this.ApplicationErrorExportBehavior = $applicationErrorExportBehavior
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("IncludeExtendedWorkspaceData", $this.IncludeExtendedWorkspaceData)
        $ReturnValue.Add("ApplicationErrorExportBehavior", $this.ApplicationErrorExportBehavior)

        return $ReturnValue
    }
}