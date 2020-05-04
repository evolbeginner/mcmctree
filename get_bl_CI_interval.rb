#! /usr/bin/env ruby


#################################################
$DIR = File.dirname($0)
$: << File.join($DIR, 'lib')


#################################################
require 'getoptlong'
require 'bio'

require 'tree'


#################################################
infile = nil


#################################################
opts = GetoptLong.new(
  ['-i', GetoptLong::REQUIRED_ARGUMENT],
)


opts.each do |opt, value|
  case opt
    when '-i'
      infile = value
  end
end


#################################################
tree = getTreeObjs(infile).shift

a_tip = tree.allTips[0]

total_dist = tree.distance(tree.root, a_tip)


tree.internal_nodes.each do |node|
  dist = total_dist - tree.distance(tree.root, node)
  node_names = tree.twoTaxaNode(node).map{|i|i.name.gsub(' ', '_')}
  node_name = node_names.join('|')
  ci_interval = node.name.split('-').reverse.map{|i|i.to_f}.reduce(:-)
  node_name = node_name.size >= 90 ? node_name[0,30] : node_name
  puts [node_name, dist.round(3), ci_interval.round(3)].join("\t")
end


