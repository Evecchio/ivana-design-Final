{% set has_filters_available = products and has_filters_enabled and (filter_categories is not empty or product_filters is not empty) %}

{% if settings.pagination == 'infinite' %}
	{% paginate by 12 %}
{% else %}
	{% paginate by 60 %}
{% endif %}

<section class="category-body ivana-category-shell ivana-search-shell" data-store="search-grid-shell">
	<div class="container py-4">
		<div class="ivana-category-header">
				{# Breadcrumbs removed #}
			<div class="grid grid-md-auto mb-md-4 align-items-end ivana-category-heading">
				<div class="mb-1 ivana-category-copy">
					<div class="grid grid-1-auto align-items-end ivana-category-title-row">
						<div class="ivana-category-title-block">
							<h1 class="ivana-category-title mb-0">
								{% if products or has_applied_filters %}
									{{ "Resultados de búsqueda" | translate }}
								{% else %}
									{{ "No encontramos nada para" | translate }}<span class="ml-2">"{{ query }}"</span>
								{% endif %}
							</h1>
							{% if products %}
								<p class="font-small mt-2 mb-0 ivana-category-meta">
									{{ "Mostrando" | translate }} <strong>{{ products_count }}</strong>
									{% if products | length > 1 %}
										{{ "resultados para" | translate }}
									{% else %}
										{{ "resultado para" | translate }}
									{% endif %}
									<span class="font-weight-bold">"{{ query }}"</span>
								</p>
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
