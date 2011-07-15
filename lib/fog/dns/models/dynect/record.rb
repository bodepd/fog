require 'fog/core/model'

module Fog
  module Dynect
    class DNS

      class Record < Fog::Model
        extend Fog::Deprecation

        identity  :id,          :aliases => 'record_id'
        attribute :name,        :aliases => 'fqdn'
        attribute :rdata
        attribute :serial_style
        attribute :ttl
        attribute :type,        :aliases => 'record_type'
        attribute :value

        def destroy
          requires :identity, :name, :zone
          connection.delete_record(zone.identity, name, identity)
          true
        end

        def save
          requires :name, :type, :value, :zone

          options = {
            :ttl => ttl
          }
          options.delete_if {|key, value| value.nil?}

          connection.post_record(type, zone.identity, name, {'address' => value}, options)
          true
        end

        def zone
          @zone
        end

        private

        def zone=(new_zone)
          @zone = new_zone
        end

      end

    end
  end
end
