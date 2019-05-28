A = [ 10  2  1;
       1  5  1;
       2  3 10 ];
       
MAXIT = 20;
       
B = [ 7;
     -8;
      6 ];

cA = columns(A);
rA = rows(A);
cB = columns(B);
rB = rows(B);

if cB != 1 || rB < 1
  error( "B has invalid size" );
endif

if cA < 1 || rA < 1 || rA!=cA
  error( "A has invalid size" );
endif
            
C = [ A B ];

#teste de convergencia da matriz A
if 1
  
  aux = sum( abs( A ),2 );
  
  for i = 1:rA
    
    #soma elementos da linha 'i'
    #para o modulo de cada linha, realiza-se a adiçao de todos os elementos dela,
    #exceto para os elementos da diagonal principal, e entao verifica-se 
    #se ela e´ menor que o elemento da diagonal que corresponde a a sua linha
    if ( aux( i ) - A( i, i ) ) > abs( A( i, i ) )
      
      error( "A does not converge" );
      
    endif;
    
  endfor
  
endif

D = A;
E = B;
sol = zeros(rA,1);
#isolando os valores C(i,i)
for i = 1:rA
  
  for j = 1:cA
    
    if i==j
      
      aux    = D(i,j);
      D(i,j) = E(i);
      E(i)   = aux;
      D(i,:) = D(i,:)/E(i);
      
    else
      
      D(i,j) = D(i,j)*(-1);
      
    endif      
    
  endfor
  
endfor

#solution vector
sol = diag(D)

for iteration = 1:MAXIT
  
  solprev = sol;
  sol = zeros(rA,1);
  
  for i = 1:rA
    
    for j = 1:cA
      
      if i==j
       
        sol(i) = sol(i) + D(i,j)
        
      else
        
        sol(i) = sol(i) + D(i,j)*solprev(j)
        
      endif
      
    endfor
    
  endfor

endfor