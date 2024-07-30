##################################################################
#_____ PROVIDER _________________________________________________#
##################################################################
aws_configs = {
  region = "us-west-2"
  tags = {
    "owner"      = "carlossfb"
    "managed-by" = "terraform"
  }
}

##################################################################
#_____ INSTANCE _________________________________________________#
##################################################################
ec2 = [
  {
    name     = "teste"
    ami      = "ami-0575e37063e3ad6b4"
    key_name = "key"
    user_data = <<-EOF
    <powershell>
    Set-DefaultAWSRegion -Region "us-east-1"
    Initialize-AWSDefaultConfiguration -AccessKey 'your-access-key' -SecretKey 'your-secret-key'
    Read-S3Object -BucketName "your-bucket-name" -Key "installer.exe" -File "C:\\installer.exe"

    ${join("\n", [
      for arg in var.antivirus_install_args : "Start-Process '${arg.path}' -ArgumentList '${arg.arguments}' -Wait"
    ])}

    Remove-Item "C:\\installer.exe"
    </powershell>
  EOF
  }
]