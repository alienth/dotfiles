alias get_instance_ip="aws ec2 describe-instances --query 'Reservations[*].Instances[*].NetworkInterfaces[*].PrivateIpAddress' --output text --instance-ids"
