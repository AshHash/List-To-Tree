{-+====================================================================================+--
--+-------------------------Tree and Associated Functions------------------------------+--
--+====================================================================================+--}

data Tree a = Nil | Leaf a | Node (Tree a) (Tree a)
 deriving Show


{-+------------------+--
--+--Helper Funtion--+--
--+------------------+-}
toTree [] _ _ str
    | str == "" = Nil
    | otherwise = Node (Leaf str) Nil
toTree ('[':xs) currentLevel treeLevel str
    | currentLevel==treeLevel = Node gs hs
    | otherwise = toTree xs currentLevel treeLevel str
        where gs = toTree xs (currentLevel+1)  (treeLevel+1) str
              hs = toTree xs (currentLevel)  (treeLevel+1) str
toTree (',':xs) currentLevel treeLevel str
    | currentLevel==treeLevel = if (str=="") then hs else (Node gs hs)
    | otherwise = toTree xs currentLevel treeLevel ""
        where gs = Leaf str
              hs = toTree xs currentLevel treeLevel ""
toTree (']':xs) currentLevel treeLevel str 
    | currentLevel == treeLevel = Node gs hs
    | otherwise = toTree xs (currentLevel) (treeLevel-1) ""
        where gs = Leaf str
              hs = Nil
toTree (x:xs) currentLevel treeLevel str = toTree xs currentLevel treeLevel (str++[x])


{-+----------------------------------+--
--+-Check if two trees are identical-+--
--+----------------------------------+-}
areIdentical Nil Nil = True
areIdentical Nil _ = False
areIdentical _ Nil = False
areIdentical (Node xs ys) (Node xs' ys')= (areIdentical xs xs') && (areIdentical ys ys')
areIdentical (Node xs ys) _ = False
areIdentical _ (Node xs' ys') = False
areIdentical (Leaf a) (Leaf b)
 | a==b = True
 | otherwise = False


{-+------------------+--
--+-Get left subtree-+--
--+------------------+-}
left (Node t s) = t
left (Leaf a) = Nil
left Nil = Nil

{-+-------------------+--
--+-Get right subtree-+--
--+-------------------+-}
right (Node t s) = s
right (Leaf a) = Nil
right Nil = Nil


{-+------------------+--
--+-Check if subtree-+--
--+------------------+-}
isSubtree Nil Nil = True
isSubtree Nil _ = False
isSubtree t s = if gs then gs else ((isSubtree (left t) s) || (isSubtree (right t) s))
    where gs = areIdentical t s


{-+-----------------------------------------+--
--+-Check if subtree and retrieve functions-+--
--+-to obtain this subtree form main tree---+--
--+-----------------------------------------+-}
isSubtreeFn Nil Nil f = (True,f)
isSubtreeFn Nil _ _ = (False,["id"])
isSubtreeFn t s f
    | gs == True = (gs,f) 
    | ((fst as)==True && (fst bs)==True) = (True,(snd as)++(snd bs))
    | (fst as) == True = as
    | (fst bs) == True = bs
    | otherwise = (False,["id"])
    where gs = areIdentical t s
          as = isSubtreeFn (left t) s (map ("head."++) f)
          bs = isSubtreeFn (right t) s (map ("tail."++) f)


{-+====================================================================================+--
--+----------------------------------List Functions------------------------------------+--
--+====================================================================================+-}


{-+------------------+--
--+-Any data to tree-+--
--+------------------+-}
elemToTree a = toTree p 0 0 ""
 where p = show a


{-+------------------+--
--+-Any list to tree-+--
--+------------------+-}
listToTree l = toTree (p (show l)) 0 0 ""
 where p = init.tail                        ----to remove first and last square braces


{-+------------------+--
--+-Check if subtree-+--
--+------------------+-}
isSublist xs ys = isSubtree (listToTree xs) (listToTree ys)


{-+----------------------+--
--+-Check if subtree and-+--
--+--Get function list---+--
--+----------------------+-}
isSublistFn xs ys = isSubtreeFn (listToTree xs) (listToTree ys) ["id"]