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
Cost = Br/2 = 157/2 = 78.5

## Problem 3: Data structures

### a) Hash table with records stored in buckets.
Has no clustering

### b) Hash table with records stored in a heap, referenced by pointers in the buckets of the hash table.
Has clustering

### c) B-tree with the records stored in the leaves.
Has no clustering

### d) B-tree with leaves pointing to linked lists of records with the same key.
Has nothing

## Problem 4: Join optimization

```py
R(A,B)              S(B,C)
Tr = 1000000        Ts = 100000

Bs = Ts/100 = 1000 blocks
Br = Tr/20 = 50000 blocks
Ib = 500
```

### a) What is the output cost of computing R×S?

### b)What is the input cost of computing R×S if the available memory is M=100 blocks?

### c)Repeat b) for the case M=1000. Comment the result.

### d)What is the output cost for the natural join of R and S?

### e)What is the cost of computing R⋈S by the sort-join method, M=100 and M=1000?

### f)What is the cost of computing R⋈S based on a clustering index on S.B?
