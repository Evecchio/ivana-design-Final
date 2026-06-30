{% for category in categories %}
    {% if category.handle == category_handle %}
        {% set category_name %}{% include 'snipplets/category-titlecase.tpl' with { category_name: category.name } %}{% endset %}
        {% set category_name = category_name | trim %}
        <div class="my-3 ml-md-2 font-medium font-md-body">{{ category_name }}</div>
    {% endif %}
    {% include 'snipplets/home/home-categories-name.tpl' with { 'categories' : category.subcategories } %}
{% endfor %}
