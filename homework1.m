N = 5 ;
dag = zeros(N,N) ;
A = 1 ; B = 2 ; C = 3 ; D = 4 ; E = 5 ;
% in this topological order it is important that parents of each node precedes i
dag(A,B) = 1 ; % i.e. A is a parent of B
dag(B,C) = 1 ; % i.e. B is a parent of C
dag(E,B) = 1 ; % i.e. E is a parent of B
dag(E,D) = 1 ; % i.e. E is a parent of D

discrete_nodes = 1 :N ; % in this example all nodes are discrete


node_sizes(1) = 2 ; % i.e. the node 1 (A) is binary
node_sizes(2) = 2 ; 
node_sizes(3) = 2 ;
node_sizes(4) = 2 ;
node_sizes(5) = 2 ; 
bnet = mk_bnet(dag, node_sizes, discrete_nodes) ;
names = {"A","B","C","D","E"};

carre_rond = [1,1,1,1,1];

draw_graph(bnet.dag,names,carre_rond);
title('gaph with complete data');
load dataComplete.txt;
nsamples = size(dataComplete,1);
bnet.CPD{A} =tabular_CPD(bnet,A);
bnet.CPD{B} =tabular_CPD(bnet,B);
bnet.CPD{C} =tabular_CPD(bnet,C);
bnet.CPD{D} =tabular_CPD(bnet,D);
bnet.CPD{E} =tabular_CPD(bnet,E);

bnet = learn_params(bnet,dataComplete');

CPT = cell(1,N);
for i = 1:N
    s= struct(bnet.CPD{i});
    CPT{i} = s.CPT;
end 

celldisp(CPT)









