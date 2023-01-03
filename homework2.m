N = 6 ;
dag = zeros(N,N) ;
A = 1 ; B = 2 ; C = 3 ; D = 4 ; E = 5 ; F = 6 ;
% in this topological order it is important that parents of each node precedes i
dag(A,B) = 1 ; % i.e. A is a parent of B
dag(B,D) = 1 ; % i.e. B is a parent of D
dag(C,D) = 1 ; % i.e. C is a parent of D
dag(C,E) = 1 ; % i.e. C is a parent of E
dag(D,F) = 1 ; % i.e. D is a parent of F
discrete_nodes = 1 :N ; % in this example all nodes are discrete
node_sizes(1) = 2 ; % i.e. the node 1 (A) is binary
node_sizes(2) = 3 ; node_sizes(3) = 2 ;
node_sizes(4) = 2 ; node_sizes(5) = 3 ; node_sizes(6) = 2 ;
bnet = mk_bnet(dag, node_sizes, discrete_nodes) ; % defines preorder and postorder
%Definition of a priori and conditional probability distributions
bnet.CPD{A} = tabular_CPD(bnet, A, [0.6 0.4]) ; %[a1a2]
bnet.CPD{B} = tabular_CPD(bnet, B, [0.6 0.2 0.3 0.4 0.1 0.4]) ;
%[b1|a1b1|a2b2|a1b2|a2b3|a1b3|a2]
bnet.CPD{C} = tabular_CPD(bnet, C, [0.4 0.6]) ; %[c1c2]
bnet.CPD{D} = tabular_CPD(bnet, D, [0.9 0.7 0.25 0.6 0.2 0.05 0.1 0.3 0.75 0.4 0.8 0.95]) ;
%[d1|b1c1d1|b2c1d1|b3c1d1|b1c2d1|b2c2d1|b3c2d2|b1c1d2|b2c1d2|b3c1d2|b1c2d2|b2c2d2|b3c2]
bnet.CPD{E} = tabular_CPD(bnet, E, [0.85 0.1 0.1 0.2 0.05 0.7]) ;
% [e1|c1e1|c2e2|c1e2|c2e3|c1e3|c2]
bnet.CPD{F} = tabular_CPD(bnet, F, [0.85 0.85 0.15 0.15]) ; % [f1|d1f1|d2f2|d1f2|d2]
engine = pearl_inf_engine(bnet) ;
% engine relative to pearl algorithm
evidence = cell(1,N) ;
evidence{E} = 3 ; %i.e. E is initializes to e3
evidence{A} = 1 ; %i.e. E is initializes to a1
[engine, loglik] = enter_evidence (engine, evidence) ;
for i=1 :N % print results on screen
marg = marginal_nodes(engine, i) ;
BEL_Cdt=marg.T
end

for each class Ci do
Ei := Pi U Ni (Pi positive, Ni negative example)
RuleSet(Ci) := empty
repeat {find-set-of-rules}
    find-one-rule R covering some positive examples
    and no negative ones
    add R to RuleSet(Ki)
    delete from Pi all pos. ex. covered by R
until Pi (set of pos. ex.) = empty
Find one rule:
    Choosing a positive example called a seed.
    Find a limited set of rules characterizing
    the seed → STAR.
Choose the best rule according to LEF criteria.