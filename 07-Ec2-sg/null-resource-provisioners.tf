#Null resources and provisioners for additional Configurations

resource "null_resource" "bastion_provisioning" {

  depends_on = [module.ec2_instances]

  #Connection block
  connection {
    type        = "ssh"
    host        = module.ec2_instances.ec2_bastion_public_ip
    user        = "ubuntu"
    private_key = file("C:/Users/User.MDELPT11/Documents/study/keys/dev-ohio-learning-kp.pem")
  }

  #File provisioner: Copies the key.pem file to /tmp/dev-ohio-learning-kp.pem
  provisioner "file" {
    source      = "C:/Users/User.MDELPT11/Documents/study/keys/dev-ohio-learning-kp.pem"
    destination = "/tmp/dev-ohio-learning-kp.pem"
  }

  #Remote exec provisioner for grant permissions to key.pem
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/dev-ohio-learning-kp.pem"
    ]
  }

  # local-exec provisioner (Creation-Time Provisioner - Triggered during Create Resource)
  provisioner "local-exec" {
    command     = "Add-Content -Path 'creation-time-vpc-id.txt' -Value \"VPC create on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') and VPC ID: ${module.vpc.vpc_id}\""
    working_dir = "local-exec-outputs-files/"
    interpreter = ["PowerShell", "-Command"]
    #on_failure = continue
  }
}