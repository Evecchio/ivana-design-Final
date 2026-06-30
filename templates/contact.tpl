{% set has_contact_info = store.whatsapp or store.phone or store.email or store.address or store.blog or store.contact_intro %}
{% set is_order_cancellation_without_id = params.order_cancellation_without_id == 'true' %}

{% if is_order_cancellation or is_order_cancellation_without_id %}
<section class="ivana-contact-shell">
<div class="container visible-when-content-ready py-4 py-md-5 mb-4">
	<div class="mb-5">
		{% embed "snipplets/page-header.tpl" with {page_header_class: 'ivana-page-hero', page_header_title_class: 'ivana-page-title'} %}
			{% set form_title = is_order_cancellation ? "Pedí la cancelación de tu última compra" | translate : "Contacto" | translate %}
			{% block page_header_text %}{{ form_title }}{% endblock page_header_text %}
		{% endembed %}
		<div class="ivana-contact-grid">
			{% if is_order_cancellation %}
				<div class="ivana-contact-card">
					<div class="text-center text-md-left mb-4">
						<p data-component="order-cancellation-disclaimer">{{ "Si te arrepentiste, podés pedir la cancelación enviando este formulario. Tenés como máximo hasta 10 días corridos desde que recibiste el producto." | translate }} </p>
						<a class="btn-link" href="{{ status_page_url_regret }}"><strong>{{'Ver detalle de la compra' | translate}}</strong></a>
					</div>
					{% if has_contact_info %}
						<h5 class="mb-1 mt-4">{{ 'Si tenés problemas con otra compra, contactanos:' | translate }}</h5>
						<div class="divider mt-0"></div>
						{% if store.contact_intro %}<p class="mb-4">{{ store.contact_intro }}</p>{% endif %}
						{% include "snipplets/contact-links.tpl" with {btn_link: true} %}
					{% endif %}
				</div>
			{% endif %}
			<div class="ivana-contact-form-card">
				{% if contact %}
					{% if contact.success %}
						<div class="alert alert-success" data-component="order-cancellation-success-message">{{ "¡Tu pedido de cancelación fue enviado!" | translate }}<br><p class="mb-0 mt-2">{{ "Vamos a ponernos en contacto con vos apenas veamos tu mensaje." | translate }}</p><br><strong>{{ "Tu código de trámite es" | translate }} #{{ last_order_id }}</strong></div>
					{% else %}
						<div class="alert alert-danger">{{ "Necesitamos tu nombre y un email para poder responderte." | translate }}</div>
					{% endif %}
				{% endif %}
				{% if is_order_cancellation_without_id %}<p class="mb-3" data-component="order-cancellation-disclaimer">{{ "Si te arrepentiste de una compra, podés pedir la cancelación enviando este formulario <strong>con tu número de orden.</strong> Tenés como máximo hasta 10 días corridos desde que recibiste el producto." | translate }}</p>{% endif %}
				{% embed "snipplets/forms/form.tpl" with{form_id: 'contact-form', form_custom_class: 'js-winnie-pooh-form', form_action: '/winnie-pooh', submit_custom_class: 'btn-block', submit_name: 'contact', submit_text: 'Enviar' | translate, data_store: 'contact-form' } %}
					{% block form_body %}
						<div class="winnie-pooh hidden"><label for="winnie-pooh">{{ "No completar este campo" | translate }}:</label><input type="text" id="winnie-pooh" name="winnie-pooh"></div>
						<input type="hidden" value="{{ product.id }}" name="product"/>
						<input type="hidden" name="type" value="order_cancellation" />
						{% embed "snipplets/forms/form-input.tpl" with{input_for: 'name', type_text: true, input_name: 'name', input_id: 'name', input_label_text: 'Nombre' | translate, input_placeholder: 'ej.: María Perez' | translate } %}{% endembed %}
						{% embed "snipplets/forms/form-input.tpl" with{input_for: 'email', type_email: true, input_name: 'email', input_id: 'email', input_label_text: 'Email' | translate, input_placeholder: 'ej.: tuemail@email.com' | translate } %}{% endembed %}
					{% endblock %}
				{% endembed %}
			</div>
		</div>
	</div>
</div>
</section>
{% else %}
<section class="ivana-page-shell ivana-institutional-page ivana-contact-page">
	<div class="container visible-when-content-ready py-4 py-md-5 mb-4">
		<div class="ivana-about-layout">
			<header class="ivana-about-heading">
				<span class="ivana-about-kicker">Contacto</span>
				<h1>Estamos para ayudarte</h1>
				<span class="ivana-title-line"></span>
				<p>¿Tenés una consulta? Estamos para ayudarte a elegir tu talle, resolver dudas sobre envíos, cambios o cualquier consulta.</p>
			</header>

			<section class="ivana-contact-channel-grid" aria-label="Canales de contacto">
				{% if store.whatsapp %}<a class="ivana-contact-channel ivana-channel-whatsapp" href="{{ store.whatsapp }}"><span class="ivana-contact-symbol">☏</span><strong>WhatsApp</strong><i></i><p>Respuesta rápida y directa</p><em>Escribinos →</em></a>{% endif %}
				<a class="ivana-contact-channel ivana-channel-instagram" href="https://www.instagram.com/ivana.design.ok/" target="_blank" rel="nofollow"><span class="ivana-contact-symbol">◎</span><strong>Instagram</strong><i></i><p>Novedades, lanzamientos y más</p><em>Seguinos →</em></a>
				{% if store.email %}<a class="ivana-contact-channel ivana-channel-email" href="mailto:{{ store.email }}"><span class="ivana-contact-symbol">✉</span><strong>Email</strong><i></i><p>Consultas generales</p><em>Escribinos →</em></a>{% endif %}
			</section>

			<section class="ivana-contact-form-section">
				<h2>Envianos un mensaje</h2>
				<span class="ivana-title-line"></span>
				<div class="ivana-contact-form-card">
					{% if product %}<div class="d-grid grid-auto-1 align-items-center mb-4"><div><img src="{{ product.featured_image | product_image_url('thumb') }}" title="{{ product.name }}" alt="{{ product.name }}" class="img-fluid" /></div><div class="pl-3"><p class="font-medium">{{ "Estás consultando por el producto:" | translate }} </br> {{ product.name | a_tag(product.url) }}</p></div></div>{% endif %}
					{% if contact %}{% if contact.success %}<div class="alert alert-success" data-component="contact-success-message">{{ "¡Gracias por contactarnos! Vamos a responderte apenas veamos tu mensaje." | translate }}</div>{% else %}<div class="alert alert-danger">{{ "Necesitamos tu nombre y un email para poder responderte." | translate }}</div>{% endif %}{% endif %}
					{% embed "snipplets/forms/form.tpl" with{form_id: 'contact-form', form_custom_class: 'js-winnie-pooh-form', form_action: '/winnie-pooh', submit_custom_class: 'btn-block', submit_name: 'contact', submit_text: 'Enviar mensaje' | translate, data_store: 'contact-form' } %}
						{% block form_body %}
							<div class="winnie-pooh hidden"><label for="winnie-pooh">{{ "No completar este campo" | translate }}:</label><input type="text" id="winnie-pooh" name="winnie-pooh"></div>
							<input type="hidden" value="{{ product.id }}" name="product"/>
							<input type="hidden" name="type" value="contact" />
							<div class="ivana-contact-form-row">
								{% embed "snipplets/forms/form-input.tpl" with{input_for: 'name', type_text: true, input_name: 'name', input_id: 'name', input_label_text: 'Nombre' | translate, input_placeholder: 'Tu nombre' | translate } %}{% endembed %}
								{% embed "snipplets/forms/form-input.tpl" with{input_for: 'email', type_email: true, input_name: 'email', input_id: 'email', input_label_text: 'Email' | translate, input_placeholder: 'Tu email' | translate } %}{% endembed %}
							</div>
							{% embed "snipplets/forms/form-input.tpl" with{input_for: 'phone', type_tel: true, input_name: 'phone', input_id: 'phone', input_label_text: 'Teléfono' | translate, input_placeholder: 'Tu teléfono' | translate } %}{% endembed %}
							{% embed "snipplets/forms/form-input.tpl" with{text_area: true, input_for: 'message', input_name: 'message', input_id: 'message', input_rows: '7', input_label_text: 'Mensaje' | translate, input_placeholder: 'Escribí tu mensaje...' | translate } %}{% endembed %}
						{% endblock %}
					{% endembed %}
				</div>
			</section>

			<section class="ivana-contact-location">
				<h2>Ivana Design</h2><span class="ivana-title-line"></span>
				{% if store.address %}<p>{{ store.address }}</p>{% else %}<p>Villa Ballester<br>Buenos Aires, Argentina</p>{% endif %}
				<p>@ivana.design.ok</p>
			</section>
		</div>
	</div>
</section>
{% endif %}
