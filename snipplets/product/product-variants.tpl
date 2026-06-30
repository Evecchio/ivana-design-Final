<div class="js-product-variants {% if quickshop %}js-product-quickshop-variants{% endif %} {% if not (settings.bullet_variants or settings.image_color_variants) %}grid grid-2 align-items-center{% endif %} mb-4">
	{% set has_size_variations = false %}
	{% if settings.bullet_variants %}
		{% set hidden_variant_select = ' d-none' %}
	{% else %}
		{% set hidden_variant_select = ' mb-0' %}
	{% endif %}
	{% for variation in product.variations %}
		{% set variation_name = variation.name | lower %}
		{% set is_size_variation = variation_name in ['talle', 'talla', 'tamanho', 'size'] %}
		{% set is_color_variation = variation_name in ['color', 'cor'] %}
		{% set use_dropdown_variant = (not quickshop) and (variation.options | length > 1) %}
		{% set use_compact_variant_select = (not quickshop) and settings.bullet_variants and is_size_variation and (variation.options | length > 5) %}
		{% if is_size_variation %}
			{% set has_size_variations = true %}
		{% endif %}

		{% if use_dropdown_variant %}
			{% set hidden_variant_select = ' d-block ivana-variation-select-dropdown' %}
		{% elseif use_compact_variant_select %}
			{% set hidden_variant_select = ' d-block ivana-variation-select-compact' %}
		{% elseif settings.bullet_variants %}
			{% set hidden_variant_select = ' d-none' %}
		{% else %}
			{% set hidden_variant_select = ' mb-0' %}
		{% endif %}

		{% set is_hidden_select = false %}
		{% if settings.image_color_variants and not (settings.bullet_variants) and not use_dropdown_variant %}
			{% if is_color_variation %}
				{% set hidden_variant_select = ' d-none' %}
				{% set is_hidden_select = true %}
			{% else %}
				{% set hidden_variant_select = ' d-block' %}
			{% endif %}
		{% endif %}

		{% set is_button_variant = (is_color_variation or settings.bullet_variants) and not use_compact_variant_select and not use_dropdown_variant %}

		<div class="js-product-variants-group ivana-variation-group {% if use_dropdown_variant %}ivana-variation-group--dropdown{% endif %} {% if is_color_variation %}js-color-variants-container{% endif %} {% if is_button_variant and show_size_guide and settings.size_guide_url and has_size_variations and loop.last %}mb-0{% endif %} {% if settings.bullet_variants %}mb-3{% endif %}" data-variation-id="{{ variation.id }}">
			{% if quickshop %}
				{% embed "snipplets/forms/form-select.tpl" with{select_label: true, select_label_name: '' ~ variation.name ~ '', select_for: 'variation_' ~ loop.index , select_id: 'variation_' ~ loop.index, select_name: 'variation' ~ '[' ~ variation.id ~ ']', select_group_custom_class: hidden_variant_select, select_custom_class: 'js-variation-option js-refresh-installment-data'} %}
					{% block select_options %}
						{% for option in variation.options %}
							<option value="{{ option.id }}" {% if product.default_options[variation.id] is same as(option.id) %}selected="selected"{% endif %}>{{ option.name }}</option>
						{% endfor %}
					{% endblock select_options%}
				{% endembed %}
			{% else %}
				{% embed "snipplets/forms/form-select.tpl" with{select_label: true, select_label_name: '' ~ variation.name ~ '', select_for: 'variation_' ~ loop.index , select_id: 'variation_' ~ loop.index, select_name: 'variation' ~ '[' ~ variation.id ~ ']', select_custom_class: 'js-variation-option js-refresh-installment-data', select_group_custom_class: hidden_variant_select} %}
					{% block select_options %}
						{% for option in variation.options %}
							<option value="{{ option.id }}" {% if product.default_options[variation.id] is same as(option.id) %}selected="selected"{% endif %} data-option="{{ option.id }}">{{ option.name }}</option>
						{% endfor %}
					{% endblock select_options%}
				{% endembed %}
			{% endif %}
			{% if is_button_variant %}
				<label class="form-label ivana-variation-label">{{ variation.name }}: <strong class="js-insta-variation-label">{{ product.default_options[variation.id] }}</strong></label>
				{% for option in variation.options %}
					<a data-option="{{ option.id }}" class="js-insta-variant btn btn-variant ivana-variation-chip{% if is_color_variation %} ivana-variation-chip--filter{% endif %}{% if product.default_options[variation.id] is same as(option.id) %} selected{% endif %}" title="{{ option.name }}" data-option="{{ option.id }}" data-variation-id="{{ variation.id }}">
						<span class="btn-variant-content" data-name="{{ option.name }}">
							{{ option.name }}
						</span>
					</a>
				{% endfor %}
			{% endif %}
		</div>
	{% endfor %}
	{% if show_size_guide and settings.size_guide_url and has_size_variations %}
		{% set has_size_guide_page_finded = false %}
		{% set size_guide_url_handle = settings.size_guide_url | trim('/') | split('/') | last %}

		{% for page in pages if page.handle == size_guide_url_handle and not has_size_guide_page_finded %}
			{% set has_size_guide_page_finded = true %}
			{% if has_size_guide_page_finded %}
				<a data-target="#size-guide-modal" data-modal-url="modal-fullscreen-size-guide" class="js-modal-open-private ivana-size-guide-link {% if settings.bullet_variants %}mt-1 mb-3{% else %}mt-3{% endif %}">
					<span class="btn-link font-small">{{ 'Guía de talles' | translate }}</span>
				</a>
				{{ component(
					'modal',{
						modal_id: 'size-guide-modal',
						position: {
							appear_from: 'bottom',
						},
						layout: {
							width_desktop: 'large',
						},
						content: {
							title: 'Guía de talles' | translate,
							body: '<div class="user-content">' ~ page.content ~ '</div>',
						},
						icons: {
							close_icon_id: 'times',
						},
						modal_classes: {
							modal: 'h-auto',
							close_icon: 'icon-inline icon-2x',
						}
					}) 
				}}
			{% endif %}
		{% endfor %}
	{% endif %}
</div>
