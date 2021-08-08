module ApplicationHelper

    # def current_order
    #     if !session[:order_id].nil?
    #         Order.find(session[:order_id])
    #     else
    #         Order.new
    #     end
    # end
    
    def current_order
        if session[:order_id].nil? && user_signed_in? && current_user.orders != []
            #if there is no command and the user is logged in and user already has a current command
            Order.find(session[:order_id] = current_user.orders.last.id)
        elsif !session[:order_id].nil? && user_signed_in? && current_user.orders != [] && current_user.orders.last.id != session[:order_id]
            #if there is a current command and the user is logged in and the user already has a command and the id of his command is different from the id of the session
            current_user.orders.last.order_items += Order.find(session[:order_id]).order_items
            Order.find(session[:order_id]).destroy!
            Order.find(session[:order_id] = current_user.orders.last.id)
        elsif !session[:order_id].nil? && user_signed_in? && current_user.orders == [] && Order.find(session[:order_id]).user_id.nil?
            #if there is a current command and the user is logged in and the user has no command and the command does not have user_id
            pan = Order.find(session[:order_id])
            pan.user_id = current_user.id
            pan.save
            Order.find(session[:order_id])
        elsif !session[:order_id].nil?
            #if there is no user login but there is a command
            Order.find(session[:order_id])
        else
            Order.new
        end
    end
    
end
