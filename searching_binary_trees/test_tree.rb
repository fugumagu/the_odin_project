require_relative 'binary_tree.rb'


a = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26.27,28,29,30]
b = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
c = [42,34,80,69,74,39,64,99,30,26,40,31,37,47,76,44,75,10,43,58,9,29,3,67,91,56,48,81,13,38,0,17,8,79,73]

tree = BinaryTree.new(a)
#tree.breadth_first_search(10)
#tree.breadth_first_search(99)
#tree.depth_first_search(10)
#tree.depth_first_search(99)
tree.dfs_rec(99)