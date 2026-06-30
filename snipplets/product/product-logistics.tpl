{% set show_product_quantity = product.available and product.display_price %}
{% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}
{% set has_product_free_shipping = product.free_shipping %}
{% set show_product_fulfillment = settings.shipping_calculator_product_page and (store.has_shipping or store.branches) and not product.is_non_shippable %}

<aside class="ivana-product-logistics-panel" aria-label="{{ 'Envíos y asistencia' | translate }}">
	<div class="ivana-product-logistics-head">
		<h2 class="ivana-product-logistics-title">{{ 'Envíos y asistencia' | translate }}</h2>
		<p class="ivana-product-logistics-summary">Revisá las opciones de entrega, retiro y ayuda antes de finalizar tu compra.</p>
	</div>

	<div class="ivana-product-logistics-benefits" aria-label="Beneficios de compra">
		<div class="ivana-product-logistics-benefit">
			<svg class="icon-inline"><use xlink:href="#truck"/></svg>
			<div>
				<strong>Envíos a todo el país</strong>
				<span>Los costos y tiempos se calculan con tu código postal.</span>
			</div>
		</div>
		<div class="ivana-product-logistics-benefit">
			<svg class="icon-inline"><use xlink:href="#check"/></svg>
			<div>
				<strong>Cambios fáciles</strong>
				<span>Podés consultar la guía de talles o escribirnos antes de comprar.</span>
			</div>
		</div>
		<div class="ivana-product-logistics-benefit">
			<svg class="icon-inline"><use xlink:href="#credit-card"/></svg>
			<div>
				<strong>Compra segura</strong>
				<span>Operás con los medios de pago habilitados en Tiendanube.</span>
			</div>
		</div>
	</div>

	{% if not product.is_non_shippable and show_product_quantity and (has_free_shipping or has_product_free_shipping) %}
		<div class="js-free-shipping-minimum-message free-shipping-message ivana-product-note font-medium">
			<span class="float-left mr-2">
				<svg class="icon-inline svg-icon-accent icon-lg"><use xlink:href="#truck"/></svg>
			</span>
			<span>
				<span class="text-accent">{{ "Envío gratis" | translate }}</span>
				<span {% if has_product_free_shipping %}style="display: none;"{% else %}class="js-shipping-minimum-label"{% endif %}>
					{{ "superando los" | translate }} <span>{{ cart.free_shipping.min_price_free_shipping.min_price }}</span>
				</span>
			</span>
			{% if not has_product_free_shipping %}
				<div class="js-free-shipping-discount-not-combinable font-small opacity-60 mt-1">
					{{ "No acumulable con otras promociones" | translate }}
				</div>
			{% endif %}
		</div>
	{% endif %}

	{% if show_product_fulfillment %}
		<div class="ivana-product-fulfillment">
			<div id="product-shipping-container" class="product-shipping-calculator list" {% if not product.display_price or not product.has_stock %}style="display:none;"{% endif %} data-shipping-url="{{ store.shipping_calculator_url }}">
				{% if store.has_shipping %}
					{% include "snipplets/shipping/shipping-calculator.tpl" with {'shipping_calculator_variant' : product.selected_or_first_available_variant, 'product_detail': true} %}
				{% endif %}
			</div>

			{% if store.branches %}
				{% include "snipplets/shipping/branches.tpl" with {'product_detail': true} %}
			{% endif %}
		</div>
	{% elseif product.is_non_shippable %}
		<div class="ivana-product-fulfillment-note">Este producto no requiere envío físico.</div>
	{% else %}
		<div class="ivana-product-fulfillment-note">Las opciones de envío disponibles se confirman durante el checkout.</div>
	{% endif %}

	<div class="ivana-product-support-cards">
		{% include 'snipplets/product/product-informative-banner.tpl' %}
	</div>
</aside>
