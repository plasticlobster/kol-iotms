A simple script that will check your various inventory locations for IOTM's because they tend to get lost sometimes.

Guide
=====

To install, type:
----------------------
<pre>
svn checkout https://github.com/plasticlobster/kol-iotms/branches/Release
</pre>

in your KoLMafia CLI

There are two configuration options available regarding mall prices:
<pre>
PLIotMShowPrices - Will show mall prices next to the items if set to true.
</pre>
<pre>
PLIotMSearchMall - Will do a mall search for each found item rather than using historical prices.
</pre>

To show historical mall prices, type:
<pre>
set PLIotMShowPrices = true
set PLIotMSearchMall = false
</pre>
into your KoLMafia CLI

To show newly-searched (within the session) mall prices, type:
<pre>
set PLIotMShowPrices = true
set PLIotMSearchMall = true
</pre>
into your KoLMafia CLI

To disable showing of mall prices, type:
<pre>
set PLIotMShowPrices = false
</pre>

into your KoLMafia CLI

To run, type:
----------------------
<pre>
PL-iotms
</pre>
into your KolMafia CLI

To update, type:
----------------------
<pre>
svn update plasticlobster-kol-iotms-branches-Release
</pre>

To remove:
----------------------
<pre>
svn delete plasticlobster-kol-iotms-branches-Release
</pre>
