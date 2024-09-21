#!/bin/bash

# Set AWS Region
REGION="us-east-1"  # Change to your desired region

# Delete EC2 Instances
echo "Deleting EC2 instances..."
INSTANCE_IDS=$(aws ec2 describe-instances --query "Reservations[*].Instances[*].InstanceId" --output text --region $REGION)
if [ -n "$INSTANCE_IDS" ]; then
    aws ec2 terminate-instances --instance-ids $INSTANCE_IDS --region $REGION
    echo "Terminating instances: $INSTANCE_IDS"
    aws ec2 wait instance-terminated --instance-ids $INSTANCE_IDS --region $REGION
else
    echo "No EC2 instances found."
fi

# Delete EBS Snapshots
echo "Deleting EBS snapshots..."
SNAPSHOT_IDS=$(aws ec2 describe-snapshots --owner-ids self --query "Snapshots[*].SnapshotId" --output text --region $REGION)
if [ -n "$SNAPSHOT_IDS" ]; then
    aws ec2 delete-snapshot --snapshot-id $SNAPSHOT_IDS --region $REGION
    echo "Deleted snapshots: $SNAPSHOT_IDS"
else
    echo "No EBS snapshots found."
fi

# Delete EBS Volumes
echo "Deleting EBS volumes..."
VOLUME_IDS=$(aws ec2 describe-volumes --query "Volumes[*].VolumeId" --output text --region $REGION)
if [ -n "$VOLUME_IDS" ]; then
    aws ec2 delete-volume --volume-id $VOLUME_IDS --region $REGION
    echo "Deleted volumes: $VOLUME_IDS"
else
    echo "No EBS volumes found."
fi

# Delete S3 Buckets
echo "Deleting S3 buckets..."
BUCKETS=$(aws s3api list-buckets --query "Buckets[*].Name" --output text)
for BUCKET in $BUCKETS; do
    echo "Emptying and deleting bucket: $BUCKET"
    aws s3 rm s3://$BUCKET --recursive --region $REGION
    aws s3api delete-bucket --bucket $BUCKET --region $REGION
done

# Delete CodeBuild Projects
echo "Deleting CodeBuild projects..."
CODEBUILD_PROJECTS=$(aws codebuild list-projects --query "projects[*]" --output text)
for PROJECT in $CODEBUILD_PROJECTS; do
    aws codebuild delete-project --name $PROJECT
    echo "Deleted CodeBuild project: $PROJECT"
done

# Delete CodeCommit Repositories
echo "Deleting CodeCommit repositories..."
CODECOMMIT_REPOS=$(aws codecommit list-repositories --query "repositories[*].repositoryName" --output text)
for REPO in $CODECOMMIT_REPOS; do
    aws codecommit delete-repository --repository-name $REPO
    echo "Deleted CodeCommit repository: $REPO"
done

# Delete CodePipeline Pipelines
echo "Deleting CodePipeline pipelines..."
PIPELINES=$(aws codepipeline list-pipelines --query "pipelines[*].name" --output text)
for PIPELINE in $PIPELINES; do
    aws codepipeline delete-pipeline --name $PIPELINE
    echo "Deleted CodePipeline: $PIPELINE"
done

echo "Cleanup completed."

