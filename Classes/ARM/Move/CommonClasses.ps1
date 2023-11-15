class RelativityArmMoveJobSourceOptions : RelativityArmJobDestinationOptions
{
    [Int32] $WorkspaceID

    RelativityArmMoveJobSourceOptions(
        [Int32] $workspaceID,
        [Int32] $databaseServerID,
        [Int32] $resourcePoolID,
        [Int32] $cacheLocationID,
        [Int32] $fileRepositoryID
    ) : base(
        $databaseServerID,
        $resourcePoolID,
        $cacheLocationID,
        $fileRepositoryID
    )
    {
        $this.WorkspaceID = $workspaceID
    }
}

class RelativityArmMoveJobFileOptions
{
    [Boolean] $LinkToExistingDocuments
    [String] $MissingFileBehavior
    [String] $LinkedFileBehavior

    RelativityArmMoveJobFileOptions(
        [Boolean] $linkToExistingDocuments,
        [String] $missingFileBehavior,
        [String] $linkedFileBehavior
    )
    {
        $this.LinkToExistingDocuments = $linkToExistingDocuments
        $this.MissingFileBehavior = $missingFileBehavior
        $this.LinkedFileBehavior = $linkedFileBehavior
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("LinkToExistingDocuments", $this.LinkToExistingDocuments)
        $ReturnValue.Add("MissingFileBehavior", $this.MissingFileBehavior)
        $ReturnValue.Add("LinkedFileBehavior", $this.LinkedFileBehavior)

        return $ReturnValue
    }
}

class RelativityArmMoveJobDatabaseOptions
{
    [Boolean] $IncludeDatabaseBackup
    [String] $CustomDatabasePath

    RelativityArmMoveJobDatabaseOptions(
        [Boolean] $includeDatabaseBackup,
        [String] $customDatabasePath
    )
    {
        $this.IncludeDatabaseBackup = $IncludeDatabaseBackup
        $this.CustomDatabasePath = $CustomDatabasePath
    }

    [Hashtable] ToHashTable()
    {
        $ReturnValue = @{}

        $ReturnValue.Add("IncludeDatabaseBackup", $this.IncludeDatabaseBackup)

        if ($this.IncludeDatabaseBackup -eq $false)
        {
            $ReturnValue.Add("CustomDatabasePath", $this.CustomDatabasePath)
        }

        return $ReturnValue
    }
}