# PSRelativity Changelog

All notable changes to this project will be documented in this file.

## [0.0.5] - 2023-11-05

### Added
- ARM API : Remove-RelativityArmArchiveJob
- ARM API : New-RelativityArmRestoreJob
- ARM API : Get-RelativityArmRestoreJob
- ARM API : Set-RelativityArmRestoreJob
- ARM API : Remove-RelativityArmRestoreJob

### Changes
- ARM API : Refactored class structure to reduce duplication of code
- ARM API : Pre-existing API calls refactored around revised best practices

## [0.0.4] - 2023-11-04

### Added
- AgentManager API : Test-NewRelativityAgent
- AgentManager API : Test-RemoveRelativityAgent
- AgentManager API : Test-UpdateRelativityAgent

### Changed
- Added success response instead of null when response is a success but doesn't return anything
- Refactored to use Invoke-WebRequest instead of Invoke-RestMethod for better error handling
- Removed duplicated code

## [0.0.3] - 2023-11-03

### Added
- AgentManager API : GetRelativityAgent
- AgentManager API : Get-RelativityAgentServer
- AgentManager API : Remove-RelativityAgent
- AgentManager API : Set-RelativityAgent

### Changed
- Refactored AgentManager code around revised best practices

## [0.0.2] - 2023-11-01

### Added
- Get-RelativityApiEndpoint

### Changed
- Refactored code to prevent monolithic .ps1 files in the future

### Fixed
- Get-RelativityArmArchiveJob no longer deletes ARM jobs

## [0.0.1] - 2023-10-31

### Added
- AgentManager API : New-RelativityAgent
- AgentManager API : Get-RelativityAgentType
- ARM API : New-RelativityArmArchiveJob
- ARM API : Get-RelativityArmArchiveJob
- ARM API : Set-RelativityArmArchiveJob
- ARM API : New-RelativityArmRestoreJob