{# Account utility #}

{% set utility_icon_md_color_class = settings.desktop_utility_colors ? 'utility-icon-md-colors' %}

{# Mobile version: keep the original simple icon #}
{% if mobile %}
	<span class="js-header-utility-icon js-header-utility-icon-only header-utility">
		{% set account_url = not customer ? store.customer_login_url : store.customer_home_url %}
		<span class="font-medium">
			<svg class="icon-inline utility-icon icon-lg" aria-hidden="true" focusable="false"><use xlink:href="#user"/></svg>
			{% if not customer %}
				{{ "Mi cuenta" | translate | a_tag(store.customer_login_url, '', 'ml-1') }}
			{% else %}
				{% set customer_short_name = customer.name|split(' ')|slice(0, 1)|join %} 
				{{ "¡Hola, {1}!" | t(customer_short_name) | a_tag(store.customer_home_url, '', 'ml-1 mr-1') }}
				/
				{{ "Cerrar sesión" | translate | a_tag(store.customer_logout_url, '', 'ml-1') }}
			{% endif %}		
		</span>
	</span>
{% else %}
	{# Desktop version: explicit "Entrar" and "Registrarse" with their own icons #}
	{% set register_link = 'mandatory' not in store.customer_accounts %}
	
	{% if not customer %}
		{# Entrar #}
		<a href="{{ store.customer_login_url }}" class="header-utility d-none d-md-flex mr-3" aria-label="{{ 'Mi cuenta' | translate }}">
			<span class="js-header-utility-icon {{ utility_icon_md_color_class }}">
				<svg class="icon-inline utility-icon icon-lg" aria-hidden="true" focusable="false"><use xlink:href="#user"/></svg>
			</span>
			{#<span class="utility-text font-weight-bold">{{ "Entrar" | translate }}</span>#}
		</a>

	{% else %}
		{# Logged in state #}
		<span class="header-utility d-none d-md-flex">
			<span class="js-header-utility-icon {{ utility_icon_md_color_class }}">
				<svg class="icon-inline utility-icon icon-lg" aria-hidden="true" focusable="false"><use xlink:href="#user"/></svg>
			</span>
			<span class="utility-text">
				{% set customer_short_name = customer.name|split(' ')|slice(0, 1)|join %} 
				<div class="font-weight-bold">
					{{ "¡Hola, {1}!" | t(customer_short_name) | a_tag(store.customer_home_url, '', '') }}
				</div>
				<div>
					{{ "Cerrar sesión" | translate | a_tag(store.customer_logout_url, '', '') }}
				</div>
			</span>
		</span>
	{% endif %}
{% endif %}
