# frozen_string_literal: true

require 'yaml'

class Store
  GOODS = YAML.load_file('goods.yml')

  def goods_list
    p 'ID   NAME    PRICE'
    GOODS.each do |item|
      p "#{item[0]}   #{item[1]['name']}    #{item[1]['price']}"
    end
  end

  def add_to_cart(cart)
    calculate(cart.split(',').map(&:to_i))
  end

  def calculate(order)
    cart_info = { items: [], sum: 0, discount: 0 }
    order.each_with_object(Hash.new(0)) { |e, h| h[e] += 1 }.each do |item_id, quantity|
      next unless item = GOODS[item_id]

      price = item_price(item, quantity)

      cart_info[:items] << { name: item['name'], quantity: quantity, price: price}
      cart_info[:sum] += price.round(2)
      cart_info[:discount] += (quantity * item['price'] - price).round(2)
    end
    cart_info
  end

  def item_price(item, quantity)
    if item['sale_price']
      calculate_discount(item, quantity)
    else
      (quantity * item['price']).round(2)
    end
  end

  def calculate_discount(item, quantity)
    total_sale_price = (quantity / item['sale_quantity']) * item['sale_price']
    total_sale_price + ((quantity % item['sale_quantity']) * item['price']).round(2)
  end

  def print_result(result)
    str_length = 15
    p 'NAME'.ljust(str_length) + 'QUANTITY'.center(str_length) + 'PRICE'.rjust(str_length)
    p '-' * 15 * 3
    result[:items].each do |item|
      p "#{item[:name].to_s.ljust(str_length)}#{item[:quantity].to_s.center(str_length)}#{item[:price].to_s.rjust(str_length)}"
    end
    p "Total price #{result[:sum]}"
    p "You saved #{result[:discount]} today"
  end
end
