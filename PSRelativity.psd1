#
# Module manifest for module 'PSRelativity'
#
# Generated by: Jarrod Kimmel
#
# Generated on: 10/29/2023
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'PSRelativity.psm1'

# Version number of this module.
ModuleVersion = '0.0.2'

# Supported PSEditions
CompatiblePSEditions = 'Desktop'

# ID used to uniquely identify this module
GUID = '95225073-9a03-4ec2-b71b-b97afe87f9ac'

# Author of this module
Author = 'Jarrod Kimmel'

# Company or vendor of this module
CompanyName = 'Jarrod Kimmel'

# Copyright statement for this module
Copyright = 'Jarrod Kimmel'

# Description of the functionality provided by this module
Description = 'A PowerShell module with cmdlets to interact with the Relativity REST API'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '5.1'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @(
    ### General
    "$PSScriptRoot\Public\RelativityAPI\Set-RelativityBaseUri.ps1",
    "$PSScriptRoot\Public\RelativityAPI\Set-RelativityCredential.ps1",
    "$PSScriptRoot\Private\RelativityAPI\Get-RelativityApiEndpoint.ps1",
    "$PSScriptRoot\Private\RelativityAPI\Get-RelativityApiRequestHeader.ps1",
    "$PSScriptRoot\Private\RelativityAPI\Invoke-RelativityApiRequest.ps1",

    ### Agent Manager API
    ###Common classes
    "$PSScriptRoot\Classes\AgentManager\CommonClasses.ps1",
    ###Get-RelativityAgentType
    "$PSScriptRoot\Classes\AgentManager\RelativityAgentTypeReadResponse.ps1",
    "$PSScriptRoot\Public\AgentManager\Get-RelativityAgentType.ps1",
    ###Get-RelativityAgentServer
    "$PSScriptRoot\Classes\AgentManager\RelativityAgentServerReadResponse.ps1",
    "$PSScriptRoot\Public\AgentManager\Get-RelativityAgentServer.ps1",
    ### New-RelativityAgent
    "$PSScriptRoot\Classes\AgentManager\RelativityAgentCreateRequest.ps1",
    "$PSScriptRoot\Classes\AgentManager\RelativityAgentCreateResponse.ps1",
    "$PSScriptRoot\Public\AgentManager\New-RelativityAgent.ps1",
    "$PSScriptRoot\Classes\AgentManager\RelativityAgentReadResponse.ps1",
    "$PSScriptRoot\Public\AgentManager\Get-RelativityAgent.ps1",
    "$PSScriptRoot\Classes\AgentManager\RelativityAgentUpdateRequest.ps1",
    "$PSScriptRoot\Public\AgentManager\Set-RelativityAgent.ps1",
    "$PSScriptRoot\Classes\AgentManager\RelativityAgentDeleteRequest.ps1",
    "$PSScriptRoot\Public\AgentManager\Remove-RelativityAgent.ps1"
)

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @(
    ### General
    "Set-RelativityBaseUri",
    "Set-RelativityCredential",

    ### Agent Manager API
    "Get-RelativityAgentType",
    "Get-RelativityAgentServer",
    "New-RelativityAgent",
    "Get-RelativityAgent",
    "Set-RelativityAgent",
    "Remove-RelativityAgent"
)

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @("relativity", "rest", "api", "developer")

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/Kimmels-n-Bits/PSRelativity/blob/main/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/Kimmels-n-Bits/PSRelativity/'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

