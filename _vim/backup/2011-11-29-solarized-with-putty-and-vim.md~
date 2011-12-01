---
layout: post
title: Using the Solarized color palette with PuTTY and Vim 
---

{{ page.title }}
================

[Solarized](http://ethanschoonover.com/solarized/) is a beautiful color palette by Ethan Schoonover. Here is a screenshot of the dark theme:

<img src="http://ethanschoonover.com/solarized/img/screen-haskell-dark.png" width=585>

Step 1: Setting up Solarized for PuTTY Tray
===========================================

[PuTTY Tray](http://haanstra.eu/putty/) is an extension of the default [PuTTY](http://www.chiark.greenend.org.uk/~sgtatham/putty/) that adds an invaluable feature which is the ability to load sessions settings from file (the default PuTTY only saves session data in the registry). We will be making use of that feature to set this up here. Here are the steps:

1. Open PuTTY
2. Click `Change Settings...` (in the PuTTY menu reached by right-clicking the top bar)
3. Select `Default Settings`, click `sessions from file` just below and then click `Save`
4. Open the directory where the `putty.exe` executable is saved
5. Open the `sessions` folder that should now have been created
6. Duplicate the newly created `Default%20Settings` file and rename 
7. Load one of these themes in your browser:
    - [dark](https://raw.github.com/brantb/solarized/master/putty-colors-solarized/solarized_dark_puttytray.txt)
    - [light](https://raw.github.com/brantb/solarized/master/putty-colors-solarized/solarized_light_puttytray.txt)
8. Replace the lines starting with `Color` in the new session file
9. Open PuTTY using this command:
{% highlight bat %}
C:\Putty\putty.exe 10.1.2.20 -l <uname> -pw <pword> -file <session-file>
{% endhighlight %}

Now you should hopefully have a PuTTY session with the Solarized color scheme!

Step 2: Setting up Solarized for Vim
====================================


