{% set subitem = subitem | default(false) %}

{% set has_featured_link = settings.featured_link_url is not empty %}
{% if has_featured_link %}
	{% set featured_link_url = settings.featured_link_url | split('://') | last | split('/') | slice(1) | join('/') | trim('/') %}
{% endif %}

{%- for item in navigation -%}
	
	{% set link_url = item.url | split('://') | last | split('/') | slice(1) | join('/') | trim('/') %}
	{% if has_featured_link %}
		{% set featured_link_classes = link_url == featured_link_url ? 'js-nav-list-link-featured nav-list-link-featured' %}
		{% set featured_link_color_classes = settings.featured_link_color and link_url == featured_link_url ? 'nav-list-link-featured-color' %}
	{% endif %}

	{% set item_name = item.name | lower | trim %}
	{% set formatted_item_name %}{% include 'snipplets/category-titlecase.tpl' with { category_name: item.name } %}{% endset %}
	{% set formatted_item_name = formatted_item_name | trim %}
	{% set is_grouped_item = item_name == 'quiénes somos' or item_name == 'cómo comprar' or item_name == 'guía de talles' or item_name == 'preguntas frecuentes' or item_name == 'contacto' or item_name == 'política de devolución' %}
	{%- if not (not subitem and is_grouped_item) -%}

	{% if item.subitems %}
		<li class="js-desktop-nav-item js-item-subitems-desktop nav-item-desktop {% if not subitem %}js-nav-main-item nav-dropdown nav-main-item {% endif %} nav-item item-with-subitems" data-component="menu.item" {% if not subitem %}style="margin: 0 14px !important;"{% endif %}>
			<div class="nav-item-container">
				<a class="js-nav-list-link nav-list-link {{ featured_link_classes }} {{ featured_link_color_classes }} {{ item.current ? 'selected' : '' }}" href="{% if item.url %}{{ item.url }}{% else %}#{% endif %}" data-url-cleaned="{{ link_url }}">{{ formatted_item_name }}
				</a>
			</div>
			{% if not subitem %}
				<div class="js-desktop-dropdown nav-dropdown-content desktop-dropdown">
					<div class="container desktop-dropdown-container">
			{% endif %}
						<ul class="{% if not subitem %}desktop-list-subitems{% endif %} list-subitems">
							{% include 'snipplets/navigation/navigation-list-megamenu.tpl' with { 'navigation' : item.subitems, 'subitem' : true } %}
						</ul>
			{% if not subitem %}
						{% include 'snipplets/navigation/navigation-banners.tpl' %}
					</div>
				</div>
			{% endif %}
		</li>
	{% else %}
		<li class="js-desktop-nav-item {% if not subitem %}js-nav-main-item nav-main-item{% endif %} nav-item-desktop nav-item" data-component="menu.item" {% if not subitem %}style="margin: 0 14px !important;"{% endif %}>
			<div class="nav-item-container">
				<a class="js-nav-list-link nav-list-link {{ featured_link_classes }} {{ featured_link_color_classes }} {{ item.current ? 'selected' : '' }}" href="{% if item.url %}{{ item.url | setting_url }}{% else %}#{% endif %}" data-url-cleaned="{{ link_url }}">{{ formatted_item_name }}</a>
			</div>
		</li>
	{% endif %}
	{%- endif -%}
{%- endfor -%}

{% if not subitem %}
	{% set has_grouped_items = false %}
	{% for item in navigation %}
		{% set item_name = item.name | lower | trim %}
		{% if item_name == 'quiénes somos' or item_name == 'cómo comprar' or item_name == 'guía de talles' or item_name == 'preguntas frecuentes' or item_name == 'contacto' or item_name == 'política de devolución' %}
			{% set has_grouped_items = true %}
		{% endif %}
	{% endfor %}

	{% if has_grouped_items %}
		<li class="js-desktop-nav-item js-item-subitems-desktop nav-item-desktop js-nav-main-item nav-dropdown nav-main-item nav-item item-with-subitems nav-dropdown-more" data-component="menu.item" style="margin: 0 14px !important;">
			<div class="nav-item-container">
				<a class="js-nav-list-link nav-list-link" href="#">Más</a>
			</div>
			<div class="js-desktop-dropdown nav-dropdown-content desktop-dropdown">
				<div class="container desktop-dropdown-container">
					<ul class="desktop-list-subitems desktop-list-subitems-more list-subitems">
						{% for item in navigation %}
							{% set item_name = item.name | lower | trim %}
							{% set formatted_item_name %}{% include 'snipplets/category-titlecase.tpl' with { category_name: item.name } %}{% endset %}
							{% set formatted_item_name = formatted_item_name | trim %}
							{% set is_grouped_item = item_name == 'quiénes somos' or item_name == 'cómo comprar' or item_name == 'guía de talles' or item_name == 'preguntas frecuentes' or item_name == 'contacto' or item_name == 'política de devolución' %}
							{% if is_grouped_item %}
								{% set link_url = item.url | split('://') | last | split('/') | slice(1) | join('/') | trim('/') %}
								<li class="js-desktop-nav-item nav-item-desktop nav-item" data-component="menu.item">
									<a class="js-nav-list-link nav-list-link {{ item.current ? 'selected' : '' }}" href="{% if item.url %}{{ item.url | setting_url }}{% else %}#{% endif %}" data-url-cleaned="{{ link_url }}">{{ formatted_item_name }}</a>
								</li>
							{% endif %}
						{% endfor %}
					</ul>
				</div>
			</div>
		</li>
	{% endif %}
{% endif %}
