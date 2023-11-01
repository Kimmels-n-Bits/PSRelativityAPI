<#
.SYNOPSIS
Represents options for including extended workspace data in an ARM archive job.

.DESCRIPTION
This class defines options related to the inclusion of extended workspace information such as installed applications, linked relativity scripts, and non-application event handlers.

.PARAMETER IncludeExtendedWorkspaceData
Indicates whether extended workspace information is included in the archive.

.PARAMETER ApplicationErrorExportBehavior
Indicates the behavior when applications error during export. Options include "SkipApplication" and "StopJob".
#>
class RelativityArmArchiveJobExtendedWorkspaceDataOptions
{
    [ValidateNotNull()]
    [Boolean] $IncludeExtendedWorkspaceData
    [ValidateSet("", "SkipApplication", "StopJob")]
    [String] $ApplicationErrorExportBehavior

    RelativityArmArchiveJobExtendedWorkspaceDataOptions([Boolean] $includeExtendedWorkspaceData, [String] $applicationErrorExportBehavior)
    {
        $this.IncludeExtendedWorkspaceData = $includeExtendedWorkspaceData
        $this.ApplicationErrorExportBehavior = $applicationErrorExportBehavior
    }

    [Hashtable] ToHashTable()
    {
        return @{
            IncludeExtendedWorkspaceData = $this.IncludeExtendedWorkspaceData
            ApplicationErrorExportBehavior = $this.ApplicationErrorExportBehavior
        }
    }
}