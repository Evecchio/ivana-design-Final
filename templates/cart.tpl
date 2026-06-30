<section class="ivana-cart-shell">
<div id="shoppingCartPage" data-minimum="{{ settings.cart_minimum_value }}" data-store="cart-page" class="container">
    {% embed "snipplets/page-header.tpl" with {page_header_class: 'ivana-page-hero', page_header_title_class: 'ivana-page-title'} %}
        {% block page_header_text %}{{ "Carrito de compras" | translate }}{% endblock page_header_text %}
    {% endembed %}

    {% if cart.items %}
        <p class="ivana-cart-intro mt-n2 mb-4">{{ 'Revisa tus productos, ajusta cantidades y confirma tu resumen antes de iniciar la compra.' | translate }}</p>
    {% endif %}
    
    <form action="{{ store.cart_url }}" method="post" class="visible-when-content-ready mb-5 ivana-cart-form" data-store="cart-form" data-component="cart">

        {# Cart alerts #}

        {% if error.add %}
            {{ component('alert', {
                'type': 'warning',
                'message': 'our_components.cart.error_messages.' ~ error.add
            }) }}
        {% endif %}
        {% for error in error.update %}
            <div class="alert alert-warning">{{ "No podemos ofrecerte {1} unidades de {2}. Solamente tenemos {3} unidades." | translate(error.requested, error.item.name, error.stock) }}</div>
        {% endfor %}
        {% if cart.items %}
            <div class="cart-page-content">
                <div class="cart-page-products">
                    <div class="cart-page-table-header ivana-cart-table-header pb-3 mb-3 font-medium bottom-line d-none d-md-grid">
                        <div>{{ 'Productos' | translate }}</div>
                        <div class="cart-page-table-header-totals">
                            <div>{{ 'Cantidad' | translate }}</div>
                            <div>{{ 'Precio' | translate }}</div>
                            <div>{{ 'Subtotal' | translate }}</div>
                        </div>
                    </div>

                    <div class="js-ajax-cart-list mb-4 ivana-cart-list">
                        {% if cart.items %}
                          {% for item in cart.items %}
                            {% include "snipplets/cart-item-ajax.tpl" with {'cart_page': true} %}
                          {% endfor %}
                        {% endif %}
                    </div>
                    <div class="cart-page-fulfillment ivana-cart-fulfillment">
                        {% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}
                        {% set has_free_shipping_bar = has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

                        {% if has_free_shipping_bar %}
                          <div class="mb-3 d-md-none">
                            {% include "snipplets/shipping/shipping-free-rest.tpl" %}
                          </div>
                        {% endif %}

                        {% include "snipplets/cart/cart-fulfillment.tpl" %}
                    </div>
                </div>
                <div class="cart-page-summary ivana-cart-summary-panel">
                    {% include "snipplets/cart/cart-summary.tpl" with {cart_page: true} %}
                </div>
            </div>
        {% else %}
            {% if not error %}
                <div class="ivana-empty-state">
                    <p class="ivana-kicker mb-3">{{ 'Todavia no agregaste productos' | translate }}</p>
                    <h2 class="h4 mb-3">{{ 'Tu carrito esta vacio.' | translate }}</h2>
                    <p class="mb-4">{{ 'Explora las categorias destacadas y volve cuando encuentres tus proximas prendas favoritas.' | translate }}</p>
                    <a href="{{ store.products_url }}" class="btn btn-primary">{{ 'Seguir comprando' | translate }}</a>
                </div>
            {% endif %}
        {% endif %}
        <div id="error-ajax-stock" class="alert alert-warning mb-3" style="display: none;"> 
            {{ "Aun no tenemos mas stock de este producto para agregarlo al carrito. Si queres podes" | translate }}<a href="{{ store.products_url }}" class="btn-link ml-1 font-small">{{ "ver otros aca" | translate }}</a>
        </div>
    </form>
    <div id="store-curr" class="hidden">{{ cart.currency }}</div>
</div>
</section>