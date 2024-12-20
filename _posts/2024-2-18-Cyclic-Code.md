---
title: Cyclic Code
data: 2024-2-18 10:40 +0800
categories: math
tag: encode decode
---

## Introduction

Example: Consider the binary code $C=\\{000, 110, 011, 101\\}$.
Firstly, this is a linear code for the sum of any two codewords
in $C$ is also in $C$. We can denote a codeword in $C$ by
$c=(c_1, c_2, c_3)$ where $c_i$ is either 0 or 1. Then the
significant property of cyclic code is tthat if $(c_1, c_2, c_3)\in C$,
we have $(c_3, c_1, c_2)$ is again a codeword in $C$.
And this is why code method called *Cyclic Code*.

**Definition (Cyclic Code)** A binary code is cyclic if it is a linear
[n, k] code and if for every codeword $(c_1, c_2, \dots, c_n)\in C$ we
also have that $(c_n, c_1, \dots, c_{n-1})$ is again a codeword in $C$.

## Polynomials over $\mathbb{F}_2$

Using polynomials to invast cyclic code would make things easy.
We use $\mathbb{F}_2\\{x\\}$ to denote the set of all polynomials

$$
a_0+a_1x+\dots+a_mx^m
$$

with $a_i\in\mathbb{F}_2$.

**Definition (Code Polynomial associated to a Cyclic Codeword)** For each
$a=(a_0, a_1, \dots, a_{n-1})$, $a$ is a codeword in a cyclic [n, k] code
$C$. Define the polynomial associated to $a\in C$ to be
$$a(x):=a_0+a_1x+\dots+a_{n-1}x^{n-1}\in\mathbb{F}_2[x]$$

Notice that the right cyclic shift (the shift in introduction) of $a(x)$
is $a_{n-1}+a_0x+a_1x^2+\dots+a{n-2}x^2{n-1}$. Compare these two polynomials,
it is clear that $xa(x)=a_{n-1}(x^n-1)+a_{n-1}+a_0x+\dots+a_{n-2}x^{n-1}$.
In other words,

$$
\begin{equation}
xa(x)\equiv a_{n-1}+a_0x+a_1x^2+\dots+a_{n-2}x^{n-1}\pmod{x^n-1}\label{eq:mod}\tag{1}
\end{equation}.
$$

## Constructing Cyclic Codes

First, consider the polynomial operations over the $\mathbb{F}_2$. Just
like number operation over $\mathbb{F}_2$, we need take the modulus 2
to the coefficients after normal operation.

For example:

$$
\begin{align}
(x^3+x)+(x+1)=&x^3+2x+1=x^3+1\\
(x^2+x)(x+1)=&x^3+2x^2+x+1=x^3+x+1\\
\frac{x^3+x^2+x}{x+1}=&x^2+1\dots -1=x^2+1\dots 1.
\end{align}
$$

Now, we can begin to constructe the cyclic code.

Assume a fixed $g(x)\in\mathbb{F}_2$ divide the polynomial $x^n-1$,
and the degree of $g(x)$ is $n-k$ for some $0\leq k\leq n$. And a
variable polynomial $\alpha$ with $deg(\alpha(x))<k$. Use $f(x)$ denote
the $g(x)\cdot\alpha(x)\bmod{x^n-1}$. Each $f(x)$ can be written as

$$
f(x)=a_0+a_1x+\dots+a_{n-1}x^{n-1}.
$$

Recall the follow equation

$$
\begin{align}
x\cdot f(x)=&a_0x+a_1x^2+\dots+a_{n-2}x^{n-2}+a_{n-1}x^{n-1}\\
=&a_{n-1}(x^n-1)+a_{n-1}+a_0x+\dots+a_{n-2}x^{n-1}\\
=&a_{n-1}(x^n-1)+h(x).
\end{align}
$$

We know that $f(x)$ is divisible by $g(x)$ and $g(x)$ divide $x^n-1$,
thus both $x\cdot f(x)$ and $a_{n-1}(x^n-1)$ are divisible by $g(x)$.
Hence $h(x)$, the right cyclic shift of $f(x)$, is divisible by $g(x)$.
Therefore we get follow theorem.

**Theorem (1)**: Fix an integer $n>1$. Let $g(x)\in\mathbb{F}_2$ divide
the polynomial $x^n-1$. Assume the degree of $g(x)$ is $n-k$ for some
$0\leq k\leq n$. COnsider the set of polynomials

$$
\mathcal{P_g}:=\{g(x)\cdot\alpha(x)\pmod{x^n-1}\mid\alpha(x)\in
\mathbb{F}_2\ with\ deg(\alpha(x))<k\}.
$$

Every code polynomial $f(x)\in\mathcal{P_g}$ can be written in the form

$$
f(x)=a_0+a_1x+\dots+a_{n-1}x^{n-1}.
$$

Then the set of all $\{a_0, a_1, \dots, a_n\}$
coming from $f(x)\in\mathcal{P_g}$ form a cyclic $[n, k]$ code.

So, we have proved that $g(x)$ could construct cyclic code, so it is called
generator polynomial, and next is to prove all cyclic codes are constructed
by $g(x)$.

**First, for every cyclic code $C$, the $g(x)$ with minimal degree
is unique.**

Assume distinct polynomials $g_1(x)\in\mathbb{F}_2$ and
$g_2(x)\in\mathbb{F}_2$ are the minimal degree generator polynomial in
cyclic code $C$. Then $g_1(x)-g_2(x)$ would have a smaller degree than
$g_1(x)$ or $g_2(x)$ since the coefficient of highest order of
$g_1(x)$ and $g_2(x)$ must be $1$. Recall the properties of cyclic code,
$\alpha(x)g_1(x)-\alpha(x)g_2(x)$ are also in $C$. Therefore,
$g_1(x)-g_2(x)$ is the generator polynomial of $C$. This is a
contradiction so the polynomial $g(x)$ of minimal degree must be unique.

**Secondly, if a cyclic code $C$ can be constructed by $g(x) via
Theorem(1), the $g(x)$ with minimal degree is unique.**

Assume $g(x)$ does not divide $x^n-1$. Thus

$$
x^n-1=g(x)\beta(x)+r(x),\qquad (\beta(x), r(x) \in \mathbb{F}_2[x])
$$

And $r(x)$ is remainder polynomial which must have degree smaller than
$g(x)$. Thus:

$$
\begin{align}
r(x)\equiv&-g(x)\beta(x)\pmod{x^n-1}\\
\equiv&g(x)\beta(x)\pmod{x^n-1}\\
\end{align}.
$$

In this case, $r(x)$ is a generator polynomial which is a constradiction.

In conclusion, we have theorem 2:

**Theorem (2):** Let $C$ be a cyclic code. Then there exists a
uniquely determined code polynomail $g(x)$ of minimal degree in $C$
which has the following properties.

> 1. $g(x)$ is unique;
> 2. $g(x)$ divides $x^n-1$;
> 3. The code $C$ can be constructed using $g(x)$ as in Theorem (1).

The polynomial $g(x)$ is called the generator polynomial for the code $C$.

## Example

If fix $n=7$, we have $x^7-1=(x-1)(x^3+x+1)(x^3+x^2+1)$.
Since we are in the binary finite field, rewrite the factorization
as $1+x^7=(1+x)(1+x+x^3)(1+x^2+x^3)$.

> - $g(x)=1, \qquad C=\mathbb{F}^7_2=[7, 7]\ code$
> - $g(x)=1+x, \qquad C=[7, 6]\ code$
> - $g(x)=1+x+x^3, \qquad C=[7, 4]\ code$
> - $g(x)=1+x^2+x^3, \qquad C=[7, 4]\ code$
> - $g(x)=(1+x)(1+x+x^3), \qquad C=[7, 3]\ code$
> - $g(x)=(1+x)(1+x^2+x^3), \qquad C=[7, 3]\ code$
> - $g(x)=(1+x+x^3)(1+x^2+x^3), \qquad C=[7, 1]\ code$
> - $g(x)=1+x^7, \qquad C=\{0000000\}=[7, 0]\ code$
