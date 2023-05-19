targetScope = 'resourceGroup'

// ----------
// PARAMETERS
// ----------
var roleDefinitionId = '0000-0000-0000-0000'
var assigneeObjectId = '0000-0000-0000-0000'
// ---------
// RESOURCES
// ---------

@description('Baseline resource configuration.')
module rggroup '../roleAssignmentResourceGroup.bicep' = {
  name: 'rggroup'
  
  params: {
    roleDefinitionId:roleDefinitionId
    parAssigneePrincipalType: 'Group'
    assigneeObjectId: assigneeObjectId
    parRoleAssignmentNameGuid: guid(resourceGroup().name, roleDefinitionId, assigneeObjectId)
  }
}
