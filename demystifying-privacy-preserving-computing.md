# Demystifying Privacy Preserving Computing

## Summary

This speaker presented several methods which can be used to conduct computations at scale on sensitive user data without exposing this data to anyone but the owner.

He was careful to distinguish privacy from protection, e.g. 

- Privatized data doesn't communicate sensitive information to anyone but, perhaps, the owner
- Privatization doesn't protect data from attacks.  An attack could obviously steal some data.  Hopefully it is privatized.

## Resources

- Conference blurb: https://thestrangeloop.com/2022/demystifying-privacy-preserving-computing.html
- Speaker: Tejas Chopra
- Video

## Details

### Differential Privacy

This is the concept of adding noise to each individual's data which can be averaged out for the purpose of computations at scale.  The noise obscures any indivual's sensitive information but computations can still be performed because the noise averages out.  This is used at Apple, see three-page paper [here](https://www.apple.com/privacy/docs/Differential_Privacy_Overview.pdf).

The general idea is to add some random 'noise' to each data point so that individual queries are unlikely to learn anything.  Aggregations over large sets of data points can average out this noisy and provide good approximations of values, e.g. max salary in a population, etc.

This is tunable by an 'epsilon' parameter which controls the strength of the privacy.  As epsilon is increased, accuracy is increased but privacy is decreased.

The term 'differential' privacy comes from the fact that the mathematical definition involves comparing the results of this application to a data set, S1, and a copy of this set with one more data point.  Ideally, the answer to a question doesn't change much with the addition of a point and, hence, attackers find it hard to glean sensitive information.

Repeated queries can allow an attacker to determine this information, so a limit on queries is needed and this is called the 'privacy budget'.

This method doesn't work well for 'small' data sets.  The definition of small would vary, I think, according to the core calculation being performed.  In one [example](https://medium.com/georgian-impact-blog/a-brief-introduction-to-differential-privacy-eacf8722283b), a data set of 1800 points contained 3 for which a certain condition was true.  The 90% confidence interval for the result of the calculation was about 1.7 to 4.49, which is quite accurate compared to the range 1-1800.

You may ask: what is the purpose of such obfuscation, if the values are close to the truth?  If, for the same query, the answer is different depending on whether a point (or person) is / is not in the data set, then we have a handy way of determining their membership.  Consider:

- How many people have a credit score below 600, among all the encrypted scores in my set?
- How many people have a credit score below 600 if I remove one person?
  - If that answer changes, I know that person's credit score is below 600.

# Fully Homomorphic Encryption

Homomorphic encryption is the idea that we can perform some computations without every decrypting the input data - probably more computations than we think.

Suppose we were totaling some numbers.  What if we had functions such that:

```
encrypt(x + y) = encrypt(x) + encrypt(y)
```

If this were true, we could perform the addition without decrypting the values - meaning we could send encrypted data to another machine/function/actor for analysis and decrypt the results.

Obviously we'd need to define '+' for encrypted values.  However, it turns out that if we can define only a few such functions, we can build almost any other - much like building logic circuits from NAND gates.  In the talk, Tejas implied that if we had two functions that act like + and *, [we can define arbitrary circuits of unbounded depth](https://en.wikipedia.org/wiki/Homomorphic_encryption#Description).

There are libraries for this sort of thing, as [described in the wikipedia page](https://en.wikipedia.org/wiki/Homomorphic_encryption#Implementations).

# Secure Multiparty Computationa

Parties that jointly compute things may face the problem of sharing too much information with each other.  SMPC involves protocols which allow these inputs to be obscured or encrypted.  For example, suppose three people wish to agree on their average salary.

```==
joe:   100k
jim:   200k
jane:  300k
```

Rather than sending their salaries to each other, they break up their salary and each gets a piece.  They then sum the pieces.

At this point, no party has any information that can be used to reconstruct another's salary.

```
      joe   jim   jane
100    50    30     20
200   -80   100    180
300     0   350    -50

sums  -30   480    150
```

However, the 'meaningless' sums can be added together and divided to get the true sum and average (600 and 200).  Each party can share their sum with the others without leaking information.

## Resources

- https://inpher.io/technology/what-is-secure-multiparty-computation.  My example came from this high-level explanation.
- https://eprint.iacr.org/2017/1234.pdf is a white paper explaining the details
