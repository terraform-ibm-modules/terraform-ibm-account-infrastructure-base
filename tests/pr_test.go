// Tests in this file are run in the PR pipeline and the continuous testing pipeline
package test

import (
	"fmt"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testschematic"
)

const solutionDir = "solutions/fully-configurable"

func setupOptions(t *testing.T, prefix string, dir string) *testschematic.TestSchematicOptions {
	options := testschematic.TestSchematicOptionsDefault(&testschematic.TestSchematicOptions{
		Testing:                t,
		TarIncludePatterns:     []string{"*.tf", fmt.Sprintf("%s/*.tf", solutionDir)},
		TemplateFolder:         solutionDir,
		Prefix:                 prefix,
		Tags:                   []string{"test-schematic"},
		DeleteWorkspaceOnFail:  false,
		WaitJobCompleteMinutes: 30,
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
	assert.NoError(t, err, "Schematic Test had an unexpected error")
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
		assert.NoError(t, err, "Schematic Upgrade Test had an unexpected error")
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
		Tags:                   []string{"test-schematic"},
		DeleteWorkspaceOnFail:  false,
		WaitJobCompleteMinutes: 30,
	})

	// Set options to the same defaults set for the resource group only flavor
	// see ibm_catalog.json
	options.TerraformVars = []testschematic.TestSchematicTerraformVar{
		{Name: "ibmcloud_api_key", Value: options.RequiredEnvironmentVars["TF_VAR_ibmcloud_api_key"], DataType: "string", Secure: true},
		{Name: "prefix", Value: options.Prefix, DataType: "string"},
		{Name: "provision_cbr", Value: false, DataType: "string"},
		{Name: "skip_iam_account_settings", Value: true, DataType: "string"},
		{Name: "provision_trusted_profile_projects", Value: false, DataType: "string"},
		{Name: "single_resource_group_name", Value: "global", DataType: "string"},
		{Name: "use_existing_single_resource_group", Value: false, DataType: "string"},
	}

	err := options.RunSchematicTest()
	assert.NoError(t, err, "Schematic Resource Group Only Test had an unexpected error")
}
