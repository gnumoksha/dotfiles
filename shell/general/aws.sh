alias my_aws-list-all="aws --region us-east-1 ec2 describe-instances --query 'Reservations[].Instances[].[Tags[?Key==Name].Value | [0], InstanceId, Placement.AvailabilityZone, InstanceType, LaunchTime, State.Name, PublicDnsName]' --output table"

function my_aws-get-instance-output() {
	aws ec2 get-console-output --instance-id $1 --output text
}

#EOF
