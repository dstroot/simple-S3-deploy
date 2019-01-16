#!/bin/bash

# S3 bucket names must be unique
REGION=us-west-2
PROJECT=aws-s3-hosting
BUCKET=$PROJECT-90278

# Create bucket using cloudformation
aws cloudformation deploy                     \
    --template-file s3hosting.yaml    \
    --stack-name $PROJECT                     \
    --capabilities CAPABILITY_IAM             \
    --parameter-overrides Name=$BUCKET

# setup package.json to deploy
echo -e "\nAll done! Now add these lines to your package.json"
echo -e 'file in the "scripts" section:\n'

echo -e '---'
echo -e '"predeploy": "yarn build",'
echo -e '"deploy": "aws s3 sync build/ s3://'$BUCKET'"'
echo -e '---'

echo -e "\nThe hosting URL is:"
echo -e "http://"$BUCKET".s3-website-"$REGION".amazonaws.com\n"
