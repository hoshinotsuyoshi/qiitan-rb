require 'ruboty/brains/base'
require 'ruboty/brains/memory'
require 'discovery_etcd_io_client'

module Ruboty
  module Brains
    class DiscoveryEtcdIo < Base
      KEY = 'brain'

      env :DISCOVERY_ETCD_IO_TOKEN, 'token of https://discovery.etcd.io/ (if not set, get a new token)', optional: true

      def initialize
        super
        @token = ENV['DISCOVERY_ETCD_IO_TOKEN'] || new_token
        @thread = Thread.new { sync }
        @thread.abort_on_exception = true
      end

      def data
        @data ||= pull || {}
      end

      private

      def client
        @client ||= DiscoveryEtcdIoClient.new(token: @token)
      end

      def new_token
        %x(curl -s https://discovery.etcd.io/new).split('/').last
      end

      def sync
        loop do
          sleep 5
          push
        end
      end

      def push
        client.set('/' + KEY, value: Marshal.dump(data))
      rescue Net::ProtocolError
      end

      def pull
        if str = client.get('/' + KEY).value
          Marshal.load(str)
        end
      rescue TypeError
      rescue Etcd::KeyNotFound
      rescue Net::ProtocolError
      end
    end
  end
end
