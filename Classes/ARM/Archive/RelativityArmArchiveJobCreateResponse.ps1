<#
.SYNOPSIS
This class represents the response received upon successful creation of an ARM Archive Job in Relativity.

.DESCRIPTION
The RelativityArmArchiveJobCreateResponse class encapsulates the identifier of the newly created ARM Archive Job. This identifier can be used for further interactions with the job within the Relativity platform.

.PARAMETER JobID
Specifies the ID of the newly created ARM Archive Job. This ID is unique to the job and is returned by the Relativity server upon successful job creation.

.EXAMPLE
$response = [RelativityArmArchiveJobCreateResponse]::new(12345)
Write-Host "The newly created job ID is: $($response.JobID)"

.NOTES
Store the JobID as it is essential for further interactions with the created ARM Archive Job within Relativity.
#>
class RelativityArmArchiveJobCreateResponse
{
    [ValidateNotNull()]
    [Int32] $JobID

    RelativityArmArchiveJobCreateResponse([Int32] $jobID)
    {
        $this.JobID = $jobID
    }
}