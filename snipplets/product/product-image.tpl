{% if home_main_product %}
	{% set has_multiple_slides = product.images_count > 1 %}
{% else %}
	{% set has_multiple_slides = product.images_count > 1 or product.video_url %}
{% endif %}

{% if product.images_count > 0 %}
	<div class="product-images-slider ivana-product-gallery position-relative mb-md-0 mb-3{% if not has_multiple_slides %} w-100{% endif %}">
		{{ component(
			'labels', {
				no_stock_only: true,
				labels_classes: {
					group: 'product-labels',
				},
			})
		}}
		{% if not home_main_product %}
			{% set has_gallery_discount = product.display_price and product.compare_at_price and product.compare_at_price > product.price %}
			{% set saving = 0 %}
			{% set discount_pct = 0 %}
			{% if has_gallery_discount %}
				{% set saving = product.compare_at_price - product.price %}
				{% set discount_pct = ((product.compare_at_price - product.price) * 100 / product.compare_at_price) | round %}
			{% endif %}
			{% set show_gallery_discount = has_gallery_discount and discount_pct > 0 and saving > 0 %}
			<div class="product-discount-overlay js-offer-label" {% if not show_gallery_discount %}style="display: none;"{% endif %}>
				<span class="product-discount-badge"><span class="js-offer-percentage">{{ discount_pct }}</span>% OFF</span>
				<span class="product-price-badge js-saved-money-message">Ahorrás <span class="js-offer-saved-money">{{ saving | money }}</span></span>
			</div>
		{% endif %}
		<div class="js-swiper-product swiper-container" data-product-images-amount="{{ product.images_count }}">
			<div class="swiper-wrapper">
				{% for image in product.images %}
					<div class="js-product-slide swiper-slide slider-slide" data-image="{{image.id}}" data-image-position="{{loop.index0}}">
						{% if home_main_product %}
							<div class="js-product-slide-link d-block position-relative" style="padding-bottom: {{ image.dimensions ? (image.dimensions['height'] / image.dimensions['width'] * 100) : 100 }}%;">
						{% else %}
							<a href="{{ image | product_image_url('original') }}" data-fancybox="product-gallery" class="js-product-slide-link d-block position-relative" style="padding-bottom: {{ image.dimensions ? (image.dimensions['height'] / image.dimensions['width'] * 100) : 100 }}%;">
						{% endif %}

							{% set image_priority_high_value = not home_main_product and loop.first %}

							{{ component(
								'image', {
									image_priority_high: image_priority_high_value,
									src: image | product_image_url('original'),
									image_name: image,
									image_width: image.dimensions.width,
									image_height: image.dimensions.height,
									image_classes: 'js-product-slide-img product-slider-image img-absolute img-absolute-centered',
									image_alt: image.alt,
									product_image: true,
								})
							}}
						{% if home_main_product %}
							</div>
						{% else %}
							</a>
						{% endif %}
					</div>
				{% endfor %}
				{% if not home_main_product %}
					{% include 'snipplets/product/product-video.tpl' %}
				{% endif %}
			</div>
		</div>
		{% if has_multiple_slides %}
			<div class="js-swiper-product-pagination swiper-fractions text-right"></div>
		{% endif %}
	</div>
{% endif %}
{% if has_multiple_slides %}
	<div class="product-images-thumbs ivana-product-thumbs ivana-product-thumbs-horizontal">
		<div class="js-swiper-product-thumbs swiper-product-thumb overflow-none mb-3"> 
			<div class="swiper-wrapper">
				{% for image in product.images %}
					<div class="swiper-slide product-thumb-container">
						{% include 'snipplets/product/product-image-thumb.tpl' %}
					</div>
				{% endfor %}
				{% if not home_main_product %}
					{# Video thumb #}
					<div class="swiper-slide product-thumb-container">
						{% include 'snipplets/product/product-video.tpl' with {thumb: true} %}
					</div>
				{% endif %}
			</div>
		</div>
		<div class="js-swiper-product-thumbs-prev swiper-button-prev swiper-button-inline svg-icon-text d-none d-md-inline-block">
			<svg class="icon-inline icon-lg icon-flip-vertical"><use xlink:href="#arrow-long-down"/></svg>
		</div>
		<div class="js-swiper-product-thumbs-next swiper-button-next swiper-button-inline svg-icon-text d-none d-md-inline-block">
			<svg class="icon-inline icon-lg"><use xlink:href="#arrow-long-down"/></svg>
		</div>
	</div>
{% endif %}