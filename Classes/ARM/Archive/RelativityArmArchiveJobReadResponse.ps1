class RelativityArmArchiveJobReadResponse : RelativityArmJobReadResponseBase
{
    [String] $ArchivePath
    [Int32] $WorkspaceID
    [RelativityArmArchiveJobMigratorOptions] $MigratorOptions
    [RelativityArmArchiveJobFileOptions] $FileOptions
    [RelativityArmArchiveJobProcessingOptions] $ProcessingOptions
    [RelativityArmArchiveJobExtendedWorkspaceDataOptions] $ExtendedWorkspaceDataOptions

    RelativityArmArchiveJobReadResponse(
        [PSCustomObject] $apiResponse
    ) : base($apiResponse)
    {
        $this.ArchivePath = $apiResponse.ArchivePath
        $this.WorkspaceID = $apiResponse.WorkspaceID

        $this.MigratorOptions = [RelativityArmArchiveJobMigratorOptions]::New(
            $apiResponse.MigratorOptions.IncludeDatabaseBackup,
            $apiResponse.MigratorOptions.IncludeDtSearch,
            $apiResponse.MigratorOptions.IncludeConceptualAnalytics,
            $apiResponse.MigratorOptions.IncludeStructuredAnalytics,
            $apiResponse.MigratorOptions.IncludeDataGrid
        )

        $this.FileOptions = [RelativityArmArchiveJobFileOptions]::New(
            $apiResponse.FileOptions.IncludeRepositoryFiles,
            $apiResponse.FileOptions.IncludeLinkedFiles,
            $apiResponse.FileOptions.MissingFileBehavior
        )

        $this.ProcessingOptions = [RelativityArmArchiveJobProcessingOptions]::New(
            $apiResponse.ProcessingOptions.IncludeProcessing,
            $apiResponse.ProcessingOptions.IncludeProcessingFiles,
            $apiResponse.ProcessingOptions.ProcessingMissingFileBehavior
        )

        $this.ExtendedWorkspaceDataOptions = [RelativityArmArchiveJobExtendedWorkspaceDataOptions]::New(
            $apiResponse.ExtendedWorkspaceDataOptions.IncludeExtendedWorkspaceData,
            $apiResponse.ExtendedWorkspaceDataOptions.ApplicationErrorExportBehavior
        )
    }
}
