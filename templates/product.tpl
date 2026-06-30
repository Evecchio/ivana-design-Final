<div id="single-product" class="js-product-detail js-product-container js-has-new-shipping js-shipping-calculator-container ivana-product-shell" data-variants="{{product.variants_object | json_encode }}" data-store="product-detail">
	<div class="container pt-4 pt-md-5 pb-4">
		<div class="product-columns ivana-product-stage mb-md-4">
			<div class="ivana-product-column ivana-product-column-media">
				<div class="product-images mb-4 mb-md-0" data-store="product-image-{{ product.id }}">
					{% include 'snipplets/product/product-image.tpl' %}
				</div>
				{% include 'snipplets/product/product-description.tpl' %}
			</div>
			<div class="ivana-product-column ivana-product-column-commerce">
				<div class="ivana-product-commerce-card">
					<div class="product-info ivana-product-buy-panel" data-store="product-info-{{ product.id }}">
						{% include 'snipplets/product/product-form.tpl' %}
					</div>
				</div>
			</div>
		</div>

	</div>
</div>

{# Related products #}
<div class="ivana-product-related">
	{% include 'snipplets/product/product-related.tpl' %}
</div>
