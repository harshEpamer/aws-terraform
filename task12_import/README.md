# Task 12 — Terraform Import (terraform import)

## Objective

Bring an existing AWS IAM policy under Terraform management using `terraform import`, without recreating or modifying the resource. After import, `terraform plan` must show no unexpected changes.

## What is Terraform Import?

When infrastructure exists in AWS but was created outside of Terraform (manually, via CLI, or by another tool), you can use `terraform import` to link the existing resource to a Terraform resource block. Terraform writes the resource into state so it can track and manage it going forward.

## Key Concepts

| Concept | Description |
|---|---|
| `terraform import` (CLI) | One-time CLI command: `terraform import <resource_address> <resource_id>` — imports a single resource. |
| `import` block (HCL, Terraform 1.5+) | Declarative import embedded in `.tf` code. Re-importable on every `terraform apply`. Better for team collaboration and re-verification. |
| Resource address | The Terraform reference to the resource, e.g., `aws_iam_policy.main`. |
| Import ID | The unique identifier AWS uses for the resource — for IAM policies this is the ARN. |
| State | After import, the resource appears in `.tfstate`. Subsequent plans compare state vs config. |

## Approach Used

This task uses a **declarative `import` block** (Terraform 1.5+) in `resources.tf`. The ARN is constructed dynamically using `data.aws_caller_identity` so it works across different AWS accounts without code changes.

```hcl
import {
  to = aws_iam_policy.main
  id = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/${var.policy_name}"
}
```

## Equivalent CLI Command

```bash
# Get the policy ARN
aws iam get-policy --policy-arn arn:aws:iam::$(aws sts get-caller-identity --query Account --output text):policy/cmtr-0g1jc0vy-iam-policy

# Import the policy
terraform import aws_iam_policy.main arn:aws:iam::<ACCOUNT_ID>:policy/cmtr-0g1jc0vy-iam-policy
```

## Workflow

```bash
# 1. Initialize with S3 backend
terraform init \
  -backend-config='bucket=cmtr-0g1jc0vy-backend-bucket-1780336887' \
  -backend-config='key=tf_code.tfstate' \
  -backend-config='region=eu-west-1'

# 2. Format and validate
terraform fmt
terraform validate

# 3. Apply (runs import block, imports policy into state)
terraform apply -auto-approve

# 4. Verify no changes
terraform plan
```

## Important Notes

- The `import` block runs as part of `terraform apply` — it reads the live AWS resource and writes it into state.
- After a successful import, `terraform plan` must output **No changes** — this confirms the `.tf` resource definition exactly matches what exists in AWS.
- If the resource definition does NOT match (e.g., different policy document or description), Terraform will propose changes. Adjust the config until plan shows no changes.
- The AWS resource is **never deleted or recreated** — only its state tracking is added to Terraform.
