{% set allowed_categories = ['tops', 'capris', 'short', 'leggings'] %}
{% set unique_home_subcategories = [] %}
{% set all_subcategories = [] %}

{# Recolectar todas las subcategorías de la navegación #}
{% for nav_item in navigation %}
	{% if nav_item.isCategory and nav_item.subitems %}
		{% for subcategory in nav_item.subitems %}
			{% if subcategory.isCategory %}
				{% set all_subcategories = all_subcategories | merge([subcategory]) %}
			{% endif %}
			{% if subcategory.subitems %}
				{% for nested_subcategory in subcategory.subitems %}
					{% if nested_subcategory.isCategory %}
						{% set all_subcategories = all_subcategories | merge([nested_subcategory]) %}
					{% endif %}
				{% endfor %}
			{% endif %}
		{% endfor %}
	{% endif %}
{% endfor %}

{# Armar lista final en el orden definido, solo las permitidas #}
{% for allowed_name in allowed_categories %}
	{% for subcategory in all_subcategories %}
		{% if subcategory.name | lower | trim == allowed_name %}
			{% if subcategory not in unique_home_subcategories %}
				{% set unique_home_subcategories = unique_home_subcategories | merge([subcategory]) %}
			{% endif %}
		{% endif %}
	{% endfor %}
{% endfor %}

{% if unique_home_subcategories is not empty %}
	<section class="section-home section-categories-home ivana-home-categories overflow-none py-10">
		<div class="container">
			<div class="ivana-home-section-head text-center w-100">
				<h2 class="ivana-home-section-title mb-0" style="display: inline-block !important; text-align: center !important; width: auto !important;">Colección Destacada</h2>
				<div class="ivana-home-section-divider"></div>
			</div>
			<div class="d-flex justify-content-center align-items-start gap-4 pb-4 ivana-home-categories-row category-slider-mobile">
				{% for subcategory in unique_home_subcategories %}
					{% set formatted_subcategory_name %}{% include 'snipplets/category-titlecase.tpl' with { category_name: subcategory.name } %}{% endset %}
					{% set formatted_subcategory_name = formatted_subcategory_name | trim %}
					{% set subcategory_handle = subcategory.url | split('://') | last | trim('/') | split('/') | last | trim %}
					{% set fallback_slide_image = false %}
					{% for slide in settings.slider_categories %}
						{% if slide.link %}
							{% set slide_handle = slide.link | split('://') | last | trim('/') | split('/') | last | trim %}
							{% if slide_handle == subcategory_handle %}
								{% set fallback_slide_image = slide.image %}
							{% endif %}
						{% endif %}
					{% endfor %}


					{# Prefer category image, fallback to slider image #}
					{% set has_subcategory_image = subcategory.images is not empty %}
					{% set subcategory_image_name = has_subcategory_image ? (subcategory.images | first) : false %}
					{% set circle_image_name = subcategory_image_name ? subcategory_image_name : fallback_slide_image %}
					{% set circle_is_category_image = subcategory_image_name ? true : false %}
					<a href="{{ subcategory.url }}" class="js-home-category d-flex flex-column align-items-center group shrink-0 text-decoration-none category-item" aria-label="{{ 'Ver categoría' | translate }} {{ formatted_subcategory_name }}">
						<div class="home-category-image-border ivana-home-category-circle w-28 h-28 md:w-36 md:h-36 rounded-circle overflow-hidden p-1 transition-all">
							<div class="w-100 h-100 rounded-circle overflow-hidden">
								{% if circle_image_name %}
									{{ component(
										'image',{
											image_name: circle_image_name,
											image_classes: 'd-block w-100 h-100 object-cover fade-in',
											image_lazy: true,
											image_lazy_js: true,
											image_alt: subcategory.name,
											category_image: circle_is_category_image,
										})
									}}
								{% else %}
									<div class="ivana-home-category-placeholder" aria-hidden="true"></div>
								{% endif %}
							</div>
						</div>
						<span class="mt-3 font-bold tracking-widest text-center ivana-home-category-name">
							{{ formatted_subcategory_name }}
						</span>
					</a>
				{% endfor %}
			</div>
		</div>
	</section>
{% endif %}
