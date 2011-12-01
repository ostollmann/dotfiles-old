---
layout: post
title: Analysing logs with simple UNIX commands
---

{{ page.title }}
================

*Note: I am a by no means a UNIX expert. I use these kind of command combinations rarely, so I am sure that there are a hundred and one better ways of doing this.*

For my bachelor thesis I developed a [MATLAB](http://www.mathworks.com/) program that takes a [Simulink](http://www.mathworks.com/products/simulink/index.html) model and extracts a [POMDP](http://en.wikipedia.org/wiki/Partially_observable_Markov_decision_process) from it. The program does this by simulating the model tens of thousands of times and looking at the model output to build a [state-space](http://en.wikipedia.org/wiki/State_space_(controls%29), an observation-space, a [transition probability matrix](http://en.wikipedia.org/wiki/Stochastic_matrix), an observation probability matrix and a [reward model](http://en.wikipedia.org/wiki/Mathematical_optimization).

I won't go into the details here, but one of the challenges of this is that neither the state-space nor the observation-space are known before hand. The model runs [initial discovery](http://en.wikipedia.org/wiki/Artificial_intelligence#Learning) simulations and then uses those intitial states to run the actual simulations. While it does this it constantly finds new states and observations that are then also used as a starting point for further simulations. That's all I am going to say for now (I will write a more detailed post about the whole project later, but I first have to see how much I can even say about it because some [industrial partners](http://www.abb.ch/) are involed).

In any case the important thing here is that because the extraction takes [multiple days](http://en.wikipedia.org/wiki/Combinatorial_explosion) and the end time is not defined (the model keeps growing) it is hard to keep track of what is going on. So today I thought I would see how much I can extract from the log file that the program continuously writes to. Let's get into it.

I don't think MATLAB offers an internal logging interface, so I wrote my own (bare-bones). It produces output like this:

<pre>
DEBUG [2011-12-05 19:49:22.639]: TP(326,395,74)=1.000000
DEBUG [2011-12-05 19:49:22.640]: R(326,395,74)=160.066821
DEBUG [2011-12-05 19:49:28.669]: TP(326,396,75)=1.000000
DEBUG [2011-12-05 19:49:28.670]: R(326,396,75)=167.133028
DEBUG [2011-12-05 19:49:28.673]: TP(326,1,76)=1.000000
DEBUG [2011-12-05 19:49:28.673]: R(326,1,76)=-Inf
DEBUG [2011-12-05 19:49:28.675]: TP(326,1,77)=1.000000
DEBUG [2011-12-05 19:49:28.676]: R(326,1,77)=-Inf
</pre>

The only lines that we will look at here are the ones that show an update of the transition probability matrix and the reward matrix. The format is `TP(source-state,sink-state,action)=value` and `R(source-state,sink-state,action)=value`. Here is a quick example of a transition probability matrix update:

<pre>
DEBUG [2011-12-05 19:49:22.639]: TP(326,395,74)=1.000000
</pre>

The above line means that the transition probability of going to state 395 given that we are now in state 326 and we take action 74 is 1. *You may be suprised by that fact that all transition probabilities here are 1, as this means that a certain action from a given state will always lead to the same sink state. This is because the model I am currently extracting from is completely deterministic.*

So here a few things that I wanted to know from the log file and I how I extracted that information:

First: **How many states has the extractor discovered?**

{% highlight bash %}
cut -d " " -f 4- $1 | grep TP | cut -d "," -f 2 | sort -n | uniq | tail -n 1
{% endhighlight %}

What we do here is cut the lines (getting only the stuff we are interested in), then grepping for lines containing the term 'TP', sorting the lines in ascending order, skipping duplicate lines (not really necessary) and finally taking the last line. *The double `cut` is redundant so I should really fix that, but I can't be bothered.*

Second: **How many simulations have run?**

{% highlight bash %}
cat $1 | grep "TP(.*,.*,.*)" | wc -l
{% endhighlight %}

This command is even simpler, it merely counts the number of line that contain the string 'TP'. Every simulation sets a single transition probability value, so this is an accurate way of getting the total number of simulations.

Third: **How many errors have occured?**

{% highlight bash %}
cat $1 | grep "TP(.*,1,.*)" | wc -l
{% endhighlight %}

This line might no make sense immediately, but it's pretty simple. We are grepping for any tranition probability update that sets a probability value for some state and some action going to sink state 1. We can do this because state 1 is the error state. If the simulation crashes (invalid input, boundary errors, etc) I say taking that action from that source state leads to the error state. So by counting the updates of probabilities reaching the error state we know the number of simulation errors that occurred.

Fourth: **What's the average reward?**

Every transition probability is associated with a reward. This reward is the average of all rewards that we got for the given source state, action and sink state. We can see the reward value being set like this `R(source-state,action,sink-state)=reward`.

{% highlight bash %}
 cat $1 | grep "R(" | cut -d "=" -f 2 | grep -v "Inf" | awk \
    '{ sum+= $1 ; rowcnt++} END {printf("%.2f\n",sum/rowcnt) }' -
{% endhighlight %}

This line is the most complicated as it uses an inverse grep and awk. In some cases the reward is set to negative Infinity: `-Inf`. This is not really a useful value and it serves mainly as a placeholder. We certainly can't use it when computing our average reward. So we remove lines containing 'Inf'. Then we sum all the values and finally divide the sum by the number of rows (which awk also keeps track of here).

Finally: **putting it all together!**

{% highlight bash %}

NUM_STATES=$(util/num_states.sh $1)
NUM_SIMS=$(util/num_sims.sh $1)
NUM_ERRS=$(util/num_errors.sh $1)

PERC_ERRS=$((100*NUM_ERRS/NUM_SIMS))

AVG_REWARD=$(util/avg_reward.sh $1)

echo "Extraction statistics:"
echo ""
echo " - number of states:        $NUM_STATES"
echo ""
echo " - number of simulations:   $NUM_SIMS"
echo " - number of errors:        $NUM_ERRS"
echo " - percentage errors:       $PERC_ERRS%"
echo ""
echo " - average reward:          $AVG_REWARD"
{% endhighlight %}


As you can see above all these command are in simple files which I then call in this script. You can run this script manually, but what I do is I run it every two seconds in a small [tmux](http://tmux.sourceforge.net/) pane next to the simulation log output using the very very useful `watch` command:

{% highlight bash %}
watch simdp/util/show_stats.sh hd_run.log
{% endhighlight %}

The combination of these script now allow me to easily keep a **clear overview of** what **the simulation** is doing **just by looking at the log file**!

FYI: here is an [actual log file](http://o1iver.net/media/hd_run.log) (34 MB)


