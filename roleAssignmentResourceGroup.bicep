targetScope = 'resourceGroup' 

metadata name = 'groups - Role Assignment to a Resource Group'
metadata description = 'Module used to assign a Role Assignment to a Resource Group'

@sys.description('A GUID representing the role assignment name.')
param parRoleAssignmentNameGuid string = guid(resourceGroup().id, roleDefinitionId, assigneeObjectId)

@sys.description('Role Definition Id (i.e. GUID, Reader Role Definition ID: acdd72a7-3385-48ef-bd42-f606fba81ae7)')
param roleDefinitionId string

@sys.description('Principal type of the assignee. Allowed values are \'Group\' (Security Group) or \'ServicePrincipal\' (Service Principal or System/User Assigned Managed Identity)')
@allowed([
  'Group'
  'ServicePrincipal'
])
param parAssigneePrincipalType string

@sys.description('Object ID of groups, service principals or managed identities. For managed identities use the principal id. For service principals, use the object ID and not the app ID')
param assigneeObjectId string



// resource resRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
//   name: parRoleAssignmentNameGuid
//   properties: {
//     roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionId)
//     principalId: assigneeObjectId
//     principalType: parAssigneePrincipalType
//   }
// }

param startTime string = utcNow()

resource pimAssignment 'Microsoft.Authorization/roleEligibilityScheduleRequests@2022-04-01-preview' = {
  name: parRoleAssignmentNameGuid
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionId)
    principalId: assigneeObjectId
    principalType: parAssigneePrincipalType
    requestType: 'AdminUpdate'
    scheduleInfo: {
      expiration: {
        duration: 'P365D'
        type: 'AfterDuration'
      }
      startDateTime: startTime
    }
  }
}

