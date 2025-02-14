terraform {
    backend "s3" {
        bucket = "bz-terraform-portfolio-project"
        key = "global/s3/terraform.tfstate"
        region = "us-west-1"
        dynamodb_table = "terraform-lock-file"
    }
}