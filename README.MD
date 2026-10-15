# Terraform AWS EC2 Instance Component

Reusable Terraform child module that launches **one EC2 instance** into an existing subnet with supplied security groups. It provisions an encrypted gp3 root disk and enforces IMDSv2 tokens.

## What it creates

- One `aws_instance`
- An encrypted gp3 root EBS volume managed as part of the instance

**Security default:** no public IP unless enabled. The component does not create networking or security groups; supply existing IDs. A public IP alone does not open inbound access: your security group rules control traffic.

## Requirements

- Terraform >= 1.13.5
- AWS provider >= 6.0.0 and < 7.0.0
- Existing subnet and security group IDs
- AMI compatible with the chosen instance type and Region

## Usage example

```hcl
module "instance" {
  source = "git::https://github.com/DmitriiPosturusu/terraform-aws-ec2-instance.git?ref=release/1.13.1.0"

  name               = "demo-instance"
  ami_id             = "ami-REPLACE_WITH_VALID_AMI_ID"
  instance_type      = "t3.micro"
  subnet_id          = aws_subnet.public.id
  security_group_ids = [aws_security_group.instance.id]

  associate_public_ip_address = false
  root_volume_size           = 8
  tags                       = { Environment = "demo" }
}
```

See [`examples/basic`](examples/basic) for an example using an Amazon Linux 2023 AMI lookup. That example expects IDs of a subnet and security group you already created.

## Inputs

| Input | Type | Default | Description |
| --- | --- | --- | --- |
| `name` | `string` | required | Instance Name tag |
| `ami_id` | `string` | required | Region-specific AMI ID |
| `subnet_id` | `string` | required | Existing subnet ID |
| `security_group_ids` | `list(string)` | required | Existing security group IDs |
| `instance_type` | `string` | `"t3.micro"` | EC2 size |
| `associate_public_ip_address` | `bool` | `false` | Assign public IPv4 |
| `key_name` | `string` | `null` | Existing EC2 key pair name |
| `user_data` | `string` | `null` | Instance startup user data |
| `root_volume_size` | `number` | `8` | gp3 root volume size in GiB |
| `tags` | `map(string)` | `{}` | Resource tags |

## Outputs

- `instance_id`
- `instance_arn`
- `private_ip`
- `public_ip`
- `public_dns`

## Run the example

```bash
cd examples/basic
terraform init
terraform plan -var='subnet_id=subnet-REPLACE' -var='security_group_ids=["sg-REPLACE"]'
# Review the plan before applying.
terraform apply -var='subnet_id=subnet-REPLACE' -var='security_group_ids=["sg-REPLACE"]'
```

Use AWS credentials with appropriate permissions. EC2 and EBS resources incur charges. Replace `YOUR_ORG` with your Git host organization and publish a version tag before using the Git example.
