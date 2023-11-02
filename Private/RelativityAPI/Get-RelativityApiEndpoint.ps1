<#
.SYNOPSIS
Constructs and returns the API endpoint for provided Relativity system components.

.DESCRIPTION
The function builds the API endpoint URL based on a given set of parameters, including the business domain, version, resources, and query string. It uses the global `$script:RelativityBaseUri` as the base URL.

.PARAMETER RestSurface
Specifies the REST surface for the API call. Defaults to "relativity.rest/api".

.PARAMETER BusinessDomain
The business domain for which the API request is intended. A predefined set of domains are accepted, including "relativity-arm", "relativity-application", and others.

.PARAMETER Version
Specifies the version of the API. For example: "v1". It defaults to an empty string if not provided.

.PARAMETER Resources
An array of `RelativityApiEndpointResource` objects that define the resource and resource ID components of the API endpoint.

.PARAMETER QueryString
The query string to be appended to the API endpoint. Should start with a "?" followed by the query parameters.

.EXAMPLE
$resource1 = [RelativityApiEndpointResource]::new("workspace", "-1")
$resource2 = [RelativityApiEndpointResource]::new("libraryapplications", "1234567")
Get-RelativityApiEndpoint -BusinessDomain "relativity-environment" -Version "v1" -Resources @($resource1, $resource2)

This will construct an endpoint similar to: 
"https://yourbaseuri/relativity.rest/api/relativity-environment/v1/workspace/-1/libraryapplications/1234567"

.NOTES
This function constructs API endpoints based on the provided parameters and the global base URI. Always ensure that the constructed endpoint matches the expected format for the target Relativity API.
#>
function Get-RelativityApiEndpoint
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $false)]
        [ValidateNotNull()]
        [String] $RestSurface = "relativity.rest/api",
        [Parameter(Mandatory = $true)]
        [ValidateSet(
            "classification-analytics",
            "conceptual-analytics",
            "kcura.datagrid.services.datagridrecordmanager.idatagridrecordmodule",
            "relativity-arm",
            "relativity-application",
            "relativity-audit",
            "relativity-data-visualization",
            "relativity-documentviewer",
            "relativity-dtsearch",
            "relativity-environment",
            "relativity-extensibility",
            "relativity-identity",
            "relativity-imaging",
            "relativity-infrastructure",
            "relativity-notifications",
            "relativity-object-model",
            "relativity-processing",
            "relativity-productions",
            "relativity-search-terms-report",
            "relativity-review",
            "relativity.libraryapplications",
            "relativity.agents",
            "relativity.objectmanager",
            "relativity.objecttypes",
            "relativity.searchproviders",
            "relativity.services.permission.ipermissionmodule",
            "relativity.services.pivot.ipivotmodule",
            "relativity.services.search.isearchmodule",
            "relativity.structuredanalytics.services.interfaces.structuredanalytics.istructuredanalyticsmodule"
        )]
        [String] $BusinessDomain,
        [Parameter(Mandatory = $false)]
        [ValidateSet(
            "",
            "v1"
        )]
        [String] $Version,
        [RelativityApiEndpointResource[]] $Resources,
        [ValidateScript({
            $_ -match "^\?((\w|\d)*?=?(\w|\d)*?&?){1,}$"
        }
        )]
        [String] $QueryString
    )

    function Join-RelativityApiEndpoint
    {
        Param
        (
            [ValidateNotNull()]
            [String] $RelativityApiEndpoint,
            [ValidateNotNull()]
            [String] $Value
        )

        if (-not [String]::IsNullOrWhiteSpace($Value))
        {
            if (-not $RelativityApiEndpoint.EndsWith("/"))
            {
                $RelativityApiEndpoint += "/"
            }

            $RelativityApiEndpoint += $Value
        }

        return $RelativityApiEndpoint
    }


    $RelativityApiEndpoint = $script:RelativityBaseUri

    $RelativityApiEndpoint = Join-RelativityApiEndpoint -RelativityApiEndpoint $RelativityApiEndpoint -Value $RestSurface
    $RelativityApiEndpoint = Join-RelativityApiEndpoint -RelativityApiEndpoint $RelativityApiEndpoint -Value $BusinessDomain
    $RelativityApiEndpoint = Join-RelativityApiEndpoint -RelativityApiEndpoint $RelativityApiEndpoint -Value $Version

    $Resources | ForEach-Object {
        $RelativityApiEndpoint = Join-RelativityApiEndpoint -RelativityApiEndpoint $RelativityApiEndpoint -Value $_.Resource
        $RelativityApiEndpoint = Join-RelativityApiEndpoint -RelativityApiEndpoint $RelativityApiEndpoint -Value $_.ResourceId
    }

    $RelativityApiEndpoint = Join-RelativityApiEndpoint -RelativityApiEndpoint $RelativityApiEndpoint -Value $QueryString

    return $RelativityApiEndpoint
}