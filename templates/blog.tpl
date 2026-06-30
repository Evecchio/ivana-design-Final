<section class="ivana-page-shell ivana-blog-shell">
    <div class="container py-4 py-md-5">
        {% embed "snipplets/page-header.tpl" with {page_header_class: 'ivana-page-hero', page_header_title_class: 'ivana-page-title'} %}
            {% block page_header_text %}{{ "Blog" | translate }}{% endblock page_header_text %}
        {% endembed %}
        <section class="blog-page ivana-blog-grid pb-5">
            <div class="grid grid-spaced grid-md-1 grid-md-3">
                {% for post in blog.posts %}
                    {{ component(
                        'blog/blog-post-item', {
                            image_lazy: true,
                            image_lazy_js: true,
                            post_item_classes: {
                                item: 'ivana-blog-card mb-4 pb-2',
                                image_container: 'ivana-blog-card-image mb-4',
                                image: 'img-absolute img-absolute-centered fade-in',
                                title: 'ivana-blog-card-title mb-3 h6',
                                summary: 'ivana-blog-card-summary mb-3 font-medium',
                                read_more: 'btn-link',
                            },
                        })
                    }}
                {% endfor %}
            </div>
        </section>
        {% include 'snipplets/grid/pagination.tpl' with {'pages': blog.pages} %}
    </div>
</section>
