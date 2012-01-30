module Fog
  module Compute
    class AWS
      class Real

        require 'fog/aws/parsers/compute/describe_instance_types'

        # Describe all available instance types (also called flavors flavors).
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'requestId'<~String> - Id of request
        #     * 'instanceTypeSet'<~Array>:
        #       * 'name'<~String> - Name of flavor
        #       * 'memoryMb'<~Integer> - Memory size of flavor in Mb
        #       * 'vcpus'<~Integer> - Number of virtual cpus
        #       * 'diskGb'<~Integer> - Size of disk in Gb
        #       * 'flavorId'<~Integer> - Numeric identifier for flavor
        #
        # Nova api docs: [http://nova.openstack.org/devref/api.html]
        def describe_instance_types()
          request({
            'Action'    => 'DescribeInstanceTypes',
            :idempotent => true,
            :parser     => Fog::Parsers::Compute::AWS::DescribeInstanceTypes.new
          })
        end

      end

      class Mock

        def describe_instance_types()

          response = Excon::Response.new

          addresses_set = self.data[:addresses].values

          instance_types = [
              {'name' => 't1.micro', 'vcpus' => '1', 'memoryMb' => 200, 'diskGb' => 100, 'flavorId' => 1 },
              {'name' => 't1.small', 'vcpus' => '100', 'memoryMb' => 2000, 'diskGb' => 1000, 'flavorId' => 2},
          ]

          response.status = 200
          response.body = {
            'requestId'     => Fog::AWS::Mock.request_id,
            'instanceTypeSet'  => instance_types
          }

          response
        end
      end
    end
  end
end
