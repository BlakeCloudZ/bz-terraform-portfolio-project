terraform {
    backend "s3" {
        bucket = "bz-my-tf-website-state"
        key = "global/s3/terraform.tfstate"
        region = "us-west-1"
        dynamodb_table = "bz-my-db-website-table"
    }
}