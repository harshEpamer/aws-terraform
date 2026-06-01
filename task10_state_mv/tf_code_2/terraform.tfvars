aws_region = "eu-west-1"

project_id = "cmtr-0g1jc0vy"

policy_name = "resource-move-demo-policy"

policy_description = "Custom role with limited permissions"

policy_document = "{\"Statement\":[{\"Action\":[\"ec2:*\",\"s3:*\"],\"Effect\":\"Allow\",\"Resource\":\"*\"}],\"Version\":\"2012-10-17\"}"
