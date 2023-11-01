<#
.SYNOPSIS
Represents file-related options for an ARM archive job.

.DESCRIPTION
This class defines various options related to the inclusion of different types of files in the archive.

.PARAMETER IncludeRepositoryFiles
Indicates whether all files included in the workspace repository, including files from file fields, will be archived in the archive directory.

.PARAMETER IncludeLinkedFiles
Indicates whether all linked files that do not exist in the workspace file repository will be archived in the archive directory.

.PARAMETER MissingFileBehavior
Indicates the behavior when missing files are detected during the archiving process. Options include "SkipFile" and "StopJob".
#>
class RelativityArmArchiveJobFileOptions
{
    [ValidateNotNull()]
    [Boolean] $IncludeRepositoryFiles
    [ValidateNotNull()]
    [Boolean] $IncludeLinkedFiles
    [ValidateSet("", "SkipFile", "StopJob")]
    [String] $MissingFileBehavior

    RelativityArmArchiveJobFileOptions([Boolean] $includeRepositoryFiles, [Boolean] $includeLinkedFiles, [String] $missingFileBehavior)
    {
        $this.IncludeRepositoryFiles = $includeRepositoryFiles
        $this.IncludeLinkedFiles = $includeLinkedFiles
        $this.MissingFileBehavior = $missingFileBehavior
    }

    [Hashtable] ToHashTable()
    {
        return @{
            IncludeRepositoryFiles = $this.IncludeRepositoryFiles
            IncludeLinkedFiles = $this.IncludeLinkedFiles
            MissingFileBehavior = $this.MissingFileBehavior
        }
    }
}