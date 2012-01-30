module Fog
  module Parsers
    module Compute
      module AWS

        class DescribeInstanceTypes < Fog::Parsers::Base

          def reset
            @instance_types = {}
            @response = { 'instanceTypeSet' => [] }
          end

          def start_element(name, attrs = [])
            super
          end

          def end_element(name)
            case name
            when 'name'
              @instance_types['name'] = value
              # since name is already a reserved attribute in the model,
              # it cannot be used as an alias for id
              @instance_types['id'] = value
            when 'memoryMb', 'vcpus', 'diskGb', 'flavorId'
              @instance_types[name] = value
            when 'item'
              @response['instanceTypeSet'] << @instance_types
              @instance_types = { }
            when 'requestId'
              @response[name] = value
            end
          end
        end
      end
    end
  end
end
