{% set nav_text_class = settings.desktop_main_nav_uppercase ? 'text-uppercase' %}
<ul class="nav-categories-mobile list-unstyled list-horizontal {{ nav_text_class }}">
	{% for category in categories %}
		{% set formatted_category_name %}{% include 'snipplets/category-titlecase.tpl' with { category_name: category.name } %}{% endset %}
		{% set formatted_category_name = formatted_category_name | trim %}
		<li class="nav-item list-item {% if loop.first %}ml-2{% endif %}">
			<a class="nav-list-link" href="{{ category.url }}">{{ formatted_category_name }}</a>
		</li>
	{% endfor %}
</ul>
