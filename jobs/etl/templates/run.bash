#!/bin/bash

set -e -u -o pipefail
set -o posix
set -x

main() {
	PATH=/var/vcap/packages/awscli/bin:/var/vcap/jobs/etl/packages/gpdb/bin:${PATH}
	<% if_p('aws_access_key_id', 'aws_secret_access_key') do |access_key, serect_key| %>
    export AWS_ACCESS_KEY_ID=<%= access_key %>
  export AWS_SECRET_ACCESS_KEY=<%= secret_key %>
	<% end %>

	apt-get update -q && apt-get install -y git-core
	git clone git://192.168.50.1/workloads

	aws s3 cp s3://gporca-perf-bucket/tpch_1g.tar .

	psql -p 5432 -h <%= link('database').instances.first.address %> -U vcap template1 -c "select gp_opt_version();"
}

main "$@"
