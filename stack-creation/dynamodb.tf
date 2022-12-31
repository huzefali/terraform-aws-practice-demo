resource "aws_dynamodb_table" "DynamoTable" {
    name = "dynamo-demo-data"
    billing_mode = "PROVISIONED"
    read_capacity  = 5
  write_capacity = 5
  hash_key       = "deviceid"
  range_key      = "timestamp"

  attribute {
    name = "deviceid"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "S"
  }
  tags = {
    "Name" = "dynamo-demo-data"
  }
}