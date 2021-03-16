# Algebraic Optimization exercises

## Problem 1: Selection optimization

```py
πA( σA=0 ∧ B=1 ∧ C>2 ∧ D=3( R ))

Tr = 10000
Br = 500
I = {50,10,20,100}
Ia = 50
```

### Option 1 - Cheapest
Cost = Br/Ia = 500/50 = 10

### Option 2
Clustering index on A not < =< => >

### Option 3
Works for B and D

CostB = T/(Ib) = 10000/(10) = 10000/10 = 1000

CostD = T/(Id) = 10000/(100) = 10000/100 = 100

### Option 4
Not isolated

### Option 5
Cost = Br = 500

### Option 6
Works on C

Cost = T/2 = 10000/2 = 5000

### Option 7
Cost = Tr = 10000

### Option 8
Cost >= Tr >= 10000


## Problem 2: Selection optimization

```sql
PERSONS( Cod, Name, Category, Dept, Building, Office );

SELECT Cod, Name
FROM Persons
WHERE Cod < 1000 AND Dept='DEEC'
```
```py
Tr = 10000
Tuple size t = 125
Block size b = 8000
Br = Tr/(t/b) = 10000/64 = 156.25 -> 157
```

Option 2 - clustering on Cod <
Cost = Br/2 = 157/2 = 78.5 -> 79

## Problem 3: Data structures

### a) Hash table with records stored in buckets.
Has clustering

### b) Hash table with records stored in a heap, referenced by pointers in the buckets of the hash table.
Has no clustering

### c) B-tree with the records stored in the leaves.
Depends

### d) B-tree with leaves pointing to linked lists of records with the same key.
Depends

## Problem 4: Join optimization

```py
R(A,B)              S(B,C)
Tr = 1000000        Ts = 100000

Bs = Ts/100 = 1000 blocks
Br = Tr/20 = 50000 blocks
Ib = 500
```

### a) What is the output cost of computing R×S?

Result = Br * Ts + Tr * Bs = 50000 * 100000 + 1000000 * 1000 = 6 * 10^9

### b)What is the input cost of computing R×S if the available memory is M=100 blocks?

M < Bs

Input = Bs + Br * Bs/(M - 1) = 1000 + 50000 * 1000/(100 - 1) = 506050.5 -> 506051

### c)Repeat b) for the case M=1000. Comment the result.

M == Bs

Input = Bs + Br = 1000 + 50000 = 51000

### d)What is the output cost for the natural join of R and S?

Cost = Tr * Ts/I = 1000000 * 100000/500 = 200000000

### e)What is the cost of computing R⋈S by the sort-join method, M=100 and M=1000?

Cost = 2 * Br * logM(Br) + 2 * Bs * logM(Bs) + Br + Bs + (Br * Ts + Tr * Bs)/I

M = 100

Cost = 2 * 50000 * log100(50000) + 2 * 1000 * log100(1000) + 50000 + 1000 + 12 000 000
Cost = 12288948.5 -> 12288949

M = 1000

Cost = 2 * 50000 * log1000(50000) + 2 * 1000 * log1000(1000) + 50000 + 1000 + 12 000 000
Cost = 12209632.33 -> 12209633

### f)What is the cost of computing R⋈S based on a clustering index on S.B?

Cost = Br + Tr * Bs/I + (Br * Ts +Tr * Bs)/I

Cost = 50000 + 1000000*1000/500 + 6 * 10^9 / 500 = 14050000

## Problem 5: Join optimization
```py
R(A,B,C), S(C,D,E), T(E,F)
Tr = 1000
Ts = 1500
Tt = 750
```
### a)Assume that the primary keys are respectively A, C and E. Estimate the size of the join R ⋈ S ⋈ T and suggest an efficient strategy for its computation.

R ⋈ S

Size: 0 <= N <= 1000

(R ⋈ S) ⋈ T

Size: 0 <= N <= 1000


### b)Assume that there are no primary keys (apart from the complete relation) and that the image sizes of the attributes are: R.C-900,  S.C-1100,  S.E-50,  T.E-100. Estimate the size of the join R ⋈ S ⋈ T and suggest an efficient strategy for its computation.

R ⋈ S

R.C = 900

S.C = 1100

Size: 0 <= N <= 900

(R ⋈ S) ⋈ T

T.E = 100

S.E = 50

Size: 0 <= N <= 50

900/50 = 18



## Problem 6: Join optimization
```py
R(A,B,C)   S(B,C,D)
Tr = 1000000
Ts = 100000

Block size -> 20 R or 100 S records

Irb = 100
Isb = 200
Irc = 50
Isc = 10

Br = Tr/20 = 50000
Bs = Ts/100 = 1000
```
### a)Estimate the cost of computing the natural join by the sort-join method.

> Don't know

## Problem 7: Join optimization

### a)R.B < S.B

### b)R.B <> S.B

## Problem 8: Algebraic manipulation
```py
πS(E1-E2) = πS(E1) -   πS(E2)
```

It is only valid if E1 and E2 have the same columns (attributes, size, etc.)