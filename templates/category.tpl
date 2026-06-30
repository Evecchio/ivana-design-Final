{% set has_filters_available = products and has_filters_enabled and (filter_categories is not empty or product_filters is not empty) %}

{# Only remove this if you want to take away the theme onboarding advices #}
{% set show_help = not has_products %}

{% if settings.pagination == 'infinite' %}
	{% paginate by 12 %}
{% else %}
	{% paginate by 60 %}
{% endif %}

{% set category_banner = (category.images is not empty) or ("banner-products.jpg" | has_custom_image) %}
{% set normalized_category_name %}{% include 'snipplets/category-titlecase.tpl' with { category_name: category.name } %}{% endset %}
{% set normalized_category_name = normalized_category_name | trim %}
{% set normalized_category_description = category.description %}

{% if not show_help %}
	<section class="category-body ivana-category-shell" data-store="category-grid-{{ category.id }}">
		<div class="container py-4">
			{% if category_banner %}
				{% include 'snipplets/category-banner.tpl' %}
			{% endif %}
			<div class="ivana-category-header">
				{# Breadcrumbs removed #}
				<div class="grid grid-md-auto mb-md-4 align-items-end ivana-category-heading">
					<div class="mb-1 ivana-category-copy">
						<div class="grid grid-1-auto align-items-end ivana-category-title-row">
							<div class="ivana-category-title-block">
								<h1 class="ivana-category-title mb-0">{{ normalized_category_name }}</h1>
								{% if normalized_category_description %}
									<p class="font-small mt-2 mb-0 ivana-category-meta">{{ normalized_category_description }}</p>
								{% endif %}
							</div>
						</div>
					</div>
					{% if products %}
						<div class="d-none d-md-block ivana-category-toolbar">
						{{ component(
							'sort-by',{
								sort_by_classes: {
									container: 'mb-1 ivana-sort-box',
									select_group: "d-inline-block w-auto mb-0",
									select_label: "font-small d-block mb-1 ivana-category-toolbar-label",
									select: "form-select-small",
									select_svg: "icon-inline icon-xs icon-w-14 svg-icon-text",
								},
								select_svg_id: 'chevron-down'
							}) 
						}}
					</div>
					{% endif %}
				</div>
			</div>
			{% include 'snipplets/grid/filters-modals.tpl' %}
			<div class="ivana-category-layout{% if products and has_filters_available %} ivana-category-layout-filters{% endif %}">
				{% if products and has_filters_available %}
					<aside class="ivana-category-sidebar d-none d-md-block">
						<div class="ivana-category-filter-card">
							{% include 'snipplets/grid/filters-controls.tpl' %}
						</div>
					</aside>
				{% else %}
					<div class="ivana-category-sidebar d-none"></div>
				{% endif %}
				<div class="ivana-category-content">
					<div class="ivana-category-products ivana-category-grid">
						{% if not has_filters_available %}
							{% include 'snipplets/grid/filters-controls.tpl' %}
						{% endif %}
						{% include 'snipplets/grid/products-list.tpl' %}
					</div>
				</div>
			</div>
		</div>
	</section>
{% elseif show_help %}
	{# Category placeholder #}
	{% include 'snipplets/defaults/show_help_category.tpl' %}
{% endif %}
