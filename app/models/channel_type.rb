class ChannelType < ActiveRecord::Base

  has_many :channels

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

end
