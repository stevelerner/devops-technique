#This example demonstrates infrastructure-as-code using Python methods to access AWS describing running instances
#by Steve Lerner steve@stevelerner.com


#boto3 is AWS's Python library
#pprint for prettyprint JSON results

import boto3
import pprint

ec2 = boto3.client('ec2')
response = ec2.describe_instances(
    Filters=[
        {
		'Name': 'instance-state-name',
                'Values': [
		'running'
                 ]
		
        }
    ]
)
pp = pprint.PrettyPrinter()
pp.pprint(response)
