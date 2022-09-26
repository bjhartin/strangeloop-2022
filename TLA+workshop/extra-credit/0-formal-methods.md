TLA+ is a *formal specification language*, which is a branch of *formal methods*, the discipline of producing provably correct code.

The field, very very roughly, is divided between people researching how to make *correct abstract models* of code and how to make *correct code*. The former has made more inroads in industry, while the latter has much more research and money invested. The difference in outcome is entirely explained by the fact that formally verifying code is *insanely, mindboggling hard*. It's like the difference between reaching the south pole and reaching the south pole of the moon.

(((
If you're interested in learning more about verifying code, you're in luck! Here are some Strange Loop talks to check out:

- https://www.thestrangeloop.com/2022/building-safety-critical-systems.html
- https://www.thestrangeloop.com/2022/formally-verifying-everybodys-cryptography.html
- https://www.thestrangeloop.com/2022/formal-modeling-and-analysis-of-distributed-systems-finding-critical-bugs-early.html

Also, check out my project Let's Prove Leftpad, where we collect proofs of leftpad in different styles. https://github.com/hwayne/lets-prove-leftpad 
)))

People were messing with formal specification in the late 1960s, it really Becomes A Thing in the late 1970's, which saw:

- Pneulli's Linear Temporal Logic (LTL)
- Tony Hoare's Communicating Sequential Processes
- Jean-Raymond Abrial's Z.

Z was a big deal because it was "polished" in a way notations before weren't. It wasn't just a set of mathematical rules, but an entire framework for specifying systems. The hope was it could be used by actual software engineers to build actual software. Unfortunately Z was still very complicated, and also getting anyone to do anything is harder than pulling teeth. Later descendants of Z, like B and Alloy, are much simpler. TLA+ was originally intended as a way of unifying LTL and Z, a proposal that was ultimately rejected by the Z committee. 

TLA+ came out in 1994, and the first model checker is from 1999.
