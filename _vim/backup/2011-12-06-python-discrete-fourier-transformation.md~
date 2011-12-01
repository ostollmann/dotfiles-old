---
layout: post
title: Python implementation of the Discrete Fourier Transform and its Inverse
---

{{ page.title }}
================

[Fourier transformations](http://en.wikipedia.org/wiki/Discrete_Fourier_transform) are exceptionally useful for [signal analysis](http://en.wikipedia.org/wiki/Signal_processing). Here is a python implementation of the discrete fourier transform and it's inverse. 

*Note: computing fourier transforms like this is not efficient. If you actually need to compute fourier tranforms consider using [fast fourier transforms](http://en.wikipedia.org/wiki/Fast_Fourier_transform).*

{% highlight python %}
import cmath
# Discrete fourier transform
def dft(x):
    t = []
    N = len(x)
    for k in range(N):
        print('k=%s', k)
        a = 0
        for n in range(N):
            print('n=%s', n)
            a += x[n]*cmath.exp(-2j*cmath.pi*k*n*(1/N))
        t.append(a)
    return t
# Inverse discrete fourier transform
def idft(t):
    x = []
    N = len(t)
    for n in range(N):
        a = 0
        for k in range(N):
            a += t[k]*cmath.exp(2j*cmath.pi*k*n*(1/N))
        a /= N
        x.append(a)
    return x
{% endhighlight %}

*Note: I have only tested this in python 3.*
