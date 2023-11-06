class RelativityArmArchiveJobOptions : RelativityArmJobOptionsBase
{
    [Int32] $WorkspaceID
    [String] $ArchiveDirectory
    [RelativityArmArchiveJobMigratorOptions] $MigratorOptions
    [RelativityArmArchiveJobFileOptions] $FileOptions
    [RelativityArmArchiveJobProcessingOptions] $ProcessingOptions
    [RelativityArmArchiveJobExtendedWorkspaceDataOptions] $ExtendedWorkspaceDataOptions
    [Boolean] $UseDefaultArchiveDirectory

    RelativityArmArchiveJobOptions(
        [Int32] $workspaceID,
        [String] $jobPriority,
        [String] $archiveDirectory,
        [String] $scheduledStartTime,
        [RelativityArmArchiveJobMigratorOptions] $migratorOptions,
        [RelativityArmArchiveJobFileOptions] $fileOptions,
        [RelativityArmArchiveJobProcessingOptions] $processingOptions,
        [RelativityArmArchiveJobExtendedWorkspaceDataOptions] $extendedWorkspaceDataOptions,
        [RelativityArmJobNotificationOptions] $notificationOptions,
        [Boolean] $uiJobActionsLocked,
        [Boolean] $useDefaultArchiveDirectory
    ) : base(
        $jobPriority,
        $scheduledStartTime,
        $notificationOptions,
        $uiJobActionsLocked
    )
    {
        $this.WorkspaceID = $workspaceID
        $this.ArchiveDirectory = $archiveDirectory
        $this.MigratorOptions = $migratorOptions
        $this.FileOptions = $fileOptions
        $this.ProcessingOptions = $processingOptions
        $this.ExtendedWorkspaceDataOptions = $extendedWorkspaceDataOptions
        $this.UseDefaultArchiveDirectory = $useDefaultArchiveDirectory
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = ([RelativityArmJobOptionsBase] $this).ToHashTable()
        
        $ReturnValue.Add("WorkspaceID", $this.WorkspaceID)
        $ReturnValue.Add("ArchiveDirectory", $this.ArchiveDirectory)
        $ReturnValue.Add("MigratorOptions", $this.MigratorOptions.ToHashTable())
        $ReturnValue.Add("FileOptions", $this.FileOptions.ToHashTable())
        $ReturnValue.Add("ProcessingOptions", $this.ProcessingOptions.ToHashTable())
        $ReturnValue.Add("ExtendedWorkspaceDataOptions", $this.ExtendedWorkspaceDataOptions.ToHashTable())
        $ReturnValue.Add("UseDefaultArchiveDirectory", $this.UseDefaultArchiveDirectory)

        return $ReturnValue
    }
}

class RelativityArmArchiveJobCreateOrUpdateRequest
{
    [RelativityArmArchiveJobOptions] $Request

    RelativityArmArchiveJobCreateOrUpdateRequest(
        [RelativityArmArchiveJobOptions] $request
    )
    {
        $this.Request = $request
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}
        
        $ReturnValue.Add("Request", $this.Request.ToHashTable())

        return $ReturnValue
    }
}