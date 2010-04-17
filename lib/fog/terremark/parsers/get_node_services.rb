module Fog
  module Parsers
    module Terremark

      class GetNodeServices < Fog::Parsers::Base

        def reset
          @node_service = {}
          @response = { 'NodeServices' => [] }
        end

        def end_element(name)
          case name
          when 'Description', 'Href', 'Name', 'IpAddress'
            @node_service[name] = @value
          when 'Enabled'
            if @value == 'true'
              @node_service[name] = true
            else
              @node_service[name] = false
            end
          when 'Id', 'Port'
            @node_service[name] = @value.to_i
          end
        end

      end

    end
  end
end
