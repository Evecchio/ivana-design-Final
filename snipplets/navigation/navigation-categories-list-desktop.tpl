{% for category in categories %}
	{% set formatted_category_name %}{% include 'snipplets/category-titlecase.tpl' with { category_name: category.name } %}{% endset %}
	{% set formatted_category_name = formatted_category_name | trim %}
	<li class="js-desktop-nav-item js-item-subitems-desktop nav-item nav-item-desktop">
		<a class="nav-list-link" href="{{ category.url }}">
			{{ formatted_category_name }}
		</a>
		{% set subcategories = category.subcategories(false) %}
		{% if subcategories %}
			<ul class="list-subitems">
				{% snipplet "navigation/navigation-categories-list-desktop.tpl" with categories = subcategories %}
			</ul>
		{% endif %}
	</li>
{% endfor %}
