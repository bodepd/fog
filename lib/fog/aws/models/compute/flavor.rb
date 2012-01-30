require 'fog/core/model'

module Fog
  module Compute
    class AWS

      class Flavor < Fog::Model

        identity :id,     aliases => 'name'

        attribute :bits
        attribute :cores, aliases => 'cores'
        attribute :disk,  aliases => 'diskGb'
        attribute :name
        attribute :ram,   aliases => 'memoryMb'

      end

    end
  end
end
