data "archive_file" "lambda" {
  output_path = "./zips/package.zip"
  type = "zip"
  source_dir = "../app"
}


resource "aws_lambda_function" "example" {
  function_name = local.app_name
  handler = "app.handler"
  runtime = "nodejs12.x"
  role = aws_iam_role.lambda_exec.arn
  source_code_hash = data.archive_file.lambda.output_base64sha256
  filename = data.archive_file.lambda.output_path
  publish = true
}


resource "aws_iam_role" "lambda_exec" {
  name = "${local.app_name}-lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_policy" "lambda" {
  name        = "${local.app_name}-lambda"
  path        = "/"
  description = "IAM policy lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda.arn
}