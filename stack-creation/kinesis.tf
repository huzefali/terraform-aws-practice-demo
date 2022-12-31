resource "aws_kinesis_stream" "kinesisstream" {
    name = "kinesis-demo-stream"
    shard_count = 2

    stream_mode_details {
        stream_mode = "PROVISIONED"
    }
    tags = {
        Name = "kinesis-demo-stream"
    }
}