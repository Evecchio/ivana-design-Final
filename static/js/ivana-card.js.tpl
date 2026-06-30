function parseIvanaMoneyValue(text) {
    if (!text) {
        return null;
    }

    var normalized = String(text).replace(/\s+/g, "").replace(/[^\d,.-]/g, "");

    if (!normalized) {
        return null;
    }

    if (normalized.indexOf(",") > -1 && normalized.indexOf(".") > -1) {
        normalized = normalized.replace(/\./g, "").replace(",", ".");
    } else if (normalized.indexOf(",") > -1) {
        normalized = normalized.replace(",", ".");
    } else if (normalized.indexOf(".") > -1) {
        if (/\.\d{3}$/.test(normalized) && !/\.\d{1,2}$/.test(normalized.replace(/\.\d{3}/g, ""))) {
            normalized = normalized.replace(/\./g, "");
        }
    }

    var value = parseFloat(normalized);

    return isNaN(value) ? null : value;
}

function normalizeIvanaProductCards(root) {
    var scope = root || document;
    var cards = scope.querySelectorAll(".js-product-item-private.product-item.ivana-card, .js-item-product, .js-product-container.js-product-item");

    cards.forEach(function(card) {
        // Normalizar nombre: solo primera letra mayúscula
        var nameEl = card.querySelector(".js-item-name");
        if (nameEl && !nameEl.dataset.ivanaNameNormalized) {
            var rawText = nameEl.textContent.trim();
            if (rawText) {
                nameEl.textContent = rawText.charAt(0).toUpperCase() + rawText.slice(1).toLowerCase();
                nameEl.dataset.ivanaNameNormalized = "1";
            }
        }

        var priceContainer = card.querySelector(".product-item-price-container");
        var discountBadge = card.querySelector(".product-item-discount");
        var comparePrice = card.querySelector("span.js-compare-price-display.product-item-price-compare");
        var currentPrice = card.querySelector("span.js-price-display.product-item-price");
        var customDiscountBadge = card.querySelector(".ivana-card-discount-tag");

        if (customDiscountBadge) {
            card.querySelectorAll(".js-offer-label-private, .js-offer-label").forEach(function(nativeOfferLabel) {
                nativeOfferLabel.remove();
            });
        }

        if (!priceContainer) {
            return;
        }

        var currentPriceValue = currentPrice ? parseIvanaMoneyValue(currentPrice.textContent) : null;
        var comparePriceValue = comparePrice ? parseIvanaMoneyValue(comparePrice.textContent) : null;
        var discountValue = null;

        if (discountBadge) {
            var discountText = (discountBadge.textContent || "").replace(/\s+/g, " ").trim();
            var discountMatch = discountText.match(/\d+(?:[.,]\d+)?/);
            discountValue = discountMatch ? parseFloat(discountMatch[0].replace(",", ".")) : null;
        } else if (customDiscountBadge) {
            var customDiscountText = (customDiscountBadge.textContent || "").replace(/\s+/g, " ").trim();
            var customDiscountMatch = customDiscountText.match(/\d+(?:[.,]\d+)?/);
            discountValue = customDiscountMatch ? parseFloat(customDiscountMatch[0].replace(",", ".")) : null;
        }

        var hideDiscount = (!discountBadge && !customDiscountBadge) || discountValue === null || discountValue <= 0;
        var hideComparePrice = !comparePrice || comparePriceValue === null || currentPriceValue === null || comparePriceValue <= currentPriceValue;

        if (discountBadge) {
            discountBadge.style.display = hideDiscount ? "none" : "";
        }

        if (comparePrice) {
            comparePrice.style.display = (hideDiscount || hideComparePrice) ? "none" : "";
        }

        priceContainer.classList.toggle("ivana-no-discount", hideDiscount || hideComparePrice);
        card.classList.toggle("ivana-no-discount", hideDiscount || hideComparePrice);

        // Wrap current price + discount badge in a single row container
        if (currentPrice && discountBadge && !card.querySelector(".ivana-price-row")) {
            var priceRow = document.createElement("span");
            priceRow.className = "ivana-price-row";
            currentPrice.parentNode.insertBefore(priceRow, currentPrice);
            priceRow.appendChild(currentPrice);
            priceRow.appendChild(discountBadge);
        }

        card.querySelectorAll(".custom-installments, .text-accent").forEach(function(node) {
            if (!node.textContent || !node.textContent.trim()) {
                node.style.display = "none";
            }
        });

        // Move installments block right after price container
        var installmentsContainer = card.querySelector(".js-max-installments-container");
        if (installmentsContainer && priceContainer && priceContainer.parentNode) {
            priceContainer.parentNode.insertBefore(installmentsContainer, priceContainer.nextSibling);
        }

        var installmentsAnchor = installmentsContainer;
        if (!installmentsAnchor && priceContainer && priceContainer.parentNode) {
            installmentsAnchor = card.querySelector(".ivana-installments-anchor");

            if (!installmentsAnchor) {
                installmentsAnchor = document.createElement("div");
                installmentsAnchor.className = "ivana-installments-anchor";
            }

            priceContainer.parentNode.insertBefore(installmentsAnchor, priceContainer.nextSibling);
        }

        var paymentDiscountContainer = card.querySelector(".js-ivana-card-payment-discount, .js-payment-discount-price-product-container");
        if (paymentDiscountContainer && installmentsAnchor && installmentsAnchor.parentNode) {
            installmentsAnchor.parentNode.insertBefore(paymentDiscountContainer, installmentsAnchor.nextSibling);
        } else if (paymentDiscountContainer && priceContainer && priceContainer.parentNode) {
            priceContainer.parentNode.insertBefore(paymentDiscountContainer, priceContainer.nextSibling);
        }


    });
}

var ivanaProductCardsQueued = false;

function updateIvanaHomeCategoryCarouselOverflow(slider) {
    if (!slider) {
        return;
    }

    var isOverflowing = slider.scrollWidth > (slider.clientWidth + 1);
    slider.classList.toggle("ivana-overflowing", isOverflowing);
}

function initializeIvanaHomeCategoryCarouselMouseScroll() {
    var sliders = document.querySelectorAll(".ivana-home-categories-row.category-slider-mobile");

    sliders.forEach(function(slider) {
        updateIvanaHomeCategoryCarouselOverflow(slider);

        if (slider.dataset.ivanaMouseScrollBound === "1") {
            return;
        }

        slider.dataset.ivanaMouseScrollBound = "1";

        slider.addEventListener("wheel", function(event) {
            if (window.innerWidth < 768) {
                return;
            }

            var delta = Math.abs(event.deltaX) > Math.abs(event.deltaY) ? event.deltaX : event.deltaY;

            if (!delta) {
                return;
            }

            event.preventDefault();
            slider.scrollLeft += delta;
        }, { passive: false });
    });

    if (!window.ivanaHomeCategoryOverflowResizeBound) {
        window.ivanaHomeCategoryOverflowResizeBound = true;

        window.addEventListener("resize", function() {
            document.querySelectorAll(".ivana-home-categories-row.category-slider-mobile").forEach(function(slider) {
                updateIvanaHomeCategoryCarouselOverflow(slider);
            });
        });
    }
}

function formatIvanaEditorialTitle(text) {
    var smallWords = {
        "a": true,
        "al": true,
        "con": true,
        "de": true,
        "del": true,
        "e": true,
        "el": true,
        "en": true,
        "la": true,
        "las": true,
        "los": true,
        "o": true,
        "para": true,
        "por": true,
        "sin": true,
        "un": true,
        "una": true,
        "y": true
    };

    return String(text || "")
        .replace(/\s+/g, " ")
        .trim()
        .replace(/\bc\s*\/\s*/gi, "con ")
        .toLowerCase()
        .split(" ")
        .map(function(word, index) {
            if (!word) {
                return word;
            }

            if (index > 0 && smallWords[word]) {
                return word;
            }

            return word.charAt(0).toUpperCase() + word.slice(1);
        })
        .join(" ");
}

function normalizeIvanaProductDetailTitle(root) {
    var scope = root || document;
    var title = scope.querySelector(".ivana-product-shell .ivana-product-title.js-product-name");

    if (!title || title.dataset.ivanaEditorialTitle === "1") {
        return;
    }

    title.textContent = formatIvanaEditorialTitle(title.textContent);
    title.dataset.ivanaEditorialTitle = "1";
}

function formatIvanaMoneyARS(value) {
    var rounded = Math.round(value || 0).toString();
    return "$" + rounded.replace(/\B(?=(\d{3})+(?!\d))/g, ".");
}

function normalizeIvanaProductDetailCommercial(root) {
    var scope = root || document;
    var shell = scope.querySelector(".ivana-product-shell");

    if (!shell) {
        return;
    }

    var priceDisplay = shell.querySelector("#price_display, .js-price-display");
    var discountContainer = shell.querySelector(".js-product-discount-container");

    if (!priceDisplay || !discountContainer) {
        return;
    }

    var price = parseIvanaMoneyValue(priceDisplay.textContent);
    var transferPercent = parseFloat((discountContainer.getAttribute("data-transfer-discount-percentage") || "").replace(",", "."));
    var transferIcon = discountContainer.querySelector(".ivana-card-transfer-icon, .ivana-product-detail-transfer-icon");
    var transferCopy = discountContainer.querySelector(".ivana-card-transfer-copy, .ivana-product-detail-transfer-copy");
    var transferLine = discountContainer.querySelector(".ivana-card-transfer-line, .ivana-product-detail-transfer-row");
    var transferPrice = discountContainer.querySelector(".ivana-card-transfer-price, .ivana-product-detail-transfer-price");
    var transferBadge = discountContainer.querySelector(".ivana-card-transfer-badge, .ivana-product-detail-transfer-badge");
    var transferCaption = discountContainer.querySelector(".ivana-card-transfer-caption, .ivana-product-detail-transfer-caption");

    if (price === null || !transferCopy || !transferPrice || isNaN(transferPercent) || transferPercent <= 0) {
        return;
    }

    if (transferPercent <= 1) {
        transferPercent = transferPercent * 100;
    }

    discountContainer.classList.add("ivana-card-transfer-container");

    if (transferIcon) {
        transferIcon.classList.add("ivana-card-transfer-icon");
    }

    transferCopy.classList.add("ivana-card-transfer-copy");
    transferPrice.classList.add("ivana-card-transfer-price");

    if (!transferLine) {
        transferLine = document.createElement("span");
        transferLine.className = "ivana-product-detail-transfer-row ivana-card-transfer-line";
        transferCopy.insertBefore(transferLine, transferPrice);
        transferLine.appendChild(transferPrice);
    } else {
        transferLine.classList.add("ivana-card-transfer-line");
    }

    if (!transferBadge) {
        transferBadge = document.createElement("span");
        transferBadge.className = "ivana-product-detail-transfer-badge ivana-card-transfer-badge";
        transferLine.appendChild(transferBadge);
    } else {
        transferBadge.classList.add("ivana-card-transfer-badge");
        if (transferBadge.parentNode !== transferLine) {
            transferLine.appendChild(transferBadge);
        }
    }

    if (transferCaption) {
        transferCaption.classList.add("ivana-card-transfer-caption");
        transferCaption.textContent = "Pagando con transferencia";
        if (transferCaption.parentNode !== transferCopy) {
            transferCopy.appendChild(transferCaption);
        }
    }

    transferPrice.textContent = formatIvanaMoneyARS(price * (100 - transferPercent) / 100);
    transferBadge.textContent = "+ " + transferPercent + "% OFF";
    discountContainer.classList.remove("ivana-hidden-zero-discount");
    discountContainer.removeAttribute("aria-hidden");
}

function normalizeIvanaProductDetailDiscountBadges(root) {
    var scope = root || document;
    var shell = scope.querySelector(".ivana-product-shell");

    if (!shell) {
        return;
    }

    shell.querySelectorAll(".ivana-product-price-badge, .product-discount-badge, .product-price-badge").forEach(function(badge) {
        var text = (badge.textContent || "").replace(/\s+/g, " ").trim();
        var match = text.match(/\d+(?:[.,]\d+)?/);
        var discount = match ? Math.round(parseFloat(match[0].replace(",", "."))) : null;

        if (discount !== null && discount <= 0) {
            badge.style.display = "none";
            badge.classList.add("ivana-hidden-zero-discount");
            badge.setAttribute("aria-hidden", "true");
        }
    });

    var overlay = shell.querySelector(".product-discount-overlay");
    if (overlay) {
        var hasVisibleOverlayContent = false;
        overlay.querySelectorAll(".product-discount-badge, .product-price-badge").forEach(function(innerBadge) {
            if (innerBadge.style.display !== "none" && !innerBadge.classList.contains("ivana-hidden-zero-discount")) {
                hasVisibleOverlayContent = true;
            }
        });
        if (!hasVisibleOverlayContent) {
            overlay.classList.remove("ivana-active");
        }
    }

    var savingSpan = shell.querySelector(".js-offer-saved-money");
    if (savingSpan) {
        var savingText = (savingSpan.textContent || "").replace(/\s+/g, " ").trim();
        var savingMatch = savingText.match(/\d+(?:[.,]\d+)?/);
        var saving = savingMatch ? parseFloat(savingMatch[0].replace(",", ".")) : null;
        if (saving !== null && saving <= 0) {
            var overlay2 = shell.querySelector(".product-discount-overlay");
            if (overlay2) {
                overlay2.classList.remove("ivana-active");
            }
        }
    }
}

function normalizeIvanaProductDescription(root) {
    var scope = root || document;
    var copy = scope.querySelector(".ivana-product-description-copy");

    if (!copy || copy.dataset.ivanaDescriptionFormatted === "1") {
        return;
    }

    var currentList = null;

    Array.prototype.slice.call(copy.children).forEach(function(node) {
        var text = (node.textContent || "").replace(/\s+/g, " ").trim();

        if (!text) {
            node.style.display = "none";
            currentList = null;
            return;
        }

        if (node.tagName === "P" && /^[-–]\s*\S+/.test(text)) {
            if (!currentList) {
                currentList = document.createElement("ul");
                currentList.className = "ivana-product-description-generated-list";
                copy.insertBefore(currentList, node);
            }

            var item = document.createElement("li");
            item.textContent = text.replace(/^[-–]\s*/, "");
            currentList.appendChild(item);
            node.parentNode.removeChild(node);
            return;
        }

        currentList = null;

        if (node.tagName === "P" && /^[A-ZÁÉÍÓÚÜÑ0-9\s]+:?$/.test(text) && text.length <= 34) {
            node.classList.add("ivana-product-description-section-label");
        }
    });

    copy.dataset.ivanaDescriptionFormatted = "1";
}

function normalizeIvanaProductDetailCta(root) {
    var scope = root || document;
    var button = scope.querySelector(".ivana-product-shell .js-prod-submit-form");

    if (!button) {
        return;
    }

    button.style.setProperty("background", "#151412", "important");
    button.style.setProperty("background-color", "#151412", "important");
    button.style.setProperty("border-color", "#151412", "important");
    button.style.setProperty("color", "#ffffff", "important");
}

function queueIvanaProductCardNormalization() {
    if (ivanaProductCardsQueued) {
        return;
    }

    ivanaProductCardsQueued = true;

    window.requestAnimationFrame(function() {
        normalizeIvanaProductCards(document);
        normalizeIvanaProductDetailTitle(document);
        normalizeIvanaProductDetailCommercial(document);
        normalizeIvanaProductDetailDiscountBadges(document);
        normalizeIvanaProductDescription(document);
        normalizeIvanaProductDetailCta(document);
        initializeIvanaHomeCategoryCarouselMouseScroll();
        ivanaProductCardsQueued = false;
    });
}

queueIvanaProductCardNormalization();

if (!window.ivanaProductCardObserver) {
    window.ivanaProductCardObserver = new MutationObserver(function() {
        queueIvanaProductCardNormalization();
    });

    window.ivanaProductCardObserver.observe(document.body, {
        childList: true,
        subtree: true
    });
}
