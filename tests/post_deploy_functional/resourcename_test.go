// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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
			"logical_product_family":  "invoicing",
			"logical_product_service": "apim",
			"region":                  "westus ",
			"class_env":               "dev ",
			"instance_env":            100,
			"cloud_resource_type":     "sa",
			"instance_resource":       1,
			"maximum_length":          26,
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

	assert.Equal(t, lowerCase, "invoicingapimwestusdev100sa001")
	assert.Equal(t, lower_case_with_default_separator, "invoicing-apim-westus-dev-100-sa-001")
	assert.Equal(t, camel_case, "InvoicingApimWestusDev100Sa001")
	assert.Equal(t, camel_case_with_separator, "Invoicing-Apim-Westus-Dev-100-Sa-001")
	assert.Equal(t, standard, "invoicing-apim-westus-dev-100-sa-001")
	assert.Equal(t, upper_case, "INVOICINGAPIMWESTUSDEV100SA001")
	assert.Equal(t, upper_case_with_separator, "INVOICING-APIM-WESTUS-DEV-100-SA-001")
}

func TestTerraformResourcenameExample_WithSeparator(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{

		TerraformDir: "../..",

		Vars: map[string]interface{}{
			"logical_product_family":  "invoicing",
			"logical_product_service": "apim",
			"region":                  "westus ",
			"class_env":               "dev ",
			"instance_env":            100,
			"cloud_resource_type":     "sa",
			"instance_resource":       1,
			"maximum_length":          24,
			"separator":               ".",
		},
	})

	terraform.InitAndApply(t, terraformOptions)

	defer terraform.Destroy(t, terraformOptions)

	lower_case_with_default_separator := terraform.Output(t, terraformOptions, "lower_case_with_separator")
	camel_case_with_separator := terraform.Output(t, terraformOptions, "camel_case_with_separator")
	standard := terraform.Output(t, terraformOptions, "standard")
	upper_case_with_separator := terraform.Output(t, terraformOptions, "upper_case_with_separator")

	assert.Equal(t, lower_case_with_default_separator, "invoicing.apim.westus.dev.100.sa.001")
	assert.Equal(t, camel_case_with_separator, "Invoicing.Apim.Westus.Dev.100.Sa.001")
	assert.Equal(t, standard, "invoicing.apim.westus.dev.100.sa.001")
	assert.Equal(t, upper_case_with_separator, "INVOICING.APIM.WESTUS.DEV.100.SA.001")
}

func TestTerraformResourcenameExample_minLength(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{

		TerraformDir: "../..",

		Vars: map[string]interface{}{
			"logical_product_family":  "invoicing",
			"logical_product_service": "apim",
			"region":                  "westus ",
			"class_env":               "dev ",
			"instance_env":            100,
			"cloud_resource_type":     "sa",
			"instance_resource":       1,
			"maximum_length":          24,
			"separator":               ".",
		},
	})

	terraform.InitAndApply(t, terraformOptions)

	defer terraform.Destroy(t, terraformOptions)

	recommended_per_length_restriction := terraform.Output(t, terraformOptions, "recommended_per_length_restriction")

	assert.Equal(t, "invoicingapimdev100sa", recommended_per_length_restriction, "The output must be equal.")
}

func TestTerraformResourcenameExample_maxLength(t *testing.T) {

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{

		TerraformDir: "../..",

		Vars: map[string]interface{}{
			"logical_product_family":  "invoicing",
			"logical_product_service": "apim",
			"region":                  "westus ",
			"class_env":               "dev ",
			"instance_env":            100,
			"cloud_resource_type":     "sa",
			"instance_resource":       1,
			"maximum_length":          512,
			"separator":               "-",
		},
	})

	terraform.InitAndApply(t, terraformOptions)

	defer terraform.Destroy(t, terraformOptions)

	recommended_per_length_restriction := terraform.Output(t, terraformOptions, "recommended_per_length_restriction")

	assert.Equal(t, recommended_per_length_restriction, "invoicing-apim-westus-dev-100-sa-001")
}
