
function X = bitsTo2PAM (bits)
  X=bits;
  ZeroIndices = find(~bits); % returns in the array, the indices of the zero bits
  OnesIndices = find(bits);  %returns in the array , the indices of the non zero (one) bits
  X(ZeroIndices) = 1 ;
  X(OnesIndices) = -1;
endfunction
