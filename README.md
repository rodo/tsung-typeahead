tsung-typeahead
===============

Typeahead module for Tsung

Usage 
=====

<pre>
  <setdynvars sourcetype="file" fileid="address" delimiter=";" order="random">
    <var name="url" />
  </setdynvars>

  <setdynvars sourcetype="eval" code="fun({Pid,DynVars})-> 15 end.">
    <var name="typeahead_max" />
  </setdynvars>

  <setdynvars sourcetype="eval" code="fun({Pid,DynVars})-> 3 end.">
    <var name="typeahead_min" />
  </setdynvars>

  <setdynvars sourcetype="erlang" callback="typeahead:get_urls">
    <var name="list_url" />
  </setdynvars>

  <foreach name="element" in="list_url">
    <request subst="true">
      <http url="/api/?q=%%_element%%" method="GET" version="1.1"></http>
    </request>
  </foreach>
</pre>

Unit tests
==========

`$ ./rebar eunit`


