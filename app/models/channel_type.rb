class ChannelType < ActiveRecord::Base

  has_many :channels

  default_scope {order(:name)}

  def tx_display
    if tx
      'TX'
    else
      ''
    end
  end
  def has_promotion_display
    if has_promotion
      'Promo'
    else
      ''
    end
  end

  def num_channels
    if channels.present?
      ActionController::Base.helpers.pluralize(channels.count, 'Channel')
    else
      ''
    end
  end

  def self.search(search)
    if search
      where('name = ?', search)
    else
      all
    end
  end
end
