<ul class="list list-unstyled">
	{% set list_classes = 'mb-3 font-medium' %}
	{% set list_with_icons_classes = with_icons ? 'd-flex align-items-center' %}
	{% set icon_classes = 'icon-inline mr-2' %}
	{% set whatsapp_digits = store.whatsapp ? store.whatsapp|split('/')|last|replace('+', '')|replace(' ', '')|replace('-', '')|replace('(', '')|replace(')', '') : '' %}
	{% set phone_digits = store.phone ? store.phone|replace('+', '')|replace(' ', '')|replace('-', '')|replace('(', '')|replace(')', '') : '' %}
	{% set whatsapp_phone_digits = whatsapp_digits|slice(0, 3) == '549' ? '54' ~ (whatsapp_digits|slice(3)) : whatsapp_digits %}
	{% set normalized_phone_digits = phone_digits|slice(0, 3) == '549' ? '54' ~ (phone_digits|slice(3)) : phone_digits %}
	{% set hide_whatsapp_phone_duplicate = dedupe_whatsapp_phone and whatsapp_phone_digits and normalized_phone_digits and whatsapp_phone_digits == normalized_phone_digits %}
	{% if store.whatsapp and not hide_whatsapp_phone_duplicate %}
		<li class="{{ list_classes }} {{ list_with_icons_classes }}">
			<a href="{{ store.whatsapp }}">
				{% if with_icons %}
					<svg class="{{ icon_classes }} icon-lg"><use xlink:href="#whatsapp-line"/></svg>
				{% endif %}
				{{ store.whatsapp |trim('https://wa.me/') }}
			</a>
		</li>
	{% endif %}
	{% if store.phone %}
		<li class="{{ list_classes }} {{ list_with_icons_classes }}">
			<a href="tel:{{ store.phone }}">
				{% if with_icons %}
					<svg class="{{ icon_classes }}"><use xlink:href="#phone"/></svg>
				{% endif %}
				{{ store.phone }}
			</a>
		</li>
	{% endif %}
	{% if store.email %}
		<li class="{{ list_classes }} {{ list_with_icons_classes }}">
			<a href="mailto:{{ store.email }}">
				{% if with_icons %}
					<svg class="{{ icon_classes }} icon-w"><use xlink:href="#email"/></svg>
				{% endif %}
				{{ store.email }}
			</a>
		</li>
	{% endif %}
	{% if store.address and not is_order_cancellation %}
		<li class="{{ list_classes }} {{ list_with_icons_classes }}">
			{% if with_icons %}
				<svg class="{{ icon_classes }} icon-lg"><use xlink:href="#map-marker"/></svg>
			{% endif %}
			{{ store.address }}
		</li>
	{% endif %}
	{% if store.blog %}
		<li class="{{ list_classes }} {{ list_with_icons_classes }}">
			<a target="_blank" href="{{ store.blog }}">
				{% if with_icons %}
					<svg class="{{ icon_classes }} icon-w"><use xlink:href="#comments"/></svg>
				{% endif %}
				{{ "¡Visitá nuestro Blog!" | translate }}
			</a>
		</li>
	{% endif %}
</ul>
