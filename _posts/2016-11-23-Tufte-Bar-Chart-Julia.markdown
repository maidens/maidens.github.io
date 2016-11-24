---
layout: post
title:  "Julia bar charts in the style of Edward Tufte"
date:   2016-11-23
categories: jekyll update
---

## Introduction 

Edward Tufte's famous book "The Visual Display of Quantitative Information" contains a section in which he redesigns the classic bar chart in a way that leaves exactly the ink necessary to convey the desired information. In this post, I'll show how to replicate his visually-pleasing bar chart in Julia using the Gadfly graphing package. 

Here's what we'll make. 

<img width="340" src="/figs/tufte/gadfly_tufte.png"> 


For reference, Tufte's redesign is shown below. 

<img width="350" src="/figs/tufte/Bar_Chart_Redesign_1.png"> 
<img width="350" src="/figs/tufte/Bar_Chart_Redesign_2.png"> 
<img width="350" src="/figs/tufte/Bar_Chart_Redesign_3.png"> 


## Bar charts in Julia using Gadfly 

Gadfly is an awesome Julia package that I have been using recently for to produce the majority of my scientific visualizations. It is based on Leland Wilkinson's book The [https://www.cs.uic.edu/~wilkinson/TheGrammarOfGraphics/GOG.html Grammar of Graphics] and Hadley Wickhams's [http://ggplot2.org/ ggplot2] for the R programming language. By default it produces some pretty nice bar charts, but also provides many opportunities for customization.  




<img width="340" src="/figs/tufte/default.png"> 

# 

{% highlight julia %}
using Gadfly

tufte_bar = Theme(
    default_color=colorant"lightgray",
    background_color=colorant"white", 
    bar_spacing=25pt,
    grid_line_width=0pt, 
    minor_label_font="Gill Sans",
    major_label_font="Gill Sans", # could be changed to Bembo if you prefer Tufte's serif typeface
)
{% endhighlight %}

