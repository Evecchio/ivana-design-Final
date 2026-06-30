{% set has_real_discount = product.compare_at_price and product.compare_at_price > product.price %}
{% set is_out_of_stock = not product.available %}
{% set is_low_stock = product.stock is not null and product.stock > 0 and product.stock < 5 %}
{% set slide_item = slide_item | default(false) %}
{% set slide_item_class = slide_item ? 'js-item-slide swiper-slide ' : '' %}
{% set max_installments_without_interests = product.get_max_installments ? product.get_max_installments(false) : null %}
{% set show_card_installments = product.show_installments and product.display_price and max_installments_without_interests and max_installments_without_interests.installment > 1 %}
{% set payment_discount_percentage = 20 %}
{% set payment_discount_price = product.price * (100 - payment_discount_percentage) / 100 %}

{# Item image slider logic #}
{% set show_image_slider = 
    (template == 'category' or template == 'search')
    and settings.product_item_slider
    and not reduced_item
    and not slide_item
    and not has_filters
    and product.other_images
%}

{% if show_image_slider %}
    {% set slider_controls_container_class = 'product-item-slider-controls-container svg-icon-text d-none d-md-block' %}
    {% set control_next_svg_id = 'arrow-long' %}
    {% set control_prev_svg_id = 'arrow-long' %}
{% endif %}

{# --- CONSTRUCCIÓN DE CONTENIDO PERSONALIZADO --- #}

{% set information_content %}
    <div class="ivana-card-content-stack">
    
    {# 2. TÍTULO DEL PRODUCTO (SEGUNDO) #}
    <div class="ivana-card-title-container">
        <h3 class="ivana-card-title">{{ product.name }}</h3>
    </div>

    {# 3. Precios y Descuento #}
    <div class="ivana-card-prices-block">
        {% if has_real_discount %}
            <span class="ivana-card-price-compare js-compare-price-display">{{ product.compare_at_price | money }}</span>
        {% endif %}
        <div class="ivana-card-price-row">
            <span class="ivana-card-price-main js-price-display">{{ product.price | money }}</span>
            {% if has_real_discount %}
                {# Prefer custom label if present; fallback to computed percentage #}
                {% set percentage_off_custom_label = product.getPriceDiscountCustomLabel %}
                {% set percentage_off = ((product.compare_at_price - product.price) * 100 / product.compare_at_price) | round %}
                {% if percentage_off > 0 %}
                    {% if percentage_off_custom_label and percentage_off_custom_label | trim %}
                        <span class="ivana-card-discount-tag">{{ percentage_off_custom_label }} OFF</span>
                    {% else %}
                        <span class="ivana-card-discount-tag">{{ percentage_off }}% OFF</span>
                    {% endif %}
                {% endif %}
            {% endif %}
        </div>
    </div>

    {# 4. Cuotas #}
    {% if show_card_installments %}
        {% set installment_value_rounded_cents = ((max_installments_without_interests.installment_data.installment_value_cents / 100) | round) * 100 %}
        <div class="ivana-card-installments-container">
            <span class="ivana-card-installments-icon" aria-hidden="true">
                <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="#9A9A9A" stroke-width="1.45" stroke-linecap="round" stroke-linejoin="round" focusable="false">
                    <rect x="3.5" y="6.5" width="17" height="11" rx="1.7" fill="none"></rect>
                    <path d="M3.5 10h17"></path>
                    <path d="M7 14.5h4"></path>
                </svg>
            </span>
            <p class="ivana-card-installments-text">
                <span class="ivana-card-installments-copy">{{ max_installments_without_interests.installment }} cuotas sin interés de</span>
                <strong class="ivana-card-installments-value">{{ installment_value_rounded_cents | money }}</strong>
            </p>
        </div>
    {% endif %}

    {# 5. Transferencia #}
    {% if product.display_price %}
        <div class="ivana-card-transfer-container">
            <span class="ivana-card-transfer-icon" aria-hidden="true">
                <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="#9A9A9A" stroke-width="1.45" stroke-linecap="round" stroke-linejoin="round" focusable="false">
                    <path d="M3.5 9.5 12 4l8.5 5.5"></path>
                    <path d="M5 9.5h14"></path>
                    <path d="M6.5 17.5h11"></path>
                    <path d="M4.5 20h15"></path>
                    <path d="M7 9.5v8"></path>
                    <path d="M10.3 9.5v8"></path>
                    <path d="M13.7 9.5v8"></path>
                    <path d="M17 9.5v8"></path>
                </svg>
            </span>
            <span class="ivana-card-transfer-copy">
                <span class="ivana-card-transfer-line">
                    <span class="ivana-card-transfer-price">{{ payment_discount_price | money }}</span>
                    <span class="ivana-card-transfer-badge">+ {{ payment_discount_percentage }}% OFF</span>
                </span>
                <span class="ivana-card-transfer-caption">Pagando con transferencia</span>
            </span>
        </div>
    {% endif %}

    {# 6. Barra de Stock #}
    <div class="ivana-card-stock-container">
        {% if is_out_of_stock %}
            <div class="ivana-card-stock-bar ivana-card-stock-bar--out">Sin stock por el momento</div>
        {% elseif is_low_stock %}
            <div class="ivana-card-stock-bar ivana-card-stock-bar--low">
                {% if product.stock == 1 %}¡Última unidad!{% else %}¡Quedan solo {{ product.stock }} unidades!{% endif %}
            </div>
        {% endif %}
    </div>

    </div>

{% endset %}

{# --- RENDER FINAL --- #}

{{ component(
    'product-item', {
        image_slider: show_image_slider,
        image_lazy: true,
        image_lazy_js: true,
        product_item_classes: {
            item: 'ivana-card ' ~ (has_real_discount ? 'ivana-has-discount ' : 'ivana-no-discount ') ~ 'js-product-container js-item-product ' ~ slide_item_class,
            information: 'ivana-card-info-container d-flex flex-column',
            name: 'hidden', 
            price: 'hidden',
            price_container: 'hidden',
        },
        custom_content: {
            information: information_content
        }
    })
}}
