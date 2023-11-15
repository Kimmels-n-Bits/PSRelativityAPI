class RelativityArmMoveJobReadResponse : RelativityArmJobReadResponseBase
{
    [RelativityArmMoveJobSourceOptions] $SourceOptions
    [RelativityArmJobDestinationOptions] $DestinationOptions
    [RelativityArmMoveJobFileOptions] $FileOptions
    [RelativityArmMoveJobDatabaseOptions] $DatabaseOptions

    RelativityArmMoveJobReadResponse(
        [PSCustomObject] $apiResponse
    ) : base($apiResponse)
    {
        $this.SourceOptions = [RelativityArmMoveJobSourceOptions]::New(
            $apiResponse.SourceOptions.WorkspaceID,
            $apiResponse.SourceOptions.ResourcePoolID,
            $apiResponse.SourceOptions.DatabaseServerID,
            $apiResponse.SourceOptions.CacheLocationID,
            $apiResponse.SourceOptions.FileRepositoryID
        )

        $this.DestinationOptions = [RelativityArmJobDestinationOptions]::New(
            $apiResponse.DestinationOptions.DatabaseServerID,
            $apiResponse.DestinationOptions.ResourcePoolID,
            $apiResponse.DestinationOptions.CacheLocationID,
            $apiResponse.DestinationOptions.FileRepositoryID
        )

        $this.FileOptions = [RelativityArmMoveJobFileOptions]::New(
            $apiResponse.FileOptions.LinkToExistingDocuments,
            $apiResponse.FileOptions.MissingFileBehavior,
            $apiResponse.FileOptions.LinkedFileBehavior
        )

        $this.DatabaseOptions = [RelativityArmMoveJobDatabaseOptions]::New(
            $apiResponse.DatabaseOptions.IncludeDatabaseBackup,
            $apiResponse.DatabaseOptions.CustomDatabasePath
        )
    }
}
