# Demystifying Privacy Preserving Computing

## Summary

This speaker presented several methods which can be used to conduct computations at scale on sensitive user data without exposing this data to anyone but the owner.

He was careful to distinguish privacy from protection, e.g. 

- Privatized data doesn't communicate sensitive information to anyone but, perhaps, the owner
- An attack could leak some data.  Hopefully it is privatized

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

