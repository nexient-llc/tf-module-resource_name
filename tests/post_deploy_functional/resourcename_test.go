package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformResourcenameExample_WithoutSeparator(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{

		TerraformDir: "../..",

		Vars: map[string]interface{}{
			"logical_product_name": "invoicing_apim",
			"region":               "westus ",
			"class_env":            "dev ",
			"instance_env":         100,
			"cloud_resource_type":  "sa",
			"instance_resource":    1,
			"maximum_length":       26,
		},
	})

	terraform.InitAndApply(t, terraformOptions)

	defer terraform.Destroy(t, terraformOptions)

	lowerCase := terraform.Output(t, terraformOptions, "lower_case")
	lower_case_with_default_separator := terraform.Output(t, terraformOptions, "lower_case_with_separator")
	camel_case := terraform.Output(t, terraformOptions, "camel_case")
	camel_case_with_separator := terraform.Output(t, terraformOptions, "camel_case_with_separator")
	standard := terraform.Output(t, terraformOptions, "standard")
	upper_case := terraform.Output(t, terraformOptions, "upper_case")
	upper_case_with_separator := terraform.Output(t, terraformOptions, "upper_case_with_separator")

	assert.Equal(t, lowerCase, "invoicing_apimwestusdev100sa001")
	assert.Equal(t, lower_case_with_default_separator, "invoicing_apim-westus-dev-100-sa-001")
	assert.Equal(t, camel_case, "Invoicing_apimWestusDev100Sa001")
	assert.Equal(t, camel_case_with_separator, "Invoicing_apim-Westus-Dev-100-Sa-001")
	assert.Equal(t, standard, "invoicing_apim-westus-dev-100-sa-001")
	assert.Equal(t, upper_case, "INVOICING_APIMWESTUSDEV100SA001")
	assert.Equal(t, upper_case_with_separator, "INVOICING_APIM-WESTUS-DEV-100-SA-001")
}

func TestTerraformResourcenameExample_WithSeparator(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{

		TerraformDir: "../..",

		Vars: map[string]interface{}{
			"logical_product_name": "invoicing_apim",
			"region":               "westus ",
			"class_env":            "dev ",
			"instance_env":         100,
			"cloud_resource_type":  "sa",
			"instance_resource":    1,
			"maximum_length":       24,
			"separator":            ".",
		},
	})

	terraform.InitAndApply(t, terraformOptions)

	defer terraform.Destroy(t, terraformOptions)

	lower_case_with_default_separator := terraform.Output(t, terraformOptions, "lower_case_with_separator")
	camel_case_with_separator := terraform.Output(t, terraformOptions, "camel_case_with_separator")
	standard := terraform.Output(t, terraformOptions, "standard")
	upper_case_with_separator := terraform.Output(t, terraformOptions, "upper_case_with_separator")

	assert.Equal(t, lower_case_with_default_separator, "invoicing_apim.westus.dev.100.sa.001")
	assert.Equal(t, camel_case_with_separator, "Invoicing_apim.Westus.Dev.100.Sa.001")
	assert.Equal(t, standard, "invoicing_apim-westus-dev-100-sa-001")
	assert.Equal(t, upper_case_with_separator, "INVOICING_APIM.WESTUS.DEV.100.SA.001")
}

func TestTerraformResourcenameExample_minLength(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{

		TerraformDir: "../..",

		Vars: map[string]interface{}{
			"logical_product_name": "invoicing_apim",
			"region":               "westus ",
			"class_env":            "dev ",
			"instance_env":         100,
			"cloud_resource_type":  "sa",
			"instance_resource":    1,
			"maximum_length":       24,
			"separator":            ".",
		},
	})

	terraform.InitAndApply(t, terraformOptions)

	defer terraform.Destroy(t, terraformOptions)

	recommended_per_length_restriction := terraform.Output(t, terraformOptions, "recommended_per_length_restriction")

	assert.Equal(t, recommended_per_length_restriction, "invoiciwestusdev100sa001")
}

func TestTerraformResourcenameExample_maxLength(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{

		TerraformDir: "../..",

		Vars: map[string]interface{}{
			"logical_product_name": "invoicing_apim",
			"region":               "westus ",
			"class_env":            "dev ",
			"instance_env":         100,
			"cloud_resource_type":  "sa",
			"instance_resource":    1,
			"maximum_length":       512,
			"separator":            ".",
		},
	})

	terraform.InitAndApply(t, terraformOptions)

	defer terraform.Destroy(t, terraformOptions)

	recommended_per_length_restriction := terraform.Output(t, terraformOptions, "recommended_per_length_restriction")

	assert.Equal(t, recommended_per_length_restriction, "invoicing_apim-westus-dev-100-sa-001")
}
