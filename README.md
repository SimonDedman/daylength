# daylength
Calculate day length from date, lat &amp; lon values.

Author: Simon Dedman

With help of: John Froeschke

First written April 2018

Typically datasets have biological (shark CPUE) and environmental parameters (temperature).

Many of these environmental parameters are encoded in a direct-recording or measurement proxy manner, e.g. salinity in parts per million is a direct measurement of a physical/chemical concentration. Temperature in Kelvin is a direct proxy to the heat energy in a system.

On the other hand, some parameters are encoded in a human-construct manner which we're so used to that it would be bizarre to do otherwise. However these likely mean nothing tangible to the response variable (e.g. shark CPUE), and also often can confound analytical techniques.

The purpose of this code is to address the most egregious of these: time and date.

One revolution around the sun is split into 12 roughly-lunar months, but these 12 months as factors or even as integers shouldn't have any relevance to the natural world. For example, December (12) is closer to January (1) for the purposes of actual climate than it is to July (7), but further numerically. As factors they're all independent and by default ordered alphabetically which does your bar-chart plotting no favours. As integers they at least run in order which works until the Dec/Jan looparound, but also has issues of scale: does April (4) have doubly pronounced climate than February (2)? It may do, in the northern hemisphere, as the seasons are progressing. But is December (12) then double June (6)? Nay.

This simple function uses latitude & longitude & date to generate day length values which are likely a more biologically appropriate metric by which to measure the progression through the year from a climate perspective, removing the arbitrary human counting.
