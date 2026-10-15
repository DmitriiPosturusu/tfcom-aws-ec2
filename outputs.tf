output "instance_id" {
  description = "EC2 instance ID."
  value       = aws_instance.this.id
}

output "instance_arn" {
  description = "EC2 instance ARN."
  value       = aws_instance.this.arn
}

output "private_ip" {
  description = "Instance private IPv4 address."
  value       = aws_instance.this.private_ip
}

output "public_ip" {
  description = "Public IPv4 address, if allocated."
  value       = aws_instance.this.public_ip
}

output "public_dns" {
  description = "Public DNS name, if available."
  value       = aws_instance.this.public_dns
}
