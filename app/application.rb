require 'pry'

class Application

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            search_item = req.path.split('/items/').last
            item_list_by_name = Item.all.map{|i| i.name}
            #binding.pry
            if item_list_by_name.include?(search_item)
                resp.write Item.all.find{|i| i.name == search_item}.price
            else
                resp.write "Item not found"
                resp.status = '400'
            end
        else
            resp.write "Route not found"
            resp.status = '404'
        end

        resp.finish
    end

end