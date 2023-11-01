<#
.SYNOPSIS
Represents processing-related options for an ARM archive job.

.DESCRIPTION
This class defines various options related to the inclusion of processing data and files in the archive.

.PARAMETER IncludeProcessing
Indicates whether Processing application data will be present in the archive directory.

.PARAMETER IncludeProcessingFiles
Indicates whether all the files and containers discovered by Processing will be archived and placed in the Invariant directory.

.PARAMETER ProcessingMissingFileBehavior
Indicates the behavior when missing Processing files are detected during the archiving process. Options include "SkipFile" and "StopJob".
#>
class RelativityArmArchiveJobProcessingOptions
{
    [ValidateNotNull()]
    [Boolean] $IncludeProcessing
    [ValidateNotNull()]
    [Boolean] $IncludeProcessingFiles
    [ValidateSet("", "SkipFile", "StopJob")]
    [String] $ProcessingMissingFileBehavior

    RelativityArmArchiveJobProcessingOptions([Boolean] $includeProcessing, [Boolean] $includeProcessingFiles, [String] $processingMissingFileBehavior)
    {
        $this.IncludeProcessing = $includeProcessing
        $this.IncludeProcessingFiles = $includeProcessingFiles
        $this.ProcessingMissingFileBehavior = $processingMissingFileBehavior
    }

    [Hashtable] ToHashTable()
    {
        return @{
            IncludeProcessing = $this.IncludeProcessing
            IncludeProcessingFiles = $this.IncludeProcessingFiles
            ProcessingMissingFileBehavior = $this.ProcessingMissingFileBehavior
        }
    }
}