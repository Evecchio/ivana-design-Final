{# Only remove this if you want to take away the theme onboarding advices #}
{% set show_help = not has_products %}

{# Here we will add an example as a help, you can delete this after you upload your products #}

{% if show_help %}
	<div id="product-example">
		{# Product placeholder #}
		{% snipplet 'defaults/show_help_product.tpl' %}
	</div>
{% else %}
	<section class="ivana-page-shell ivana-error-shell">
		<div id="page-error" class="container py-4 py-md-5 mb-4">
			{% embed "snipplets/page-header.tpl" with {page_header_class: 'ivana-page-hero', page_header_title_class: 'ivana-page-title'} %}
				{% block page_header_text %}{{ "Error" | translate }} - 404{% endblock page_header_text %}
			{% endembed %}
			<div class="ivana-empty-state">
				<h2 class="h5 mb-3 mb-md-2">{{ "La página que estás buscando no existe." | translate }}</h2>
				<a href="{{ store.products_url }}" class="btn btn-primary d-inline-block mt-3">{{ "Ver productos" | translate }}</a>
			</div>
			{% set featured_products = sections.primary.products %}
			{% if featured_products | length > 1 %}
				<div class="ivana-home-section-head text-center mt-5 mb-4">
					<h3 class="ivana-home-section-title">{{ "Quizás te interesen los siguientes productos." | translate }}</h3>
					<div class="ivana-home-section-divider"></div>
				</div>
				<div class="position-relative py-4">
					<div class="js-swiper-featured swiper-container">
						<div class="js-products-featured-grid swiper-wrapper">
							{% for product in featured_products %}
								{% include 'snipplets/product-item.tpl' with {'slide_item': true, 'section_name': section_name } %}
							{% endfor %}
						</div>
					</div>
					<div class="js-swiper-featured-pagination swiper-pagination swiper-pagination-bullets swiper-pagination-outside w-100"></div>
					<div class="js-swiper-featured-prev swiper-button-prev svg-icon-text swiper-button-outside d-none d-md-block">
						<svg class="icon-inline icon-2x icon-flip-horizontal"><use xlink:href="#arrow-long"/></svg>
					</div>
					<div class="js-swiper-featured-next swiper-button-next svg-icon-text swiper-button-outside d-none d-md-block">
						<svg class="icon-inline icon-2x"><use xlink:href="#arrow-long"/></svg>
					</div>
				</div>
			{% endif %}
		</div>
	</section>
{% endif %}
