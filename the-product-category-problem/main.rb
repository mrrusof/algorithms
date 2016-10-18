#!/usr/bin/env ruby

class Product

  attr_reader :name
  attr_accessor :parent_categories

  def initialize name
    @name = name
    @parent_categories = []
  end

  def to_s
    @name
  end

  alias inspect to_s

  def categories
    @parent_categories.reduce [] do |acc, c|
      begin
        acc << c
        c = c.parent
      end while c
      acc
    end
  end

end

class Category

  attr_reader :name, :products, :children
  attr_accessor :parent

  def initialize name
    @name = name
    @products = []
    @children = []
    @parent = nil
  end

  def to_s
    name
  end

  alias inspect to_s

  def add_product p
    if @children.empty?
      @products << p
      p.parent_categories << self
    end
  end

  def add_category c
    if @products.empty? and not c.parent
      @children << c
      c.parent = self
    end
  end

  def all_products
    if @children.empty?
      @products
    else
      @children.reduce [] { |acc, c| acc.concat c.all_products }
    end
  end

end

# sandwich = Product.new 'sandwich'
# puts "sandwich = #{sandwich}"
# puts "[sandwich] = #{[sandwich]}"

# gsf = Category.new 'gas station food'
# puts "gsf = #{gsf}"
# puts "[gsf] = #{[gsf]}"

# gsf.add_product sandwich
# puts "gsf.products = #{gsf.products}"

# food = Category.new 'food'
# food.add_category gsf
# puts "food.children = #{food.children}"

# ff = Category.new 'fast food'
# gsf.add_category ff
# puts "gsf.children = #{gsf.children}"

# pizza = Product.new 'pizza'
# food.add_product pizza
# puts "food.products = #{food.products}"

# gsg = Category.new 'gas station goods'
# gsg.add_category gsf
# puts "gsg.children = #{gsg.children}"
# puts "gsf.parent = #{gsf.parent}"

# puts "sandwich.categories = #{sandwich.categories}"

# food.add_category ff
# ff.add_product pizza
# puts "food.all_products = #{food.all_products}"




food = Category.new 'food'
gsf = Category.new 'gas station food'
ff = Category.new 'fast food'
sandwich = Product.new 'sandwich'
pizza = Product.new 'pizza'

food.add_category gsf
food.add_category ff
gsf.add_product sandwich
ff.add_product pizza

puts "sandwich.categories = #{sandwich.categories}"
puts "pizza.categories = #{pizza.categories}"
puts "food.all_products = #{food.all_products}"
