<section class="ivana-page-shell ivana-blog-post-shell">
    <div class="container container-narrow py-4 py-md-5">
        {% embed "snipplets/page-header.tpl" with {page_header_class: 'ivana-page-hero', page_header_title_class: 'ivana-page-title mb-0'} %}
            {% block page_header_text %}{{ post.title }}{% endblock page_header_text %}
        {% endembed %}
        <div class="blog-post-page ivana-rich-content pb-5">
            {{ component(
                'blog/blog-post-content', {
                    image_lazy: true,
                    image_lazy_js: true,
                    post_content_classes: {
                        date: 'mb-4 font-small',
                        image: 'img-fluid fade-in mb-4 pb-2',
                        content: 'mb-2',
                    },
                })
            }}
        </div>
    </div>
</section>
