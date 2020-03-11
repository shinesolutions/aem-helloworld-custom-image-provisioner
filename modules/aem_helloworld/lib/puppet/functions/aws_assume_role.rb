#!/usr/bin/ruby

require 'aws-sdk-iam' # v3: require 'aws-sdk'
require 'aws-sdk-route53' # v3: require 'aws-sdk'
require "csv"

Puppet::Functions.create_function(:aws_assume_role) do

  dispatch :aws_assume_role do
    required_param 'Integer', :duration_time
    required_param 'String', :session_name
    required_param 'String', :region_name
    required_param 'Tuple', :assume_policy
  end

  def aws_assume_role(duration_time, session_name, region_name, assume_policy)

    puts "\nGathering credentials..."
    sts_client = Aws::STS::Client.new(region: region_name)
    resp = sts_client.get_caller_identity()
    role_name = resp.arn.split('/')[1]
    client = Aws::IAM::Client.new(region: region_name)
    iam_resp = client.get_role(role_name: role_name)

    role_arn = iam_resp.role.arn

    assume_doc = {
        "Version" => "2012-10-17",
        "Statement" => [
            {
                "Effect" => "Allow",
                "Action" => assume_policy,
                "Resource" => "*"
            }
        ]
    }.to_json

# Create a assume role.
    puts "\nCreating assume role..."
    assume_resp = sts_client.assume_role({
                                             duration_seconds: duration_time,
                                             policy: assume_doc,
                                             role_arn: role_arn,
                                             role_session_name: session_name, })

    puts resp.to_h
    access_key_id = assume_resp.credentials.access_key_id
    secret_access_key = assume_resp.credentials.secret_access_key
    session_token = assume_resp.credentials.session_token

# Create a credential.
    puts "\nCreating assume role credential..."
    role_credentials = Aws::Credentials.new(access_key_id, secret_access_key, session_token)

# Test a assume role with route53.
    puts "\nTest assumed route53 authority..."
    client = Aws::Route53::Client.new(region: region_name, credentials: role_credentials)
    route53_resp = client.list_hosted_zones_by_name()
    puts route53_resp.to_h

    CSV.open("/home/.assume_credential", "wb") do |csv|
      csv << ["access_key_id", access_key_id]
      csv << ["secret_access_key", secret_access_key]
      csv << ["session_token", session_token]
    end
  end
end
