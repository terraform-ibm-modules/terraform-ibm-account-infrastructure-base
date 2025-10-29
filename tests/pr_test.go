// Tests in this file are run in the PR pipeline and the continuous testing pipeline
package test

import (
	"fmt"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testschematic"
)

/*
Global variables
*/
const solutionDir = "solutions/fully-configurable"
const terraformVersion = "terraform_v1.12.2" // This should match the version in the ibm_catalog.json
var tags = []string{"test-schematic", "account-infra-base"}

/*
Common setup options
*/
func setupOptions(t *testing.T, prefix string, dir string) *testschematic.TestSchematicOptions {
	options := testschematic.TestSchematicOptionsDefault(&testschematic.TestSchematicOptions{
		Testing:                    t,
		TarIncludePatterns:         []string{"*.tf", fmt.Sprintf("%s/*.tf", solutionDir)},
		TemplateFolder:             solutionDir,
		Prefix:                     prefix,
		Tags:                       tags,
		DeleteWorkspaceOnFail:      false,
		WaitJobCompleteMinutes:     30,
		TerraformVersion:           terraformVersion,
		CheckApplyResultForUpgrade: true, // Set to true to test the actual terraform apply upgrade
	})

	options.TerraformVars = []testschematic.TestSchematicTerraformVar{
		{Name: "ibmcloud_api_key", Value: options.RequiredEnvironmentVars["TF_VAR_ibmcloud_api_key"], DataType: "string", Secure: true},
		{Name: "prefix", Value: options.Prefix, DataType: "string"},
		{Name: "provision_cbr", Value: false, DataType: "string"},
		{Name: "allowed_ip_addresses", Value: []string{"0.0.0.0/0", "::/0"}, DataType: "list(string)"},
		{Name: "observability_resource_group_name", Value: "obs-resource-group", DataType: "string"},
	}

	return options
}

func TestRunDA(t *testing.T) {
	/* Unable to run tests in parallel as both are trying to update account settings at
	   the same time, and the following error is observed:
	   "Error: UpdateAccountSettingsWithContext failed Couldn't save cloudshell settings for account"
	*/

	// t.Parallel()

	options := setupOptions(t, "aib", solutionDir)

	err := options.RunSchematicTest()
	assert.NoError(t, err, "TestRunDA had an unexpected error")
}

func TestRunUpgradeDA(t *testing.T) {
	/* Unable to run tests in parallel as both are trying to update account settings at
	   the same time, and the following error is observed:
	   "Error: UpdateAccountSettingsWithContext failed Couldn't save cloudshell settings for account"
	*/

	// t.Parallel()

	options := setupOptions(t, "aibupg", solutionDir)

	err := options.RunSchematicUpgradeTest()
	if !options.UpgradeTestSkipped {
		assert.NoError(t, err, "TestRunUpgradeDA had an unexpected error")
	}
}

func TestRunRGOnlyDA(t *testing.T) {
	t.Parallel()

	options := testschematic.TestSchematicOptionsDefault(&testschematic.TestSchematicOptions{
		Testing:                t,
		TarIncludePatterns:     []string{"*.tf", fmt.Sprintf("%s/*.tf", solutionDir)},
		TemplateFolder:         solutionDir,
		Prefix:                 "rgonly",
		Region:                 "us-east",
		Tags:                   tags,
		DeleteWorkspaceOnFail:  false,
		WaitJobCompleteMinutes: 30,
		TerraformVersion:       terraformVersion,
	})

	// Set options to the same defaults set for the resource group only flavor
	// see ibm_catalog.json
	options.TerraformVars = []testschematic.TestSchematicTerraformVar{
		{Name: "ibmcloud_api_key", Value: options.RequiredEnvironmentVars["TF_VAR_ibmcloud_api_key"], DataType: "string", Secure: true},
		{Name: "prefix", Value: options.Prefix, DataType: "string"},
		{Name: "provision_cbr", Value: false, DataType: "string"},
		{Name: "skip_iam_account_settings", Value: true, DataType: "string"},
		{Name: "provision_trusted_profile_projects", Value: false, DataType: "string"},
		{Name: "global_resource_group_name", Value: "global", DataType: "string"},
	}

	err := options.RunSchematicTest()
	assert.NoError(t, err, "TestRunRGOnlyDA had an unexpected error")
}
