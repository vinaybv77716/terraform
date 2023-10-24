terraform{
backend "s3"{
bucket="mys3bucketforremotebackend"
region ="us-east-1"
key="vinay/terraform.tfstate"

}
}
