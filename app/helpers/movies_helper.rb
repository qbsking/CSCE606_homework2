module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  def hilite
    params[:sort] == 'title_header' ? {class: 'hilite' } : {}
  end
end
