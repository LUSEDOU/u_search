Criteria 1
    Criteria 1
Criteria 2
Criteria 3
    Criteria 1
    Criteria 2

Calification 1
    Calification 1
Calification 2
Calification 3
    Calification 1
    Calification 2


From
Node from Crit_1 Cali_1  _
    -> _1
        Node from Crit_1 Cali_1 _1
            -> _11
            -> Node Crit_1 Cal_1 _  _11
    -> Node Crit_1 Cal_1 [...] _1
Node from Crit_2 Cali_2 _
    -> _2
    -> Node Crit_2 Cal_2  _ _2
Node from Crit_3 Cali_3 _
    -> _3
        Node from Crit_1 Cali_1 _3
            -> _31
            -> Node Crit_1 Cal_1 _ _31
        Node from Crit_2 Cali_2 _3
            -> _32
            -> Node Crit_2 Cal_2 _ _32
    -> Node Crit_3 Cal_3 [...] _3

Save Score xyz
Node Save Score xyz
    [...] get x-> Node
        Node Save Score yz
            [...] get y-> Node
                Node Save Score z
                    [...] get z-> Node
                        Node Save Score _
                            -> Score
                        old = :Score * :Critera:percentage
                        new = ->Score * :Calification:percentage
                        -> old - new




