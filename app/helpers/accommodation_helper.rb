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

    record.photos.find { |photo| photo.blob.content_type.in?(IMAGE_CONTENT_TYPES) } || record.photos.first
  end

  def listing_photo_tag(record, css_class: 'hcard-photo', alt: nil)
    photo = listing_cover_photo(record)

    if photo
      image_tag photo, class: css_class, alt: alt || record.name, loading: 'lazy',
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
