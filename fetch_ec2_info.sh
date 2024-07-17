#!/bin/bash



# AWS CLI command to describe EC2 instances
#aws ec2 describe-instances --query "Reservations[*].Instances[*].{InstanceID:InstanceId, Name:Tags[?Key=='Name'] | [0].Value, State:State.Name, PrivateIP:PrivateIpAddress, PublicIP:PublicIpAddress}" --output table
# Set your desired AWS region
REGION="us-east-2"
# AWS CLI command to describe EC2 instances
#aws ec2 describe-instances --query "Reservations[*].Instances[*].{InstanceID:InstanceId, Name:Tags[?Key=='Name'] | [0].Value, State:State.Name, PrivateIP:PrivateIpAddress, PublicIP:PublicIpAddress}" --output table
#!/bin/bash

# Set your desired AWS region
REGION="us-east-2"

# AWS CLI command to describe EC2 instances
aws ec2 describe-instances --region $REGION --query "Reservations[*].Instances[*].{InstanceID:InstanceId, Name:Tags[?Key=='Name'] | [0].Value, State:State.Name, PrivateIP:PrivateIpAddress, PublicIP:PublicIpAddress}" --output table

