defmodule Element do
  use Marker
  require Marker.HTML

  Marker.component :column do
    div class: "s c" do
      @__content__
    end
  end

  Marker.component :row do
    div class: "s r" do
      @__content__
    end
  end
end
