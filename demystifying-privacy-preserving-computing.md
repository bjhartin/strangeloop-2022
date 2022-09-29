# Demystifying Privacy Preserving Computing

## Summary

This speaker presented several methods which can be used to conduct computations at scale on sensitive user data without exposing this data to anyone but the owner.

He was careful to distinguish privacy from protection, e.g. 

- Privatized data doesn't communicate sensitive information to anyone but, perhaps, the owner
- Privatization doesn't protect data from attacks.  An attack could obviously steal some data.  Hopefully it is privatized.

## Resources

- Conference blurb: https://thestrangeloop.com/2022/demystifying-privacy-preserving-computing.html
- Speaker: Tejas Chopra
- Video: TBD
- [The Rise of Fully Homomorphic Encryption](https://queue.acm.org/detail.cfm?id=3561800)
- https://inpher.io/technology/what-is-secure-multiparty-computation.  My example came from this high-level explanation.
- https://eprint.iacr.org/2017/1234.pdf is a white paper explaining the details
- [Is Homomorphic Encryption Ready to Deliver ...](https://www.techrepublic.com/article/is-homomorphic-encryption-ready-to-deliver-confidential-cloud-computing-to-enterprises)


## Details

### Differential Privacy

This is the concept of adding noise to each individual's data which can be averaged out for the purpose of computations at scale.  The noise obscures any indivual's sensitive information but computations can still be performed.  This is used at Apple, see three-page paper [here](https://www.apple.com/privacy/docs/Differential_Privacy_Overview.pdf).

Due to the noise, individual queries are unlikely to learn anything.  Aggregations over large sets of data points average out this noise and provide good approximations of values, e.g. max salary in a population, etc.

This is tunable by an 'epsilon' parameter which controls the strength of the privacy.  Accuracy grows with epsilon, but privacy diminishes.

The term 'differential' privacy comes from comparing the results computed from a data set, S1, with a copy of S1 having one more data point.  Ideally, this result is indistinguishable and hence, attackers find it hard to glean sensitive information.

Repeated queries can allow an attacker to determine this information, so a limit is needed, which is called the 'privacy budget'.

This method doesn't work well for 'small' data sets, depending on the core calculation being performed.  In one [example](https://medium.com/georgian-impact-blog/a-brief-introduction-to-differential-privacy-eacf8722283b), a data set of 1800 points contained 3 for which a certain condition was true.  The 90% confidence interval for the result of the calculation was about 1.7 to 4.49, which is quite close to 3, when compared to 1800.

You may ask: what is the purpose of such obfuscation, if the values are close to the truth?  Consider a situation in which the result is different between the set S1 and S1 + p1 (the additional data point).  If such is true, we know something about p!

- How many people have a credit score below 600, among all the encrypted scores in my set?
- How many people have a credit score below 600 if I add Joe Smith?
  - If that answer increases, I know Joe's credit score is below 600.

Restating things, this strategy prevents such 'differential' attacks by ensuring that the two answers are not distinguishable.

### Fully Homomorphic Encryption

Homomorphic encryption is the idea that we can perform some computations without decrypting the input data - probably more computations than we think.

Suppose we were totaling some numbers.  What if we had functions such that:

```
encrypt(x + y) = encrypt(x) + encrypt(y)
```

We could perform the addition without decrypting the values - meaning we could send encrypted data to another machine/function/actor for analysis and decrypt the results.

Obviously we'd need to define '+' for encrypted values.  However, it turns out that if we can define only a few such functions, we can build almost any other - much like building logic circuits from NAND gates.  In the talk, Tejas implied that if we had two functions that act like + and *, [we can define arbitrary circuits of unbounded depth](https://en.wikipedia.org/wiki/Homomorphic_encryption#Description).

There are different levels of homomorphism in this context: _partially_, _somewhat_, _leveled fully_ and _fully homomorphic_.  The level provided by a given encryption scheme will determine what kinds of things can be computed.  See the link below for more information.

There are libraries for this sort of thing, as [described in the wikipedia page](https://en.wikipedia.org/wiki/Homomorphic_encryption#Implementations).

### Secure Multiparty Computation

Parties that jointly compute things may face the problem of sharing too much information with each other.  SMPC involves protocols which allow these inputs to be obscured or encrypted.  Consider a trivial example where three people wish to jointly compute their average salary.


The actual salaries are:

```
joe:   100k
jim:   200k
jane:  300k
```

Each party desires to keep their salary secret, but wishes for their computed average to be confirmed by the other two party's computations.

Rather than sending their salaries to each other, they break up their salary and each gets a piece.  They then sum the pieces.  No party can reconstruct another's salary.

(all numbers are in thousands)

```
salaries                   joe   jim   jane
100  --- split into --->    50    30     20
200                        -80   100    180
300                          0   350    -50
```

The individual sums are then:

```
joe   jim   jane
-30   480    150
```

These 'meaningless' sums can be shared without information loss.  Each party can compute a true total (600k) and average (200k) of the salaries without actually knowing them.
