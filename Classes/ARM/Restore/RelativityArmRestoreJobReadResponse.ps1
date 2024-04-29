class RelativityArmRestoreJobReadResponse : RelativityArmJobReadResponseBase
{
    [String] $ArchivePath
    [String] $SourceWorkspace
    [Int32] $DestinationWorkspaceID
    [String] $ExistingTargetDatabase
    [RelativityArmRestoreJobDestinationOptions] $DestinationOptions
    [RelativityArmRestoreJobMigratorsDestinationOptions] $MigratorsDestinationOptions
    [RelativityArmRestoreJobAdvancedFileOptions] $AdvancedFileOptions
    [RelativityArmRestoreJobUserMapping[]] $UserMappings
    [RelativityArmRestoreJobGroupMapping[]] $GroupMappings
    [RelativityArmRestoreJobApplication[]] $Applications

    RelativityArmRestoreJobReadResponse(
        [PSCustomObject] $apiResponse
    ) : base($apiResponse)
    {
        $this.ArchivePath = $apiResponse.ArchivePath
        $this.SourceWorkspace = $apiResponse.SourceWorkspace
        $this.DestinationWorkspaceID = $apiResponse.DestinationWorkspaceID
        $this.ExistingTargetDatabase = $apiResponse.ExistingTargetDatabase

        $this.DestinationOptions = [RelativityArmRestoreJobDestinationOptions]::New(
            $apiResponse.DestinationOptions.DatabaseServerID,
            $apiResponse.DestinationOptions.ResourcePoolID,
            $apiResponse.DestinationOptions.MatterID,
            $apiResponse.DestinationOptions.CacheLocationID,
            $apiResponse.DestinationOptions.FileRepositoryID
        )

        $this.MigratorsDestinationOptions = [RelativityArmRestoreJobMigratorsDestinationOptions]::New(
            $apiResponse.MigratorsDestinationOptions.StructuredAnalyticsServerID,
            $apiResponse.MigratorsDestinationOptions.ConceptualAnalyticsServerID,
            $apiResponse.MigratorsDestinationOptions.DtSearchLocationID
        )

        $this.AdvancedFileOptions = [RelativityArmRestoreJobAdvancedFileOptions]::New(
            $apiResponse.AdvancedFileOptions.ReferenceFilesAsArchiveLinks,
            $apiResponse.AdvancedFileOptions.UpdateRepositoryFilePaths,
            $apiResponse.AdvancedFileOptions.UpdateLinkedFilePaths
        )

        $UserMappingsValue = New-Object "System.Collections.Generic.List[RelativityArmRestoreJobUserMapping]"

        $apiResponse.UserMappings | ForEach-Object {
            $UserMappingsValue.Add([RelativityArmRestoreJobUserMapping]::New(
                    $_.ArchiveUserID,
                    $_.InstanceUserID
                ))
        }

        $this.UserMappings = $UserMappingsValue.ToArray()

        $GroupMappingsValue = New-Object "System.Collections.Generic.List[RelativityArmRestoreJobGroupMapping]"

        $apiResponse.GroupMappings | ForEach-Object {
            $GroupMappingsValue.Add([RelativityArmRestoreJobGroupMapping]::New(
                    $_.ArchiveGroupID,
                    $_.InstanceGroupID
                ))
        }

        $ApplicationsValue = New-Object "System.Collections.Generic.List[RelativityArmRestoreJobApplication]"

        $apiResponse.Applications | ForEach-Object {
            $ApplicationsValue.Add([RelativityArmRestoreJobApplication]::New(
                    $_.Name,
                    $_.Guid,
                    $_.ShouldRestore
                ))
        }
    }
}