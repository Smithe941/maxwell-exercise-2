# frozen_string_literal: true

load 'store.rb'

store = Store.new

p 'Welcome to the store'
store.goods_list
p 'Add item IDs to cart separated with coma'
order = store.add_to_cart(gets.chomp)
store.print_result(order)
