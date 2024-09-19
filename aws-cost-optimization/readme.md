AWS Cloud Cost Optimization - Identifying Stale Resources

Problem:
There may be instances where a user takes an EBS snapshot of an active EC2 instance. If the EC2 instance is later terminated, it is the user's responsibility to delete the associated snapshot. However, if the user forgets to delete the snapshot, it will unnecessarily cost the organization.

Solution: 
In this project, we created a Lambda function that identifies EBS snapshots no longer associated with any active EC2 instances and deletes them to save on storage costs.

Approach: 
Write a Python code that serves as a Lambda handler. This Lambda function fetches all EBS snapshots owned by the same account ('self') and retrieves a list of active EC2 instances (both running and stopped). For each snapshot, it checks whether the associated volume (if it exists) is not linked to any active instance. If it finds a stale snapshot, it deletes it, effectively optimizing storage costs.

How to use:
1) Create a lambda function and use python as coding platform. 
2) Copy and paste the code from aws-stale-resources.py and paste it while reating lambda function.
3) Make sure to set up proper IAM permissions for your Lambda function to allow it to describe instances, describe snapshots, and delete snapshots.
4) You can adjust the Lambda timeout and memory settings based on your needs.

