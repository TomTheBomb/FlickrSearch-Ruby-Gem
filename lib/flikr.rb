##
#  @author     Thomas Rothwell <devnull@thomasrothwell.com>
#  @copyright  Copyright 2013. (http://thomasrothwell.com)
#  @license    MIT License (http://www.opensource.org/licenses/mit-license.php)
#  @version    1.0
#  
#  Based off: http://www.golygon.com/2010/10/ruby-on-rails-3-flickr-api-for-photo-search/
module FlikrSearch
    class Request
        # Flikr API Url
        @@uri = URI.parse("http://api.flickr.com/services/rest/")
    
        # Flikr API Key
        @@api_key = defined?(FLIKRSEARCH_API_KEY) ? FLIKRSEARCH_API_KEY : "825e43c19f429a0a6a114b1e62d2136c"
    
        def search (term = nil, page_number = 1, per_page = 100)
            params = {
                "method" => "flickr.photos.search", 
                "api_key" => @@api_key, 
                "per_page" => per_page, 
                "sort" => "relevance", 
                "media" => "photos", 
                "tags" => term,
                "page" => page_number,
            }
        
            http = Net::HTTP.new(@@uri.host, @@uri.port)
            request = Net::HTTP::Get.new(@@uri.path)
            request.set_form_data(params)

            # Instantiate a new Request object
            request = Net::HTTP::Get.new(@@uri.path+ "?" + request.body)
            response = http.request(request).body
        
            # Convert the response into a Hash for usability
            response = Hash.from_xml(response)
            return response["rsp"]
        end
    end
end
#url = “http://farm”+e.attributes['farm']+”.static.flickr.com/”+e.attributes['server']+”/”+e.attributes['id']+”_”+e.attributes['secret']+”.jpg”;
#puts FlikrSearch::Request.new.search('Pollenizer')
