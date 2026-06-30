{# IMPORTANT Do not remove this hidden subtotal, it is used by JS to calculate cart total #}
<div class="js-subtotal-price subtotal-price hidden" data-priceraw="{{ cart.total }}"></div>

{# Used to assign currency to total #}
<div id="store-curr" class="hidden">{{ cart.currency }}</div>

{# Check if store has free shipping without regions or categories #}

{% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}
{% set has_free_shipping_bar = has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

{# Cart subtotals for cart popup #}

{% if not cart_page %}
  
  {% if has_free_shipping_bar and cart.items_count > 0 %}
    {# includes free shipping progress bar: only if store has free shipping with a minimum #}
    <div class="mx-neg-3 mt-2 mb-3">
      {% include "snipplets/shipping/shipping-free-rest.tpl" %}
    </div>
  {% endif %}

  <div class="pb-2">
    {% include "snipplets/cart/cart-totals.tpl" with {cart_subtotal: true} %}
    {% include "snipplets/cart/cart-totals.tpl" with {cart_promotions: true} %}
  </div>

  {% include "snipplets/cart/cart-fulfillment.tpl" %}
{% endif %}

{% if cart_page %}
  <div id="cart-sticky-summary" class="position-sticky-md cart-page-totals ivana-cart-summary-sticky">
    <div class="ivana-cart-summary-head mb-4">
      <p class="ivana-kicker mb-2">{{ 'Resumen de compra' | translate }}</p>
      <h2 class="ivana-cart-summary-title mb-2">{{ 'Tu pedido' | translate }}</h2>
      <p class="ivana-cart-summary-copy mb-0">{{ 'Revisa tus totales antes de iniciar la compra.' | translate }}</p>
    </div>

    {% if has_free_shipping_bar and cart.items_count > 0 %}
      <div class="mb-3 d-none d-md-block">
        {% include "snipplets/shipping/shipping-free-rest.tpl" %}
      </div>
    {% endif %}

    <div class="ivana-cart-summary-lines pb-2">
      {% include "snipplets/cart/cart-totals.tpl" with {cart_subtotal: true} %}
      {% include "snipplets/cart/cart-totals.tpl" with {cart_promotions: true} %}
      {% include "snipplets/cart/cart-totals.tpl" with {cart_shipping_costs: true} %}
    </div>
{% else %}
{% endif %}
  
    {% include "snipplets/cart/cart-totals.tpl" with {cart_total: true} %}

    {% set cart_page_value = cart_page ? true : false %}
    {% include "snipplets/cart/cart-button.tpl" with {cart_page: cart_page_value} %}
    
{% if cart_page %}
  </div>
{% endif %}
