#!/bin/bash

#Aws resoucre tracking script


echo `date +"%Y-%M-%d %T"`" - AWS resource tracking started" >> /k8sPractice/log.txt

#list aws s3 buckets
echo "Print list of s3 buckets"
aws s3 ls

#list aws ec2 instances 
echo "Print list of ec2 instances"
aws ec2 describe-instances


#list aws iam users
echo "Print list of iam users"

#list aws iam usernames
echo "Print list of iam usernames"
aws iam list-users | jq '.Users[].UserName'



