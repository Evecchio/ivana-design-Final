{% if store.whatsapp %}
    <a href="{{ store.whatsapp }}" target="_blank" rel="noopener noreferrer" class="btn-whatsapp" aria-label="{{ 'Comunicate por WhatsApp' | translate }}">
        <svg class="icon-inline" aria-hidden="true" focusable="false"><use xlink:href="#whatsapp"/></svg>
    </a>
{% endif %}
