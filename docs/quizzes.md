---
layout: page
title: Quizzes
permalink: quizzes/
---
{% assign sorted_ex = site.quizzes | sort: 'week' | group_by:'week' %}
{% for week in sorted_ex %}
<h2>Week {{ week.name }}</h2>
<ol>
    {% for ex in week.items %}
        <li><a href="{{ site.baseurl }}{{ ex.url }}">{{ ex.title }}</a></li>
    {% endfor %}
</ol>
{% endfor %}
