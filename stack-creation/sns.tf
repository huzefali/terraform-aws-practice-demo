resource "aws_sns_topic" "snstopic" {
    name = "sns-demo-topic"
    display_name = "sns-demo-topic"
    tags = {
      "Name" = "sns-demo-topic-alerts"
    }
}
resource "aws_sns_topic_subscription" "snstopicsubscription" {
    topic_arn = aws_sns_topic.snstopic.arn
    protocol = "email"
    endpoint = "huzefa.i.rangwala@gmail.com"
}

