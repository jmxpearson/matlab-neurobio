---
layout: page
title: Publications
permalink: exercises/
---
{% assign sorted_ex = site.exercises | sort: 'week' | group_by:'week' %}
{% for week in sorted_ex %}
<h2>Week {{ week.name }}</h2>
<ol>
    {% for ex in week.items %}
        <li><a href="{{ ex.url }}">{{ ex.title }}</a></li>
    {% endfor %}
</ol>
{% endfor %}
