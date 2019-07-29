alias get_instance_ip="aws ec2 describe-instances --query 'Reservations[*].Instances[*].NetworkInterfaces[*].PrivateIpAddress' --output text --instance-ids"
alias get_instance_public_ip="aws ec2 describe-instances --query 'Reservations[*].Instances[*].NetworkInterfaces[*].Association.PublicIp' --output text --instance-ids"

get_instance () {
    aws ec2 describe-instances --query 'Reservations[*].Instances[*]' --instance-ids $* | jq '.'
}
