module Requestbin

    BASE_URL = "https://requestb.in/api/"
    API_VERSION = "v1"

    class Bins

        def create
            Bins.post_request('bins')
        end

        def get(bin_name)
            Bins.get_request(File.join('bins', bin_name.to_s))
        end

        def requests(bin_name)
            Bins.get_request(File.join('bins', bin_name.to_s, 'requests'))
        end

        def request(bin_name, request_name)
            Bins.get_request(File.join('bins', bin_name.to_s, 'requests', request_name.to_s))
        end

        private

        def self.post_request(route)
          request('POST', route)
        end

        def self.get_request(route)
            request('GET', route)
        end


        def self.request(method, route, data=nil, options=nil)
          path = path_for(route, options)
          uri = uri_for(path)
          method = method.upcase
          headers = header()
          res = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            case method
            when 'POST'   then request = Net::HTTP::Post.new(uri.request_uri, headers)
            when 'GET'    then request = Net::HTTP::Get.new(uri.request_uri, headers)
            else
              return {}
            end
            request.body = data unless data.nil?
            http.request request
          end
          parse_response(res)
        end

        def self.parse_response(response)
            begin
                [JSON.parse(response.body,  symbolize_names: true)].flatten.each do |json_object|
                    next if json_object.fetch(:body, '').empty?
                    json_object[:body] = JSON.parse(json_object[:body])
                end
            rescue JSON::ParserError => e
                response.body.is_a?(Array) ? response.body : {' ErrorCode' => -1 }
            end
        end

        def self.path_for(route, options)
            File.join('', API_VERSION, route.to_s) + (options.nil? ? '' : ('&' + options))
        end

        def self.uri_for(path)
            URI(File.join(BASE_URL, path))
        end

        def self.header
            { 'Content-Type' => 'application/json' }
        end
    end
end
