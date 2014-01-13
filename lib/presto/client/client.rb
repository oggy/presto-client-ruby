#
# Presto client for Ruby
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#
module Presto::Client

  require 'presto/client/models'
  require 'presto/client/query'

  class Client
    def initialize(options)
      @session = ClientSession.new(options)
    end

    def query(query, &block)
      if block
        q = Query.start(@session, query)
        begin
          yield q
        ensure
          q.close
        end
      else
        return Query.start(@session, query)
      end
    end
  end

  def self.new(*args)
    Client.new(*args)
  end

end
