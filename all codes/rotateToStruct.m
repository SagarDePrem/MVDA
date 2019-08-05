function  [T]=rotateToStruct(target,A)

[L4,T] = rotatefactors(A,'method','pattern','target',target);
end
