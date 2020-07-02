aws sagemaker create-transform-job --transform-job-name sklearn-byoc-inference-toolkit-016 \
    --model-name sklearn-byoc-inference-toolkit \
    --transform-resources InstanceType=ml.m5.large,InstanceCount=1 \
    --transform-input '{
        "DataSource": {
            "S3DataSource": {
                "S3DataType": "S3Prefix",
                "S3Uri": "s3://rajramch-sagemaker/byoc/transform/input"
            }
        },
        "ContentType": "text/csv"
    }' \
    --transform-output S3OutputPath=s3://rajramch-sagemaker/byoc/transform/output,Accept=application/json
