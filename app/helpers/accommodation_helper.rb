module AccommodationHelper
  IMAGE_CONTENT_TYPES = %w[
    image/png
    image/jpeg
    image/jpg
    image/pjpeg
    image/webp
  ].freeze

  def listing_cover_photo(record)
    return unless record.photos.attached?

    # Порядок ActiveStorage attachments может отличаться между устройствами/миграциями.
    # Поэтому выбираем детерминированно и возвращаем ATTACHMENT (а не blob),
    # чтобы image_tag гарантированно получил корректный URL.
    attachments = record.photos_attachments
                         .includes(:blob)
                         .sort_by { |att| [att.created_at || att.blob.created_at, att.id] }

    allowed = attachments.select { |att| IMAGE_CONTENT_TYPES.include?(att.blob.content_type) }
    allowed.first || attachments.first
  end

  def listing_photo_tag(record, css_class: 'hcard-photo', alt: nil)
    attachment = listing_cover_photo(record)

    if attachment
      image_tag attachment, class: css_class, alt: alt || record.name, loading: 'lazy',
                            style: 'width:100%;height:100%;object-fit:cover;display:block'
    else
      emoji = record.is_a?(Hotel) ? '🏨' : '🏠'
      content_tag(
        :div,
        emoji,
        style: 'width:100%;height:100%;display:flex;align-items:center;justify-content:center;font-size:52px;background:linear-gradient(135deg,#122720,#0d1c18)'
      )
    end
  end

  def listing_path_for(listing, **params)
    if listing.hotel?
      hotel_path(listing.record, **params)
    else
      property_path(listing.record, **params)
    end
  end
end
