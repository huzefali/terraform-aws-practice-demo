output "ECServerSecurityGroup" {
    description = "ec2 security group"
    value = aws_security_group.ECServerSecurityGroup.arn
}

output "EC2KeyPairID" {
    description = "ths is the ec2 key pair"
    value = aws_key_pair.ec2-key-pair.id
}

output "EC2InstancePublicIP" {
    description = "this is the public ip you will use for ssh"
    value = aws_instance.EC2Server.public_ip
}

output "KinesisArn" {
    description = "Kinesis data steam arn"
    value = aws_kinesis_stream.kinesisstream.arn
  
}

output "SNSArn" {
    description = "SNS alerting topics"
    value = aws_sns_topic.snstopic.arn
}

output "S3BucketArn" {
  description = "S3 Bucket Arn"
  value       = aws_s3_bucket.S3Bucket.arn
}

output "S3BucketObjectArn" {
  description = "S3 Bucket Object Arn"
  value       = "s3://${aws_s3_bucket.S3Bucket.bucket}/${aws_s3_object.S3BucketObject.id}"
}

output "DynamoDBArn" {
  description = "DynamoDB Arn"
  value       = aws_dynamodb_table.DynamoTable.arn
}