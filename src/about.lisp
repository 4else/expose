#|
AI:  something else you need to knwow

not what we are but what else can we be

got to know where you are and where else you can be

A bird in the hand is worth two in bush? really? 
there are 3 birds? and 67% of
them live in something called a bush?
If the world divides into places where
different birds  live and work live in different places, 
how to ensure that what
we build for (e.g.) the birds out of the bush, 
doesn't hurt everyone else?

There are issues of pressing current concern.
As more and more of the world is mitigated by softwre,
the choices within that software effect more and more
people. Sadly, there are too many recent examples
of software-bases inequities since
designers did not look far enough into
the choices of their tools

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


[^warn]: "Ignoring things outside XXX  rest" actually
means "ignoring a lot". 
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

| Class    | Algorithm  |
|----------|------------|
| learn    | clustering, contrasts, semi-supervised learning,            |
| optimize | sequential model optimization, parzen estimators, mutli-objective optimization| 

[^nw82]: A. Newell. The Knowledge Level. Artificial Intelligence, 18(1):87-127, 1982.
[^si96]: Simon, Herbert A. 1996. The Sciences of the Artificial (3rd ed.). Cambridge, MA: MIT Press.

|#
