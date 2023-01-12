N = 4 ;
dag = zeros(N,N) ;
C= 1 ; S = 2 ; R = 3 ; W = 4 ;
% in this topological order it is important that parents of each node precedes i
dag(C,S) = 1 ; % i.e. C is a parent of S
dag(C,R) = 1 ; % i.e. C is a parent of R
dag(S,W) = 1 ; % i.e. S is a parent of W
dag(R,W) = 1 ; % i.e. R is a parent of W

discrete_nodes = 1 :N ; % in this example all nodes are discrete


node_sizes(1) = 2 ; % i.e. the node 1 (A) is binary
node_sizes(2) = 2 ; 
node_sizes(3) = 2 ;
node_sizes(4) = 3 ;

bnet = mk_bnet(dag, node_sizes, discrete_nodes) ; % defines preorder and postorder

%Definition of a priori and conditional probability distributions
bnet.CPD{A} = tabular_CPD(bnet, A, [0.4 0.6]) ; %[a1a2]
bnet.CPD{S} = tabular_CPD(bnet, S, [0.8 0.7 0.2 0.3 ]) ;
bnet.CPD{R} = tabular_CPD(bnet, R, [0 0.8 1 0.2]) ; %[c1c2]
bnet.CPD{W} = tabular_CPD(bnet, W, [0.7 0.4 0.8 0.1 0.1 0.3 0.2 0.4 0.2 0.3 0 0.5]) ;
% engine relative to pearl algorithm
evidence = cell(1,N) ;
[engine, loglik] = enter_evidence (engine, evidence) ;
for i=1 :N % print results on screen
marg = marginal_nodes(engine, i) ;
BEL_Cdt=marg.T
end
engine = jtree_inf_engine(bnet); 
