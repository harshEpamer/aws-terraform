resource "aws_key_pair" "this" {
  key_name   = var.keypair_name
  public_key = var.ssh_key

  tags = {
    Name    = var.keypair_name
    Project = var.project_tag
    ID      = var.id_tag
  }
}
