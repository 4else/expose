#|

<img src="/etc/img/errors.jpeg" align=right width=300>

This book is about algorithms that seek
"something else"; i.e. that find things
that you should be seeing, but might be missing.


It is reversed engineered from 20 years of data mining,
hundreds of research papers, and the work of 20 Ph.D. students[^phd].

We offer those algorithms in   toolkit  that is remarkable small and fast. In less
than a thousand lines of code, these tools complete tasks 
that, elsewhere, have been explored as different things [^tasks]. Here,
we suggest that they are all aspects of one thing- a process we will
call _cluster and contrast_.

explanations algorithms, -- so [^soc]
much so that, possibly,
some prior work tried complex solutions, _without_
comparing them against something simpler.


[^tasks]: Classification and regression and planning and explanation;
  clustering; random projections;  feature selection;  instance selection; 
  tree-structured Parzen estimator, 
  semi-supervised learners, anomaly detectors,
  multi-objective optimization (including sequential model optimization) and hyper-parameter optimizers. 
  Do not be alarmed if you do not know what these are, yet.  You will.  

These pages offers  high-level notes on what is going
on here, plus some historical perspectives. 
To really get inside this material, I offer you two challenges:

1. Recode everything here  in your favorite language (a task that takes my students around seven weekly homeworks)
2. Do some of the [inclusiveness training exercises](include.md).

[^phd]: **Current:** Leonardo Arias, Joymallya Chakraborty, 
  Xiao Ling, Suvodeep Majumder, Andre Motta, Kewen Peng, 
  Rui Shu, Xueqi(Sherry) Yang, Rahul Yedida; 
  **Past:** Amritanshu Agrawal, Shrikanth Chandrasekaran, 
  Jianfeng Chen , Scott  Chen, Wei Fu, Ekrem Kocaguneli, 
  Joe Krall, Rahul Krishna, Vivek Nair, Ashutosh Nandeshwar, 
  David Owen, Fayola Peters, Abdel Salam Sayyad, Huy Tu, 
  Tianpei (Patrick) Xia, Zhe Yu. **Honorable Mentions**: 
  Gregory Gay.  Anything sensible in these pages  comes from them (and  all mistakes are mine).

## Seeking "Something Else"

I write algorithms that search large spaces of options looking for ways to satisfy,
as far as possible, a diverse set of goals.
Such algorithms may
may expose alarming dangers but they can also 
return surprising or delight results. 
They are nondeterministic algorithms, which is another way of saying they make lots of guesses.
Sure, that means they can make mistakes but it also means they can find their ways into corners
that are otherwise overlooked. As Vilfredo Pareto says:

> Give me the fruitful error any time, full of seeds, bursting with its own corrections. You can keep your sterile truth for yourself. 

Hence are tools
for planning how to improve things and for monitoring
what might make things worse. 

And  hopefully, they
will change what you think about the world
since, in this era of great change,
we should ask
"ask not what you can do to your data but what
your data can do for you".


to find and util"something else"
Suppose you wanted to teach responsible algorithm design to computer
scientists and software engineers. What would tell them?


Some say that a bird in the hand is worth two in bush. Really?
There are 3 birds? And 67% of them live in something called a bush?
If the world divides into places where different birds  live and
work live in different places, how can we  ensure that when we build
for (e.g.) the birds out of the bush, that does not hurt everyone
else?

There are issues of pressing current concern.  As more and more of
the world is mitigated by software, the choices within that software
effect more and more people. Sadly, there are too many recent
examples of software-bases inequities. In all those cases, designers
did not look far enough into the choices, and consequences, of their
tools. 

The good news is that
methods for mitigating [^mitigate]
those inequities are also useful for achieving
many other tasks as well.
In turns out that exploring more choices 
is important when designing any  system [^xu15]. Currently, designers
are overwhelmed by choices and fully 30% of errors in cloud
systems are due to poor configuration choices.  

[^mitigate]: We take care to say _mitigate_ and not _remove_.
Many inequities will continue until we repair the 
social, economic and political
forces created them [^no77]. Those repairs will
require extensive advocacy, years of work, and large
scale social and/or legislative change.
For example,

[^noblehow]: Noble (p179)[^no18] want to 
"decoupling of advertising and commercial interests 
from the ability to access high-quality information on the Internet", 
"suspend the circulation of racist and exist material that is used 
to erode our civil and human rights”; and require that all search results be color-coded to symbolize e.g.  pornography (in red), business or commercial material (in green),entertainment (in orange), etc [104, p179].


Nevertheless, there are many scenarios where machine learning
software has been found to be biased and generating arguably unfair
decisions. Google's sentiment analyzer model which determines
positive or negative sentiment, gives negative score to the sentences
such as _"I am a Jew", and "I am homosexual"_[^goo]. Facial recognition software
which predicts characteristics such as gender, age from images has
been found to have a much higher error rate for dark-skinned women
compared to light-skinned men [^bias]. A popular photo
tagging model has assigned animal category labels to dark skinned
people [^photos]. Recidivism assessment models used by
the criminal justice system have been found to be more likely to
falsely label black defendants as future criminals at almost twice
the rate as white defendants [^crims]. Amazon.com stopped
using automated job recruiting model after detection of bias against
women [^racist].
For other examples of
unfair decisions made by software.
see many other places including
Cathy O'Neil’s  _Weapons of Math Destruction_ [^maths]
and 
or  Safiya Umoja Noble's
book _Algorithms of oppression_ [^no18].


For example, the technology discussed
here has been used to mitigate for bias in decision making algorithms
[^joy20] _and also_ for improving text-based classifiers;
helping spacecraft land closer to target;
fixing bugs in space capsules about systems;
reducing the energy requirements of database systems;
configuring complex cloud-based computing; 
exploring options within software processes; 
etc; etc. 

pragmatics:
To address these issues, we need new processes
and the algorithms to support those processes.
An example search over all choices can be impractical.
Firstly, there may be too many choices.
Lutosa explores models of XXX softare process.
Valerdi notes how long it takes humans to recach
concensese.
Clearly,
Cant be constantly searching all the time- never 
get anything done (you can't grow the bush unless
you assume there is soil).
you need a  sampling policy (that does not take up
too many resources)
to know when you might want to change things. 

possibilites:
happily the world supports ways to do all the above.
Given $P$ possibilities, each with $N$ options,
the
space of reachable options is far smaller
than _N<sup>P</sup>_ hard.
For several years, I explored safety
critical properties of finite
state machines using
many randomly instances of
those machines [^b]. I stopped doing that
when a graph-theory specialist told me
"the real world is a special
case; most real world models live in a very small corner
of the total space of  possibilities". For example, 
there
are rocks and birds but no rocks have wings. 
Also,
just to take an example from software engineering,
Lutosa reports that 
in models with 128 binary options for organizing a software
development project, less than 3% of the 2<sup>128</sup>
of those options satisfy "sanity checks" that rule
our impossibilities.


[^warn]: "Ignoring things outside XXX  rest" actually means "ignoring a lot". 
[^b]: asdas

limits:
of course, all the above has limits.  any
representational system (including you and me)
uses that representation to summarize the world.
Those representations enable a set of
tricks to let us
reason faster; e.g. if we store  common
experiences and prune the rest, we can 

- search our memory faster. 
- raise an alert if something unusual happens (where
  "unusual" means something new arrives that is not in
  memory).

But while those tricks let us think faster, they
also can also drive thinking into little boxes from
which we never escape.
For example,
if we design for the bird in the hand, we may never
realize that the bush is a useful place
for hiding from predators.
So not only do need to study the space "inside the
box" (but looking for diverse places with the current
space), we also need to think out of the box
by seeking the "other voice":

- _Embrace diversity:_ Emphasis, not hide, differences. 
  Different viewpoints are fuel for thought: why
  waste that fuel? 
  Congitive walk throughs
   Burnett team differences.[^hiding] 
- _Outreach_: Do outreach beyond the current team and
staff the design team with
  persons from diverse backgrounds, empowered
  to make change in the design.
- _Tinkering_: 
  Try out the viewpoint of
  others while tinkering with the materials at
  hand-- not with the view to "change what is being
  built" but rather in order to "change the builder".
  When tinkering with data mining, do not ask "what can we do
  with the data" but "what can the data do to us".
  Seek the 
new insights that demand a revision
to how you (or your organization or society) approaches
its goals (perhaps even changing those goals).

[^hiding]: Caveat. Respect privacy. 

Fortunately, there 
are So all the above must
come with a label "handle with care" and 

After decades of research, can we simplify AI?  What can we do _now_
that clarifies, generalizes and simplifies what we were doing _then_?
And what do we know _now_ that means we have to change what we do
in the _future_?

To answer that question, we start with Allen Newell's [^nw82] 1981
idea of the  _Knowledge Level_.  According to Allen, intelligent
agents chooses actions that, they think, take them closer to their
goals.  Conceptually, these means they walk a directed graph where
each edge is a possible choice of what to do each node.  That
structure might be too large to enumerate and, truth to tell, an
agent may only have access to some small part of that graph. Hence,
one of the agent's tasks is to _learn_ what it can about that the
space of choices that surround it.

Under the hood of the knowledge level, is the symbol level.  Here,
the knowledge level agent stores all its tools and tricks needed
to make everything run. This could be logical theorem provers,
Python scripts, steam engines, whatever is needed to make the
knowledge-level execute.  The knowledge level rationalizes the
agent's behavior, while the symbol level mechanizes the agent's
behavior.  Our claim, to be defended below, is that a very small
number of data miner operators can serve as the symbol-level for a
wide range of knowledge-level tasks.

Herbert Simon [^si96] has more to say choices:

- The real result of our (choices) is to establish initial conditions
  for the next succeeding stage of (choices). What we call "final"
  goals are in fact criteria for choosing the initial conditions that
  we will leave to our successors...  One desideratum would be a world
  offering as many (choices) as possible to future decision makers,
  avoiding irreversible commitments that they cannot undo.



 For example, in a computer program, the knowledge level consists of the information contained in its data structures that it uses to perform certain actions. The symbol level consists of the program's algorithms, the data structures themselves, and so on.


[^ad21]: K. Adams, [_Timnit Gebru envisions a future for smart, ethical AI_](https://www.marketplace.org/shows/marketplace-tech/timnit-gebru-envisions-a-future-for-smart-ethical-ai/) MarketplaceTech, 2021

[^no77]: D. Noble, _American By Design_. Knopf, 1977.

[^no18]: S.U.Noble, _Algorithms of Oppression_.    New York University Press, 2018. 

[^nw82]: A. Newell. The Knowledge Level. Artificial Intelligence, 18(1):87-127, 1982.

[^si96]: Simon, Herbert A. 1996. The Sciences of the Artificial (3rd ed.). Cambridge, MA: MIT Press.

[^soc]: The Social Dilemma, 2020, Docudrama directed by Jeff Orlowski; written by Jeff Orlowski, Davis Coombe, and Vickie Curtis. 

[^xu15]: Tianyin Xu, Long Jin, Xuepeng Fan, Yuanyuan Zhou, Shankar Pasupathy, and Rukma Talwadker. 2015.  [Hey, you have given me too many knobs!: understanding and dealing with over-designed configuration in system software](https://cseweb.ucsd.edu/~tixu/papers/fse15.pdf).  FSE 2015.

[^goo]: [Google’s sentiment analyzer thinks being gay is bad](https://bit.ly/2yMax8V), Motherboard, Oct 2017. 

[^bias]: [Study  finds  gender  and  skin-type  bias  in  commercial  artificial-intelligence  systems](https://bit.ly/2LxosK6), Feb 11m 2018,  Larry Hardesty,  MIT News.

[^photos]: [Google  apologizes  for  mis-tagging  photos  of  african  americans](https://cbsn.ws/2LBYbdy)  July  2015

[^crims]: [Machine  bias,”www.propublica.org,  May  2016](https://www.propublica.org/article/machine-bias-risk-assessments-in-criminal-sentencing)

[^racist]: [Amazon  just  showed  us  that  ’unbiased’  algorithms  can  be  inadvertently  racist](https://www.businessinsider.com/how-algorithms-can-be-racist-2016-4), Apr 21, 2016, Insider Magazine, Rafi Letzter.

[^maths]: C. O’Neil, _Weapons of Math Destruction_. Crown Publishing Group, 2016


|#
